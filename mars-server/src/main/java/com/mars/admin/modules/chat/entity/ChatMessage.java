package com.mars.admin.modules.chat.entity;

import com.mars.admin.modules.base.entity.BaseEntity;
import com.mybatisflex.annotation.Id;
import com.mybatisflex.annotation.KeyType;
import com.mybatisflex.annotation.Table;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.time.LocalDateTime;

/**
 * 聊天消息实体
 *
 * @author Mars
 * @version 1.0
 * @date 2025-01-07
 */
@Data
@EqualsAndHashCode(callSuper = true)
@Table("tb_chat_message")
public class ChatMessage extends BaseEntity {

    /**
     * 消息ID
     */
    @Id(keyType = KeyType.Auto)
    private Long id;

    /**
     * 会话ID
     */
    private Long sessionId;

    /**
     * 发送者ID
     */
    private Long senderId;

    /**
     * 接收者ID
     */
    private Long receiverId;

    /**
     * 消息类型：1-文本，2-图片，3-语音，4-视频，5-文件
     */
    private Integer messageType;

    /**
     * 消息内容
     */
    private String content;

    /**
     * 媒体文件URL（图片、语音、视频、文件）
     */
    private String mediaUrl;

    /**
     * 消息状态：0-未读，1-已读
     */
    private Integer status;

    /**
     * 发送时间
     */
    private LocalDateTime sendTime;

    /**
     * 阅读时间
     */
    private LocalDateTime readTime;
}
