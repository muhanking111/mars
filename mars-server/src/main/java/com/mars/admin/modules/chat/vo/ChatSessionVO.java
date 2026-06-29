package com.mars.admin.modules.chat.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@Schema(description = "聊天会话信息")
public class ChatSessionVO {


    @Schema(description = "会话ID")
    private Long id;

    @Schema(description = "用户1 ID")
    private Long user1Id;

    @Schema(description = "用户2 ID")
    private Long user2Id;

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

    @Schema(description = "对方用户ID")
    private Long otherUserId;

    @Schema(description = "对方用户昵称")
    private String otherUserNickname;

    @Schema(description = "对方用户头像")
    private String otherUserAvatar;

    @Schema(description = "当前用户未读消息数")
    private Integer unreadCount;

    @Schema(description = "创建时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createTime;

    @Schema(description = "更新时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime updateTime;
}
