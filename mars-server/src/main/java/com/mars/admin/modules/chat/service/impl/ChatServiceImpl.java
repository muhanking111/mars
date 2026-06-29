package com.mars.admin.modules.chat.service.impl;

import cn.hutool.core.bean.BeanUtil;
import com.mars.admin.modules.chat.entity.ChatMessage;
import com.mars.admin.modules.chat.entity.ChatSession;
import com.mars.admin.modules.chat.mapper.ChatMessageMapper;
import com.mars.admin.modules.chat.mapper.ChatSessionMapper;
import com.mars.admin.modules.chat.service.ChatService;
import com.mars.admin.modules.chat.vo.ChatSessionVO;
import com.mars.admin.modules.chat.vo.ChatSessionWithUsersVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 聊天服务实现类
 *
 * @author Mars
 * @version 1.0
 * @date 2025-01-07
 */
@Slf4j
@Service
public class ChatServiceImpl implements ChatService {

    @Autowired
    private ChatSessionMapper chatSessionMapper;

    @Autowired
    private ChatMessageMapper chatMessageMapper;


    @Override
    @Transactional
    public ChatSessionWithUsersVO getOrCreateSession(Long user1Id, Long user2Id) {
        // 确保user1Id < user2Id，保证会话的唯一性
        Long smallerId = Math.min(user1Id, user2Id);
        Long largerId = Math.max(user1Id, user2Id);

        // 查找现有会话
        ChatSessionWithUsersVO session = chatSessionMapper.findSessionWithUsersInfo(smallerId, largerId);


        if (session == null) {
            // 创建新会话
            session = new ChatSessionWithUsersVO();
            session.setUser1Id(smallerId);
            session.setUser2Id(largerId);
            session.setLastMessage("");
            session.setLastMessageTime(LocalDateTime.now());
            session.setUser1UnreadCount(0);
            session.setUser2UnreadCount(0);

            session.setStatus(0);
            session.setCreateTime(LocalDateTime.now());
            session.setUpdateTime(LocalDateTime.now());
            ChatSession chatSession = new ChatSession();
            BeanUtil.copyProperties(session, chatSession);
            chatSessionMapper.insert(chatSession);
            log.info("创建新的聊天会话：用户 {} 和用户 {}", smallerId, largerId);
        }

        return session;
    }

    @Override
    public ChatSessionWithUsersVO getOrCreateSessionWithUsers(Long user1Id, Long user2Id) {
        return null;
    }

    @Override
    @Transactional
    public ChatMessage sendMessage(Long senderId, Long receiverId, Integer messageType, String content, String mediaUrl) {
        // 获取或创建会话
        ChatSessionWithUsersVO session = getOrCreateSession(senderId, receiverId);

        // 创建消息
        ChatMessage message = new ChatMessage();
        message.setSessionId(session.getId());
        message.setSenderId(senderId);
        message.setReceiverId(receiverId);
        message.setMessageType(messageType);
        message.setContent(content);
        message.setMediaUrl(mediaUrl);
        message.setStatus(0); // 未读
        message.setSendTime(LocalDateTime.now());
        message.setCreateTime(LocalDateTime.now());
        message.setUpdateTime(LocalDateTime.now());

        chatMessageMapper.insert(message);

        // 更新会话信息
        session.setLastMessage(content != null ? content : "[媒体消息]");
        session.setLastMessageTime(LocalDateTime.now());
        session.setUpdateTime(LocalDateTime.now());

        // 更新接收者未读消息数
        if (senderId.equals(session.getUser1Id())) {
            session.setUser2UnreadCount(session.getUser2UnreadCount() + 1);
        } else {
            session.setUser1UnreadCount(session.getUser1UnreadCount() + 1);
        }

        ChatSession chatSession = new ChatSession();
        BeanUtil.copyProperties(session, chatSession);
        chatSessionMapper.update(chatSession);

        log.info("用户 {} 向用户 {} 发送消息：{}", senderId, receiverId, content);
        return message;
    }

    @Override
    public List<ChatMessage> getSessionMessages(Long sessionId, Integer page, Integer size) {
        int offset = (page - 1) * size;
        return chatMessageMapper.findBySessionId(sessionId, offset, size);
    }

    @Override
    public List<ChatSession> getUserSessions(Long userId) {
        return chatSessionMapper.findByUserId(userId);
    }

    @Override
    public List<ChatSessionVO> getUserSessionsWithUserInfo(Long userId) {
        return chatSessionMapper.findSessionsWithUserInfo(userId);
    }

    @Override
    @Transactional
    public void markMessagesAsRead(Long sessionId, Long userId) {
        // 将会话中的未读消息标记为已读
        chatMessageMapper.markAsRead(sessionId, userId);

        // 清空当前用户的未读消息数
        chatSessionMapper.clearUnreadCount(sessionId, userId);

        log.info("用户 {} 标记会话 {} 的消息为已读", userId, sessionId);
    }

    @Override
    public Integer getUnreadCount(Long sessionId, Long userId) {
        return chatMessageMapper.getUnreadCount(sessionId, userId);
    }

    @Override
    @Transactional
    public void deleteSession(Long sessionId, Long userId) {
        // 这里可以实现软删除或者只对当前用户隐藏会话
        ChatSession session = chatSessionMapper.selectOneById(sessionId);
        if (session != null && (session.getUser1Id().equals(userId) || session.getUser2Id().equals(userId))) {
            session.setStatus(1); // 标记为已删除
            session.setUpdateTime(LocalDateTime.now());
            chatSessionMapper.update(session);
            log.info("用户 {} 删除会话 {}", userId, sessionId);
        }
    }
}
