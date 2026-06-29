package com.mars.admin.modules.user.service.impl;

import com.mars.admin.framework.exception.BusinessException;
import com.mars.admin.modules.user.entity.User;
import com.mars.admin.modules.user.entity.UserFollow;
import com.mars.admin.modules.user.mapper.UserFollowMapper;
import com.mars.admin.modules.user.service.IUserFollowService;
import com.mars.admin.modules.user.service.IUserService;
import com.mars.admin.modules.user.vo.FollowStatusVO;
import com.mybatisflex.core.query.QueryWrapper;
import com.mybatisflex.spring.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import static com.mars.admin.modules.user.entity.table.UserFollowTableDef.USER_FOLLOW;
import static com.mars.admin.modules.user.entity.table.UserTableDef.USER;

/**
 * 用户关注关系Service实现类
 *
 * @author Mars
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class UserFollowServiceImpl extends ServiceImpl<UserFollowMapper, UserFollow> implements IUserFollowService {

    private final IUserService userService;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean followUser(Long currentUserId, Long followUserId) {
        // 检查参数
        if (currentUserId == null || followUserId == null) {
            throw new BusinessException("用户ID不能为空");
        }

        // 不能关注自己
        if (currentUserId.equals(followUserId)) {
            throw new BusinessException("不能关注自己");
        }

        // 检查被关注用户是否存在
        User targetUser = userService.getById(followUserId);
        if (targetUser == null) {
            throw new BusinessException("用户不存在");
        }

        // 检查是否已经关注
        QueryWrapper queryWrapper = QueryWrapper.create()
                .where(USER_FOLLOW.USER_ID.eq(currentUserId))
                .and(USER_FOLLOW.FOLLOW_USER_ID.eq(followUserId));

        UserFollow existFollow = getOne(queryWrapper);

        if (existFollow != null) {
            if (existFollow.getStatus() == UserFollow.STATUS_FOLLOW) {
                // 已经关注了
                return true;
            } else {
                // 之前取消关注过，现在重新关注
                existFollow.setStatus(UserFollow.STATUS_FOLLOW);
                boolean updated = updateById(existFollow);

                if (updated) {
                    // 更新用户统计数据
                    updateUserFollowCount(currentUserId, followUserId, true);
                }
                return updated;
            }
        } else {
            // 新增关注关系
            UserFollow userFollow = new UserFollow()
                    .setUserId(currentUserId)
                    .setFollowUserId(followUserId)
                    .setStatus(UserFollow.STATUS_FOLLOW);

            boolean saved = save(userFollow);

            if (saved) {
                // 更新用户统计数据
                updateUserFollowCount(currentUserId, followUserId, true);
            }
            return saved;
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean unfollowUser(Long currentUserId, Long followUserId) {
        // 检查参数
        if (currentUserId == null || followUserId == null) {
            throw new IllegalArgumentException("用户ID不能为空");
        }

        // 查找关注关系
        QueryWrapper queryWrapper = QueryWrapper.create()
                .where(USER_FOLLOW.USER_ID.eq(currentUserId))
                .and(USER_FOLLOW.FOLLOW_USER_ID.eq(followUserId))
                .and(USER_FOLLOW.STATUS.eq(UserFollow.STATUS_FOLLOW));

        UserFollow userFollow = getOne(queryWrapper);

        if (userFollow != null) {
            // 更新状态为取消关注
            userFollow.setStatus(UserFollow.STATUS_UNFOLLOW);
            boolean updated = updateById(userFollow);

            if (updated) {
                // 更新用户统计数据
                updateUserFollowCount(currentUserId, followUserId, false);
            }
            return updated;
        }

        // 没有找到关注关系，认为操作成功
        return true;
    }

    @Override
    public FollowStatusVO checkFollowStatus(Long currentUserId, Long targetUserId) {
        FollowStatusVO result = new FollowStatusVO()
                .setTargetUserId(targetUserId)
                .setIsFollowing(false);

        if (currentUserId == null || targetUserId == null) {
            return result;
        }

        // 获取目标用户信息
        User targetUser = userService.getById(targetUserId);
        if (targetUser != null) {
            result.setTargetUserName(targetUser.getNickname())
                    .setTargetUserAvatar(targetUser.getAvatar());
        }

        // 检查关注状态
        QueryWrapper queryWrapper = QueryWrapper.create()
                .where(USER_FOLLOW.USER_ID.eq(currentUserId))
                .and(USER_FOLLOW.FOLLOW_USER_ID.eq(targetUserId))
                .and(USER_FOLLOW.STATUS.eq(UserFollow.STATUS_FOLLOW));

        UserFollow userFollow = getOne(queryWrapper);
        result.setIsFollowing(userFollow != null);

        return result;
    }

    @Override
    public long getFollowingCount(Long userId) {
        if (userId == null) {
            return 0;
        }

        QueryWrapper queryWrapper = QueryWrapper.create()
                .where(USER_FOLLOW.USER_ID.eq(userId))
                .and(USER_FOLLOW.STATUS.eq(UserFollow.STATUS_FOLLOW));

        return count(queryWrapper);
    }

    @Override
    public long getFollowersCount(Long userId) {
        if (userId == null) {
            return 0;
        }

        QueryWrapper queryWrapper = QueryWrapper.create()
                .where(USER_FOLLOW.FOLLOW_USER_ID.eq(userId))
                .and(USER_FOLLOW.STATUS.eq(UserFollow.STATUS_FOLLOW));

        return count(queryWrapper);
    }

    /**
     * 更新用户关注统计数据
     *
     * @param currentUserId 当前用户ID
     * @param followUserId  被关注用户ID
     * @param isFollow      是否关注（true-关注，false-取消关注）
     */
    private void updateUserFollowCount(Long currentUserId, Long followUserId, boolean isFollow) {
        try {
            // 更新当前用户的关注数
            long followingCount = getFollowingCount(currentUserId);
            User currentUser = userService.getById(currentUserId);
            if (currentUser != null) {
                currentUser.setFollowingCount((int) followingCount);
                userService.updateById(currentUser);
            }

            // 更新被关注用户的粉丝数
            long followersCount = getFollowersCount(followUserId);
            User targetUser = userService.getById(followUserId);
            if (targetUser != null) {
                targetUser.setFollowersCount((int) followersCount);
                userService.updateById(targetUser);
            }

            log.info("更新用户关注统计成功: currentUserId={}, followUserId={}, isFollow={}",
                    currentUserId, followUserId, isFollow);
        } catch (Exception e) {
            log.error("更新用户关注统计失败: currentUserId={}, followUserId={}, isFollow={}",
                    currentUserId, followUserId, isFollow, e);
            // 这里不抛出异常，避免影响主要业务流程
        }
    }
}