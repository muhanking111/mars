package com.mars.admin.modules.user.service;

import com.mars.admin.modules.user.entity.UserFollow;
import com.mars.admin.modules.user.vo.FollowStatusVO;
import com.mybatisflex.core.service.IService;

/**
 * 用户关注关系Service接口
 *
 * @author Mars
 */
public interface IUserFollowService extends IService<UserFollow> {

    /**
     * 关注用户
     *
     * @param currentUserId 当前用户ID
     * @param followUserId  要关注的用户ID
     * @return 是否成功
     */
    boolean followUser(Long currentUserId, Long followUserId);

    /**
     * 取消关注用户
     *
     * @param currentUserId 当前用户ID
     * @param followUserId  要取消关注的用户ID
     * @return 是否成功
     */
    boolean unfollowUser(Long currentUserId, Long followUserId);

    /**
     * 检查关注状态
     *
     * @param currentUserId 当前用户ID
     * @param targetUserId  目标用户ID
     * @return 关注状态
     */
    FollowStatusVO checkFollowStatus(Long currentUserId, Long targetUserId);

    /**
     * 获取用户关注数量
     *
     * @param userId 用户ID
     * @return 关注数量
     */
    long getFollowingCount(Long userId);

    /**
     * 获取用户粉丝数量
     *
     * @param userId 用户ID
     * @return 粉丝数量
     */
    long getFollowersCount(Long userId);
}