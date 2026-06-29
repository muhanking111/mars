package com.mars.admin.framework.service;

import com.mars.admin.framework.util.IpUtils;
import com.mars.admin.framework.util.LoginIdUtils;
import com.mars.admin.framework.util.UserAgentUtils;
import com.mars.admin.modules.system.entity.SysApiLog;
import com.mars.admin.modules.system.entity.SysUser;
import com.mars.admin.modules.system.service.ISysApiLogService;
import com.mars.admin.modules.system.service.ISysUserService;
import cn.dev33.satoken.stp.StpUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerMapping;

import jakarta.servlet.http.HttpServletRequest;
import java.nio.charset.StandardCharsets;
import java.util.UUID;
import java.util.concurrent.CompletableFuture;
import java.util.regex.Pattern;

/**
 * 异步保存接口请求日志
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class AsyncApiLogService {

    private static final int MAX_TEXT_LENGTH = 2000;
    private static final Pattern PASSWORD_PATTERN = Pattern.compile(
            "(\"(?:password|oldPassword|newPassword|confirmPassword)\"\\s*:\\s*)\"[^\"]*\"",
            Pattern.CASE_INSENSITIVE);

    private final ISysApiLogService sysApiLogService;
    private final ISysUserService sysUserService;

    @Async("apiLogExecutor")
    public CompletableFuture<Void> saveAsync(SysApiLog apiLog) {
        try {
            sysApiLogService.insertApiLog(apiLog);
        } catch (Exception e) {
            log.error("异步保存接口日志失败: {} {}, 错误: {}",
                    apiLog.getRequestMethod(), apiLog.getRequestUrl(), e.getMessage(), e);
        }
        return CompletableFuture.completedFuture(null);
    }

    /**
     * 从请求上下文构建日志实体
     */
    public SysApiLog buildLog(HttpServletRequest request,
                              byte[] requestBody,
                              byte[] responseBody,
                              int responseCode,
                              long startTime,
                              Exception ex) {
        long costTime = System.currentTimeMillis() - startTime;
        String ip = IpUtils.getIpAddr(request);

        SysApiLog apiLog = new SysApiLog();
        apiLog.setTraceId(UUID.randomUUID().toString().replace("-", ""));
        apiLog.setRequestMethod(request.getMethod());
        apiLog.setRequestUrl(buildRequestUrl(request));
        apiLog.setClassMethod(resolveClassMethod(request));
        apiLog.setOperIp(ip);
        apiLog.setOperLocation(IpUtils.isInternalIp(ip) ? "内网IP" : null);
        apiLog.setBrowser(UserAgentUtils.getBrowser(request));
        apiLog.setOs(UserAgentUtils.getOperatingSystem(request));
        apiLog.setRequestParams(buildRequestParams(request, requestBody));
        apiLog.setResponseBody(truncate(maskSensitive(toUtf8(responseBody))));
        apiLog.setResponseCode(responseCode);
        apiLog.setCostTime(costTime);

        SysUser user = getCurrentUser();
        if (user != null) {
            apiLog.setOperName(user.getUsername());
        }

        if (ex != null) {
            apiLog.setStatus(1);
            apiLog.setErrorMsg(truncate(ex.getMessage()));
        } else if (responseCode >= 400) {
            apiLog.setStatus(1);
            apiLog.setErrorMsg("HTTP " + responseCode);
        } else {
            apiLog.setStatus(0);
        }

        return apiLog;
    }

    private String buildRequestUrl(HttpServletRequest request) {
        String uri = request.getRequestURI();
        String query = request.getQueryString();
        if (StringUtils.hasText(query)) {
            return uri + "?" + query;
        }
        return uri;
    }

    private String resolveClassMethod(HttpServletRequest request) {
        Object handler = request.getAttribute(HandlerMapping.BEST_MATCHING_HANDLER_ATTRIBUTE);
        if (handler instanceof HandlerMethod handlerMethod) {
            return handlerMethod.getBeanType().getName() + "." + handlerMethod.getMethod().getName() + "()";
        }
        return null;
    }

    private String buildRequestParams(HttpServletRequest request, byte[] requestBody) {
        StringBuilder sb = new StringBuilder();
        String body = maskSensitive(truncate(toUtf8(requestBody)));
        if (StringUtils.hasText(body)) {
            sb.append(body);
        }
        if (sb.isEmpty() && request.getParameterMap() != null && !request.getParameterMap().isEmpty()) {
            sb.append(request.getParameterMap().toString());
        }
        return truncate(sb.toString());
    }

    private SysUser getCurrentUser() {
        try {
            if (!StpUtil.isLogin()) {
                return null;
            }
            Long userId = LoginIdUtils.parseSysUserId(StpUtil.getLoginId());
            if (userId == null) {
                return null;
            }
            return sysUserService.getById(userId);
        } catch (Exception e) {
            return null;
        }
    }

    private String toUtf8(byte[] bytes) {
        if (bytes == null || bytes.length == 0) {
            return null;
        }
        return new String(bytes, StandardCharsets.UTF_8);
    }

    private String maskSensitive(String text) {
        if (!StringUtils.hasText(text)) {
            return text;
        }
        return PASSWORD_PATTERN.matcher(text).replaceAll("$1\"***\"");
    }

    private String truncate(String text) {
        if (!StringUtils.hasText(text)) {
            return text;
        }
        if (text.length() <= MAX_TEXT_LENGTH) {
            return text;
        }
        return text.substring(0, MAX_TEXT_LENGTH) + "...";
    }
}
