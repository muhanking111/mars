package com.mars.admin.modules.system.controller;

import com.mars.admin.framework.common.Result;
import com.mars.admin.modules.base.controller.BaseController;
import com.mars.admin.modules.system.entity.SysApiLog;
import com.mars.admin.modules.system.service.ISysApiLogService;
import com.mybatisflex.core.paginate.Page;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 接口日志 Controller
 */
@RestController
@RequestMapping("/system/apilog")
@Tag(name = "接口日志管理", description = "接口请求日志管理")
public class SysApiLogController extends BaseController<SysApiLog, Long> {

    @Autowired
    private ISysApiLogService sysApiLogService;

    @Override
    public String permissionModule() {
        return "system:apilog";
    }

    @GetMapping("/pageList")
    @Operation(summary = "分页查询接口日志")
    public Result<Page<SysApiLog>> pageList(
            @RequestParam(defaultValue = "1") Integer current,
            @RequestParam(defaultValue = "10") Integer size,
            SysApiLog apiLog) {
        return Result.success(sysApiLogService.selectApiLogPage(Page.of(current, size), apiLog));
    }

    @DeleteMapping("/clean")
    @Operation(summary = "清空接口日志")
    public Result<Void> clean() {
        return sysApiLogService.cleanApiLog() ? Result.success() : Result.error("清空失败");
    }

    @PostMapping("/export")
    @Operation(summary = "导出接口日志")
    public Result<List<SysApiLog>> export(@RequestBody SysApiLog apiLog) {
        return Result.success(sysApiLogService.exportApiLog(apiLog));
    }
}
