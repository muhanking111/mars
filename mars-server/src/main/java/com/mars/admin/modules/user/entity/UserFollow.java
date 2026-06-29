package com.mars.admin.modules.user.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.mybatisflex.annotation.*;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * 用户关注关系实体类
 *
 * @author Mars
 */
@Data
@Accessors(chain = true)
@Table(value = "tb_user_follow")
@Schema(description = "用户关注关系")
public class UserFollow implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id(keyType = KeyType.Auto)
    @Schema(description = "主键ID")
    private Long id;

    @Schema(description = "关注者用户ID", requiredMode = Schema.RequiredMode.REQUIRED)
    @Column("user_id")
    private Long userId;

    @Schema(description = "被关注者用户ID", requiredMode = Schema.RequiredMode.REQUIRED)
    @Column("follow_user_id")
    private Long followUserId;

    @Schema(description = "状态：0-取消关注，1-关注中")
    @Column("status")
    private Integer status;

    @Schema(description = "关注时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Column(value = "create_time", onInsertValue = "now()")
    private LocalDateTime createTime;

    @Schema(description = "更新时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Column(value = "update_time", onInsertValue = "now()", onUpdateValue = "now()")
    private LocalDateTime updateTime;

    // 关注状态常量
    public static final int STATUS_UNFOLLOW = 0; // 取消关注
    public static final int STATUS_FOLLOW = 1;   // 关注中
}