package com.mars.admin.framework.strategy.impl;

import cn.dev33.satoken.stp.SaTokenInfo;
import cn.dev33.satoken.stp.StpUtil;
import cn.hutool.core.util.StrUtil;
import com.mars.admin.framework.util.LoginIdUtils;
import com.mars.admin.framework.util.PasswordUtils;
import cn.hutool.system.UserInfo;
import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONObject;
import com.mars.admin.common.enums.LoginType;
import com.mars.admin.common.request.LoginRequest;
import com.mars.admin.common.response.LoginResponse;
import com.mars.admin.modules.system.entity.SysUser;
import com.mars.admin.framework.exception.BusinessException;
import com.mars.admin.framework.strategy.LoginStrategy;
import com.mars.admin.modules.system.mapper.SysUserMapper;
import com.mars.admin.modules.system.service.ISysLoginInfoService;
import com.mars.admin.modules.user.entity.User;
import com.mars.admin.modules.user.mapper.UserMapper;
import com.mars.admin.modules.user.vo.UserInfoVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.client.RestTemplate;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.TimeUnit;

/**
 * APP登录策略
 *
 * @author 程序员Mars
 * @version 1.0
 * @date 2025-01-16
 */
@Slf4j
@Component
public class AppLoginStrategy implements LoginStrategy {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private ISysLoginInfoService sysLoginInfoService;


    @Override
    public LoginType getLoginType() {
        return LoginType.APP;
    }

    @Override
    public LoginResponse login(LoginRequest loginRequest) {
        // 1. 验证登录参数
        if (!validateLoginRequest(loginRequest)) {
            throw BusinessException.of("手机号不能为空");
        }

        String mobile = loginRequest.getMobile();
        // 3. 查询或创建用户
        User user = findOrCreateUser(mobile, loginRequest);
        // 校验密码
        if (!PasswordUtils.matches(loginRequest.getPassword(), user.getPassword())) {
            throw BusinessException.of("密码错误");
        }

        // 4. 校验用户状态
        checkUserStatus(user, loginRequest.getUsername());

        // 5. 执行登录
        StpUtil.login(LoginIdUtils.appUser(user.getId()));

        // 6. 获取 Token 信息
        SaTokenInfo tokenInfo = StpUtil.getTokenInfo();

        // 7. 更新用户登录信息
        updateUserLoginInfo(user);

        // 8. 记录登录成功日志
        recordLoginInfo(loginRequest.getMobile(), "0", "APP登录成功");

        // 9. 构建返回结果
        LoginResponse response = new LoginResponse();
        response.setToken(tokenInfo.getTokenValue());
        response.setTokenType("Bearer");
        response.setExpiresIn(tokenInfo.getTokenTimeout());
        response.setLoginType(getLoginType().getCode());

        // 清除敏感信息
        user.setPassword(null);

        UserInfoVO vo = new UserInfoVO();
        BeanUtils.copyProperties(user, vo);
        response.setUserInfo(vo);
        // 小程序端扩展信息
        Map<String, Object> extraInfo = new HashMap<>();
        extraInfo.put("loginTime", LocalDateTime.now());
        extraInfo.put("clientType", "APP");
        response.setExtraInfo(extraInfo);
        return response;
    }

    @Override
    public boolean validateLoginRequest(LoginRequest loginRequest) {
        return StringUtils.hasText(loginRequest.getMobile());
    }

    @Override
    public String getUserIdentifier(LoginRequest loginRequest) {
        // 小程序用户标识是openId，需要通过code获取
        return null;
    }


    /**
     * 查询或创建用户
     */
    private User findOrCreateUser(String phone, LoginRequest loginRequest) {
        User user = userMapper.selectByPhone(phone);

        if (user == null) {
            // 如果用户不存在，创建新用户
            user = createNewUser(phone, loginRequest);
        } else {
            // 如果用户存在，更新用户信息
            updateUserInfo(user, loginRequest);
        }

        return user;
    }

    /**
     * 创建新用户
     */
    private User createNewUser(String phone, LoginRequest loginRequest) {
        User user = new User();
        user.setPhone(phone);
        if (StringUtils.hasText(loginRequest.getPassword())) {
            user.setPassword(PasswordUtils.encrypt(loginRequest.getPassword()));
        }
        user.setAvatar(loginRequest.getAvatar());
        user.setStatus(1);
        user.setType(2);
        user.setIsDeleted(0);
        user.setCreateTime(LocalDateTime.now());
        user.setUpdateTime(LocalDateTime.now());
        userMapper.insertSelective(user);
        return user;
    }

    /**
     * 更新用户信息
     */
    private void updateUserInfo(User user, LoginRequest loginRequest) {
        user.setUpdateTime(LocalDateTime.now());
        userMapper.update(user);
    }

    /**
     * 校验用户状态
     */
    private void checkUserStatus(User user, String openId) {
        if (user == null) {
            recordLoginInfo(openId, "0", "用户不存在");
            throw BusinessException.of("用户不存在");
        }

        // 检查用户状态
        if (user.getStatus() == null || user.getStatus() == 0) {
            recordLoginInfo(openId, "0", "用户已被禁用");
            throw BusinessException.of("用户已被禁用，请联系管理员");
        }

        // 检查用户是否被删除
        if (user.getIsDeleted() != null && user.getIsDeleted() == 1) {
            recordLoginInfo(openId, "0", "用户已被删除");
            throw BusinessException.of("用户不存在");
        }
    }

    /**
     * 更新用户登录信息
     */
    private void updateUserLoginInfo(User user) {
        try {
            user.setLastLoginTime(LocalDateTime.now());
            userMapper.update(user);
        } catch (Exception e) {
            log.error("更新用户登录信息失败", e);
        }
    }

    /**
     * 记录登录日志
     */
    private void recordLoginInfo(String identifier, String status, String message) {
        try {
            sysLoginInfoService.recordLoginInfo(identifier, status, message, getClientIp());
        } catch (Exception e) {
            log.error("记录登录日志失败", e);
        }
    }

    /**
     * 获取客户端IP
     */
    private String getClientIp() {
        // 这里可以从request中获取IP，为了简化暂时返回固定值
        return "127.0.0.1";
    }
}
