package com.mars.admin.modules.chat.mapper;

import com.mars.admin.modules.chat.entity.ChatMessage;
import com.mybatisflex.core.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 聊天消息Mapper
 *
 * @author Mars
 * @version 1.0
 * @date 2025-01-07
 */
@Mapper
public interface ChatMessageMapper extends BaseMapper<ChatMessage> {

    /**
     * 根据会话ID获取消息列表
     */
    List<ChatMessage> findBySessionId(@Param("sessionId") Long sessionId,
                                      @Param("offset") Integer offset,
                                      @Param("limit") Integer limit);

    /**
     * 获取会话未读消息数
     */
    Integer getUnreadCount(@Param("sessionId") Long sessionId, @Param("userId") Long userId);

    /**
     * 标记消息为已读
     */
    void markAsRead(@Param("sessionId") Long sessionId, @Param("userId") Long userId);

    /**
     * 获取最新消息
     */
    ChatMessage getLatestMessage(@Param("sessionId") Long sessionId);
}
