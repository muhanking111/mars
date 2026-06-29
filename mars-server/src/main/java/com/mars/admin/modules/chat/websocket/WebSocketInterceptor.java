package com.mars.admin.modules.chat.websocket;

import cn.dev33.satoken.stp.StpUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.HandshakeInterceptor;

import java.util.Map;

/**
 * WebSocket握手拦截器
 *
 * @author Mars
 * @version 1.0
 * @date 2025-01-07
 */
@Slf4j
public class WebSocketInterceptor implements HandshakeInterceptor {

    @Override
    public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response,
                                   WebSocketHandler wsHandler, Map<String, Object> attributes) throws Exception {
        try {
            // 从请求参数中获取token
            String token = getTokenFromRequest(request);
            if (token == null) {
                log.warn("WebSocket连接失败：缺少token");
                return false;
            }
            // 判断token是否有效
            Object loginIdByToken = StpUtil.getLoginIdByToken(token);
            if (loginIdByToken == null) {
                log.warn("WebSocket连接失败：无效的token");
                return false;
            }

            // 将用户ID存储到WebSocket会话属性中
            attributes.put("userId", loginIdByToken);
            attributes.put("token", token);

            log.info("用户 {} 请求建立WebSocket连接", loginIdByToken);
            return true;
        } catch (Exception e) {
            log.error("WebSocket握手验证失败：{}", e.getMessage());
            return false;
        }
    }

    @Override
    public void afterHandshake(ServerHttpRequest request, ServerHttpResponse response,
                               WebSocketHandler wsHandler, Exception exception) {
        if (exception != null) {
            log.error("WebSocket握手后处理异常：{}", exception.getMessage());
        }
    }

    /**
     * 从请求中获取token
     */
    private String getTokenFromRequest(ServerHttpRequest request) {
        String query = request.getURI().getQuery();
        if (query != null) {
            String[] params = query.split("&");
            for (String param : params) {
                String[] keyValue = param.split("=");
                if (keyValue.length == 2 && "token".equals(keyValue[0])) {
                    return keyValue[1];
                }
            }
        }
        return null;
    }
}
