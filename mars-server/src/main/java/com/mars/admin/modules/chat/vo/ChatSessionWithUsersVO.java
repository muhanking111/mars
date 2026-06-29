package com.mars.admin.modules.chat.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 聊天会话VO（包含用户信息）
 *
 * @author Mars
 * @version 1.0
 * @date 2025-01-07
 */
@Data
@Schema(description = "聊天会话信息（包含用户信息）")
public class ChatSessionWithUsersVO {

    @Schema(description = "会话ID")
    private Long id;

    @Schema(description = "用户1 ID")
    private Long user1Id;

    @Schema(description = "用户2 ID")
    private Long user2Id;

    @Schema(description = "用户1昵称")
    private String user1Name;

    @Schema(description = "用户1头像")
    private String user1Avatar;

    @Schema(description = "用户2昵称")
    private String user2Name;

    @Schema(description = "用户2头像")
    private String user2Avatar;

    @Schema(description = "最后一条消息内容")
    private String lastMessage;

    @Schema(description = "最后消息时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime lastMessageTime;

    @Schema(description = "用户1未读消息数")
    private Integer user1UnreadCount;

    @Schema(description = "用户2未读消息数")
    private Integer user2UnreadCount;

    @Schema(description = "会话状态：0-正常，1-已删除")
    private Integer status;

    @Schema(description = "创建时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createTime;

    @Schema(description = "更新时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime updateTime;
}
