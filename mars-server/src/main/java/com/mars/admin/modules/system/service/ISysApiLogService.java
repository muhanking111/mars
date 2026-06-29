package com.mars.admin.modules.system.service;

import com.mars.admin.modules.base.service.BaseService;
import com.mars.admin.modules.system.entity.SysApiLog;
import com.mybatisflex.core.paginate.Page;

import java.util.List;

/**
 * 接口日志 Service
 */
public interface ISysApiLogService extends BaseService<SysApiLog> {

    Page<SysApiLog> selectApiLogPage(Page<SysApiLog> page, SysApiLog apiLog);

    boolean insertApiLog(SysApiLog apiLog);

    boolean cleanApiLog();

    List<SysApiLog> exportApiLog(SysApiLog apiLog);
}
