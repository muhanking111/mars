package com.mars.admin.framework.config;

import cn.dev33.satoken.stp.StpInterface;
import com.mars.admin.framework.util.LoginIdUtils;
import com.mars.admin.modules.system.entity.SysRole;
import com.mars.admin.modules.system.service.ISysMenuService;
import com.mars.admin.modules.system.service.ISysRoleService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Sa-Token权限接口实现类
 */
@Slf4j
@Component
public class StpInterfaceImpl implements StpInterface {

    @Autowired
    private ISysMenuService sysMenuService;

    @Autowired
    private ISysRoleService sysRoleService;

    @Override
    public List<String> getPermissionList(Object loginId, String loginType) {
        try {
            Long userId = LoginIdUtils.parseSysUserId(loginId);
            if (userId == null) {
                return new ArrayList<>();
            }

            List<String> permissions = sysMenuService.selectPermsByUserId(userId);
            List<String> filteredPermissions = new ArrayList<>();
            if (permissions != null) {
                for (String permission : permissions) {
                    if (permission != null && !permission.trim().isEmpty()) {
                        filteredPermissions.add(permission.trim());
                    }
                }
            }

            log.debug("用户ID: {} 的权限数量: {}", userId, filteredPermissions.size());
            return filteredPermissions;
        } catch (Exception e) {
            log.error("获取用户权限列表失败: {}", e.getMessage(), e);
            return new ArrayList<>();
        }
    }

    @Override
    public List<String> getRoleList(Object loginId, String loginType) {
        try {
            Long userId = LoginIdUtils.parseSysUserId(loginId);
            if (userId == null) {
                return new ArrayList<>();
            }

            List<SysRole> roles = sysRoleService.selectRolesByUserId(userId);
            if (roles == null || roles.isEmpty()) {
                return new ArrayList<>();
            }

            return roles.stream()
                    .map(role -> role.getRoleKey() != null ? role.getRoleKey() : role.getRoleCode())
                    .filter(key -> key != null && !key.isBlank())
                    .collect(Collectors.toList());
        } catch (Exception e) {
            log.error("获取用户角色列表失败: {}", e.getMessage(), e);
            return new ArrayList<>();
        }
    }
}
