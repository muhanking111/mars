package com.mars.admin.framework.util;

/**
 * Sa-Token loginId 工具：分离 B 端（sys）与 C 端（app）用户
 */
public final class LoginIdUtils {

    public static final String SYS_PREFIX = "sys:";
    public static final String APP_PREFIX = "app:";

    private LoginIdUtils() {
    }

    public static String sysUser(Long userId) {
        return SYS_PREFIX + userId;
    }

    public static String appUser(Long userId) {
        return APP_PREFIX + userId;
    }

    public static boolean isSysUser(Object loginId) {
        return loginId != null && loginId.toString().startsWith(SYS_PREFIX);
    }

    public static boolean isAppUser(Object loginId) {
        return loginId != null && loginId.toString().startsWith(APP_PREFIX);
    }

    /** 解析后台用户 ID，C 端或非法格式返回 null */
    public static Long parseSysUserId(Object loginId) {
        if (loginId == null) {
            return null;
        }
        String id = loginId.toString();
        if (id.startsWith(SYS_PREFIX)) {
            return Long.valueOf(id.substring(SYS_PREFIX.length()));
        }
        if (id.startsWith(APP_PREFIX)) {
            return null;
        }
        try {
            return Long.valueOf(id);
        } catch (NumberFormatException e) {
            return null;
        }
    }

    /** 解析 C 端用户 ID */
    public static Long parseAppUserId(Object loginId) {
        if (loginId == null) {
            return null;
        }
        String id = loginId.toString();
        if (id.startsWith(APP_PREFIX)) {
            return Long.valueOf(id.substring(APP_PREFIX.length()));
        }
        return null;
    }
}
