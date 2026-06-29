package com.mars.admin.modules.chat.entity;

import com.mars.admin.modules.base.entity.BaseEntity;
import com.mybatisflex.annotation.Id;
import com.mybatisflex.annotation.KeyType;
import com.mybatisflex.annotation.Table;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.time.LocalDateTime;

/**
 * 聊天会话实体
 *
 * @author Mars
 * @version 1.0
 * @date 2025-01-07
 */
@Data
@EqualsAndHashCode(callSuper = true)
@Table("tb_chat_session")
public class ChatSession extends BaseEntity {

    /**
     * 会话ID
     */
    @Id(keyType = KeyType.Auto)
    private Long id;

    /**
     * 用户1 ID
     */
    private Long user1Id;

    /**
     * 用户2 ID
     */
    private Long user2Id;

    /**
     * 最后一条消息内容
     */
    private String lastMessage;

    /**
     * 最后消息时间
     */
    private LocalDateTime lastMessageTime;

    /**
     * 用户1未读消息数
     */
    private Integer user1UnreadCount;

    /**
     * 用户2未读消息数
     */
    private Integer user2UnreadCount;

    /**
     * 会话状态：0-正常，1-已删除
     */
    private Integer status;
}
