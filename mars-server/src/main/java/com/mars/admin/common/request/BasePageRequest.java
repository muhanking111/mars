package com.mars.admin.common.request;

import lombok.Data;

/**
 * 代码领取微信公众号【程序员Mars】
 *
 * @className: BasePageRequest
 * @author: Mars
 * @date: 2025/7/30 0:40
 */
@Data
public class BasePageRequest {


    /**
     * 当前页码
     */
    private Integer current = 1;

    /**
     * 每页数量
     */
    private Integer size = 10;
    
    // 为了兼容性，保留原有的getter方法
    public Integer getPageNumber() {
        return current;
    }
    
    public Integer getPageSize() {
        return size;
    }
}
