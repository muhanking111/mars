package com.mars.admin.modules.system.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.mybatisflex.annotation.Column;
import com.mybatisflex.annotation.Id;
import com.mybatisflex.annotation.KeyType;
import com.mybatisflex.annotation.Table;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * 接口请求日志
 */
@Data
@Accessors(chain = true)
@Table("sys_api_log")
@Schema(description = "接口请求日志")
public class SysApiLog implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id(keyType = KeyType.Auto)
    private Long id;

    @Column("trace_id")
    private String traceId;

    @Column("request_method")
    private String requestMethod;

    @Column("request_url")
    private String requestUrl;

    @Column("class_method")
    private String classMethod;

    @Column("oper_name")
    private String operName;

    @Column("oper_ip")
    private String operIp;

    @Column("oper_location")
    private String operLocation;

    @Column("browser")
    private String browser;

    @Column("os")
    private String os;

    @Column("request_params")
    private String requestParams;

    @Column("response_body")
    private String responseBody;

    @Column("response_code")
    private Integer responseCode;

    /** 0-正常 1-异常 */
    @Column("status")
    private Integer status;

    @Column("error_msg")
    private String errorMsg;

    @Column("cost_time")
    private Long costTime;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Column(value = "create_time", onInsertValue = "now()")
    private LocalDateTime createTime;
}
