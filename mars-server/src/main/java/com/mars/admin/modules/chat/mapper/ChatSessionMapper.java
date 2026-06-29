package com.mars.admin.modules.chat.mapper;

import com.mars.admin.modules.chat.entity.ChatSession;
import com.mars.admin.modules.chat.vo.ChatSessionVO;
import com.mars.admin.modules.chat.vo.ChatSessionWithUsersVO;
import com.mybatisflex.core.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 聊天会话Mapper
 *
 * @author Mars
 * @version 1.0
 * @date 2025-01-07
 */
@Mapper
public interface ChatSessionMapper extends BaseMapper<ChatSession> {

    /**
     * 根据两个用户ID查找会话
     */
    ChatSession findByUserIds(@Param("user1Id") Long user1Id, @Param("user2Id") Long user2Id);

    /**
     * 获取用户的所有会话列表
     */
    List<ChatSession> findByUserId(@Param("userId") Long userId);

    /**
     * 获取用户的所有会话列表（包含对方用户信息）
     */
    List<ChatSessionVO> findSessionsWithUserInfo(@Param("userId") Long userId);

    /**
     * 根据两个用户ID查找会话（包含用户信息）
     */
    ChatSessionWithUsersVO findSessionWithUsersInfo(@Param("user1Id") Long user1Id, @Param("user2Id") Long user2Id);

    /**
     * 更新未读消息数
     */
    void updateUnreadCount(@Param("sessionId") Long sessionId,
                           @Param("userId") Long userId,
                           @Param("count") Integer count);

    /**
     * 清空未读消息数
     */
    void clearUnreadCount(@Param("sessionId") Long sessionId, @Param("userId") Long userId);
}
