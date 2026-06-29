package com.mars.admin.framework.filter;

import lombok.extern.slf4j.Slf4j;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * CORS跨域过滤器
 * 处理跨域请求，确保OPTIONS预检请求能够正确响应
 *
 * @author Mars
 * @version 1.0
 * @date 2025-01-07
 */
@Slf4j
@Component
@Order(-200) // 设置更高的优先级，确保在Sa-Token拦截器之前执行
public class CorsFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        log.info("CORS过滤器初始化完成");
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain)
            throws IOException, ServletException {
        
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;

        // 获取请求来源
        String origin = request.getHeader("Origin");
        
        // 设置CORS响应头
        if (origin != null && (origin.startsWith("http://localhost:") || 
                              origin.startsWith("http://127.0.0.1:") ||
                              origin.startsWith("https://localhost:") ||
                              origin.startsWith("https://127.0.0.1:"))) {
            response.setHeader("Access-Control-Allow-Origin", origin);
        }
        
        response.setHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS, HEAD, PATCH");
        response.setHeader("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept, Authorization, Cache-Control, Pragma, Expires, satoken");
        response.setHeader("Access-Control-Allow-Credentials", "true");
        response.setHeader("Access-Control-Max-Age", "3600");
        response.setHeader("Access-Control-Expose-Headers", "Authorization, Content-Type, X-Total-Count, Access-Control-Allow-Origin, Access-Control-Allow-Credentials");

        // 如果是OPTIONS预检请求，直接返回200状态码
        if ("OPTIONS".equalsIgnoreCase(request.getMethod())) {
            response.setStatus(HttpServletResponse.SC_OK);
            log.debug("处理OPTIONS预检请求: {} -> {}", request.getRequestURI(), origin);
            return;
        }

        // 继续执行后续过滤器
        filterChain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        log.info("CORS过滤器销毁");
    }
} 