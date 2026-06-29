package com.mars.admin.modules.system.mapper;

import com.mars.admin.modules.base.mapper.BasePlusMapper;
import com.mars.admin.modules.system.entity.SysApiLog;
import org.apache.ibatis.annotations.Mapper;

/**
 * 接口日志 Mapper
 */
@Mapper
public interface SysApiLogMapper extends BasePlusMapper<SysApiLog> {

    int cleanApiLog();
}
