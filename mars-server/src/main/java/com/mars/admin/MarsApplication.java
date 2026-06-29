package com.mars.admin;

import com.mars.admin.framework.anno.MarsAdminStarter;
import org.springframework.boot.SpringApplication;

/**
 * 启动类
 *
 * @author 程序员Mars
 * @version 1.0
 * @date 2026-06-05
 */
@MarsAdminStarter
public class MarsApplication {


    public static void main(String[] args) {
        SpringApplication.run(MarsApplication.class, args);
    }
}
