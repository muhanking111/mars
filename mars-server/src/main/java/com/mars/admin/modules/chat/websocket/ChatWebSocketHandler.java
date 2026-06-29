package com.mars.admin.modules.chat.websocket;

import com.alibaba.fastjson2.JSON;
import com.mars.admin.modules.chat.entity.ChatMessage;
import com.mars.admin.modules.chat.service.ChatService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.socket.*;

import java.io.IOException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * 聊天WebSocket处理器
 *
 * @author Mars
 * @version 1.0
 * @date 2025-01-07
 */
@Slf4j
public class ChatWebSocketHandler implements WebSocketHandler {

    private ChatService chatService;

    public void setChatService(ChatService chatService) {
        this.chatService = chatService;
    }

    // 存储用户ID与WebSocket会话的映射
    private static final Map<Long, WebSocketSession> USER_SESSIONS = new ConcurrentHashMap<>();

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        Object userId1 = session.getAttributes().get("userId");
        Long userId = Long.valueOf(userId1.toString());
        USER_SESSIONS.put(userId, session);
        log.info("用户 {} WebSocket连接建立成功，当前在线用户数：{}", userId, USER_SESSIONS.size());

        // 发送连接成功消息
        sendMessage(session, new WebSocketMessage("CONNECT_SUCCESS", "连接成功", null));
    }

    @Override
    public void handleMessage(WebSocketSession session, org.springframework.web.socket.WebSocketMessage<?> message) throws Exception {

        Object userId1 = session.getAttributes().get("userId");
        Long senderId = Long.valueOf(userId1.toString());

        try {
            String payload = message.getPayload().toString();
            ChatMessageDTO messageDTO = JSON.parseObject(payload, ChatMessageDTO.class);

            log.info("收到用户 {} 的消息：{}", senderId, payload);

            // 处理不同类型的消息
            switch (messageDTO.getType()) {
                case "SEND_MESSAGE":
                    handleSendMessage(senderId, messageDTO);
                    break;
                case "MARK_READ":
                    handleMarkRead(senderId, messageDTO);
                    break;
                case "HEARTBEAT":
                    handleHeartbeat(session);
                    break;
                default:
                    log.warn("未知的消息类型：{}", messageDTO.getType());
            }
        } catch (Exception e) {
            log.error("处理WebSocket消息异常：{}", e.getMessage(), e);
            sendMessage(session, new WebSocketMessage("ERROR", "消息处理失败", null));
        }
    }


    @Override
    public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {

        Object userId1 = session.getAttributes().get("userId");
        Long userId = Long.valueOf(userId1.toString());

        log.error("用户 {} WebSocket传输异常：{}", userId, exception.getMessage());
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus closeStatus) throws Exception {

        Object userId1 = session.getAttributes().get("userId");
        Long userId = Long.valueOf(userId1.toString());


        USER_SESSIONS.remove(userId);
        log.info("用户 {} WebSocket连接关闭，当前在线用户数：{}", userId, USER_SESSIONS.size());
    }

    @Override
    public boolean supportsPartialMessages() {
        return false;
    }

    /**
     * 处理发送消息
     */
    private void handleSendMessage(Long senderId, ChatMessageDTO messageDTO) {
        try {
            // 保存消息到数据库
            ChatMessage savedMessage = chatService.sendMessage(senderId, messageDTO.getReceiverId(),
                    messageDTO.getMessageType(), messageDTO.getContent(), messageDTO.getMediaUrl());

            // 构造响应消息
            WebSocketMessage response = new WebSocketMessage("NEW_MESSAGE", "新消息", savedMessage);

            // 发送给接收者
            WebSocketSession receiverSession = USER_SESSIONS.get(messageDTO.getReceiverId());
            if (receiverSession != null && receiverSession.isOpen()) {
                sendMessage(receiverSession, response);
            }

            // 发送确认给发送者
            WebSocketSession senderSession = USER_SESSIONS.get(senderId);
            if (senderSession != null && senderSession.isOpen()) {
                sendMessage(senderSession, new WebSocketMessage("SEND_SUCCESS", "发送成功", savedMessage));
            }

        } catch (Exception e) {
            log.error("发送消息失败：{}", e.getMessage(), e);
            WebSocketSession senderSession = USER_SESSIONS.get(senderId);
            if (senderSession != null && senderSession.isOpen()) {
                sendMessage(senderSession, new WebSocketMessage("SEND_FAILED", "发送失败", null));
            }
        }
    }

    /**
     * 处理标记已读
     */
    private void handleMarkRead(Long userId, ChatMessageDTO messageDTO) {
        try {
            chatService.markMessagesAsRead(messageDTO.getSessionId(), userId);

            WebSocketSession session = USER_SESSIONS.get(userId);
            if (session != null && session.isOpen()) {
                sendMessage(session, new WebSocketMessage("MARK_READ_SUCCESS", "标记已读成功", null));
            }
        } catch (Exception e) {
            log.error("标记已读失败：{}", e.getMessage(), e);
        }
    }

    /**
     * 处理心跳
     */
    private void handleHeartbeat(WebSocketSession session) {
        sendMessage(session, new WebSocketMessage("HEARTBEAT_RESPONSE", "pong", null));
    }

    /**
     * 发送消息到指定会话
     */
    private void sendMessage(WebSocketSession session, WebSocketMessage message) {
        try {
            if (session.isOpen()) {
                session.sendMessage(new TextMessage(JSON.toJSONString(message)));
            }
        } catch (IOException e) {
            log.error("发送WebSocket消息失败：{}", e.getMessage());
        }
    }

    /**
     * 向指定用户发送消息
     */
    public void sendMessageToUser(Long userId, WebSocketMessage message) {
        WebSocketSession session = USER_SESSIONS.get(userId);
        if (session != null && session.isOpen()) {
            sendMessage(session, message);
        }
    }

    /**
     * 获取在线用户数量
     */
    public int getOnlineUserCount() {
        return USER_SESSIONS.size();
    }

    /**
     * 检查用户是否在线
     */
    public boolean isUserOnline(Long userId) {
        WebSocketSession session = USER_SESSIONS.get(userId);
        return session != null && session.isOpen();
    }

    /**
     * WebSocket消息DTO
     */
    public static class ChatMessageDTO {
        private String type;
        private Long receiverId;
        private Long sessionId;
        private Integer messageType;
        private String content;
        private String mediaUrl;

        // getters and setters
        public String getType() {
            return type;
        }

        public void setType(String type) {
            this.type = type;
        }

        public Long getReceiverId() {
            return receiverId;
        }

        public void setReceiverId(Long receiverId) {
            this.receiverId = receiverId;
        }

        public Long getSessionId() {
            return sessionId;
        }

        public void setSessionId(Long sessionId) {
            this.sessionId = sessionId;
        }

        public Integer getMessageType() {
            return messageType;
        }

        public void setMessageType(Integer messageType) {
            this.messageType = messageType;
        }

        public String getContent() {
            return content;
        }

        public void setContent(String content) {
            this.content = content;
        }

        public String getMediaUrl() {
            return mediaUrl;
        }

        public void setMediaUrl(String mediaUrl) {
            this.mediaUrl = mediaUrl;
        }
    }

    /**
     * WebSocket消息包装类
     */
    public static class WebSocketMessage {
        private String type;
        private String message;
        private Object data;

        public WebSocketMessage(String type, String message, Object data) {
            this.type = type;
            this.message = message;
            this.data = data;
        }

        // getters and setters
        public String getType() {
            return type;
        }

        public void setType(String type) {
            this.type = type;
        }

        public String getMessage() {
            return message;
        }

        public void setMessage(String message) {
            this.message = message;
        }

        public Object getData() {
            return data;
        }

        public void setData(Object data) {
            this.data = data;
        }
    }
}
