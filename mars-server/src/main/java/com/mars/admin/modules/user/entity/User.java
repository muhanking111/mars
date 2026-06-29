package com.mars.admin.modules.user.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.mars.admin.modules.base.entity.BaseEntity;
import com.mars.admin.framework.listener.EntityChangeListener;
import com.mybatisflex.annotation.*;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * 用户实体类
 *
 * @author Mars
 */
@Data
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@Table(value = "tb_user", onInsert = EntityChangeListener.class, onUpdate = EntityChangeListener.class)
@Schema(description = "用户")
public class User extends BaseEntity {

    private static final long serialVersionUID = 1L;

    @Id(keyType = KeyType.Auto)
    @Schema(description = "用户ID")
    private Long id;

    @Schema(description = "用户名", requiredMode = Schema.RequiredMode.REQUIRED)
    @Column("username")
    private String username;

    @Schema(description = "昵称")
    @Column("nickname")
    private String nickname;

    @Schema(description = "真实姓名")
    @Column("real_name")
    private String realName;

    @Schema(description = "手机号")
    @Column("phone")
    private String phone;

    @Schema(description = "邮箱")
    @Column("email")
    private String email;

    @Schema(description = "头像URL")
    @Column("avatar")
    private String avatar;

    @Schema(description = "类型 1-微信用户 2 app用户")
    @Column("type")
    private Integer type;

    @Schema(description = "性别：0-未知，1-男，2-女")
    @Column("gender")
    private Integer gender;

    @Schema(description = "生日")
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Column("birthday")
    private LocalDate birthday;

    @Schema(description = "密码（加密）")
    @Column("password")
    private String password;

    @Schema(description = "密码盐值")
    @Column("salt")
    private String salt;

    @Schema(description = "微信OpenID")
    @Column("wechat_openid")
    private String wechatOpenid;

    @Schema(description = "微信UnionID")
    @Column("wechat_unionid")
    private String wechatUnionid;

    @Schema(description = "QQ OpenID")
    @Column("qq_openid")
    private String qqOpenid;

    @Schema(description = "用户等级")
    @Column("level")
    private Integer level;

    @Schema(description = "经验值")
    @Column("experience")
    private Integer experience;

    @Schema(description = "积分")
    @Column("points")
    private Integer points;

    @Schema(description = "旅行天数")
    @Column("travel_days")
    private Integer travelDays;

    @Schema(description = "到过城市数")
    @Column("travel_cities")
    private Integer travelCities;

    @Schema(description = "到过国家数")
    @Column("travel_countries")
    private Integer travelCountries;

    @Schema(description = "粉丝数")
    @Column("followers_count")
    private Integer followersCount;

    @Schema(description = "关注数")
    @Column("following_count")
    private Integer followingCount;

    @Schema(description = "发帖数")
    @Column("posts_count")
    private Integer postsCount;

    @Schema(description = "获赞数")
    @Column("likes_count")
    private Integer likesCount;

    @Schema(description = "个性签名")
    @Column("signature")
    private String signature;

    @Schema(description = "所在地")
    @Column("location")
    private String location;

    @Schema(description = "状态：0-禁用，1-正常，2-审核中")
    @Column("status")
    private Integer status;

    @Schema(description = "是否认证：0-否，1-是")
    @Column("is_verified")
    private Integer isVerified;

    @Schema(description = "认证类型：0-无，1-个人，2-企业，3-官方")
    @Column("verified_type")
    private Integer verifiedType;

    @Schema(description = "最后登录时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Column("last_login_time")
    private LocalDateTime lastLoginTime;

    @Schema(description = "最后登录IP")
    @Column("last_login_ip")
    private String lastLoginIp;

    // 非数据库字段
    @Schema(description = "是否关注")
    @Column(ignore = true)
    private Boolean isFollowed;

    @Schema(description = "等级名称")
    @Column(ignore = true)
    private String levelName;

    @Schema(description = "认证类型名称")
    @Column(ignore = true)
    private String verifiedTypeName;
}
