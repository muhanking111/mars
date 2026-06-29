package com.mars.admin.framework.filter;

import com.mars.admin.framework.service.AsyncApiLogService;
import com.mars.admin.modules.system.entity.SysApiLog;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Component;
import org.springframework.util.AntPathMatcher;
import org.springframework.util.StringUtils;
import org.springframework.web.filter.OncePerRequestFilter;
import org.springframework.web.util.ContentCachingRequestWrapper;
import org.springframework.web.util.ContentCachingResponseWrapper;

import java.io.IOException;
import java.util.List;

/**
 * 接口日志过滤器：包装请求/响应体，请求结束后异步落库
 */
@Slf4j
@Component
@Order(Ordered.HIGHEST_PRECEDENCE + 20)
@RequiredArgsConstructor
public class ApiLogFilter extends OncePerRequestFilter {

    private static final int CACHE_LIMIT = 8 * 1024;
    private static final AntPathMatcher PATH_MATCHER = new AntPathMatcher();

    private static final List<String> EXCLUDE_PATTERNS = List.of(
            "/druid/**",
            "/doc.html",
            "/swagger-ui.html",
            "/swagger-ui/**",
            "/v3/api-docs/**",
            "/knife4j/**",
            "/actuator/**",
            "/sqlLog.html",
            "/sqlLog/**",
            "/sql-log/**",
            "/file/**",
            "/static/**",
            "/public/**",
            "/webjars/**",
            "/favicon.ico",
            "/error"
    );

    private final AsyncApiLogService asyncApiLogService;

    @Override
    protected boolean shouldNotFilter(HttpServletRequest request) {
        if (HttpMethod.OPTIONS.matches(request.getMethod())) {
            return true;
        }
        String uri = request.getRequestURI();
        String contextPath = request.getContextPath();
        if (StringUtils.hasText(contextPath) && uri.startsWith(contextPath)) {
            uri = uri.substring(contextPath.length());
        }
        for (String pattern : EXCLUDE_PATTERNS) {
            if (PATH_MATCHER.match(pattern, uri)) {
                return true;
            }
        }
        return false;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request,
                                    HttpServletResponse response,
                                    FilterChain filterChain) throws ServletException, IOException {
        long startTime = System.currentTimeMillis();
        ContentCachingRequestWrapper requestWrapper = new ContentCachingRequestWrapper(request, CACHE_LIMIT);
        ContentCachingResponseWrapper responseWrapper = new ContentCachingResponseWrapper(response);

        Exception caught = null;
        try {
            filterChain.doFilter(requestWrapper, responseWrapper);
        } catch (Exception ex) {
            caught = ex;
            throw ex;
        } finally {
            try {
                SysApiLog apiLog = asyncApiLogService.buildLog(
                        requestWrapper,
                        requestWrapper.getContentAsByteArray(),
                        responseWrapper.getContentAsByteArray(),
                        responseWrapper.getStatus(),
                        startTime,
                        caught
                );
                asyncApiLogService.saveAsync(apiLog);
            } catch (Exception e) {
                log.warn("记录接口日志失败: {}", e.getMessage());
            }
            responseWrapper.copyBodyToResponse();
        }
    }
}
