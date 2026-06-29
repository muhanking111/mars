package com.mars.admin.framework.util;

import cn.hutool.crypto.digest.BCrypt;
import org.springframework.util.DigestUtils;
import org.springframework.util.StringUtils;

import java.nio.charset.StandardCharsets;

/**
 * 密码工具类：统一 BCrypt，兼容旧 MD5 数据
 */
public final class PasswordUtils {

    private PasswordUtils() {
    }

    /** BCrypt 加密 */
    public static String encrypt(String password) {
        if (!StringUtils.hasText(password)) {
            return "";
        }
        return BCrypt.hashpw(password, BCrypt.gensalt());
    }

    /** 校验密码（BCrypt 优先，兼容 MD5） */
    public static boolean matches(String rawPassword, String storedPassword) {
        if (!StringUtils.hasText(rawPassword) || !StringUtils.hasText(storedPassword)) {
            return false;
        }
        if (isBcrypt(storedPassword)) {
            return BCrypt.checkpw(rawPassword, storedPassword);
        }
        String md5 = DigestUtils.md5DigestAsHex(rawPassword.getBytes(StandardCharsets.UTF_8));
        return md5.equalsIgnoreCase(storedPassword);
    }

    public static boolean isBcrypt(String storedPassword) {
        return storedPassword != null && storedPassword.startsWith("$2");
    }
}
