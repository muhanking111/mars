package com.mars.admin.framework.aspect;

import cn.dev33.satoken.stp.StpUtil;
import com.mars.admin.framework.common.annotation.PermissionModule;
import com.mars.admin.modules.base.controller.BaseController;
import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.lang.reflect.Method;
import java.util.Map;
import java.util.Set;

/**
 * Controller 权限切面：BaseController 子类 + @PermissionModule 标注类
 */
@Slf4j
@Aspect
@Component
@Order(0)
public class BaseControllerPermissionAspect {

    /** 仅配置了 list 权限、无按钮级权限的模块 */
    private static final Set<String> LIST_ONLY_MODULES = Set.of(
            "system:dept",
            "system:post",
            "system:dict",
            "system:config"
    );

    private static final Map<String, String> METHOD_PERMISSION_SUFFIX = Map.ofEntries(
            Map.entry("list", "list"),
            Map.entry("getById", "query"),
            Map.entry("page", "list"),
            Map.entry("pageList", "list"),
            Map.entry("tree", "list"),
            Map.entry("optionselect", "list"),
            Map.entry("save", "add"),
            Map.entry("saveBatch", "add"),
            Map.entry("update", "edit"),
            Map.entry("saveOrUpdate", "edit"),
            Map.entry("changeStatus", "edit"),
            Map.entry("authRole", "edit"),
            Map.entry("authDept", "edit"),
            Map.entry("authPost", "edit"),
            Map.entry("authMenu", "edit"),
            Map.entry("refreshCache", "edit"),
            Map.entry("deleteById", "remove"),
            Map.entry("deleteBatch", "remove"),
            Map.entry("clean", "clear"),
            Map.entry("count", "query"),
            Map.entry("export", "export"),
            Map.entry("exportExcel", "export"),
            Map.entry("importData", "import"),
            Map.entry("info", "query"),
            Map.entry("resources", "query"),
            Map.entry("alerts", "query"),
            Map.entry("overview", "query"),
            Map.entry("process", "query"),
            Map.entry("recent", "query"),
            Map.entry("clear", "clear"),
            Map.entry("checkUsernameUnique", "query"),
            Map.entry("checkEmailUnique", "query"),
            Map.entry("checkPhoneUnique", "query"),
            Map.entry("checkRoleCodeUnique", "query"),
            Map.entry("checkRoleKeyUnique", "query"),
            Map.entry("checkPostCodeUnique", "query"),
            Map.entry("checkPostNameUnique", "query"),
            Map.entry("checkDeptCodeUnique", "query"),
            Map.entry("checkDeptNameUnique", "query"),
            Map.entry("checkMenuCodeUnique", "query"),
            Map.entry("checkPermsUnique", "query"),
            Map.entry("checkConfigKeyUnique", "query")
    );

    @Before("execution(* com.mars.admin.modules..*Controller.*(..))")
    public void checkControllerPermission(JoinPoint joinPoint) {
        Object target = joinPoint.getTarget();
        String module = resolvePermissionModule(target);
        if (module == null) {
            return;
        }

        Method method = ((MethodSignature) joinPoint.getSignature()).getMethod();
        if (!hasRestMapping(method)) {
            return;
        }

        String suffix = resolvePermissionSuffix(method.getName());
        if (suffix == null) {
            return;
        }

        checkPermission(module, suffix);
    }

    /** 校验权限，兼容仅有 list 权限的模块 */
    private void checkPermission(String module, String suffix) {
        String permission = module + ":" + suffix;
        if (StpUtil.hasPermission(permission)) {
            return;
        }
        String listPermission = module + ":list";
        // 仅 list 权限的模块：list 覆盖该模块全部操作
        if (LIST_ONLY_MODULES.contains(module) && StpUtil.hasPermission(listPermission)) {
            return;
        }
        // 查询类操作：有 list 权限即可读取
        if ("query".equals(suffix) && StpUtil.hasPermission(listPermission)) {
            return;
        }
        StpUtil.checkPermission(permission);
    }

    private String resolvePermissionModule(Object target) {
        if (target instanceof BaseController<?, ?> baseController) {
            return baseController.permissionModule();
        }
        PermissionModule annotation = target.getClass().getAnnotation(PermissionModule.class);
        return annotation != null ? annotation.value() : null;
    }

    private String resolvePermissionSuffix(String methodName) {
        String suffix = METHOD_PERMISSION_SUFFIX.get(methodName);
        if (suffix != null) {
            return suffix;
        }
        if (methodName.startsWith("check") && methodName.endsWith("Unique")) {
            return "query";
        }
        if (methodName.startsWith("add")) {
            return "add";
        }
        if (methodName.startsWith("update")) {
            return "edit";
        }
        if (methodName.startsWith("get") || methodName.startsWith("select")) {
            return "query";
        }
        if (methodName.startsWith("delete") || methodName.startsWith("remove")) {
            return "remove";
        }
        return null;
    }

    private boolean hasRestMapping(Method method) {
        return method.isAnnotationPresent(GetMapping.class)
                || method.isAnnotationPresent(PostMapping.class)
                || method.isAnnotationPresent(PutMapping.class)
                || method.isAnnotationPresent(DeleteMapping.class)
                || method.isAnnotationPresent(RequestMapping.class);
    }
}
