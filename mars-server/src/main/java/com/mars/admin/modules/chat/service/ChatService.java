package com.mars.admin.modules.chat.service;

import com.mars.admin.modules.chat.entity.ChatMessage;
import com.mars.admin.modules.chat.entity.ChatSession;
import com.mars.admin.modules.chat.vo.ChatSessionVO;
import com.mars.admin.modules.chat.vo.ChatSessionWithUsersVO;

import java.util.List;

public interface ChatService {

    /**
     * 获取或创建聊天会话
     */
    ChatSessionWithUsersVO getOrCreateSession(Long user1Id, Long user2Id);

    /**
     * 获取或创建聊天会话（包含用户信息）
     */
    ChatSessionWithUsersVO getOrCreateSessionWithUsers(Long user1Id, Long user2Id);

    /**
     * 发送消息
     */
    ChatMessage sendMessage(Long senderId, Long receiverId, Integer messageType, String content, String mediaUrl);

    /**
     * 获取会话消息列表
     */
    List<ChatMessage> getSessionMessages(Long sessionId, Integer page, Integer size);

    /**
     * 获取用户的会话列表
     */
    List<ChatSession> getUserSessions(Long userId);

    /**
     * 获取用户的会话列表（包含对方用户信息）
     */
    List<ChatSessionVO> getUserSessionsWithUserInfo(Long userId);

    /**
     * 标记消息为已读
     */
    void markMessagesAsRead(Long sessionId, Long userId);

    /**
     * 获取未读消息数
     */
    Integer getUnreadCount(Long sessionId, Long userId);

    /**
     * 删除会话
     */
    void deleteSession(Long sessionId, Long userId);

}
