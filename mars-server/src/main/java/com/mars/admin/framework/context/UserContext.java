package com.mars.admin.framework.context;

import cn.dev33.satoken.stp.StpUtil;
import com.mars.admin.framework.util.LoginIdUtils;

/**
 * 用户上下文工具类
 * 用于获取当前登录用户信息
 *
 * @author 程序员Mars
 * @version 1.0
 * @date 2026-06-05
 */
public class UserContext {

    /**
     * 获取当前登录后台用户ID
     *
     * @return 用户ID，未登录或非后台用户返回null
     */
    public static Long getCurrentUserId() {
        try {
            if (StpUtil.isLogin()) {
                return LoginIdUtils.parseSysUserId(StpUtil.getLoginId());
            }
        } catch (Exception e) {
            // 忽略异常，返回null
        }
        return null;
    }

    /**
     * 获取当前登录用户ID，如果未登录返回默认值
     *
     * @param defaultUserId 默认用户ID
     * @return 用户ID
     */
    public static Long getCurrentUserId(Long defaultUserId) {
        Long userId = getCurrentUserId();
        return userId != null ? userId : defaultUserId;
    }

    /**
     * 检查是否已登录
     *
     * @return true已登录，false未登录
     */
    public static boolean isLogin() {
        try {
            return StpUtil.isLogin();
        } catch (Exception e) {
            return false;
        }
    }
} 