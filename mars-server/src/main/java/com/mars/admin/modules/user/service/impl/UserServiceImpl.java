package com.mars.admin.modules.user.service.impl;

import cn.dev33.satoken.stp.StpUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.crypto.digest.BCrypt;
import com.mars.admin.framework.exception.BusinessException;
import com.mars.admin.modules.system.entity.*;
import com.mars.admin.modules.user.entity.User;
import com.mars.admin.modules.user.mapper.UserMapper;
import com.mars.admin.modules.user.service.IUserService;
import com.mars.admin.modules.base.service.impl.BaseServiceImpl;
import com.mars.admin.modules.user.vo.UserInfoVO;
import com.mybatisflex.core.paginate.Page;
import com.mybatisflex.core.query.QueryWrapper;
import com.mars.admin.framework.util.LoginIdUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;

import static com.mars.admin.modules.user.entity.table.UserTableDef.USER;


/**
 * 用户Service实现类
 *
 * @author Mars
 */
@Slf4j
@Service
public class UserServiceImpl extends BaseServiceImpl<User> implements IUserService {


    @Autowired
    private UserMapper userMapper;

    @Override
    public User selectByUsername(String username) {
        if (StrUtil.isBlank(username)) {
            return null;
        }
        return userMapper.selectByUsername(username);
    }

    @Override
    public User selectByPhone(String phone) {
        if (StrUtil.isBlank(phone)) {
            return null;
        }
        return userMapper.selectByPhone(phone);
    }

    @Override
    public User selectByEmail(String email) {
        if (StrUtil.isBlank(email)) {
            return null;
        }
        return userMapper.selectByEmail(email);
    }

    @Override
    public User selectByWechatOpenid(String wechatOpenid) {
        if (StrUtil.isBlank(wechatOpenid)) {
            return null;
        }
        return userMapper.selectByWechatOpenid(wechatOpenid);
    }

    @Override
    public User selectByQqOpenid(String qqOpenid) {
        if (StrUtil.isBlank(qqOpenid)) {
            return null;
        }
        return userMapper.selectByQqOpenid(qqOpenid);
    }

    @Override
    public Page<User> selectUserPage(Page<User> page, User user) {
        QueryWrapper query = QueryWrapper.create()
                .select(USER.ALL_COLUMNS)
                .from(USER)
                .where(USER.IS_DELETED.eq(0));

        // 构建查询条件
        if (user != null) {
            if (StrUtil.isNotBlank(user.getUsername())) {
                query.and(USER.USERNAME.like(user.getUsername()));
            }

            if (StrUtil.isNotBlank(user.getPhone())) {
                query.and(USER.PHONE.like(user.getPhone()));
            }
            if (StrUtil.isNotBlank(user.getEmail())) {
                query.and(USER.EMAIL.like(user.getEmail()));
            }

            if (user.getStatus() != null) {
                query.and(USER.STATUS.eq(user.getStatus()));
            }

        }

        query.orderBy(USER.CREATE_TIME.desc());
        return userMapper.paginate(page, query);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean register(User user) {
        // 校验用户名唯一性
        if (!checkUsernameUnique(user.getUsername(), null)) {
            throw new RuntimeException("用户名已存在");
        }

        // 校验手机号唯一性
        if (StrUtil.isNotBlank(user.getPhone()) && !checkPhoneUnique(user.getPhone(), null)) {
            throw new RuntimeException("手机号已存在");
        }


        // 设置默认值
        if (user.getLevel() == null) {
            user.setLevel(1);
        }
        if (user.getExperience() == null) {
            user.setExperience(0);
        }
        if (user.getPoints() == null) {
            user.setPoints(100); // 新用户赠送100积分
        }
        if (user.getStatus() == null) {
            user.setStatus(1);
        }
        if (user.getIsVerified() == null) {
            user.setIsVerified(0);
        }
        if (user.getVerifiedType() == null) {
            user.setVerifiedType(0);
        }

        // 初始化统计字段
        user.setTravelDays(0);
        user.setPhone(user.getPhone());
        user.setTravelCities(0);
        user.setTravelCountries(0);
        user.setFollowersCount(0);
        user.setFollowingCount(0);
        user.setPostsCount(0);
        user.setLikesCount(0);

        // 加密密码
        if (StrUtil.isNotBlank(user.getPassword())) {
            String salt = UUID.randomUUID().toString().replace("-", "");
            user.setSalt(salt);
            user.setPassword(BCrypt.hashpw(user.getPassword(), BCrypt.gensalt()));
        }

        return save(user);
    }

    @Override
    public boolean updateUser(User user) {
        if (user.getId() == null) {
            return false;
        }

        // 校验用户名唯一性
        if (StrUtil.isNotBlank(user.getUsername()) && !checkUsernameUnique(user.getUsername(), user.getId())) {
            throw new RuntimeException("用户名已存在");
        }

        // 校验手机号唯一性
        if (StrUtil.isNotBlank(user.getPhone()) && !checkPhoneUnique(user.getPhone(), user.getId())) {
            throw new RuntimeException("手机号已存在");
        }

        // 校验邮箱唯一性
        if (StrUtil.isNotBlank(user.getEmail()) && !checkEmailUnique(user.getEmail(), user.getId())) {
            throw new RuntimeException("邮箱已存在");
        }

        return updateById(user);
    }

    @Override
    public boolean updateLoginInfo(Long userId, String loginIp) {
        if (userId == null) {
            return false;
        }
        return userMapper.updateLoginInfo(userId, loginIp) > 0;
    }

    @Override
    public boolean updateUserStats(Long userId, Integer followersCount, Integer followingCount,
                                   Integer postsCount, Integer likesCount) {
        if (userId == null) {
            return false;
        }
        return userMapper.updateUserStats(userId, followersCount, followingCount, postsCount, likesCount) > 0;
    }

    @Override
    public boolean updateUserLevel(Long userId, Integer level, Integer experience) {
        if (userId == null) {
            return false;
        }
        return userMapper.updateUserLevel(userId, level, experience) > 0;
    }

    @Override
    public boolean updateUserPoints(Long userId, Integer points) {
        if (userId == null || points == null) {
            return false;
        }
        return userMapper.updateUserPoints(userId, points) > 0;
    }

    @Override
    public boolean updateVerifiedStatus(Long userId, Integer isVerified, Integer verifiedType) {
        if (userId == null) {
            return false;
        }
        return userMapper.updateVerifiedStatus(userId, isVerified, verifiedType) > 0;
    }

    @Override
    public boolean changeStatus(Long userId, Integer status) {
        if (userId == null || status == null) {
            return false;
        }
        User user = new User();
        user.setId(userId);
        user.setStatus(status);
        return updateById(user);
    }

    @Override
    public boolean resetPassword(Long userId, String newPassword) {
        if (userId == null || StrUtil.isBlank(newPassword)) {
            return false;
        }

        String salt = UUID.randomUUID().toString().replace("-", "");
        String encryptedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());

        User user = new User();
        user.setId(userId);
        user.setPassword(encryptedPassword);
        user.setSalt(salt);

        return updateById(user);
    }

