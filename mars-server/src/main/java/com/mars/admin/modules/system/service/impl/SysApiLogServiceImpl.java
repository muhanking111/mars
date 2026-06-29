package com.mars.admin.modules.system.service.impl;

import com.mars.admin.modules.base.service.impl.BaseServiceImpl;
import com.mars.admin.modules.system.entity.SysApiLog;
import com.mars.admin.modules.system.mapper.SysApiLogMapper;
import com.mars.admin.modules.system.service.ISysApiLogService;
import com.mybatisflex.core.paginate.Page;
import com.mybatisflex.core.query.QueryWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.util.List;

import static com.mars.admin.modules.system.entity.table.SysApiLogTableDef.SYS_API_LOG;

/**
 * 接口日志 Service 实现
 */
@Service
public class SysApiLogServiceImpl extends BaseServiceImpl<SysApiLog> implements ISysApiLogService {

    @Autowired
    private SysApiLogMapper sysApiLogMapper;

    @Override
    public Page<SysApiLog> selectApiLogPage(Page<SysApiLog> page, SysApiLog apiLog) {
        QueryWrapper query = QueryWrapper.create().from(SYS_API_LOG);

        if (StringUtils.hasText(apiLog.getOperName())) {
            query.and(SYS_API_LOG.OPER_NAME.like(apiLog.getOperName()));
        }
        if (StringUtils.hasText(apiLog.getRequestUrl())) {
            query.and(SYS_API_LOG.REQUEST_URL.like(apiLog.getRequestUrl()));
        }
        if (StringUtils.hasText(apiLog.getRequestMethod())) {
            query.and(SYS_API_LOG.REQUEST_METHOD.eq(apiLog.getRequestMethod()));
        }
        if (apiLog.getStatus() != null) {
            query.and(SYS_API_LOG.STATUS.eq(apiLog.getStatus()));
        }
        if (StringUtils.hasText(apiLog.getOperIp())) {
            query.and(SYS_API_LOG.OPER_IP.like(apiLog.getOperIp()));
        }

        query.orderBy(SYS_API_LOG.CREATE_TIME.desc());
        return this.page(page, query);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean insertApiLog(SysApiLog apiLog) {
        return this.save(apiLog);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean cleanApiLog() {
        return sysApiLogMapper.cleanApiLog() >= 0;
    }

    @Override
    public List<SysApiLog> exportApiLog(SysApiLog apiLog) {
        QueryWrapper query = QueryWrapper.create().from(SYS_API_LOG);

        if (StringUtils.hasText(apiLog.getOperName())) {
            query.and(SYS_API_LOG.OPER_NAME.like(apiLog.getOperName()));
        }
        if (StringUtils.hasText(apiLog.getRequestUrl())) {
            query.and(SYS_API_LOG.REQUEST_URL.like(apiLog.getRequestUrl()));
        }
        if (apiLog.getStatus() != null) {
            query.and(SYS_API_LOG.STATUS.eq(apiLog.getStatus()));
        }

        query.orderBy(SYS_API_LOG.CREATE_TIME.desc());
        return this.list(query);
    }
}
