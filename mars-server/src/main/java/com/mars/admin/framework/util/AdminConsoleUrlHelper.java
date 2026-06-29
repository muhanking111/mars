package com.mars.admin.framework.util;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

/**
 * 管理端外链 URL 工具：根据 server.port / context-path 修正 Druid、接口文档等链接
 */
@Component
public class AdminConsoleUrlHelper {

    @Value("${server.port:8080}")
    private int serverPort;

    @Value("${server.servlet.context-path:}")
    private String contextPath;

    /**
     * 修正外链地址，补齐 context-path（如 /api）
     */
    public String normalizeExternalUrl(String url) {
        if (url == null || url.isBlank()) {
            return url;
        }
        if (!url.startsWith("http://") && !url.startsWith("https://")) {
            return url;
        }

        String ctx = normalizedContextPath();
        String localBase = "http://localhost:" + serverPort;
        String localBase127 = "http://127.0.0.1:" + serverPort;

        if (url.startsWith(localBase + "/") || url.startsWith(localBase127 + "/")) {
            String host = url.startsWith(localBase) ? localBase : localBase127;
            String path = url.substring(host.length());
            if (ctx.isEmpty() || path.startsWith(ctx + "/") || path.equals(ctx)) {
                return url;
            }
            if (isConsolePath(path)) {
                return host + ctx + path;
            }
        }
        return url;
    }

    public String druidIndexUrl() {
        return "http://localhost:" + serverPort + normalizedContextPath() + "/druid/index.html";
    }

    public String docUrl() {
        return "http://localhost:" + serverPort + normalizedContextPath() + "/doc.html";
    }

    private boolean isConsolePath(String path) {
        return path.startsWith("/druid")
                || path.equals("/doc.html")
                || path.startsWith("/doc.html")
                || path.startsWith("/knife4j")
                || path.startsWith("/swagger-ui")
                || path.startsWith("/v3/api-docs");
    }

    private String normalizedContextPath() {
        if (contextPath == null || contextPath.isBlank() || "/".equals(contextPath)) {
            return "";
        }
        return contextPath.startsWith("/") ? contextPath : "/" + contextPath;
    }
}