    @Override
    public boolean changePassword(Long userId, String oldPassword, String newPassword) {
        if (userId == null || StrUtil.isBlank(oldPassword) || StrUtil.isBlank(newPassword)) {
            return false;
        }

        User user = getById(userId);
        if (user == null) {
            return false;
        }

        // 验证旧密码
        if (!BCrypt.checkpw(oldPassword, user.getPassword())) {
            throw new RuntimeException("原密码错误");
        }

        return resetPassword(userId, newPassword);
    }

    @Override
    public boolean checkUsernameUnique(String username, Long userId) {
        if (StrUtil.isBlank(username)) {
            return true;
        }

        QueryWrapper query = QueryWrapper.create()
                .select(USER.ID)
                .from(USER)
                .where(USER.USERNAME.eq(username))
                .and(USER.IS_DELETED.eq(0));

        if (userId != null) {
            query.and(USER.ID.ne(userId));
        }

        return userMapper.selectOneByQuery(query) == null;
    }

    @Override
    public boolean checkPhoneUnique(String phone, Long userId) {
        if (StrUtil.isBlank(phone)) {
            return true;
        }

        QueryWrapper query = QueryWrapper.create()
                .select(USER.ID)
                .from(USER)
                .where(USER.PHONE.eq(phone))
                .and(USER.IS_DELETED.eq(0));

        if (userId != null) {
            query.and(USER.ID.ne(userId));
        }

        return userMapper.selectOneByQuery(query) == null;
    }

    @Override
    public boolean checkEmailUnique(String email, Long userId) {
        if (StrUtil.isBlank(email)) {
            return true;
        }

        QueryWrapper query = QueryWrapper.create()
                .select(USER.ID)
                .from(USER)
                .where(USER.EMAIL.eq(email))
                .and(USER.IS_DELETED.eq(0));

        if (userId != null) {
            query.and(USER.ID.ne(userId));
        }

        return userMapper.selectOneByQuery(query) == null;
    }

    @Override
    public List<User> selectByLevel(Integer level) {
        if (level == null) {
            return null;
        }
        return userMapper.selectByLevel(level);
    }

    @Override
    public List<User> selectByVerifiedStatus(Integer isVerified, Integer verifiedType) {
        return userMapper.selectByVerifiedStatus(isVerified, verifiedType);
    }

    @Override
    public List<User> selectActiveUsers(Integer limit) {
        if (limit == null || limit <= 0) {
            limit = 10;
        }
        return userMapper.selectActiveUsers(limit);
    }

