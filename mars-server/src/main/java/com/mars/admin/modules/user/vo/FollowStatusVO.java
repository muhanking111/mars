package com.mars.admin.modules.user.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.experimental.Accessors;

/**
 * 关注状态响应VO
 *
 * @author Mars
 */
@Data
@Accessors(chain = true)
@Schema(description = "关注状态")
public class FollowStatusVO {

    @Schema(description = "是否已关注")
    private Boolean isFollowing;

    @Schema(description = "目标用户ID")
    private Long targetUserId;

    @Schema(description = "目标用户昵称")
    private String targetUserName;

    @Schema(description = "目标用户头像")
    private String targetUserAvatar;
}