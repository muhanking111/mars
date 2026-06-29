package com.mars.admin.modules.user.mapper;

import com.mars.admin.modules.user.entity.User;
import com.mybatisflex.core.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 用户Mapper接口
 *
 * @author Mars
 */
@Mapper
public interface UserMapper extends BaseMapper<User> {

    /**
     * 根据用户名查询用户
     *
     * @param username 用户名
     * @return 用户信息
     */
    User selectByUsername(@Param("username") String username);

    /**
     * 根据手机号查询用户
     *
     * @param phone 手机号
     * @return 用户信息
     */
    User selectByPhone(@Param("phone") String phone);

    /**
     * 根据邮箱查询用户
     *
     * @param email 邮箱
     * @return 用户信息
     */
    User selectByEmail(@Param("email") String email);

    /**
     * 根据微信OpenID查询用户
     *
     * @param wechatOpenid 微信OpenID
     * @return 用户信息
     */
    User selectByWechatOpenid(@Param("wechatOpenid") String wechatOpenid);

    /**
     * 根据QQ OpenID查询用户
     *
     * @param qqOpenid QQ OpenID
     * @return 用户信息
     */
    User selectByQqOpenid(@Param("qqOpenid") String qqOpenid);

    /**
     * 更新用户登录信息
     *
     * @param userId 用户ID
     * @param loginIp 登录IP
     * @return 更新结果
     */
    int updateLoginInfo(@Param("userId") Long userId, @Param("loginIp") String loginIp);

    /**
     * 更新用户统计信息
     *
     * @param userId 用户ID
     * @param followersCount 粉丝数
     * @param followingCount 关注数
     * @param postsCount 发帖数
     * @param likesCount 获赞数
     * @return 更新结果
     */
    int updateUserStats(@Param("userId") Long userId,
                        @Param("followersCount") Integer followersCount,
                        @Param("followingCount") Integer followingCount,
                        @Param("postsCount") Integer postsCount,
                        @Param("likesCount") Integer likesCount);

    /**
     * 更新用户等级和经验
     *
     * @param userId 用户ID
     * @param level 等级
     * @param experience 经验值
     * @return 更新结果
     */
    int updateUserLevel(@Param("userId") Long userId,
                        @Param("level") Integer level,
                        @Param("experience") Integer experience);

    /**
     * 更新用户积分
     *
     * @param userId 用户ID
     * @param points 积分变化量（正数为增加，负数为减少）
     * @return 更新结果
     */
    int updateUserPoints(@Param("userId") Long userId, @Param("points") Integer points);

    /**
     * 更新用户认证状态
     *
     * @param userId 用户ID
     * @param isVerified 是否认证
     * @param verifiedType 认证类型
     * @return 更新结果
     */
    int updateVerifiedStatus(@Param("userId") Long userId,
                             @Param("isVerified") Integer isVerified,
                             @Param("verifiedType") Integer verifiedType);

    /**
     * 根据等级查询用户列表
     *
     * @param level 用户等级
     * @return 用户列表
     */
    List<User> selectByLevel(@Param("level") Integer level);

    /**
     * 根据认证状态查询用户列表
     *
     * @param isVerified 是否认证
     * @param verifiedType 认证类型
     * @return 用户列表
     */
    List<User> selectByVerifiedStatus(@Param("isVerified") Integer isVerified,
                                      @Param("verifiedType") Integer verifiedType);

    /**
     * 查询活跃用户（按最后登录时间排序）
     *
     * @param limit 限制数量
     * @return 用户列表
     */
    List<User> selectActiveUsers(@Param("limit") Integer limit);

    /**
     * 查询用户排行榜（按积分排序）
     *
     * @param limit 限制数量
     * @return 用户列表
     */
    List<User> selectUserRanking(@Param("limit") Integer limit);
}