    @Override
    public List<User> selectUserRanking(Integer limit) {
        if (limit == null || limit <= 0) {
            limit = 10;
        }
        return userMapper.selectUserRanking(limit);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean deleteUsers(Long[] userIds) {
        if (userIds == null || userIds.length == 0) {
            return false;
        }

        // 软删除
        User user = new User();
        user.setIsDeleted(1);
        user.setDeleteTime(LocalDateTime.now());

        QueryWrapper query = QueryWrapper.create()
                .where(USER.ID.in(Arrays.asList(userIds)));

        return userMapper.updateByQuery(user, query) > 0;
    }

    @Override
    public List<User> exportUser(User user) {
        QueryWrapper query = QueryWrapper.create()
                .select(USER.ALL_COLUMNS)
                .from(USER)
                .where(USER.IS_DELETED.eq(0));

        // 构建查询条件（与分页查询相同）
        if (user != null) {
            if (StrUtil.isNotBlank(user.getUsername())) {
                query.and(USER.USERNAME.like(user.getUsername()));
            }

            if (StrUtil.isNotBlank(user.getPhone())) {
                query.and(USER.PHONE.like(user.getPhone()));
            }
            if (StrUtil.isNotBlank(user.getEmail())) {
                query.and(USER.EMAIL.like(user.getEmail()));
            }

            if (user.getStatus() != null) {
                query.and(USER.STATUS.eq(user.getStatus()));
            }
        }

        query.orderBy(USER.CREATE_TIME.desc());
        return userMapper.selectListByQuery(query);
    }

    @Override
    public boolean updatePersonalInfo(User user) {
        if (user == null || user.getId() == null) {
            return false;
        }

        // 只允许更新个人信息字段
        User updateUser = new User();
        updateUser.setId(user.getId());
        updateUser.setNickname(user.getNickname());
        updateUser.setRealName(user.getRealName());
        updateUser.setEmail(user.getEmail());
        updateUser.setAvatar(user.getAvatar());
        updateUser.setGender(user.getGender());
        updateUser.setBirthday(user.getBirthday());
        updateUser.setSignature(user.getSignature());
        updateUser.setLocation(user.getLocation());

        return updateById(updateUser);
    }

    @Override
    public boolean bindThirdPartyAccount(Long userId, String platform, String openid) {
        if (userId == null || StrUtil.isBlank(platform) || StrUtil.isBlank(openid)) {
            return false;
        }

        User user = new User();
        user.setId(userId);

        if ("wechat".equals(platform)) {
            user.setWechatOpenid(openid);
        } else if ("qq".equals(platform)) {
            user.setQqOpenid(openid);
        } else {
            return false;
        }

        return updateById(user);
    }

    @Override
    public boolean unbindThirdPartyAccount(Long userId, String platform) {
        if (userId == null || StrUtil.isBlank(platform)) {
            return false;
        }

        User user = new User();
        user.setId(userId);

        if ("wechat".equals(platform)) {
            user.setWechatOpenid(null);
        } else if ("qq".equals(platform)) {
            user.setQqOpenid(null);
        } else {
            return false;
        }

        return updateById(user);
    }

    @Override
    public UserInfoVO getCurrentUser() {
        if (!StpUtil.isLogin()) {
            throw BusinessException.of("用户未登录");
        }
        Long userId = LoginIdUtils.parseAppUserId(StpUtil.getLoginId());
        if (userId == null) {
            throw BusinessException.of("非App用户，无权访问");
        }
        User user = userMapper.selectOneById(userId);
        if (user == null) {
            throw BusinessException.of("用户不存在");
        }

        // 检查用户状态
        if (user.getStatus() == null || user.getStatus() == 0) {
            throw BusinessException.of("用户已被禁用");
        }

        if (user.getIsDeleted() != null && user.getIsDeleted() == 1) {
            throw BusinessException.of("用户已被删除");
        }
        // 清除敏感信息
        user.setPassword(null);
        UserInfoVO vo = new UserInfoVO();
        BeanUtils.copyProperties(user, vo);
        return vo;
    }

    @Override
    public UserInfoVO getOtherUserInfo(Long userId) {
        User user = userMapper.selectOneById(userId);
        if (user == null) {
            throw BusinessException.of("用户不存在");
        }

        // 检查用户状态
        if (user.getStatus() == null || user.getStatus() == 0) {
            throw BusinessException.of("用户已被禁用");
        }

        if (user.getIsDeleted() != null && user.getIsDeleted() == 1) {
            throw BusinessException.of("用户已被删除");
        }
        // 清除敏感信息
        user.setPassword(null);
        UserInfoVO vo = new UserInfoVO();
        BeanUtils.copyProperties(user, vo);
        return vo;
    }
}
