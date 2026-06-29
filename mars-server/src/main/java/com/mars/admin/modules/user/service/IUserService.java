package com.mars.admin.modules.user.service;

import com.mars.admin.modules.user.entity.User;
import com.mars.admin.modules.base.service.BaseService;
import com.mars.admin.modules.user.vo.UserInfoVO;
import com.mybatisflex.core.paginate.Page;

import java.util.List;

/**
 * 用户Service接口
 * 继承 BaseService 获得更多便捷方法
 *
 * @author Mars
 */
public interface IUserService extends BaseService<User> {

    /**
     * 根据用户名查询用户
     *
     * @param username 用户名
     * @return 用户信息
     */
    User selectByUsername(String username);

    /**
     * 根据手机号查询用户
     *
     * @param phone 手机号
     * @return 用户信息
     */
    User selectByPhone(String phone);

    /**
     * 根据邮箱查询用户
     *
     * @param email 邮箱
     * @return 用户信息
     */
    User selectByEmail(String email);

    /**
     * 根据微信OpenID查询用户
     *
     * @param wechatOpenid 微信OpenID
     * @return 用户信息
     */
    User selectByWechatOpenid(String wechatOpenid);

    /**
     * 根据QQ OpenID查询用户
     *
     * @param qqOpenid QQ OpenID
     * @return 用户信息
     */
    User selectByQqOpenid(String qqOpenid);

    /**
     * 分页查询用户列表
     *
     * @param page 分页参数
     * @param user 查询条件
     * @return 用户分页列表
     */
    Page<User> selectUserPage(Page<User> page, User user);

    /**
     * 用户注册
     *
     * @param user 用户信息
     * @return 注册结果
     */
    boolean register(User user);

    /**
     * 更新用户信息
     *
     * @param user 用户信息
     * @return 更新结果
     */
    boolean updateUser(User user);

    /**
     * 更新用户登录信息
     *
     * @param userId  用户ID
     * @param loginIp 登录IP
     * @return 更新结果
     */
    boolean updateLoginInfo(Long userId, String loginIp);

    /**
     * 更新用户统计信息
     *
     * @param userId         用户ID
     * @param followersCount 粉丝数
     * @param followingCount 关注数
     * @param postsCount     发帖数
     * @param likesCount     获赞数
     * @return 更新结果
     */
    boolean updateUserStats(Long userId, Integer followersCount, Integer followingCount,
                            Integer postsCount, Integer likesCount);

    /**
     * 更新用户等级和经验
     *
     * @param userId     用户ID
     * @param level      等级
     * @param experience 经验值
     * @return 更新结果
     */
    boolean updateUserLevel(Long userId, Integer level, Integer experience);

    /**
     * 更新用户积分
     *
     * @param userId 用户ID
     * @param points 积分变化量（正数为增加，负数为减少）
     * @return 更新结果
     */
    boolean updateUserPoints(Long userId, Integer points);

    /**
     * 更新用户认证状态
     *
     * @param userId       用户ID
     * @param isVerified   是否认证
     * @param verifiedType 认证类型
     * @return 更新结果
     */
    boolean updateVerifiedStatus(Long userId, Integer isVerified, Integer verifiedType);

    /**
     * 修改用户状态
     *
     * @param userId 用户ID
     * @param status 状态
     * @return 修改结果
     */
    boolean changeStatus(Long userId, Integer status);

    /**
     * 重置用户密码
     *
     * @param userId      用户ID
     * @param newPassword 新密码
     * @return 重置结果
     */
    boolean resetPassword(Long userId, String newPassword);

    /**
     * 修改用户密码
     *
     * @param userId      用户ID
     * @param oldPassword 旧密码
     * @param newPassword 新密码
     * @return 修改结果
     */
    boolean changePassword(Long userId, String oldPassword, String newPassword);

    /**
     * 校验用户名是否唯一
     *
     * @param username 用户名
     * @param userId   用户ID（修改时传入）
     * @return 是否唯一
     */
    boolean checkUsernameUnique(String username, Long userId);

    /**
     * 校验手机号是否唯一
     *
     * @param phone  手机号
     * @param userId 用户ID（修改时传入）
     * @return 是否唯一
     */
    boolean checkPhoneUnique(String phone, Long userId);

    /**
     * 校验邮箱是否唯一
     *
     * @param email  邮箱
     * @param userId 用户ID（修改时传入）
     * @return 是否唯一
     */
    boolean checkEmailUnique(String email, Long userId);

    /**
     * 根据等级查询用户列表
     *
     * @param level 用户等级
     * @return 用户列表
     */
    List<User> selectByLevel(Integer level);

    /**
     * 根据认证状态查询用户列表
     *
     * @param isVerified   是否认证
     * @param verifiedType 认证类型
     * @return 用户列表
     */
    List<User> selectByVerifiedStatus(Integer isVerified, Integer verifiedType);

    /**
     * 查询活跃用户（按最后登录时间排序）
     *
     * @param limit 限制数量
     * @return 用户列表
     */
    List<User> selectActiveUsers(Integer limit);

    /**
     * 查询用户排行榜（按积分排序）
     *
     * @param limit 限制数量
     * @return 用户列表
     */
    List<User> selectUserRanking(Integer limit);

    /**
     * 删除用户
     *
     * @param userIds 用户ID数组
     * @return 删除结果
     */
    boolean deleteUsers(Long[] userIds);

    /**
     * 导出用户数据
     *
     * @param user 查询条件
     * @return 用户列表
     */
    List<User> exportUser(User user);

    /**
     * 更新个人信息
     *
     * @param user 用户信息
     * @return 更新结果
     */
    boolean updatePersonalInfo(User user);

    /**
     * 绑定第三方账号
     *
     * @param userId   用户ID
     * @param platform 平台类型：wechat, qq
     * @param openid   第三方openid
     * @return 绑定结果
     */
    boolean bindThirdPartyAccount(Long userId, String platform, String openid);

    /**
     * 解绑第三方账号
     *
     * @param userId   用户ID
     * @param platform 平台类型：wechat, qq
     * @return 解绑结果
     */
    boolean unbindThirdPartyAccount(Long userId, String platform);

    /**
     * 获取用户信息
     *
     * @return 用户信息
     */
    UserInfoVO getCurrentUser();

    /**
     * 获取其他用户信息
     *
     * @param userId userId
     * @return UserInfoVO
     */
    UserInfoVO getOtherUserInfo(Long userId);
}
