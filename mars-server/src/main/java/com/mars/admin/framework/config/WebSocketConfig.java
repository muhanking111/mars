package com.mars.admin.framework.config;

import com.mars.admin.modules.chat.service.ChatService;
import com.mars.admin.modules.chat.websocket.ChatWebSocketHandler;
import com.mars.admin.modules.chat.websocket.WebSocketInterceptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

/**
 * WebSocket配置
 *
 * @author Mars
 * @version 1.0
 * @date 2025-01-07
 */
@Configuration
@EnableWebSocket
public class WebSocketConfig implements WebSocketConfigurer {

    @Autowired
    private ChatService chatService;

    @Bean
    public ChatWebSocketHandler chatWebSocketHandler() {
        ChatWebSocketHandler handler = new ChatWebSocketHandler();
        handler.setChatService(chatService);
        return handler;
    }

    @Bean
    public WebSocketInterceptor webSocketInterceptor() {
        return new WebSocketInterceptor();
    }

    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
        registry.addHandler(chatWebSocketHandler(), "/ws/chat")
                .addInterceptors(webSocketInterceptor())
                .setAllowedOrigins("*"); // 生产环境需要配置具体域名
    }
}
