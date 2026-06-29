/*
 Navicat Premium Dump SQL

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80032 (8.0.32)
 Source Host           : localhost:3306
 Source Schema         : chaoyou

 Target Server Type    : MySQL
 Target Server Version : 80032 (8.0.32)
 File Encoding         : 65001

 Date: 28/07/2025 10:04:10
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'N' COMMENT '系统内置：Y-是，N-否',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建人',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新人',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除：0-否，1-是',
  `delete_time` datetime NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_config_key`(`config_key` ASC) USING BTREE,
  INDEX `idx_config_type`(`config_type` ASC) USING BTREE,
  INDEX `idx_is_deleted`(`is_deleted` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '参数配置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow', '2025-06-25 16:34:16', '2025-06-25 16:34:16', 1, NULL, 0, NULL);
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', '初始化密码 123456', '2025-06-25 16:34:16', '2025-06-25 16:34:16', 1, NULL, 0, NULL);
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', '深色主题theme-dark，浅色主题theme-light', '2025-06-25 16:34:16', '2025-06-25 16:34:16', 1, NULL, 0, NULL);

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门ID',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父部门ID，0为根部门',
  `ancestors` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '部门名称',
  `dept_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '部门编码',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '状态：0-停用，1-正常',
  `is_system` tinyint(1) NULL DEFAULT 0 COMMENT '是否系统部门：0-否，1-是(不可删除)',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建人',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新人',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除：0-否，1-是',
  `delete_time` datetime NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_dept_code`(`dept_code` ASC) USING BTREE,
  INDEX `idx_parent_id`(`parent_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_order_num`(`order_num` ASC) USING BTREE,
  INDEX `idx_is_deleted`(`is_deleted` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 109 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '系统部门表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', '总公司', 'HEAD_OFFICE', 0, 'admin', '18483678969', '123@qq.com', 1, 1, '1212111', '2025-06-25 16:34:16', '2025-06-28 23:29:14', 1, 1, 0, NULL);
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', '技术部', 'TECH_DEPT', 1, 'admin', '18483678969', '123@qq.com', 1, 1, NULL, '2025-06-25 16:34:16', '2025-06-28 22:10:01', 1, NULL, 0, NULL);
INSERT INTO `sys_dept` VALUES (102, 100, '0,100', '运营部', 'OPERATION_DEPT', 2, 'admin', '18483678969', '123@qq.com', 1, 1, NULL, '2025-06-25 16:34:16', '2025-06-28 22:10:01', 1, NULL, 0, NULL);
INSERT INTO `sys_dept` VALUES (103, 100, '0,100', '财务部', 'FINANCE_DEPT', 3, 'admin', '18483678969', '123@qq.com', 1, 1, NULL, '2025-06-25 16:34:16', '2025-06-28 22:11:17', 1, NULL, 1, '2025-06-28 22:11:17');
INSERT INTO `sys_dept` VALUES (104, 100, '0,100', '11', '212', 0, '12', '18483678369', '123@qq.com', 1, NULL, '1212', '2025-06-28 22:16:30', '2025-06-28 23:27:43', 1, NULL, 1, '2025-06-28 23:27:43');
INSERT INTO `sys_dept` VALUES (105, 100, '0,100', '11', '11', 22, '11', '18483678369', '123@qq.com', 1, NULL, '', '2025-06-28 23:29:45', '2025-06-28 23:30:16', 1, NULL, 1, '2025-06-28 23:30:16');
INSERT INTO `sys_dept` VALUES (108, 100, '0,100', '11', '2121233', 0, '12', '18483678369', '123@qq.com', 1, NULL, '', '2025-06-28 23:33:59', '2025-06-28 23:34:17', 1, NULL, 1, '2025-06-28 23:34:17');

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '样式属性',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'N' COMMENT '是否默认：Y-是，N-否',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '状态：0-停用，1-正常',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建人',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新人',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除：0-否，1-是',
  `delete_time` datetime NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_dict_type`(`dict_type` ASC) USING BTREE,
  INDEX `idx_dict_sort`(`dict_sort` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_is_deleted`(`is_deleted` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '字典数据表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', 1, '性别男', '2025-06-25 16:34:16', '2025-06-25 16:34:16', 1, NULL, 0, NULL);
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', 1, '性别女', '2025-06-25 16:34:16', '2025-06-25 16:34:16', 1, NULL, 0, NULL);
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', 1, '性别未知', '2025-06-25 16:34:16', '2025-06-25 16:34:16', 1, NULL, 0, NULL);
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', 1, '显示菜单', '2025-06-25 16:34:16', '2025-06-25 16:34:16', 1, NULL, 0, NULL);
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', 1, '隐藏菜单', '2025-06-25 16:34:16', '2025-06-25 16:34:16', 1, NULL, 0, NULL);
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', 1, '正常状态', '2025-06-25 16:34:16', '2025-06-25 16:34:16', 1, NULL, 0, NULL);
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', 1, '停用状态', '2025-06-25 16:34:16', '2025-06-25 16:34:16', 1, NULL, 0, NULL);
INSERT INTO `sys_dict_data` VALUES (8, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', 1, '系统默认是', '2025-06-25 16:34:16', '2025-06-25 16:34:16', 1, NULL, 0, NULL);
INSERT INTO `sys_dict_data` VALUES (9, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', 1, '系统默认否', '2025-06-25 16:34:16', '2025-06-25 16:34:16', 1, NULL, 0, NULL);
INSERT INTO `sys_dict_data` VALUES (10, 0, '1', '1', 'test', '', '', 'N', 1, '', '2025-07-08 13:54:37', '2025-07-08 13:54:41', NULL, NULL, 1, '2025-07-08 13:54:41');

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '字典类型',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '状态：0-停用，1-正常',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建人',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新人',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除：0-否，1-是',
  `delete_time` datetime NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_dict_type`(`dict_type` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_is_deleted`(`is_deleted` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '字典类型表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', 1, '用户性别列表', '2025-06-25 16:34:16', '2025-06-25 16:34:16', 1, NULL, 0, NULL);
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', 1, '菜单状态列表', '2025-06-25 16:34:16', '2025-06-25 16:34:16', 1, NULL, 0, NULL);
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', 1, '系统开关列表', '2025-06-25 16:34:16', '2025-06-25 16:34:16', 1, NULL, 0, NULL);
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', 1, '任务状态列表', '2025-06-25 16:34:16', '2025-07-01 11:43:42', 1, NULL, 1, '2025-07-01 11:43:42');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', 1, '任务分组列表', '2025-06-25 16:34:16', '2025-06-25 16:34:16', 1, NULL, 0, NULL);
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', 1, '系统是否列表', '2025-06-25 16:34:16', '2025-06-25 16:34:16', 1, NULL, 0, NULL);
INSERT INTO `sys_dict_type` VALUES (7, '测试', 'test', 1, '', '2025-07-08 13:54:29', '2025-07-08 13:54:44', 1, NULL, 1, '2025-07-08 13:54:44');

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0' COMMENT '登录状态：0-成功，1-失败',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '提示消息',
  `login_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '访问时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_name`(`user_name` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_login_time`(`login_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 198 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '系统访问记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (1, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '密码错误', '2025-06-25 21:04:58');
INSERT INTO `sys_logininfor` VALUES (2, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '密码错误', '2025-06-25 21:05:07');
INSERT INTO `sys_logininfor` VALUES (3, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '0', '密码错误', '2025-06-25 21:06:52');
INSERT INTO `sys_logininfor` VALUES (4, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-06-25 21:07:03');
INSERT INTO `sys_logininfor` VALUES (5, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-06-25 22:35:10');
INSERT INTO `sys_logininfor` VALUES (6, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-06-25 22:55:40');
INSERT INTO `sys_logininfor` VALUES (7, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-06-25 22:59:21');
INSERT INTO `sys_logininfor` VALUES (8, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-06-25 23:02:06');
INSERT INTO `sys_logininfor` VALUES (9, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '2', '退出成功', '2025-06-25 23:04:17');
INSERT INTO `sys_logininfor` VALUES (10, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-06-25 23:04:30');
INSERT INTO `sys_logininfor` VALUES (11, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-06-25 23:05:48');
INSERT INTO `sys_logininfor` VALUES (12, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-06-25 23:06:14');
INSERT INTO `sys_logininfor` VALUES (13, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-06-26 14:12:05');
INSERT INTO `sys_logininfor` VALUES (14, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-06-26 14:12:26');
INSERT INTO `sys_logininfor` VALUES (15, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-06-26 14:12:38');
INSERT INTO `sys_logininfor` VALUES (16, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-06-26 14:12:52');
INSERT INTO `sys_logininfor` VALUES (17, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-06-26 14:22:11');
INSERT INTO `sys_logininfor` VALUES (18, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-06-26 14:29:03');
INSERT INTO `sys_logininfor` VALUES (19, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-06-26 14:29:15');
INSERT INTO `sys_logininfor` VALUES (20, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-06-26 14:56:07');
INSERT INTO `sys_logininfor` VALUES (21, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-06-26 15:12:03');
INSERT INTO `sys_logininfor` VALUES (22, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-06-26 15:20:28');
INSERT INTO `sys_logininfor` VALUES (23, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-06-26 17:11:27');
INSERT INTO `sys_logininfor` VALUES (24, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-06-26 17:17:44');
INSERT INTO `sys_logininfor` VALUES (25, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-06-26 17:22:15');
INSERT INTO `sys_logininfor` VALUES (26, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-06-26 17:22:31');
INSERT INTO `sys_logininfor` VALUES (27, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-06-26 17:25:10');
INSERT INTO `sys_logininfor` VALUES (28, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-06-26 17:29:20');
INSERT INTO `sys_logininfor` VALUES (29, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-06-26 17:29:27');
INSERT INTO `sys_logininfor` VALUES (30, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-06-26 17:31:04');
INSERT INTO `sys_logininfor` VALUES (31, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-06-26 17:35:42');
INSERT INTO `sys_logininfor` VALUES (32, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-06-26 17:35:52');
INSERT INTO `sys_logininfor` VALUES (33, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-06-26 17:43:50');
INSERT INTO `sys_logininfor` VALUES (34, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-06-26 17:43:57');
INSERT INTO `sys_logininfor` VALUES (35, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-06-26 17:44:10');
INSERT INTO `sys_logininfor` VALUES (36, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-06-26 17:44:52');
INSERT INTO `sys_logininfor` VALUES (37, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-06-26 17:45:46');
INSERT INTO `sys_logininfor` VALUES (38, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-06-26 17:52:00');
INSERT INTO `sys_logininfor` VALUES (39, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-06-28 10:59:37');
INSERT INTO `sys_logininfor` VALUES (40, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-06-28 11:03:23');
INSERT INTO `sys_logininfor` VALUES (41, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-06-28 11:17:13');
INSERT INTO `sys_logininfor` VALUES (42, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-06-28 21:36:03');
INSERT INTO `sys_logininfor` VALUES (43, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-06-28 21:36:30');
INSERT INTO `sys_logininfor` VALUES (44, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-06-28 23:27:29');
INSERT INTO `sys_logininfor` VALUES (45, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-06-30 21:48:56');
INSERT INTO `sys_logininfor` VALUES (46, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-06-30 21:58:53');
INSERT INTO `sys_logininfor` VALUES (47, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-06-30 22:01:00');
INSERT INTO `sys_logininfor` VALUES (48, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-06-30 22:04:20');
INSERT INTO `sys_logininfor` VALUES (49, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-07-01 14:03:26');
INSERT INTO `sys_logininfor` VALUES (50, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-07-01 14:07:10');
INSERT INTO `sys_logininfor` VALUES (51, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-07-01 14:09:06');
INSERT INTO `sys_logininfor` VALUES (52, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-07-01 14:13:59');
INSERT INTO `sys_logininfor` VALUES (53, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-07-01 14:16:22');
INSERT INTO `sys_logininfor` VALUES (54, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-07-01 14:22:15');
INSERT INTO `sys_logininfor` VALUES (55, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-07-01 14:25:02');
INSERT INTO `sys_logininfor` VALUES (56, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-07-01 14:26:55');
INSERT INTO `sys_logininfor` VALUES (57, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-07-01 14:27:25');
INSERT INTO `sys_logininfor` VALUES (58, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-07-01 14:28:37');
INSERT INTO `sys_logininfor` VALUES (59, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-07-01 14:32:37');
INSERT INTO `sys_logininfor` VALUES (60, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-07-01 14:35:21');
INSERT INTO `sys_logininfor` VALUES (61, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-07-01 14:40:18');
INSERT INTO `sys_logininfor` VALUES (62, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-07-01 14:49:36');
INSERT INTO `sys_logininfor` VALUES (63, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-07-01 14:56:28');
INSERT INTO `sys_logininfor` VALUES (64, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-07-01 15:05:29');
INSERT INTO `sys_logininfor` VALUES (65, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-07-01 15:11:43');
INSERT INTO `sys_logininfor` VALUES (66, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-07-01 15:18:02');
INSERT INTO `sys_logininfor` VALUES (67, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-07-01 15:37:26');
INSERT INTO `sys_logininfor` VALUES (68, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-07-01 15:45:31');
INSERT INTO `sys_logininfor` VALUES (69, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-07-01 15:46:22');
INSERT INTO `sys_logininfor` VALUES (70, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-07-01 15:50:37');
INSERT INTO `sys_logininfor` VALUES (71, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-07-01 15:55:13');
INSERT INTO `sys_logininfor` VALUES (72, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-07-01 15:58:24');
INSERT INTO `sys_logininfor` VALUES (73, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-07-01 16:07:09');
INSERT INTO `sys_logininfor` VALUES (74, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-07-01 16:07:12');
INSERT INTO `sys_logininfor` VALUES (75, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-07-01 16:08:58');
INSERT INTO `sys_logininfor` VALUES (76, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-07-01 16:14:17');
INSERT INTO `sys_logininfor` VALUES (77, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-07-01 16:50:11');
INSERT INTO `sys_logininfor` VALUES (78, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-07-01 17:26:20');
INSERT INTO `sys_logininfor` VALUES (79, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-07-01 17:37:35');
INSERT INTO `sys_logininfor` VALUES (80, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-07-01 17:43:08');
INSERT INTO `sys_logininfor` VALUES (81, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-07-01 18:05:14');
INSERT INTO `sys_logininfor` VALUES (82, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-07-01 19:32:45');
INSERT INTO `sys_logininfor` VALUES (83, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-07-01 20:10:55');
INSERT INTO `sys_logininfor` VALUES (84, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-07-01 20:11:04');
INSERT INTO `sys_logininfor` VALUES (85, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-07-01 20:11:16');
INSERT INTO `sys_logininfor` VALUES (86, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-07-01 20:14:37');
INSERT INTO `sys_logininfor` VALUES (87, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-07-01 20:16:14');
INSERT INTO `sys_logininfor` VALUES (88, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-07-01 20:19:12');
INSERT INTO `sys_logininfor` VALUES (89, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-07-01 20:25:12');
INSERT INTO `sys_logininfor` VALUES (90, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, '1', '登录成功', '2025-07-01 22:17:41');
INSERT INTO `sys_logininfor` VALUES (91, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'Google Chrome', 'Windows 10', '0', '登录成功', '2025-07-03 13:55:36');
INSERT INTO `sys_logininfor` VALUES (92, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'Google Chrome', 'Windows 10', '0', '登录成功', '2025-07-03 14:24:48');
INSERT INTO `sys_logininfor` VALUES (93, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'Google Chrome', 'Windows 10', '0', '登录成功', '2025-07-03 14:42:17');
INSERT INTO `sys_logininfor` VALUES (94, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'Google Chrome', 'Windows 10', '0', '登录成功', '2025-07-03 14:47:27');
INSERT INTO `sys_logininfor` VALUES (95, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'Google Chrome', 'Windows 10', '0', '登录成功', '2025-07-03 14:48:07');
INSERT INTO `sys_logininfor` VALUES (96, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'Google Chrome', 'Windows 10', '0', '登录成功', '2025-07-03 14:48:28');
INSERT INTO `sys_logininfor` VALUES (97, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'Google Chrome', 'Windows 10', '0', '登录成功', '2025-07-03 14:48:52');
INSERT INTO `sys_logininfor` VALUES (98, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'Google Chrome', 'Windows 10', '0', '登录成功', '2025-07-03 14:50:08');
INSERT INTO `sys_logininfor` VALUES (99, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'Google Chrome', 'Windows 10', '0', '登录成功', '2025-07-03 14:51:01');
INSERT INTO `sys_logininfor` VALUES (100, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'Google Chrome', 'Windows 10', '0', '登录成功', '2025-07-03 14:52:15');
INSERT INTO `sys_logininfor` VALUES (101, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'Google Chrome', 'Windows 10', '0', '登录成功', '2025-07-03 14:53:41');
INSERT INTO `sys_logininfor` VALUES (102, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'Google Chrome', 'Windows 10', '0', '登录成功', '2025-07-03 14:54:25');
INSERT INTO `sys_logininfor` VALUES (103, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'Google Chrome', 'Windows 10', '0', '登录成功', '2025-07-03 14:58:41');
INSERT INTO `sys_logininfor` VALUES (104, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'Google Chrome', 'Windows 10', '0', '登录成功', '2025-07-03 15:48:20');
INSERT INTO `sys_logininfor` VALUES (105, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'Google Chrome', 'Windows 10', '0', '登录成功', '2025-07-03 16:01:37');
INSERT INTO `sys_logininfor` VALUES (106, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'Google Chrome', 'Windows 10', '0', '登录成功', '2025-07-03 16:48:44');
INSERT INTO `sys_logininfor` VALUES (107, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'Google Chrome', 'Windows 10', '0', '登录成功', '2025-07-03 16:49:58');
INSERT INTO `sys_logininfor` VALUES (108, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'Google Chrome', 'Windows 10', '0', '登录成功', '2025-07-03 17:06:47');
INSERT INTO `sys_logininfor` VALUES (109, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'Google Chrome', 'Windows 10', '0', '登录成功', '2025-07-03 17:08:45');
INSERT INTO `sys_logininfor` VALUES (110, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'Google Chrome', 'Windows 10', '0', '登录成功', '2025-07-04 09:56:06');
INSERT INTO `sys_logininfor` VALUES (111, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'Google Chrome', 'Windows 10', '0', '登录成功', '2025-07-04 10:36:19');
INSERT INTO `sys_logininfor` VALUES (112, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'Google Chrome', 'Windows 10', '0', '密码错误', '2025-07-04 11:10:58');
INSERT INTO `sys_logininfor` VALUES (113, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'Google Chrome', 'Windows 10', '0', '登录成功', '2025-07-04 11:11:04');
INSERT INTO `sys_logininfor` VALUES (114, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'Google Chrome', 'Windows 10', '0', '登录成功', '2025-07-04 11:11:36');
INSERT INTO `sys_logininfor` VALUES (115, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'Google Chrome', 'Windows 10', '0', '登录成功', '2025-07-04 13:46:54');
INSERT INTO `sys_logininfor` VALUES (116, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'Google Chrome', 'Windows 10', '0', '登录成功', '2025-07-04 13:56:25');
INSERT INTO `sys_logininfor` VALUES (117, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'Google Chrome', 'Windows 10', '0', '登录成功', '2025-07-04 14:43:37');
INSERT INTO `sys_logininfor` VALUES (118, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'Google Chrome', 'Windows 10', '0', '登录成功', '2025-07-04 15:57:49');
INSERT INTO `sys_logininfor` VALUES (119, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'Google Chrome', 'Windows 10', '0', '登录成功', '2025-07-04 16:55:58');
INSERT INTO `sys_logininfor` VALUES (120, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'Google Chrome', 'Windows 10', '0', '登录成功', '2025-07-08 11:25:55');
INSERT INTO `sys_logininfor` VALUES (121, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'Google Chrome', 'Windows 10', '0', '登录成功', '2025-07-08 11:31:28');
INSERT INTO `sys_logininfor` VALUES (122, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'Google Chrome', 'Windows 10', '0', '登录成功', '2025-07-08 11:33:37');
INSERT INTO `sys_logininfor` VALUES (123, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'Google Chrome', 'Windows 10', '0', '登录成功', '2025-07-08 11:50:33');
INSERT INTO `sys_logininfor` VALUES (124, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'Google Chrome', 'Windows 10', '0', '登录成功', '2025-07-08 11:52:34');
INSERT INTO `sys_logininfor` VALUES (125, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'Google Chrome', 'Windows 10', '0', '登录成功', '2025-07-08 11:54:26');
INSERT INTO `sys_logininfor` VALUES (126, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'Google Chrome', 'Windows 10', '0', '登录成功', '2025-07-08 11:58:15');
INSERT INTO `sys_logininfor` VALUES (127, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'Google Chrome', 'Windows 10', '0', '登录成功', '2025-07-08 12:00:39');
INSERT INTO `sys_logininfor` VALUES (128, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'Google Chrome', 'Windows 10', '0', '登录成功', '2025-07-08 13:49:02');
INSERT INTO `sys_logininfor` VALUES (129, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'Google Chrome', 'Windows 10', '0', '登录成功', '2025-07-08 13:55:48');
INSERT INTO `sys_logininfor` VALUES (130, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'Google Chrome', 'Windows 10', '0', '登录成功', '2025-07-08 14:26:58');
INSERT INTO `sys_logininfor` VALUES (131, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'Google Chrome', 'Windows 10', '0', '登录成功', '2025-07-08 15:27:08');
INSERT INTO `sys_logininfor` VALUES (132, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'Google Chrome', 'Windows 10', '0', '登录成功', '2025-07-08 15:55:32');
INSERT INTO `sys_logininfor` VALUES (133, 'admin', '127.0.0.1', '内网IP', 'Google Chrome', 'Windows 10', '0', 'PC端登录成功', '2025-07-08 17:07:08');
INSERT INTO `sys_logininfor` VALUES (134, 'admin', '127.0.0.1', '内网IP', 'Microsoft Edge', 'Windows 10', '0', 'PC端登录成功', '2025-07-08 17:34:41');
INSERT INTO `sys_logininfor` VALUES (135, 'admin', '127.0.0.1', '内网IP', 'Microsoft Edge', 'Windows 10', '0', 'PC端登录成功', '2025-07-08 17:38:47');
INSERT INTO `sys_logininfor` VALUES (136, 'admin', '127.0.0.1', '内网IP', 'Google Chrome', 'Windows 10', '0', 'PC端登录成功', '2025-07-09 15:29:31');
INSERT INTO `sys_logininfor` VALUES (137, 'admin', '127.0.0.1', '内网IP', 'Google Chrome', 'Windows 10', '0', 'PC端登录成功', '2025-07-09 15:46:15');
INSERT INTO `sys_logininfor` VALUES (138, 'admin', '127.0.0.1', '内网IP', 'Google Chrome', 'Windows 10', '0', 'PC端登录成功', '2025-07-09 15:47:45');
INSERT INTO `sys_logininfor` VALUES (139, 'admin', '127.0.0.1', '内网IP', 'Google Chrome', 'Windows 10', '0', 'PC端登录成功', '2025-07-09 15:49:53');
INSERT INTO `sys_logininfor` VALUES (140, 'admin', '127.0.0.1', '内网IP', 'Google Chrome', 'Windows 10', '0', 'PC端登录成功', '2025-07-09 15:54:13');
INSERT INTO `sys_logininfor` VALUES (141, 'admin', '127.0.0.1', '内网IP', 'Microsoft Edge', 'Windows 10', '0', 'PC端登录成功', '2025-07-09 15:54:24');
INSERT INTO `sys_logininfor` VALUES (142, 'admin', '127.0.0.1', '内网IP', 'Google Chrome', 'Windows 10', '0', 'PC端登录成功', '2025-07-09 15:54:30');
INSERT INTO `sys_logininfor` VALUES (143, 'admin', '127.0.0.1', '内网IP', 'Google Chrome', 'Windows 10', '0', 'PC端登录成功', '2025-07-09 16:25:08');
INSERT INTO `sys_logininfor` VALUES (144, 'opzUF43XlvnVUw5S9qS2cI6L7p9M', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '0', '小程序登录成功', '2025-07-26 18:11:12');
INSERT INTO `sys_logininfor` VALUES (145, 'opzUF43XlvnVUw5S9qS2cI6L7p9M', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '0', '小程序登录成功', '2025-07-26 18:12:21');
INSERT INTO `sys_logininfor` VALUES (146, 'opzUF43XlvnVUw5S9qS2cI6L7p9M', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '0', '小程序登录成功', '2025-07-26 19:31:08');
INSERT INTO `sys_logininfor` VALUES (147, 'opzUF43XlvnVUw5S9qS2cI6L7p9M', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '0', '小程序登录成功', '2025-07-26 19:52:00');
INSERT INTO `sys_logininfor` VALUES (148, 'opzUF43XlvnVUw5S9qS2cI6L7p9M', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '0', '小程序登录成功', '2025-07-26 19:52:40');
INSERT INTO `sys_logininfor` VALUES (149, 'opzUF43XlvnVUw5S9qS2cI6L7p9M', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '0', '小程序登录成功', '2025-07-26 19:57:54');
INSERT INTO `sys_logininfor` VALUES (150, 'opzUF43XlvnVUw5S9qS2cI6L7p9M', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '0', '小程序登录成功', '2025-07-26 19:59:54');
INSERT INTO `sys_logininfor` VALUES (151, 'opzUF43XlvnVUw5S9qS2cI6L7p9M', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '0', '小程序登录成功', '2025-07-26 20:02:36');
INSERT INTO `sys_logininfor` VALUES (152, 'opzUF43XlvnVUw5S9qS2cI6L7p9M', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '0', '小程序登录成功', '2025-07-26 20:03:52');
INSERT INTO `sys_logininfor` VALUES (153, 'opzUF43XlvnVUw5S9qS2cI6L7p9M', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '0', '小程序登录成功', '2025-07-26 20:12:58');
INSERT INTO `sys_logininfor` VALUES (154, 'opzUF43XlvnVUw5S9qS2cI6L7p9M', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '0', '小程序登录成功', '2025-07-26 20:16:02');
INSERT INTO `sys_logininfor` VALUES (155, 'opzUF43XlvnVUw5S9qS2cI6L7p9M', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '0', '小程序登录成功', '2025-07-26 20:17:37');
INSERT INTO `sys_logininfor` VALUES (156, 'opzUF43XlvnVUw5S9qS2cI6L7p9M', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '0', '小程序登录成功', '2025-07-26 21:06:09');
INSERT INTO `sys_logininfor` VALUES (157, 'opzUF43XlvnVUw5S9qS2cI6L7p9M', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '0', '小程序登录成功', '2025-07-26 21:28:43');
INSERT INTO `sys_logininfor` VALUES (158, 'opzUF43XlvnVUw5S9qS2cI6L7p9M', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '0', '小程序登录成功', '2025-07-27 10:44:51');
INSERT INTO `sys_logininfor` VALUES (159, 'opzUF43XlvnVUw5S9qS2cI6L7p9M', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '0', '小程序登录成功', '2025-07-27 10:47:58');
INSERT INTO `sys_logininfor` VALUES (160, 'opzUF43XlvnVUw5S9qS2cI6L7p9M', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '0', '小程序登录成功', '2025-07-27 11:13:19');
INSERT INTO `sys_logininfor` VALUES (161, 'opzUF43XlvnVUw5S9qS2cI6L7p9M', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '0', '小程序登录成功', '2025-07-27 11:30:29');
INSERT INTO `sys_logininfor` VALUES (162, 'opzUF43XlvnVUw5S9qS2cI6L7p9M', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '0', '小程序登录成功', '2025-07-27 11:36:03');
INSERT INTO `sys_logininfor` VALUES (163, 'opzUF43XlvnVUw5S9qS2cI6L7p9M', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '0', '小程序登录成功', '2025-07-27 11:36:28');
INSERT INTO `sys_logininfor` VALUES (164, 'opzUF43XlvnVUw5S9qS2cI6L7p9M', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '0', '小程序登录成功', '2025-07-27 11:37:49');
INSERT INTO `sys_logininfor` VALUES (165, 'opzUF43XlvnVUw5S9qS2cI6L7p9M', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '0', '小程序登录成功', '2025-07-27 11:38:46');
INSERT INTO `sys_logininfor` VALUES (166, 'opzUF43XlvnVUw5S9qS2cI6L7p9M', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '0', '小程序登录成功', '2025-07-27 11:39:51');
INSERT INTO `sys_logininfor` VALUES (167, 'opzUF43XlvnVUw5S9qS2cI6L7p9M', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '0', '小程序登录成功', '2025-07-27 11:59:53');
INSERT INTO `sys_logininfor` VALUES (168, 'opzUF43XlvnVUw5S9qS2cI6L7p9M', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '0', '小程序登录成功', '2025-07-27 12:42:49');
INSERT INTO `sys_logininfor` VALUES (169, 'opzUF43XlvnVUw5S9qS2cI6L7p9M', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '0', '小程序登录成功', '2025-07-27 12:46:22');
INSERT INTO `sys_logininfor` VALUES (170, 'opzUF43XlvnVUw5S9qS2cI6L7p9M', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '0', '小程序登录成功', '2025-07-27 13:01:15');
INSERT INTO `sys_logininfor` VALUES (171, 'opzUF43XlvnVUw5S9qS2cI6L7p9M', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '0', '小程序登录成功', '2025-07-27 13:07:09');
INSERT INTO `sys_logininfor` VALUES (172, 'opzUF43XlvnVUw5S9qS2cI6L7p9M', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '0', '小程序登录成功', '2025-07-27 13:11:21');
INSERT INTO `sys_logininfor` VALUES (173, 'opzUF43XlvnVUw5S9qS2cI6L7p9M', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '0', '小程序登录成功', '2025-07-27 13:13:23');
INSERT INTO `sys_logininfor` VALUES (174, 'opzUF43XlvnVUw5S9qS2cI6L7p9M', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '0', '小程序登录成功', '2025-07-27 13:49:02');
INSERT INTO `sys_logininfor` VALUES (175, 'opzUF43XlvnVUw5S9qS2cI6L7p9M', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '0', '小程序登录成功', '2025-07-27 14:00:54');
INSERT INTO `sys_logininfor` VALUES (176, 'opzUF43XlvnVUw5S9qS2cI6L7p9M', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '0', '小程序登录成功', '2025-07-27 14:07:05');
INSERT INTO `sys_logininfor` VALUES (177, 'opzUF43XlvnVUw5S9qS2cI6L7p9M', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '0', '小程序登录成功', '2025-07-27 14:23:28');
INSERT INTO `sys_logininfor` VALUES (178, 'opzUF43XlvnVUw5S9qS2cI6L7p9M', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '0', '小程序登录成功', '2025-07-27 14:29:48');
INSERT INTO `sys_logininfor` VALUES (179, 'opzUF43XlvnVUw5S9qS2cI6L7p9M', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '0', '小程序登录成功', '2025-07-27 14:32:02');
INSERT INTO `sys_logininfor` VALUES (180, 'opzUF43XlvnVUw5S9qS2cI6L7p9M', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '0', '小程序登录成功', '2025-07-27 14:36:11');
INSERT INTO `sys_logininfor` VALUES (181, 'opzUF43XlvnVUw5S9qS2cI6L7p9M', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '0', '小程序登录成功', '2025-07-27 16:34:50');
INSERT INTO `sys_logininfor` VALUES (182, 'lisi', '127.0.0.1', '内网IP', 'Google Chrome', 'Windows 10', '0', '用户不存在', '2025-07-27 17:07:26');
INSERT INTO `sys_logininfor` VALUES (183, 'admin', '127.0.0.1', '内网IP', 'Google Chrome', 'Windows 10', '0', 'PC端登录成功', '2025-07-27 17:09:21');
INSERT INTO `sys_logininfor` VALUES (184, 'opzUF43XlvnVUw5S9qS2cI6L7p9M', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '0', '小程序登录成功', '2025-07-27 17:39:05');
INSERT INTO `sys_logininfor` VALUES (185, 'opzUF43XlvnVUw5S9qS2cI6L7p9M', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '0', '小程序登录成功', '2025-07-27 17:50:44');
INSERT INTO `sys_logininfor` VALUES (186, 'opzUF43XlvnVUw5S9qS2cI6L7p9M', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '0', '小程序登录成功', '2025-07-27 18:04:17');
INSERT INTO `sys_logininfor` VALUES (187, 'opzUF43XlvnVUw5S9qS2cI6L7p9M', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '0', '小程序登录成功', '2025-07-27 19:08:08');
INSERT INTO `sys_logininfor` VALUES (188, 'lisi', '127.0.0.1', '内网IP', 'Google Chrome', 'Windows 10', '0', 'PC端登录成功', '2025-07-27 19:18:56');
INSERT INTO `sys_logininfor` VALUES (189, 'opzUF43XlvnVUw5S9qS2cI6L7p9M', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '0', '小程序登录成功', '2025-07-27 19:22:51');
INSERT INTO `sys_logininfor` VALUES (190, 'opzUF43XlvnVUw5S9qS2cI6L7p9M', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '0', '小程序登录成功', '2025-07-27 19:34:51');
INSERT INTO `sys_logininfor` VALUES (191, 'opzUF43XlvnVUw5S9qS2cI6L7p9M', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '0', '小程序登录成功', '2025-07-27 20:08:49');
INSERT INTO `sys_logininfor` VALUES (192, 'opzUF43XlvnVUw5S9qS2cI6L7p9M', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '0', '小程序登录成功', '2025-07-27 20:54:21');
INSERT INTO `sys_logininfor` VALUES (193, '18483678377', '127.0.0.1', '内网IP', 'Google Chrome', 'Linux', '0', 'APP登录成功', '2025-07-27 21:15:55');
INSERT INTO `sys_logininfor` VALUES (194, 'lisi', '127.0.0.1', '内网IP', 'Google Chrome', 'Windows 10', '0', 'PC端登录成功', '2025-07-27 21:19:36');
INSERT INTO `sys_logininfor` VALUES (195, 'admin', '127.0.0.1', '内网IP', 'Google Chrome', 'Windows 10', '0', 'PC端登录成功', '2025-07-27 21:20:45');
INSERT INTO `sys_logininfor` VALUES (196, 'opzUF43XlvnVUw5S9qS2cI6L7p9M', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '0', '小程序登录成功', '2025-07-27 21:28:32');
INSERT INTO `sys_logininfor` VALUES (197, 'opzUF43XlvnVUw5S9qS2cI6L7p9M', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '0', '小程序登录成功', '2025-07-27 21:45:08');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父菜单ID，0为根菜单',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '菜单名称',
  `menu_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '菜单编码',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '菜单类型：M-目录，C-菜单，F-按钮',
  `route_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '路由名称',
  `route_path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '路由地址',
  `component` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '组件路径',
  `redirect` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '重定向地址',
  `query_param` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '路由参数',
  `is_frame` tinyint(1) NULL DEFAULT 1 COMMENT '是否为外链：0-是，1-否',
  `is_cache` tinyint(1) NULL DEFAULT 0 COMMENT '是否缓存：0-缓存，1-不缓存',
  `menu_type_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '菜单类型标识',
  `visible` tinyint(1) NULL DEFAULT 1 COMMENT '菜单状态：0-隐藏，1-显示',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '菜单状态：0-停用，1-正常',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '菜单图标',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `is_system` tinyint(1) NULL DEFAULT 0 COMMENT '是否系统菜单：0-否，1-是(不可删除)',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建人',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新人',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除：0-否，1-是',
  `delete_time` datetime NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_menu_code`(`menu_code` ASC) USING BTREE,
  INDEX `idx_parent_id`(`parent_id` ASC) USING BTREE,
  INDEX `idx_menu_type`(`menu_type` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_visible`(`visible` ASC) USING BTREE,
  INDEX `idx_order_num`(`order_num` ASC) USING BTREE,
  INDEX `idx_is_deleted`(`is_deleted` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 30312 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '系统菜单权限表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, 0, '系统管理', 'SYSTEM', 'M', 'manage', '/manage', 'layout.base', NULL, NULL, 1, 0, '', 1, 1, '', 'hugeicons:ai-setting', 1, 1, NULL, '2025-06-25 16:34:16', '2025-07-08 14:46:38', 1, NULL, 0, NULL);
INSERT INTO `sys_menu` VALUES (2, 0, '系统运维', 'MONITOR', 'M', 'monitor', '/monitor', 'layout.base', NULL, NULL, 1, 0, '', 1, 1, '', 'pepicons-pencil:monitor', 2, 1, NULL, '2025-06-25 16:34:16', '2025-07-08 14:29:08', 1, 1, 0, NULL);
INSERT INTO `sys_menu` VALUES (3, 0, '系统工具', 'TOOL', 'M', 'tool', '/tool', 'layout.base', NULL, NULL, 1, 0, '', 1, 1, '', 'tool', 3, 1, NULL, '2025-06-25 16:34:16', '2025-07-08 13:59:51', 1, NULL, 1, '2025-07-08 13:59:51');
INSERT INTO `sys_menu` VALUES (100, 1018, '用户列表', 'USER_MANAGE', 'C', 'manage_user', '/manage/user', 'view.manage_user', NULL, NULL, 1, 0, '', 1, 1, 'system:user:list', 'tabler:users', 1, 1, NULL, '2025-06-25 16:34:16', '2025-07-08 14:51:22', 1, 1, 0, NULL);
INSERT INTO `sys_menu` VALUES (101, 1017, '角色管理', 'ROLE_MANAGE', 'C', 'manage_role', '/manage/role', 'view.manage_role', NULL, NULL, 1, 0, '', 1, 1, 'system:role:list', 'peoples', 2, 1, NULL, '2025-06-25 16:34:16', '2025-06-30 21:54:17', 1, NULL, 0, NULL);
INSERT INTO `sys_menu` VALUES (102, 1017, '菜单管理', 'MENU_MANAGE', 'C', 'manage_menu', '/manage/menu', 'view.manage_menu', NULL, NULL, 1, 0, '', 1, 1, 'system:menu:list', 'bi:menu-button-wide', 3, 1, NULL, '2025-06-25 16:34:16', '2025-07-08 14:35:09', 1, NULL, 0, NULL);
INSERT INTO `sys_menu` VALUES (103, 30306, '部门管理', 'DEPT_MANAGE', 'C', 'manage_dept', '/manage/dept', 'view.manage_dept', NULL, NULL, 1, 0, '', 1, 1, 'system:dept:list', 'fluent:organization-32-regular', 4, 1, NULL, '2025-06-25 16:34:16', '2025-07-08 14:23:43', 1, 1, 0, NULL);
INSERT INTO `sys_menu` VALUES (104, 30306, '岗位管理', 'POST_MANAGE', 'C', 'manage_post', '/manage/post', 'view.manage_post', NULL, NULL, 1, 0, '', 1, 1, 'system:post:list', 'post', 5, 1, NULL, '2025-06-25 16:34:16', '2025-07-03 15:46:58', 1, 1, 0, NULL);
INSERT INTO `sys_menu` VALUES (105, 1, '字典管理', 'DICT_MANAGE', 'C', 'manage_dict', '/manage/dict', 'view.manage_dict', NULL, NULL, 1, 0, '', 1, 1, 'system:dict:list', 'dict', 6, 1, NULL, '2025-06-25 16:34:16', '2025-06-26 15:02:40', 1, NULL, 0, NULL);
INSERT INTO `sys_menu` VALUES (106, 1, '参数设置', 'CONFIG_MANAGE', 'C', 'manage_config', '/manage/config', 'view.manage_config', NULL, NULL, 1, 0, '', 1, 1, 'system:config:list', 'edit', 7, 1, NULL, '2025-06-25 16:34:16', '2025-06-26 15:02:49', 1, NULL, 0, NULL);
INSERT INTO `sys_menu` VALUES (107, 2, '缓存监控', 'CACHE_MONITOR', 'C', 'manage_cache-monitor', '/manage/cache-monitor', 'view.manage_cache-monitor', NULL, NULL, 1, 0, '', 1, 1, 'system:cache:monitor', 'material-symbols:monitor-heart-outline', 8, 1, NULL, '2025-07-01 15:02:21', '2025-07-08 14:21:07', 1, 1, 0, NULL);
INSERT INTO `sys_menu` VALUES (108, 2, '缓存列表', 'CACHE_LIST', 'C', 'manage_cache-list', '/manage/cache-list', 'view.manage_cache-list', NULL, NULL, 1, 0, '', 1, 1, 'system:cache:list', 'mdi:database-search', 9, 1, NULL, '2025-07-01 15:02:21', '2025-07-04 15:07:53', 1, 1, 0, NULL);
INSERT INTO `sys_menu` VALUES (109, 2, '系统监控', 'SYSTEM_MONITOR', 'C', 'manage_system-monitor', '/manage/system-monitor', 'view.manage_system-monitor', NULL, NULL, 1, 0, '', 1, 1, 'system:monitor:info', 'pepicons-pencil:monitor', 1, 0, NULL, '2025-07-04 14:47:37', '2025-07-08 14:17:20', NULL, NULL, 0, NULL);
INSERT INTO `sys_menu` VALUES (301, 0, '文件管理', 'FILE_MANAGE', 'M', 'file-manage', '/file-manage', '', NULL, NULL, 1, 0, '', 1, 1, '', 'clarity:directory-line', 11, 0, '文件管理主菜单', '2025-07-01 20:04:43', '2025-07-08 15:04:14', 1, 1, 0, NULL);
INSERT INTO `sys_menu` VALUES (302, 301, '文件列表', 'FILE_LIST', 'C', 'manage_file-manage', '/manage/file-manage', 'view.manage_file-manage', NULL, NULL, 1, 0, '', 1, 1, 'system:file:list', 'octicon:file-directory-open-fill-24', 1, 0, '文件列表管理', '2025-07-01 20:04:43', '2025-07-08 14:49:57', 1, 1, 0, NULL);
INSERT INTO `sys_menu` VALUES (303, 301, 'OSS配置', 'OSS_CONFIG', 'C', 'manage_oss-config', '/manage/oss-config', 'view.manage_oss-config', NULL, NULL, 1, 0, '', 1, 1, 'system:ossConfig:list', 'ic:round-storage', 2, 0, 'OSS配置管理', '2025-07-01 20:04:43', '2025-07-01 20:24:49', 1, 1, 0, NULL);
INSERT INTO `sys_menu` VALUES (1000, 100, '用户查询', 'USER_QUERY', 'F', '', '', '', NULL, NULL, 1, 0, '', 1, 1, 'system:user:query', '', 1, 1, NULL, '2025-06-25 16:34:16', '2025-06-25 16:34:16', 1, NULL, 0, NULL);
INSERT INTO `sys_menu` VALUES (1001, 100, '用户新增', 'USER_ADD', 'F', '', '', '', NULL, NULL, 1, 0, '', 1, 1, 'system:user:add', '', 2, 1, NULL, '2025-06-25 16:34:16', '2025-06-25 16:34:16', 1, NULL, 0, NULL);
INSERT INTO `sys_menu` VALUES (1002, 100, '用户修改', 'USER_EDIT', 'F', '', '', '', NULL, NULL, 1, 0, '', 1, 1, 'system:user:edit', '', 3, 1, NULL, '2025-06-25 16:34:16', '2025-06-25 16:34:16', 1, NULL, 0, NULL);
INSERT INTO `sys_menu` VALUES (1003, 100, '用户删除', 'USER_DELETE', 'F', '', '', '', NULL, NULL, 1, 0, '', 1, 1, 'system:user:remove', '', 4, 1, NULL, '2025-06-25 16:34:16', '2025-06-25 16:34:16', 1, NULL, 0, NULL);
INSERT INTO `sys_menu` VALUES (1004, 100, '用户导出', 'USER_EXPORT', 'F', '', '', '', NULL, NULL, 1, 0, '', 1, 1, 'system:user:export', '', 5, 1, NULL, '2025-06-25 16:34:16', '2025-06-25 16:34:16', 1, NULL, 0, NULL);
INSERT INTO `sys_menu` VALUES (1005, 100, '用户导入', 'USER_IMPORT', 'F', '', '', '', NULL, NULL, 1, 0, '', 1, 1, 'system:user:import', '', 6, 1, NULL, '2025-06-25 16:34:16', '2025-06-25 16:34:16', 1, NULL, 0, NULL);
INSERT INTO `sys_menu` VALUES (1006, 100, '重置密码', 'USER_RESET_PWD', 'F', '', '', '', NULL, NULL, 1, 0, '', 1, 1, 'system:user:resetPwd', '', 7, 1, NULL, '2025-06-25 16:34:16', '2025-06-25 16:34:16', 1, NULL, 0, NULL);
INSERT INTO `sys_menu` VALUES (1007, 101, '角色查询', 'ROLE_QUERY', 'F', '', '', '', NULL, NULL, 1, 0, '', 1, 1, 'system:role:query', '', 1, 1, NULL, '2025-06-25 16:34:16', '2025-06-25 16:34:16', 1, NULL, 0, NULL);
INSERT INTO `sys_menu` VALUES (1008, 101, '角色新增', 'ROLE_ADD', 'F', '', '', '', NULL, NULL, 1, 0, '', 1, 1, 'system:role:add', '', 2, 1, NULL, '2025-06-25 16:34:16', '2025-06-25 16:34:16', 1, NULL, 0, NULL);
INSERT INTO `sys_menu` VALUES (1009, 101, '角色修改', 'ROLE_EDIT', 'F', '', '', '', NULL, NULL, 1, 0, '', 1, 1, 'system:role:edit', '', 3, 1, NULL, '2025-06-25 16:34:16', '2025-06-25 16:34:16', 1, NULL, 0, NULL);
INSERT INTO `sys_menu` VALUES (1010, 101, '角色删除', 'ROLE_DELETE', 'F', '', '', '', NULL, NULL, 1, 0, '', 1, 1, 'system:role:remove', '', 4, 1, NULL, '2025-06-25 16:34:16', '2025-06-25 16:34:16', 1, NULL, 0, NULL);
INSERT INTO `sys_menu` VALUES (1011, 101, '角色导出', 'ROLE_EXPORT', 'F', '', '', '', NULL, NULL, 1, 0, '', 1, 1, 'system:role:export', '', 5, 1, NULL, '2025-06-25 16:34:16', '2025-06-25 16:34:16', 1, NULL, 0, NULL);
INSERT INTO `sys_menu` VALUES (1012, 102, '菜单查询', 'MENU_QUERY', 'F', '', '', '', NULL, NULL, 1, 0, '', 1, 1, 'system:menu:query', '', 1, 1, NULL, '2025-06-25 16:34:16', '2025-06-25 16:34:16', 1, NULL, 0, NULL);
INSERT INTO `sys_menu` VALUES (1013, 102, '菜单新增', 'MENU_ADD', 'F', '', '', '', NULL, NULL, 1, 0, '', 1, 1, 'system:menu:add', '', 2, 1, NULL, '2025-06-25 16:34:16', '2025-06-25 16:34:16', 1, NULL, 0, NULL);
INSERT INTO `sys_menu` VALUES (1014, 102, '菜单修改', 'MENU_EDIT', 'F', '', '', '', NULL, NULL, 1, 0, '', 1, 1, 'system:menu:edit', '', 3, 1, NULL, '2025-06-25 16:34:16', '2025-06-25 16:34:16', 1, NULL, 0, NULL);
INSERT INTO `sys_menu` VALUES (1015, 102, '菜单删除', 'MENU_DELETE', 'F', '', '', '', NULL, NULL, 1, 0, '', 1, 1, 'system:menu:remove', '', 4, 1, NULL, '2025-06-25 16:34:16', '2025-06-25 16:34:16', 1, NULL, 0, NULL);
INSERT INTO `sys_menu` VALUES (1016, 0, '首页', 'HOME', 'C', 'home', '/home', 'layout.base$view.home', NULL, NULL, 1, 0, '', 1, 1, NULL, 'ic:baseline-home', 0, 1, NULL, '2025-06-26 16:06:53', '2025-07-08 14:07:38', 1, NULL, 0, NULL);
INSERT INTO `sys_menu` VALUES (1017, 0, '权限管理', 'POWER', 'M', 'power', '/power', '', '', NULL, 1, 0, '', 1, 1, '', 'icon-park-outline:permissions', 20, NULL, NULL, '2025-06-30 21:51:59', '2025-07-08 14:33:08', 1, NULL, 0, NULL);
INSERT INTO `sys_menu` VALUES (1018, 0, '用户管理', 'USER', 'M', 'user', '/user', '', '', NULL, 1, 0, '', 1, 1, '', 'tabler:users', 30, NULL, NULL, '2025-06-30 21:56:53', '2025-07-08 14:51:11', 1, 1, 0, NULL);
INSERT INTO `sys_menu` VALUES (1070, 107, '缓存监控查询', 'CACHE_MONITOR_QUERY', 'F', '', '', '', NULL, NULL, 1, 0, '', 1, 1, 'system:cache:monitor:query', '', 1, 1, NULL, '2025-07-01 15:02:52', '2025-07-01 15:02:52', 1, NULL, 0, NULL);
INSERT INTO `sys_menu` VALUES (1071, 107, '缓存监控刷新', 'CACHE_MONITOR_REFRESH', 'F', '', '', '', NULL, NULL, 1, 0, '', 1, 1, 'system:cache:monitor:refresh', '', 2, 1, NULL, '2025-07-01 15:02:52', '2025-07-01 15:02:52', 1, NULL, 0, NULL);
INSERT INTO `sys_menu` VALUES (1072, 107, '缓存统计查询', 'CACHE_STATS_QUERY', 'F', '', '', '', NULL, NULL, 1, 0, '', 1, 1, 'system:cache:stats:query', '', 3, 1, NULL, '2025-07-01 15:02:52', '2025-07-01 15:02:52', 1, NULL, 0, NULL);
INSERT INTO `sys_menu` VALUES (1080, 108, '缓存列表查询', 'CACHE_LIST_QUERY', 'F', '', '', '', NULL, NULL, 1, 0, '', 1, 1, 'system:cache:list:query', '', 1, 1, NULL, '2025-07-01 15:02:58', '2025-07-01 15:02:58', 1, NULL, 0, NULL);
INSERT INTO `sys_menu` VALUES (1081, 108, '缓存详情查看', 'CACHE_DETAIL_VIEW', 'F', '', '', '', NULL, NULL, 1, 0, '', 1, 1, 'system:cache:detail:view', '', 2, 1, NULL, '2025-07-01 15:02:58', '2025-07-01 15:02:58', 1, NULL, 0, NULL);
INSERT INTO `sys_menu` VALUES (1082, 108, '缓存删除', 'CACHE_DELETE', 'F', '', '', '', NULL, NULL, 1, 0, '', 1, 1, 'system:cache:delete', '', 3, 1, NULL, '2025-07-01 15:02:58', '2025-07-01 15:02:58', 1, NULL, 0, NULL);
INSERT INTO `sys_menu` VALUES (1083, 108, '缓存批量删除', 'CACHE_BATCH_DELETE', 'F', '', '', '', NULL, NULL, 1, 0, '', 1, 1, 'system:cache:batch:delete', '', 4, 1, NULL, '2025-07-01 15:02:58', '2025-07-01 15:02:58', 1, NULL, 0, NULL);
INSERT INTO `sys_menu` VALUES (1084, 108, '缓存空间清空', 'CACHE_SPACE_CLEAR', 'F', '', '', '', NULL, NULL, 1, 0, '', 1, 1, 'system:cache:space:clear', '', 5, 1, NULL, '2025-07-01 15:02:58', '2025-07-01 15:02:58', 1, NULL, 0, NULL);
INSERT INTO `sys_menu` VALUES (2100, 0, '日志管理', 'LOG_MANAGE', 'M', 'log-manage', '/log-manage', '', NULL, NULL, 1, 0, '', 1, 1, '', 'ix:log', 10, 0, '日志管理目录', '2025-01-02 10:00:00', '2025-07-08 14:25:14', 1, 1, 0, NULL);
INSERT INTO `sys_menu` VALUES (2101, 2100, '操作日志', 'OPERATION_LOG', 'C', 'manage_operation-log', '/manage/operation-log', 'view.manage_operation-log', NULL, NULL, 1, 0, '', 1, 1, 'system:operlog:list', 'ix:log', 1, 0, '操作日志菜单', '2025-01-02 10:00:00', '2025-07-08 14:35:46', 1, 1, 0, NULL);
INSERT INTO `sys_menu` VALUES (2102, 2100, '登录日志', 'LOGIN_LOG', 'C', 'manage_login-log', '/manage/login-log', 'view.manage_login-log', NULL, NULL, 1, 0, '', 1, 1, 'system:logininfor:list', 'ix:log', 2, 0, '登录日志菜单', '2025-01-02 10:00:00', '2025-07-02 13:58:40', 1, 1, 0, NULL);
INSERT INTO `sys_menu` VALUES (2103, 2101, '操作查询', 'OPERLOG_QUERY', 'F', '', '', '', NULL, NULL, 1, 0, '', 1, 1, 'system:operlog:query', '', 1, 0, '操作日志查询权限', '2025-01-02 10:00:00', '2025-01-02 10:00:00', 1, 1, 0, NULL);
INSERT INTO `sys_menu` VALUES (2104, 2101, '操作删除', 'OPERLOG_REMOVE', 'F', '', '', '', NULL, NULL, 1, 0, '', 1, 1, 'system:operlog:remove', '', 2, 0, '操作日志删除权限', '2025-01-02 10:00:00', '2025-01-02 10:00:00', 1, 1, 0, NULL);
INSERT INTO `sys_menu` VALUES (2105, 2101, '日志导出', 'OPERLOG_EXPORT', 'F', '', '', '', NULL, NULL, 1, 0, '', 1, 1, 'system:operlog:export', '', 3, 0, '操作日志导出权限', '2025-01-02 10:00:00', '2025-01-02 10:00:00', 1, 1, 0, NULL);
INSERT INTO `sys_menu` VALUES (2106, 2101, '详情查看', 'OPERLOG_DETAIL', 'F', '', '', '', NULL, NULL, 1, 0, '', 1, 1, 'system:operlog:detail', '', 4, 0, '操作日志详情权限', '2025-01-02 10:00:00', '2025-01-02 10:00:00', 1, 1, 0, NULL);
INSERT INTO `sys_menu` VALUES (2107, 2101, '日志清空', 'OPERLOG_CLEAR', 'F', '', '', '', NULL, NULL, 1, 0, '', 1, 1, 'system:operlog:clear', '', 5, 0, '操作日志清空权限', '2025-01-02 10:00:00', '2025-01-02 10:00:00', 1, 1, 0, NULL);
INSERT INTO `sys_menu` VALUES (2108, 2102, '登录查询', 'LOGININFOR_QUERY', 'F', '', '', '', NULL, NULL, 1, 0, '', 1, 1, 'system:logininfor:query', '', 1, 0, '登录日志查询权限', '2025-01-02 10:00:00', '2025-01-02 10:00:00', 1, 1, 0, NULL);
INSERT INTO `sys_menu` VALUES (2109, 2102, '登录删除', 'LOGININFOR_REMOVE', 'F', '', '', '', NULL, NULL, 1, 0, '', 1, 1, 'system:logininfor:remove', '', 2, 0, '登录日志删除权限', '2025-01-02 10:00:00', '2025-01-02 10:00:00', 1, 1, 0, NULL);
INSERT INTO `sys_menu` VALUES (2110, 2102, '日志导出', 'LOGININFOR_EXPORT', 'F', '', '', '', NULL, NULL, 1, 0, '', 1, 1, 'system:logininfor:export', '', 3, 0, '登录日志导出权限', '2025-01-02 10:00:00', '2025-01-02 10:00:00', 1, 1, 0, NULL);
INSERT INTO `sys_menu` VALUES (2111, 2102, '账户解锁', 'LOGININFOR_UNLOCK', 'F', '', '', '', NULL, NULL, 1, 0, '', 1, 1, 'system:logininfor:unlock', '', 4, 0, '登录日志解锁权限', '2025-01-02 10:00:00', '2025-01-02 10:00:00', 1, 1, 0, NULL);
INSERT INTO `sys_menu` VALUES (2112, 2102, '详情查看', 'LOGININFOR_DETAIL', 'F', '', '', '', NULL, NULL, 1, 0, '', 1, 1, 'system:logininfor:detail', '', 5, 0, '登录日志详情权限', '2025-01-02 10:00:00', '2025-01-02 10:00:00', 1, 1, 0, NULL);
INSERT INTO `sys_menu` VALUES (2113, 2102, '日志清空', 'LOGININFOR_CLEAR', 'F', '', '', '', NULL, NULL, 1, 0, '', 1, 1, 'system:logininfor:clear', '', 6, 0, '登录日志清空权限', '2025-01-02 10:00:00', '2025-01-02 10:00:00', 1, 1, 0, NULL);
INSERT INTO `sys_menu` VALUES (30201, 302, '文件上传', 'FILE_UPLOAD', 'F', '', '', '', NULL, NULL, 1, 0, '', 1, 1, 'system:file:upload', '', 1, 0, '文件上传权限', '2025-07-01 20:04:43', '2025-07-01 20:22:45', 1, 1, 0, NULL);
INSERT INTO `sys_menu` VALUES (30202, 302, '文件下载', 'FILE_DOWNLOAD', 'F', '', '', '', NULL, NULL, 1, 0, '', 1, 1, 'system:file:download', '', 2, 0, '文件下载权限', '2025-07-01 20:04:43', '2025-07-01 20:22:55', 1, 1, 0, NULL);
INSERT INTO `sys_menu` VALUES (30203, 302, '文件删除', 'FILE_DELETE', 'F', '', '', '', NULL, NULL, 1, 0, '', 1, 1, 'system:file:delete', '', 3, 0, '文件删除权限', '2025-07-01 20:04:43', '2025-07-01 20:23:06', 1, 1, 0, NULL);
INSERT INTO `sys_menu` VALUES (30204, 302, '文件预览', 'FILE_PREVIEW', 'F', '', '', '', NULL, NULL, 1, 0, '', 1, 1, 'system:file:preview', '', 4, 0, '文件预览权限', '2025-07-01 20:04:43', '2025-07-01 20:23:15', 1, 1, 0, NULL);
INSERT INTO `sys_menu` VALUES (30301, 303, '配置新增', 'OSS_COMFIG_ADD', 'F', '', '', '', NULL, NULL, 1, 0, '', 1, 1, 'system:ossConfig:add', '', 1, 0, 'OSS配置新增权限', '2025-07-01 20:04:43', '2025-07-01 20:23:29', 1, 1, 0, NULL);
INSERT INTO `sys_menu` VALUES (30302, 303, '配置编辑', 'OSS_COMFIG_EDIT', 'F', '', '', '', NULL, NULL, 1, 0, '', 1, 1, 'system:ossConfig:edit', '', 2, 0, 'OSS配置编辑权限', '2025-07-01 20:04:43', '2025-07-01 20:24:13', 1, 1, 0, NULL);
INSERT INTO `sys_menu` VALUES (30303, 303, '配置删除', 'OSS_COMFIG_REMOVE', 'F', '', '', '', NULL, NULL, 1, 0, '', 1, 1, 'system:ossConfig:remove', '', 3, 0, 'OSS配置删除权限', '2025-07-01 20:04:43', '2025-07-01 20:24:05', 1, 1, 0, NULL);
INSERT INTO `sys_menu` VALUES (30304, 303, '配置查询', 'OSS_COMFIG_QUERY', 'F', '', '', '', NULL, NULL, 1, 0, '', 1, 1, 'system:ossConfig:query', '', 4, 0, 'OSS配置查询权限', '2025-07-01 20:04:43', '2025-07-01 20:24:00', 1, 1, 0, NULL);
INSERT INTO `sys_menu` VALUES (30305, 303, '配置测试', 'OSS_COMFIG_TEST', 'F', '', '', '', NULL, NULL, 1, 0, '', 1, 1, 'system:ossConfig:test', '', 5, 0, 'OSS配置测试权限', '2025-07-01 20:04:43', '2025-07-01 20:23:54', 1, 1, 0, NULL);
INSERT INTO `sys_menu` VALUES (30306, 0, '组织管理', 'org', 'M', 'org', '/org', '', '', NULL, 1, 0, '', 1, 1, '', 'eos-icons:organization-outlined', 3, 0, NULL, '2025-07-03 15:46:07', '2025-07-08 14:22:46', 1, 1, 0, NULL);
INSERT INTO `sys_menu` VALUES (30307, 0, '系统运维', 'maintenance', 'M', 'maintenance', '/maintenance', '', '', NULL, 0, 0, '', 1, 1, '', 'pepicons-pencil:monitor', 0, 0, NULL, '2025-07-03 15:59:01', '2025-07-08 14:26:17', 1, NULL, 1, '2025-07-08 11:50:10');
INSERT INTO `sys_menu` VALUES (30308, 2, '连接监控', 'mysqlconn', 'C', 'mysqlconn', 'http://localhost:8080/druid/index.html', '', 'http://localhost:8080/druid/index.html', NULL, 0, 0, '', 1, 1, '', 'ic:outline-monitor-heart', 0, 0, NULL, '2025-07-03 16:01:20', '2025-07-08 14:13:50', 1, 1, 0, NULL);
INSERT INTO `sys_menu` VALUES (30309, 2, '接口文档', 'apidoc', 'C', 'apidoc', 'http://localhost:8080/doc.html', '', 'http://localhost:8080/doc.html', NULL, 0, 0, '', 1, 1, '', 'mingcute:doc-line', 0, 0, NULL, '2025-07-03 16:01:20', '2025-07-08 14:15:41', 1, 1, 0, NULL);
INSERT INTO `sys_menu` VALUES (30310, 0, '官网网站', 'website', 'C', 'website', 'https://www.marsadmin.cn/', '', 'https://www.marsadmin.cn/', NULL, 0, 0, '', 1, 1, '', 'hugeicons:office', 100, 0, NULL, '2025-07-03 16:01:20', '2025-07-08 15:06:40', 1, 1, 0, NULL);
INSERT INTO `sys_menu` VALUES (30311, 0, '官网文档', 'websitedoc', 'C', 'websitedoc', 'https://docs.marsadmin.cn/', '', 'https://docs.marsadmin.cn/', NULL, 0, 0, '', 1, 1, '', 'solar:route-linear', 200, 0, NULL, '2025-07-03 16:01:20', '2025-07-08 15:07:14', 1, 1, 0, NULL);

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '模块标题',
  `business_type` int NULL DEFAULT 0 COMMENT '业务类型：0-其它，1-新增，2-修改，3-删除',
  `method` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '请求方式',
  `operator_type` int NULL DEFAULT 0 COMMENT '操作类别：0-其它，1-后台用户，2-手机端用户',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '返回参数',
  `status` int NULL DEFAULT 0 COMMENT '操作状态：0-正常，1-异常',
  `error_msg` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '错误消息',
  `oper_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '操作时间',
  `cost_time` bigint NULL DEFAULT 0 COMMENT '消耗时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_business_type`(`business_type` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_oper_time`(`oper_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 69 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '操作日志记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (1, '文件管理', 10, 'com.mars.admin.modules.base.controller.FileUploadController.upload()', 'POST', 1, NULL, NULL, '/file/upload', '127.0.0.1', NULL, '描述: 上传文件：#{#file.originalFilename}', '{\"code\":200,\"message\":\"上传成功\",\"data\":{\"id\":2,\"fileName\":\"b5f0f4fbb41c489fa1799c50db6247de.jpg\",\"originalName\":\"img_v3_02mm_6eaf2ac0-71ba-43ed-a56f-3913e28ab79g.jpg\",\"fileSuffix\":\"jpg\",\"url\":\"http://150.158.49.140:9000/test/upload/2025/07/03/b5f0f4fbb41c489fa1799c50db6247de.jpg\",\"size\":100276,\"filePath\":\"upload/2025/07/03/b5f0f4fbb41c489fa1799c50db6247de.jpg\",\"contentType\":\"image/jpeg\",\"configKey\":\"minio\",\"uploadStatus\":1},\"timestamp\":1751521465056,\"error\":false,\"success\":true}', 0, NULL, '2025-07-03 13:44:25', 4);
INSERT INTO `sys_oper_log` VALUES (2, '菜单管理', 1, 'com.mars.admin.modules.system.controller.SysMenuController.save()', 'POST', 1, 'admin', '未知部门', '/system/menu', '127.0.0.1', NULL, '{\"entity\":{\"createTime\":null,\"updateTime\":null,\"createBy\":null,\"updateBy\":null,\"isDeleted\":null,\"deleteTime\":null,\"id\":null,\"parentId\":0,\"menuName\":\"组织管理\",\"menuCode\":\"org\",\"menuType\":\"M\",\"routeName\":\"org\",\"routePath\":\"/org\",\"component\":\"\",\"redirect\":\"\",\"queryParam\":null,\"isFrame\":1,\"isCache\":0,\"menuTypeFlag\":\"\",\"visible\":1,\"status\":1,\"perms\":\"\",\"icon\":\"\",\"orderNum\":0,\"isSystem\":null,\"remark\":null,\"children\":null,\"parentName\":null}} | 描述: 新增菜单：#{#entity.menuName}', '{\"code\":500,\"message\":\"权限标识已存在，请重新输入\",\"data\":null,\"timestamp\":1751528390583,\"error\":true,\"success\":false}', 0, NULL, '2025-07-03 15:39:50', 8);
INSERT INTO `sys_oper_log` VALUES (3, '菜单管理', 1, 'com.mars.admin.modules.system.controller.SysMenuController.save()', 'POST', 1, 'admin', '未知部门', '/system/menu', '127.0.0.1', NULL, '{\"entity\":{\"createTime\":null,\"updateTime\":null,\"createBy\":null,\"updateBy\":null,\"isDeleted\":null,\"deleteTime\":null,\"id\":null,\"parentId\":0,\"menuName\":\"组织管理\",\"menuCode\":\"org\",\"menuType\":\"M\",\"routeName\":\"org\",\"routePath\":\"/org\",\"component\":\"\",\"redirect\":\"\",\"queryParam\":null,\"isFrame\":1,\"isCache\":0,\"menuTypeFlag\":\"\",\"visible\":1,\"status\":1,\"perms\":\"\",\"icon\":\"\",\"orderNum\":0,\"isSystem\":null,\"remark\":null,\"children\":null,\"parentName\":null}} | 描述: 新增菜单：#{#entity.menuName}', '{\"code\":500,\"message\":\"权限标识已存在，请重新输入\",\"data\":null,\"timestamp\":1751528443748,\"error\":true,\"success\":false}', 0, NULL, '2025-07-03 15:40:43', 4);
INSERT INTO `sys_oper_log` VALUES (4, '菜单管理', 1, 'com.mars.admin.modules.system.controller.SysMenuController.save()', 'POST', 1, 'admin', '未知部门', '/system/menu', '127.0.0.1', NULL, '{\"entity\":{\"createTime\":null,\"updateTime\":null,\"createBy\":null,\"updateBy\":null,\"isDeleted\":null,\"deleteTime\":null,\"id\":null,\"parentId\":0,\"menuName\":\"组织管理\",\"menuCode\":\"org\",\"menuType\":\"M\",\"routeName\":\"org\",\"routePath\":\"/org\",\"component\":\"\",\"redirect\":\"\",\"queryParam\":null,\"isFrame\":1,\"isCache\":0,\"menuTypeFlag\":\"\",\"visible\":1,\"status\":1,\"perms\":\"\",\"icon\":\"\",\"orderNum\":0,\"isSystem\":null,\"remark\":null,\"children\":null,\"parentName\":null}} | 描述: 新增菜单：#{#entity.menuName}', '{\"code\":500,\"message\":\"权限标识已存在，请重新输入\",\"data\":null,\"timestamp\":1751528463888,\"error\":true,\"success\":false}', 0, NULL, '2025-07-03 15:41:03', 7);
INSERT INTO `sys_oper_log` VALUES (5, '菜单管理', 1, 'com.mars.admin.modules.system.controller.SysMenuController.save()', 'POST', 1, 'admin', '未知部门', '/system/menu', '127.0.0.1', NULL, '{\"entity\":{\"createTime\":null,\"updateTime\":null,\"createBy\":null,\"updateBy\":null,\"isDeleted\":null,\"deleteTime\":null,\"id\":null,\"parentId\":0,\"menuName\":\"组织管理\",\"menuCode\":\"org\",\"menuType\":\"M\",\"routeName\":\"org\",\"routePath\":\"/org\",\"component\":\"\",\"redirect\":\"\",\"queryParam\":null,\"isFrame\":1,\"isCache\":0,\"menuTypeFlag\":\"\",\"visible\":1,\"status\":1,\"perms\":\"\",\"icon\":\"\",\"orderNum\":0,\"isSystem\":null,\"remark\":null,\"children\":null,\"parentName\":null}} | 描述: 新增菜单', '{\"code\":500,\"message\":\"权限标识已存在，请重新输入\",\"data\":null,\"timestamp\":1751528536572,\"success\":false,\"error\":true}', 0, NULL, '2025-07-03 15:42:16', 25);
INSERT INTO `sys_oper_log` VALUES (6, '菜单管理', 1, 'com.mars.admin.modules.system.controller.SysMenuController.save()', 'POST', 1, 'admin', '未知部门', '/system/menu', '127.0.0.1', NULL, '{\"entity\":{\"createTime\":null,\"updateTime\":null,\"createBy\":null,\"updateBy\":null,\"isDeleted\":null,\"deleteTime\":null,\"id\":null,\"parentId\":0,\"menuName\":\"组织管理\",\"menuCode\":\"org\",\"menuType\":\"M\",\"routeName\":\"org\",\"routePath\":\"/org\",\"component\":\"\",\"redirect\":\"\",\"queryParam\":null,\"isFrame\":1,\"isCache\":0,\"menuTypeFlag\":\"\",\"visible\":1,\"status\":1,\"perms\":\"\",\"icon\":\"\",\"orderNum\":0,\"isSystem\":null,\"remark\":null,\"children\":null,\"parentName\":null}} | 描述: 新增菜单', '{\"code\":500,\"message\":\"权限标识已存在，请重新输入\",\"data\":null,\"timestamp\":1751528571399,\"success\":false,\"error\":true}', 0, NULL, '2025-07-03 15:42:51', 6);
INSERT INTO `sys_oper_log` VALUES (7, '菜单管理', 1, 'com.mars.admin.modules.system.controller.SysMenuController.save()', 'POST', 1, 'admin', '未知部门', '/system/menu', '127.0.0.1', NULL, '{\"entity\":{\"createTime\":null,\"updateTime\":null,\"createBy\":null,\"updateBy\":null,\"isDeleted\":null,\"deleteTime\":null,\"id\":null,\"parentId\":0,\"menuName\":\"组织管理\",\"menuCode\":\"org\",\"menuType\":\"M\",\"routeName\":\"org\",\"routePath\":\"/org\",\"component\":\"\",\"redirect\":\"\",\"queryParam\":null,\"isFrame\":1,\"isCache\":0,\"menuTypeFlag\":\"\",\"visible\":1,\"status\":1,\"perms\":\"\",\"icon\":\"\",\"orderNum\":0,\"isSystem\":null,\"remark\":null,\"children\":null,\"parentName\":null}} | 描述: 新增菜单', '{\"code\":500,\"message\":\"权限标识已存在，请重新输入\",\"data\":null,\"timestamp\":1751528584345,\"success\":false,\"error\":true}', 0, NULL, '2025-07-03 15:43:04', 4);
INSERT INTO `sys_oper_log` VALUES (8, '菜单管理', 1, 'com.mars.admin.modules.system.controller.SysMenuController.save()', 'POST', 1, 'admin', '未知部门', '/system/menu', '127.0.0.1', NULL, '{\"entity\":{\"createTime\":null,\"updateTime\":null,\"createBy\":null,\"updateBy\":null,\"isDeleted\":null,\"deleteTime\":null,\"id\":null,\"parentId\":0,\"menuName\":\"组织管理\",\"menuCode\":\"org\",\"menuType\":\"M\",\"routeName\":\"org\",\"routePath\":\"/org\",\"component\":\"\",\"redirect\":\"\",\"queryParam\":null,\"isFrame\":1,\"isCache\":0,\"menuTypeFlag\":\"\",\"visible\":1,\"status\":1,\"perms\":\"\",\"icon\":\"\",\"orderNum\":0,\"isSystem\":null,\"remark\":null,\"children\":null,\"parentName\":null}} | 描述: 新增菜单', '{\"code\":500,\"message\":\"权限标识已存在，请重新输入\",\"data\":null,\"timestamp\":1751528716211,\"success\":false,\"error\":true}', 0, NULL, '2025-07-03 15:45:16', 5);
INSERT INTO `sys_oper_log` VALUES (9, '菜单管理', 1, 'com.mars.admin.modules.system.controller.SysMenuController.save()', 'POST', 1, 'admin', '未知部门', '/system/menu', '127.0.0.1', NULL, '{\"entity\":{\"createTime\":\"2025-07-03 15:46:07\",\"updateTime\":null,\"createBy\":1,\"updateBy\":null,\"isDeleted\":0,\"deleteTime\":null,\"id\":30306,\"parentId\":0,\"menuName\":\"组织管理\",\"menuCode\":\"org\",\"menuType\":\"M\",\"routeName\":\"org\",\"routePath\":\"/org\",\"component\":\"\",\"redirect\":\"\",\"queryParam\":null,\"isFrame\":1,\"isCache\":0,\"menuTypeFlag\":\"\",\"visible\":1,\"status\":1,\"perms\":\"\",\"icon\":\"\",\"orderNum\":0,\"isSystem\":null,\"remark\":null,\"children\":null,\"parentName\":null}} | 描述: 新增菜单', '{\"code\":200,\"message\":\"新增成功\",\"data\":null,\"timestamp\":1751528767435,\"error\":false,\"success\":true}', 0, NULL, '2025-07-03 15:46:07', 26);
INSERT INTO `sys_oper_log` VALUES (10, '菜单管理', 2, 'com.mars.admin.modules.system.controller.SysMenuController.update()', 'PUT', 1, 'admin', '未知部门', '/system/menu', '127.0.0.1', NULL, '{\"entity\":{\"createTime\":\"2025-06-25 16:34:16\",\"updateTime\":\"2025-07-03 15:46:42\",\"createBy\":1,\"updateBy\":1,\"isDeleted\":0,\"deleteTime\":null,\"id\":103,\"parentId\":30306,\"menuName\":\"部门管理\",\"menuCode\":\"DEPT_MANAGE\",\"menuType\":\"C\",\"routeName\":\"manage_dept\",\"routePath\":\"/manage/dept\",\"component\":\"view.manage_dept\",\"redirect\":null,\"queryParam\":null,\"isFrame\":1,\"isCache\":0,\"menuTypeFlag\":\"\",\"visible\":1,\"status\":1,\"perms\":\"system:dept:list\",\"icon\":\"tree\",\"orderNum\":4,\"isSystem\":1,\"remark\":null,\"children\":[],\"parentName\":null}} | 描述: 修改菜单', '{\"code\":200,\"message\":\"修改成功\",\"data\":null,\"timestamp\":1751528802228,\"error\":false,\"success\":true}', 0, NULL, '2025-07-03 15:46:42', 4);
INSERT INTO `sys_oper_log` VALUES (11, '菜单管理', 2, 'com.mars.admin.modules.system.controller.SysMenuController.update()', 'PUT', 1, 'admin', '未知部门', '/system/menu', '127.0.0.1', NULL, '{\"entity\":{\"createTime\":\"2025-06-25 16:34:16\",\"updateTime\":\"2025-07-03 15:46:58\",\"createBy\":1,\"updateBy\":1,\"isDeleted\":0,\"deleteTime\":null,\"id\":104,\"parentId\":30306,\"menuName\":\"岗位管理\",\"menuCode\":\"POST_MANAGE\",\"menuType\":\"C\",\"routeName\":\"manage_post\",\"routePath\":\"/manage/post\",\"component\":\"view.manage_post\",\"redirect\":null,\"queryParam\":null,\"isFrame\":1,\"isCache\":0,\"menuTypeFlag\":\"\",\"visible\":1,\"status\":1,\"perms\":\"system:post:list\",\"icon\":\"post\",\"orderNum\":5,\"isSystem\":1,\"remark\":null,\"children\":[],\"parentName\":null}} | 描述: 修改菜单', '{\"code\":200,\"message\":\"修改成功\",\"data\":null,\"timestamp\":1751528818389,\"error\":false,\"success\":true}', 0, NULL, '2025-07-03 15:46:58', 3);
INSERT INTO `sys_oper_log` VALUES (12, '角色管理', 4, 'com.mars.admin.modules.system.controller.SysRoleController.authMenu()', 'PUT', 1, 'admin', '未知部门', '/system/role/authMenu', '127.0.0.1', NULL, '{\"role\":{\"createTime\":null,\"updateTime\":null,\"createBy\":null,\"updateBy\":null,\"isDeleted\":null,\"deleteTime\":null,\"id\":1,\"roleName\":null,\"roleCode\":null,\"roleKey\":null,\"roleSort\":null,\"dataScope\":null,\"menuCheckStrictly\":null,\"deptCheckStrictly\":null,\"status\":null,\"isSystem\":null,\"description\":null,\"remark\":null,\"menus\":null,\"depts\":null,\"menuIds\":[1016,2,3,105,106,1000,1001,1002,1003,1004,1005,1006,1007,1008,1009,1010,1011,1012,1013,1014,1015,1070,1071,1072,1080,1081,1082,1083,1084,30201,30202,30203,30204,30301,30302,30303,30304,30305,100,101,102,107,108,302,303,1018,1017,1,301],\"deptIds\":null}} | 描述: 分配角色菜单权限，角色ID：#{#role.id}', '{\"code\":200,\"message\":\"操作成功\",\"data\":null,\"timestamp\":1751528860862,\"error\":false,\"success\":true}', 0, NULL, '2025-07-03 15:47:40', 4);
INSERT INTO `sys_oper_log` VALUES (13, '角色管理', 4, 'com.mars.admin.modules.system.controller.SysRoleController.authMenu()', 'PUT', 1, 'admin', '未知部门', '/system/role/authMenu', '127.0.0.1', NULL, '{\"role\":{\"createTime\":null,\"updateTime\":null,\"createBy\":null,\"updateBy\":null,\"isDeleted\":null,\"deleteTime\":null,\"id\":1,\"roleName\":null,\"roleCode\":null,\"roleKey\":null,\"roleSort\":null,\"dataScope\":null,\"menuCheckStrictly\":null,\"deptCheckStrictly\":null,\"status\":null,\"isSystem\":null,\"description\":null,\"remark\":null,\"menus\":null,\"depts\":null,\"menuIds\":[1016,2,3,105,106,1000,1001,1002,1003,1004,1005,1006,1007,1008,1009,1010,1011,1012,1013,1014,1015,1070,1071,1072,1080,1081,1082,1083,1084,30201,30202,30203,30204,30301,30302,30303,30304,30305,100,101,102,107,108,302,303,1018,1017,1,301,30306,103,104],\"deptIds\":null}} | 描述: 分配角色菜单权限，角色ID：#{#role.id}', '{\"code\":200,\"message\":\"操作成功\",\"data\":null,\"timestamp\":1751528866704,\"error\":false,\"success\":true}', 0, NULL, '2025-07-03 15:47:46', 5);
INSERT INTO `sys_oper_log` VALUES (14, '文件管理', 10, 'com.mars.admin.modules.base.controller.FileUploadController.upload()', 'POST', 1, NULL, NULL, '/file/upload', '127.0.0.1', NULL, '描述: 上传文件：#{#file.originalFilename}', '{\"code\":500,\"message\":\"上传失败: 本地文件上传失败: java.io.FileNotFoundException: C:\\\\Users\\\\qiu_m\\\\AppData\\\\Local\\\\Temp\\\\tomcat.8080.5746850484025418959\\\\work\\\\Tomcat\\\\localhost\\\\ROOT\\\\.\\\\upload\\\\upload\\\\2025\\\\07\\\\04\\\\cbcb6a91fb7b43fb83df4f03c0a688e5.jpeg (系统找不到指定的路径。)\",\"data\":null,\"timestamp\":1751598147896,\"error\":true,\"success\":false}', 0, NULL, '2025-07-04 11:02:27', 5);
INSERT INTO `sys_oper_log` VALUES (15, '文件管理', 10, 'com.mars.admin.modules.base.controller.FileUploadController.upload()', 'POST', 1, NULL, NULL, '/file/upload', '127.0.0.1', NULL, '描述: 上传文件：#{#file.originalFilename}', '{\"code\":200,\"message\":\"上传成功\",\"data\":{\"id\":3,\"fileName\":\"55afdcc5602c458ea03a22a2bc55bf16.jpeg\",\"originalName\":\"头像.jpeg\",\"fileSuffix\":\"jpeg\",\"url\":\"http://150.158.49.140:9000/test/upload/2025/07/04/55afdcc5602c458ea03a22a2bc55bf16.jpeg\",\"size\":8838,\"filePath\":\"upload/2025/07/04/55afdcc5602c458ea03a22a2bc55bf16.jpeg\",\"contentType\":\"image/jpeg\",\"configKey\":\"minio\",\"uploadStatus\":1},\"timestamp\":1751598273145,\"error\":false,\"success\":true}', 0, NULL, '2025-07-04 11:04:33', 2);
INSERT INTO `sys_oper_log` VALUES (16, '文件管理', 10, 'com.mars.admin.modules.base.controller.FileUploadController.upload()', 'POST', 1, NULL, NULL, '/file/upload', '127.0.0.1', NULL, '描述: 上传文件：#{#file.originalFilename}', '{\"code\":200,\"message\":\"上传成功\",\"data\":{\"id\":4,\"fileName\":\"ce27368b3efa4c1d81c0dc8c49ea8f89.jpg\",\"originalName\":\"Bears.jpg\",\"fileSuffix\":\"jpg\",\"url\":\"http://150.158.49.140:9000/test/upload/2025/07/04/ce27368b3efa4c1d81c0dc8c49ea8f89.jpg\",\"size\":123500,\"filePath\":\"upload/2025/07/04/ce27368b3efa4c1d81c0dc8c49ea8f89.jpg\",\"contentType\":\"image/jpeg\",\"configKey\":\"minio\",\"uploadStatus\":1},\"timestamp\":1751599113397,\"error\":false,\"success\":true}', 0, NULL, '2025-07-04 11:18:33', 0);
INSERT INTO `sys_oper_log` VALUES (17, '文件管理', 10, 'com.mars.admin.modules.base.controller.FileUploadController.upload()', 'POST', 1, NULL, NULL, '/file/upload', '127.0.0.1', NULL, '描述: 上传文件：#{#file.originalFilename}', '{\"code\":200,\"message\":\"上传成功\",\"data\":{\"id\":5,\"fileName\":\"7af03b4667b14d4ba3f274a194365c19.jpeg\",\"originalName\":\"头像.jpeg\",\"fileSuffix\":\"jpeg\",\"url\":\"http://150.158.49.140:9000/test/upload/2025/07/04/7af03b4667b14d4ba3f274a194365c19.jpeg\",\"size\":8838,\"filePath\":\"upload/2025/07/04/7af03b4667b14d4ba3f274a194365c19.jpeg\",\"contentType\":\"image/jpeg\",\"configKey\":\"minio\",\"uploadStatus\":1},\"timestamp\":1751599120842,\"error\":false,\"success\":true}', 0, NULL, '2025-07-04 11:18:40', 1);
INSERT INTO `sys_oper_log` VALUES (18, '角色管理', 4, 'com.mars.admin.modules.system.controller.SysRoleController.authMenu()', 'PUT', 1, 'admin', '未知部门', '/system/role/authMenu', '127.0.0.1', NULL, '{\"role\":{\"createTime\":null,\"updateTime\":null,\"createBy\":null,\"updateBy\":null,\"isDeleted\":null,\"deleteTime\":null,\"id\":1,\"roleName\":null,\"roleCode\":null,\"roleKey\":null,\"roleSort\":null,\"dataScope\":null,\"menuCheckStrictly\":null,\"deptCheckStrictly\":null,\"status\":null,\"isSystem\":null,\"description\":null,\"remark\":null,\"menus\":null,\"depts\":null,\"menuIds\":[1016,2,3,105,106,1000,1001,1002,1003,1004,1005,1006,1007,1008,1009,1010,1011,1012,1013,1014,1015,1070,1071,1072,1080,1081,1082,1083,1084,30201,30202,30203,30204,30301,30302,30303,30304,30305,100,101,102,107,108,302,303,1018,1017,1,301],\"deptIds\":null}} | 描述: 分配角色菜单权限，角色ID：#{#role.id}', '{\"code\":200,\"message\":\"操作成功\",\"data\":null,\"timestamp\":1751608646198,\"error\":false,\"success\":true}', 0, NULL, '2025-07-04 13:57:26', 11);
INSERT INTO `sys_oper_log` VALUES (19, '角色管理', 4, 'com.mars.admin.modules.system.controller.SysRoleController.authMenu()', 'PUT', 1, 'admin', '未知部门', '/system/role/authMenu', '127.0.0.1', NULL, '{\"role\":{\"createTime\":null,\"updateTime\":null,\"createBy\":null,\"updateBy\":null,\"isDeleted\":null,\"deleteTime\":null,\"id\":1,\"roleName\":null,\"roleCode\":null,\"roleKey\":null,\"roleSort\":null,\"dataScope\":null,\"menuCheckStrictly\":null,\"deptCheckStrictly\":null,\"status\":null,\"isSystem\":null,\"description\":null,\"remark\":null,\"menus\":null,\"depts\":null,\"menuIds\":[1016,2,3,105,106,1000,1001,1002,1003,1004,1005,1006,1007,1008,1009,1010,1011,1012,1013,1014,1015,1070,1071,1072,1080,1081,1082,1083,1084,30201,30202,30203,30204,30301,30302,30303,30304,30305,100,101,102,107,108,302,303,1018,1017,1,301,30306,103,104],\"deptIds\":null}} | 描述: 分配角色菜单权限，角色ID：#{#role.id}', '{\"code\":200,\"message\":\"操作成功\",\"data\":null,\"timestamp\":1751608998327,\"error\":false,\"success\":true}', 0, NULL, '2025-07-04 14:03:18', 11);
INSERT INTO `sys_oper_log` VALUES (20, '角色管理', 4, 'com.mars.admin.modules.system.controller.SysRoleController.authMenu()', 'PUT', 1, 'admin', '未知部门', '/system/role/authMenu', '127.0.0.1', NULL, '{\"role\":{\"createTime\":null,\"updateTime\":null,\"createBy\":null,\"updateBy\":null,\"isDeleted\":null,\"deleteTime\":null,\"id\":1,\"roleName\":null,\"roleCode\":null,\"roleKey\":null,\"roleSort\":null,\"dataScope\":null,\"menuCheckStrictly\":null,\"deptCheckStrictly\":null,\"status\":null,\"isSystem\":null,\"description\":null,\"remark\":null,\"menus\":null,\"depts\":null,\"menuIds\":[1016,2,3,105,106,1000,1001,1002,1003,1004,1005,1006,1007,1008,1009,1010,1011,1012,1013,1014,1015,30201,30202,30203,30204,30301,30302,30303,30304,30305,103,104,100,101,102,302,303,1018,1017,30306,301,1],\"deptIds\":null}} | 描述: 分配角色菜单权限，角色ID：#{#role.id}', '{\"code\":200,\"message\":\"操作成功\",\"data\":null,\"timestamp\":1751609016094,\"error\":false,\"success\":true}', 0, NULL, '2025-07-04 14:03:36', 4);
INSERT INTO `sys_oper_log` VALUES (21, '角色管理', 4, 'com.mars.admin.modules.system.controller.SysRoleController.authMenu()', 'PUT', 1, 'admin', '未知部门', '/system/role/authMenu', '127.0.0.1', NULL, '{\"role\":{\"createTime\":null,\"updateTime\":null,\"createBy\":null,\"updateBy\":null,\"isDeleted\":null,\"deleteTime\":null,\"id\":1,\"roleName\":null,\"roleCode\":null,\"roleKey\":null,\"roleSort\":null,\"dataScope\":null,\"menuCheckStrictly\":null,\"deptCheckStrictly\":null,\"status\":null,\"isSystem\":null,\"description\":null,\"remark\":null,\"menus\":null,\"depts\":null,\"menuIds\":[1016,2,3,105,106,1000,1001,1002,1003,1004,1005,1006,1007,1008,1009,1010,1011,1012,1013,1014,1015,30201,30202,30203,30204,30301,30302,30303,30304,30305,103,104,100,101,102,302,303,1018,1017,30306,301,107,1070,1071,1072,108,1080,1081,1082,1083,1084,1],\"deptIds\":null}} | 描述: 分配角色菜单权限，角色ID：#{#role.id}', '{\"code\":200,\"message\":\"操作成功\",\"data\":null,\"timestamp\":1751609021265,\"error\":false,\"success\":true}', 0, NULL, '2025-07-04 14:03:41', 6);
INSERT INTO `sys_oper_log` VALUES (22, '角色管理', 4, 'com.mars.admin.modules.system.controller.SysRoleController.authMenu()', 'PUT', 1, 'admin', '未知部门', '/system/role/authMenu', '127.0.0.1', NULL, '{\"role\":{\"createTime\":null,\"updateTime\":null,\"createBy\":null,\"updateBy\":null,\"isDeleted\":null,\"deleteTime\":null,\"id\":1,\"roleName\":null,\"roleCode\":null,\"roleKey\":null,\"roleSort\":null,\"dataScope\":null,\"menuCheckStrictly\":null,\"deptCheckStrictly\":null,\"status\":null,\"isSystem\":null,\"description\":null,\"remark\":null,\"menus\":null,\"depts\":null,\"menuIds\":[1016,3,105,106,1000,1001,1002,1003,1004,1005,1006,1007,1008,1009,1010,1011,1012,1013,1014,1015,1070,1071,1072,1080,1081,1082,1083,1084,30201,30202,30203,30204,30301,30302,30303,30304,30305,103,104,100,101,102,107,108,302,303,1018,1017,30306,1,301,2,109],\"deptIds\":null}} | 描述: 分配角色菜单权限，角色ID：#{#role.id}', '{\"code\":200,\"message\":\"操作成功\",\"data\":null,\"timestamp\":1751611721309,\"error\":false,\"success\":true}', 0, NULL, '2025-07-04 14:48:41', 6);
INSERT INTO `sys_oper_log` VALUES (23, '角色管理', 4, 'com.mars.admin.modules.system.controller.SysRoleController.authMenu()', 'PUT', 1, 'admin', '未知部门', '/system/role/authMenu', '127.0.0.1', NULL, '{\"role\":{\"createTime\":null,\"updateTime\":null,\"createBy\":null,\"updateBy\":null,\"isDeleted\":null,\"deleteTime\":null,\"id\":1,\"roleName\":null,\"roleCode\":null,\"roleKey\":null,\"roleSort\":null,\"dataScope\":null,\"menuCheckStrictly\":null,\"deptCheckStrictly\":null,\"status\":null,\"isSystem\":null,\"description\":null,\"remark\":null,\"menus\":null,\"depts\":null,\"menuIds\":[1016,3,105,106,109,1000,1001,1002,1003,1004,1005,1006,1007,1008,1009,1010,1011,1012,1013,1014,1015,1070,1071,1072,1080,1081,1082,1083,1084,30201,30202,30203,30204,30301,30302,30303,30304,30305,103,104,30308,100,101,102,107,108,302,303,1018,1017,30306,1,2,301,30307,2100,2101,2102,2103,2104,2105,2106,2107,2108,2109,2110,2111,2112,2113],\"deptIds\":null}} | 描述: 分配角色菜单权限，角色ID：#{#role.id}', '{\"code\":200,\"message\":\"操作成功\",\"data\":null,\"timestamp\":1751945608256,\"error\":false,\"success\":true}', 0, NULL, '2025-07-08 11:33:28', 9);
INSERT INTO `sys_oper_log` VALUES (24, '角色管理', 2, 'com.mars.admin.modules.system.controller.SysRoleController.update()', 'PUT', 1, 'admin', '未知部门', '/system/role', '127.0.0.1', NULL, '{\"entity\":{\"createTime\":null,\"updateTime\":\"2025-07-08 11:33:30\",\"createBy\":null,\"updateBy\":1,\"isDeleted\":null,\"deleteTime\":null,\"id\":1,\"roleName\":\"超级管理员\",\"roleCode\":\"SUPER_ADMIN\",\"roleKey\":\"admin\",\"roleSort\":1,\"dataScope\":1,\"menuCheckStrictly\":1,\"deptCheckStrictly\":1,\"status\":1,\"isSystem\":null,\"description\":\"超级管理员\",\"remark\":\"\",\"menus\":null,\"depts\":null,\"menuIds\":null,\"deptIds\":null}} | 描述: 修改角色：#{#entity.roleName}', '{\"code\":200,\"message\":\"修改成功\",\"data\":null,\"timestamp\":1751945610581,\"error\":false,\"success\":true}', 0, NULL, '2025-07-08 11:33:30', 5);
INSERT INTO `sys_oper_log` VALUES (25, '菜单管理', 2, 'com.mars.admin.modules.system.controller.SysMenuController.update()', 'PUT', 1, 'admin', '未知部门', '/system/menu', '127.0.0.1', NULL, '{\"entity\":{\"createTime\":\"2025-07-03 16:01:20\",\"updateTime\":\"2025-07-04 16:53:55\",\"createBy\":1,\"updateBy\":null,\"isDeleted\":0,\"deleteTime\":null,\"id\":30308,\"parentId\":2,\"menuName\":\"连接监控\",\"menuCode\":\"mysqlconn\",\"menuType\":\"C\",\"routeName\":\"mysqlconn\",\"routePath\":\"/mysqlconn\",\"component\":\"\",\"redirect\":\"http://localhost:8080/druid/index.html\",\"queryParam\":null,\"isFrame\":0,\"isCache\":0,\"menuTypeFlag\":\"\",\"visible\":1,\"status\":1,\"perms\":\"\",\"icon\":\"\",\"orderNum\":0,\"isSystem\":0,\"remark\":null,\"children\":[],\"parentName\":null}} | 描述: 修改菜单：#{#entity.menuName}', '{\"code\":500,\"message\":\"权限标识已存在，请重新输入\",\"data\":null,\"timestamp\":1751945845824,\"error\":true,\"success\":false}', 0, NULL, '2025-07-08 11:37:25', 5);
INSERT INTO `sys_oper_log` VALUES (26, '菜单管理', 2, 'com.mars.admin.modules.system.controller.SysMenuController.update()', 'PUT', 1, 'admin', '未知部门', '/system/menu', '127.0.0.1', NULL, '{\"entity\":{\"createTime\":\"2025-07-03 16:01:20\",\"updateTime\":\"2025-07-04 16:53:55\",\"createBy\":1,\"updateBy\":null,\"isDeleted\":0,\"deleteTime\":null,\"id\":30308,\"parentId\":2,\"menuName\":\"连接监控\",\"menuCode\":\"mysqlconn\",\"menuType\":\"C\",\"routeName\":\"mysqlconn\",\"routePath\":\"/mysqlconn\",\"component\":\"\",\"redirect\":\"http://localhost:8080/druid/index.html\",\"queryParam\":null,\"isFrame\":0,\"isCache\":0,\"menuTypeFlag\":\"\",\"visible\":1,\"status\":1,\"perms\":\"\",\"icon\":\"\",\"orderNum\":0,\"isSystem\":0,\"remark\":null,\"children\":[],\"parentName\":null}} | 描述: 修改菜单', '{\"code\":500,\"message\":\"权限标识已存在，请重新输入\",\"data\":null,\"timestamp\":1751945935683,\"error\":true,\"success\":false}', 0, NULL, '2025-07-08 11:38:55', 31);
INSERT INTO `sys_oper_log` VALUES (27, '菜单管理', 2, 'com.mars.admin.modules.system.controller.SysMenuController.update()', 'PUT', 1, 'admin', '未知部门', '/system/menu', '127.0.0.1', NULL, '{\"entity\":{\"createTime\":\"2025-07-03 16:01:20\",\"updateTime\":\"2025-07-04 16:53:55\",\"createBy\":1,\"updateBy\":null,\"isDeleted\":0,\"deleteTime\":null,\"id\":30308,\"parentId\":2,\"menuName\":\"连接监控\",\"menuCode\":\"mysqlconn\",\"menuType\":\"C\",\"routeName\":\"mysqlconn\",\"routePath\":\"/mysqlconn\",\"component\":\"\",\"redirect\":\"http://localhost:8080/druid/index.html\",\"queryParam\":null,\"isFrame\":0,\"isCache\":0,\"menuTypeFlag\":\"\",\"visible\":1,\"status\":1,\"perms\":\"\",\"icon\":\"\",\"orderNum\":0,\"isSystem\":0,\"remark\":null,\"children\":[],\"parentName\":null}} | 描述: 修改菜单', '{\"code\":500,\"message\":\"权限标识已存在，请重新输入\",\"data\":null,\"timestamp\":1751946342949,\"error\":true,\"success\":false}', 0, NULL, '2025-07-08 11:45:43', 32);
INSERT INTO `sys_oper_log` VALUES (28, '菜单管理', 2, 'com.mars.admin.modules.system.controller.SysMenuController.update()', 'PUT', 1, 'admin', '未知部门', '/system/menu', '127.0.0.1', NULL, '{\"entity\":{\"createTime\":\"2025-07-03 16:01:20\",\"updateTime\":\"2025-07-04 16:53:55\",\"createBy\":1,\"updateBy\":null,\"isDeleted\":0,\"deleteTime\":null,\"id\":30308,\"parentId\":2,\"menuName\":\"连接监控\",\"menuCode\":\"mysqlconn\",\"menuType\":\"C\",\"routeName\":\"mysqlconn\",\"routePath\":\"/mysqlconn\",\"component\":\"\",\"redirect\":\"http://localhost:8080/druid/index.html\",\"queryParam\":null,\"isFrame\":0,\"isCache\":0,\"menuTypeFlag\":\"\",\"visible\":1,\"status\":1,\"perms\":\"\",\"icon\":\"\",\"orderNum\":0,\"isSystem\":0,\"remark\":null,\"children\":[],\"parentName\":null}} | 描述: 修改菜单', '{\"code\":500,\"message\":\"权限标识已存在，请重新输入\",\"data\":null,\"timestamp\":1751946368712,\"error\":true,\"success\":false}', 0, NULL, '2025-07-08 11:46:08', 7);
INSERT INTO `sys_oper_log` VALUES (29, '菜单管理', 2, 'com.mars.admin.modules.system.controller.SysMenuController.update()', 'PUT', 1, 'admin', '未知部门', '/system/menu', '127.0.0.1', NULL, '{\"entity\":{\"createTime\":\"2025-07-03 16:01:20\",\"updateTime\":\"2025-07-04 16:53:55\",\"createBy\":1,\"updateBy\":null,\"isDeleted\":0,\"deleteTime\":null,\"id\":30308,\"parentId\":2,\"menuName\":\"连接监控\",\"menuCode\":\"mysqlconn\",\"menuType\":\"C\",\"routeName\":\"mysqlconn\",\"routePath\":\"/mysqlconn\",\"component\":\"\",\"redirect\":\"http://localhost:8080/druid/index.html\",\"queryParam\":null,\"isFrame\":0,\"isCache\":0,\"menuTypeFlag\":\"\",\"visible\":1,\"status\":1,\"perms\":\"\",\"icon\":\"\",\"orderNum\":0,\"isSystem\":0,\"remark\":null,\"children\":[],\"parentName\":null}} | 描述: 修改菜单', '{\"code\":500,\"message\":\"权限标识已存在，请重新输入\",\"data\":null,\"timestamp\":1751946433654,\"error\":true,\"success\":false}', 0, NULL, '2025-07-08 11:47:13', 7);
INSERT INTO `sys_oper_log` VALUES (30, '菜单管理', 2, 'com.mars.admin.modules.system.controller.SysMenuController.update()', 'PUT', 1, 'admin', '未知部门', '/system/menu', '127.0.0.1', NULL, '{\"entity\":{\"createTime\":\"2025-07-03 16:01:20\",\"updateTime\":\"2025-07-04 16:53:55\",\"createBy\":1,\"updateBy\":null,\"isDeleted\":0,\"deleteTime\":null,\"id\":30308,\"parentId\":2,\"menuName\":\"连接监控\",\"menuCode\":\"mysqlconn\",\"menuType\":\"C\",\"routeName\":\"mysqlconn\",\"routePath\":\"/mysqlconn\",\"component\":\"\",\"redirect\":\"http://localhost:8080/druid/index.html\",\"queryParam\":null,\"isFrame\":0,\"isCache\":0,\"menuTypeFlag\":\"\",\"visible\":1,\"status\":1,\"perms\":\"\",\"icon\":\"\",\"orderNum\":0,\"isSystem\":0,\"remark\":null,\"children\":[],\"parentName\":null}} | 描述: 修改菜单', '{\"code\":500,\"message\":\"权限标识已存在，请重新输入\",\"data\":null,\"timestamp\":1751946526468,\"error\":true,\"success\":false}', 0, NULL, '2025-07-08 11:48:46', 9);
INSERT INTO `sys_oper_log` VALUES (31, '菜单管理', 2, 'com.mars.admin.modules.system.controller.SysMenuController.update()', 'PUT', 1, 'admin', '未知部门', '/system/menu', '127.0.0.1', NULL, '{\"entity\":{\"createTime\":\"2025-07-03 16:01:20\",\"updateTime\":\"2025-07-08 11:49:54\",\"createBy\":1,\"updateBy\":1,\"isDeleted\":0,\"deleteTime\":null,\"id\":30308,\"parentId\":2,\"menuName\":\"连接监控\",\"menuCode\":\"mysqlconn\",\"menuType\":\"C\",\"routeName\":\"mysqlconn\",\"routePath\":\"/mysqlconn\",\"component\":\"\",\"redirect\":\"http://localhost:8080/druid/index.html\",\"queryParam\":null,\"isFrame\":0,\"isCache\":0,\"menuTypeFlag\":\"\",\"visible\":1,\"status\":1,\"perms\":\"\",\"icon\":\"\",\"orderNum\":0,\"isSystem\":0,\"remark\":null,\"children\":[],\"parentName\":null}} | 描述: 修改菜单', '{\"code\":200,\"message\":\"修改成功\",\"data\":null,\"timestamp\":1751946594489,\"error\":false,\"success\":true}', 0, NULL, '2025-07-08 11:49:54', 47);
INSERT INTO `sys_oper_log` VALUES (32, '菜单管理', 3, 'com.mars.admin.modules.system.controller.SysMenuController.deleteById()', 'DELETE', 1, 'admin', '未知部门', '/system/menu/30307', '127.0.0.1', NULL, '{\"id\":30307} | 描述: 删除菜单', '{\"code\":200,\"message\":\"删除成功\",\"data\":null,\"timestamp\":1751946610859,\"error\":false,\"success\":true}', 0, NULL, '2025-07-08 11:50:10', 12);
INSERT INTO `sys_oper_log` VALUES (33, '菜单管理', 2, 'com.mars.admin.modules.system.controller.SysMenuController.update()', 'PUT', 1, 'admin', '未知部门', '/system/menu', '127.0.0.1', NULL, '{\"entity\":{\"createTime\":\"2025-07-03 15:46:07\",\"updateTime\":\"2025-07-08 12:00:33\",\"createBy\":1,\"updateBy\":1,\"isDeleted\":0,\"deleteTime\":null,\"id\":30306,\"parentId\":0,\"menuName\":\"组织管理\",\"menuCode\":\"org\",\"menuType\":\"M\",\"routeName\":\"org\",\"routePath\":\"/org\",\"component\":\"\",\"redirect\":\"\",\"queryParam\":null,\"isFrame\":1,\"isCache\":0,\"menuTypeFlag\":\"\",\"visible\":1,\"status\":1,\"perms\":\"\",\"icon\":\"\",\"orderNum\":3,\"isSystem\":0,\"remark\":null,\"children\":[{\"createTime\":\"2025-06-25 16:34:16\",\"updateTime\":\"2025-07-03 15:46:42\",\"createBy\":1,\"updateBy\":1,\"isDeleted\":0,\"deleteTime\":null,\"id\":103,\"parentId\":30306,\"menuName\":\"部门管理\",\"menuCode\":\"DEPT_MANAGE\",\"menuType\":\"C\",\"routeName\":\"manage_dept\",\"routePath\":\"/manage/dept\",\"component\":\"view.manage_dept\",\"redirect\":null,\"queryParam\":null,\"isFrame\":1,\"isCache\":0,\"menuTypeFlag\":\"\",\"visible\":1,\"status\":1,\"perms\":\"system:dept:list\",\"icon\":\"tree\",\"orderNum\":4,\"isSystem\":1,\"remark\":null,\"children\":[],\"parentName\":null},{\"createTime\":\"2025-06-25 16:34:16\",\"updateTime\":\"2025-07-03 15:46:58\",\"createBy\":1,\"updateBy\":1,\"isDeleted\":0,\"deleteTime\":null,\"id\":104,\"parentId\":30306,\"menuName\":\"岗位管理\",\"menuCode\":\"POST_MANAGE\",\"menuType\":\"C\",\"routeName\":\"manage_post\",\"routePath\":\"/manage/post\",\"component\":\"view.manage_post\",\"redirect\":null,\"queryParam\":null,\"isFrame\":1,\"isCache\":0,\"menuTypeFlag\":\"\",\"visible\":1,\"status\":1,\"perms\":\"system:post:list\",\"icon\":\"post\",\"orderNum\":5,\"isSystem\":1,\"remark\":null,\"children\":[],\"parentName\":null}],\"parentName\":null}} | 描述: 修改菜单', '{\"code\":200,\"message\":\"修改成功\",\"data\":null,\"timestamp\":1751947233286,\"error\":false,\"success\":true}', 0, NULL, '2025-07-08 12:00:33', 8);
INSERT INTO `sys_oper_log` VALUES (34, '字典管理', 1, 'com.mars.admin.modules.system.controller.SysDictController.addDictType()', 'POST', 1, 'admin', '未知部门', '/system/dict/type', '127.0.0.1', NULL, '{\"dictType\":{\"createTime\":\"2025-06-25 16:34:16\",\"updateTime\":\"2025-06-25 16:34:16\",\"createBy\":1,\"updateBy\":null,\"isDeleted\":0,\"deleteTime\":null,\"id\":7,\"dictName\":\"测试\",\"dictType\":\"test\",\"status\":1,\"remark\":\"\",\"dictDataList\":null}} | 描述: 新增字典类型：#{#dictType.dictName}', '{\"code\":200,\"message\":\"新增成功\",\"data\":null,\"timestamp\":1751954069747,\"error\":false,\"success\":true}', 0, NULL, '2025-07-08 13:54:29', 8);
INSERT INTO `sys_oper_log` VALUES (35, '字典管理', 1, 'com.mars.admin.modules.system.controller.SysDictController.addDictData()', 'POST', 1, 'admin', '未知部门', '/system/dict/data', '127.0.0.1', NULL, '{\"dictData\":{\"createTime\":null,\"updateTime\":null,\"createBy\":null,\"updateBy\":null,\"isDeleted\":0,\"deleteTime\":null,\"id\":10,\"dictSort\":0,\"dictLabel\":\"1\",\"dictValue\":\"1\",\"dictType\":\"test\",\"cssClass\":\"\",\"listClass\":\"\",\"isDefault\":\"N\",\"status\":1,\"remark\":\"\"}} | 描述: 新增字典数据：#{#dictData.dictLabel}', '{\"code\":200,\"message\":\"新增成功\",\"data\":null,\"timestamp\":1751954077136,\"error\":false,\"success\":true}', 0, NULL, '2025-07-08 13:54:37', 4);
INSERT INTO `sys_oper_log` VALUES (36, '字典管理', 3, 'com.mars.admin.modules.system.controller.SysDictController.deleteDictData()', 'DELETE', 1, 'admin', '未知部门', '/system/dict/data/10', '127.0.0.1', NULL, '{\"id\":10} | 描述: 删除字典数据，ID：#{#id}', '{\"code\":200,\"message\":\"删除成功\",\"data\":null,\"timestamp\":1751954081137,\"error\":false,\"success\":true}', 0, NULL, '2025-07-08 13:54:41', 3);
INSERT INTO `sys_oper_log` VALUES (37, '字典管理', 3, 'com.mars.admin.modules.system.controller.SysDictController.deleteDictType()', 'DELETE', 1, 'admin', '未知部门', '/system/dict/type/7', '127.0.0.1', NULL, '{\"id\":7} | 描述: 删除字典类型，ID：#{#id}', '{\"code\":200,\"message\":\"删除成功\",\"data\":null,\"timestamp\":1751954084481,\"error\":false,\"success\":true}', 0, NULL, '2025-07-08 13:54:44', 2);
INSERT INTO `sys_oper_log` VALUES (38, '文件管理', 10, 'com.mars.admin.modules.base.controller.FileUploadController.upload()', 'POST', 1, NULL, NULL, '/file/upload', '127.0.0.1', NULL, '描述: 上传文件：#{#file.originalFilename}', '{\"code\":200,\"message\":\"上传成功\",\"data\":{\"id\":6,\"fileName\":\"fdebb9be36184ceaa0bebf3c49f63b00.jpg\",\"originalName\":\"sex.jpg\",\"fileSuffix\":\"jpg\",\"url\":\"http://150.158.49.140:9000/test/upload/2025/07/08/fdebb9be36184ceaa0bebf3c49f63b00.jpg\",\"size\":39854,\"filePath\":\"upload/2025/07/08/fdebb9be36184ceaa0bebf3c49f63b00.jpg\",\"contentType\":\"image/jpeg\",\"configKey\":\"minio\",\"uploadStatus\":1},\"timestamp\":1751954170967,\"error\":false,\"success\":true}', 0, NULL, '2025-07-08 13:56:10', 2);
INSERT INTO `sys_oper_log` VALUES (39, '文件管理', 10, 'com.mars.admin.modules.base.controller.FileUploadController.upload()', 'POST', 1, NULL, NULL, '/file/upload', '127.0.0.1', NULL, '描述: 上传文件：#{#file.originalFilename}', '{\"code\":500,\"message\":\"上传失败: 本地文件上传失败: java.io.FileNotFoundException: C:\\\\Users\\\\Administrator\\\\AppData\\\\Local\\\\Temp\\\\tomcat.8080.12348213868114401789\\\\work\\\\Tomcat\\\\localhost\\\\ROOT\\\\.\\\\upload\\\\upload\\\\2025\\\\07\\\\08\\\\88b29180328c444a82d466b2415091c5.jpg (系统找不到指定的路径。)\",\"data\":null,\"timestamp\":1751954328977,\"error\":true,\"success\":false}', 0, NULL, '2025-07-08 13:58:48', 1);
INSERT INTO `sys_oper_log` VALUES (40, '文件管理', 3, 'com.mars.admin.modules.base.controller.FileUploadController.delete()', 'DELETE', 1, 'admin', '未知部门', '/file/6', '127.0.0.1', NULL, '{\"id\":6} | 描述: 删除文件，文件ID：#{#id}', '{\"code\":200,\"message\":\"操作成功\",\"data\":null,\"timestamp\":1751954334745,\"error\":false,\"success\":true}', 0, NULL, '2025-07-08 13:58:54', 4);
INSERT INTO `sys_oper_log` VALUES (41, '文件管理', 10, 'com.mars.admin.modules.base.controller.FileUploadController.upload()', 'POST', 1, NULL, NULL, '/file/upload', '127.0.0.1', NULL, '描述: 上传文件：#{#file.originalFilename}', '{\"code\":500,\"message\":\"上传失败: 本地文件上传失败: java.io.FileNotFoundException: C:\\\\Users\\\\Administrator\\\\AppData\\\\Local\\\\Temp\\\\tomcat.8080.12348213868114401789\\\\work\\\\Tomcat\\\\localhost\\\\ROOT\\\\.\\\\upload\\\\upload\\\\2025\\\\07\\\\08\\\\b3c108b13c524d07957c8b9c4fc8c301.jpg (系统找不到指定的路径。)\",\"data\":null,\"timestamp\":1751954340921,\"error\":true,\"success\":false}', 0, NULL, '2025-07-08 13:59:00', 0);
INSERT INTO `sys_oper_log` VALUES (42, '菜单管理', 3, 'com.mars.admin.modules.system.controller.SysMenuController.deleteById()', 'DELETE', 1, 'admin', '未知部门', '/system/menu/3', '127.0.0.1', NULL, '{\"id\":3} | 描述: 删除菜单', '{\"code\":200,\"message\":\"删除成功\",\"data\":null,\"timestamp\":1751954391504,\"error\":false,\"success\":true}', 0, NULL, '2025-07-08 13:59:51', 2);
INSERT INTO `sys_oper_log` VALUES (43, '文件管理', 10, 'com.mars.admin.modules.base.controller.FileUploadController.upload()', 'POST', 1, NULL, NULL, '/file/upload', '127.0.0.1', NULL, '描述: 上传文件：#{#file.originalFilename}', '{\"code\":200,\"message\":\"上传成功\",\"data\":{\"id\":7,\"fileName\":\"3098111a10b340d79926b877bedbb8ea.jpg\",\"originalName\":\"img_v3_02mm_6eaf2ac0-71ba-43ed-a56f-3913e28ab79g.jpg\",\"fileSuffix\":\"jpg\",\"url\":\"http://150.158.49.140:9000/test/upload/2025/07/08/3098111a10b340d79926b877bedbb8ea.jpg\",\"size\":100276,\"filePath\":\"upload/2025/07/08/3098111a10b340d79926b877bedbb8ea.jpg\",\"contentType\":\"image/jpeg\",\"configKey\":\"minio\",\"uploadStatus\":1},\"timestamp\":1751961344340,\"error\":false,\"success\":true}', 0, NULL, '2025-07-08 15:55:44', 6);
INSERT INTO `sys_oper_log` VALUES (44, '文件管理', 10, 'com.mars.admin.modules.base.controller.FileUploadController.upload()', 'POST', 1, NULL, NULL, '/file/upload', '127.0.0.1', NULL, '描述: 上传文件：#{#file.originalFilename}', '{\"code\":200,\"message\":\"上传成功\",\"data\":{\"id\":8,\"fileName\":\"05d75ad7b8aa400183ea2712293ca9c4.jpg\",\"originalName\":\"profile.jpg\",\"fileSuffix\":\"jpg\",\"url\":\"http://150.158.49.140:9000/test/upload/2025/07/08/05d75ad7b8aa400183ea2712293ca9c4.jpg\",\"size\":93672,\"filePath\":\"upload/2025/07/08/05d75ad7b8aa400183ea2712293ca9c4.jpg\",\"contentType\":\"image/jpeg\",\"configKey\":\"minio\",\"uploadStatus\":1},\"timestamp\":1751961386577,\"error\":false,\"success\":true}', 0, NULL, '2025-07-08 15:56:26', 0);
INSERT INTO `sys_oper_log` VALUES (45, '文件管理', 10, 'com.mars.admin.modules.base.controller.FileUploadController.upload()', 'POST', 1, NULL, NULL, '/file/upload', '127.0.0.1', NULL, '描述: 上传文件：#{#file.originalFilename}', '{\"code\":200,\"message\":\"上传成功\",\"data\":{\"id\":9,\"fileName\":\"6a6007c5eea44aca847344b0ea689c36.jpg\",\"originalName\":\"profile.jpg\",\"fileSuffix\":\"jpg\",\"url\":\"http://150.158.49.140:9000/test/upload/2025/07/08/6a6007c5eea44aca847344b0ea689c36.jpg\",\"size\":93672,\"filePath\":\"upload/2025/07/08/6a6007c5eea44aca847344b0ea689c36.jpg\",\"contentType\":\"image/jpeg\",\"configKey\":\"minio\",\"uploadStatus\":1},\"timestamp\":1751961420504,\"error\":false,\"success\":true}', 0, NULL, '2025-07-08 15:57:00', 0);
INSERT INTO `sys_oper_log` VALUES (46, '文件管理', 10, 'com.mars.admin.modules.base.controller.FileUploadController.upload()', 'POST', 1, NULL, NULL, '/file/upload', '127.0.0.1', NULL, '描述: 上传文件：#{#file.originalFilename}', '{\"code\":200,\"message\":\"上传成功\",\"data\":{\"id\":10,\"fileName\":\"2e6040c282ca4023b99154d64e256b1c.jpg\",\"originalName\":\"profile.jpg\",\"fileSuffix\":\"jpg\",\"url\":\"http://localhost:8080/file/2025/07/09/2e6040c282ca4023b99154d64e256b1c.jpg\",\"size\":93672,\"filePath\":\"2025/07/09\\\\2e6040c282ca4023b99154d64e256b1c.jpg\",\"contentType\":\"image/jpeg\",\"configKey\":\"local\",\"uploadStatus\":1},\"timestamp\":1752045805222,\"error\":false,\"success\":true}', 0, NULL, '2025-07-09 15:23:25', 5);
INSERT INTO `sys_oper_log` VALUES (47, '文件管理', 10, 'com.mars.admin.modules.base.controller.FileUploadController.upload()', 'POST', 1, NULL, NULL, '/file/upload', '127.0.0.1', NULL, '描述: 上传文件：#{#file.originalFilename}', '{\"code\":200,\"message\":\"上传成功\",\"data\":{\"id\":11,\"fileName\":\"738b8d79e4ae4354958001222ddd4004.jpg\",\"originalName\":\"profile.jpg\",\"fileSuffix\":\"jpg\",\"url\":\"http://150.158.49.140:9000/test/upload/2025/07/09/738b8d79e4ae4354958001222ddd4004.jpg\",\"size\":93672,\"filePath\":\"upload/2025/07/09/738b8d79e4ae4354958001222ddd4004.jpg\",\"contentType\":\"image/jpeg\",\"configKey\":\"minio\",\"uploadStatus\":1},\"timestamp\":1752046551316,\"error\":false,\"success\":true}', 0, NULL, '2025-07-09 15:36:10', 19562);
INSERT INTO `sys_oper_log` VALUES (48, '文件管理', 10, 'com.mars.admin.modules.base.controller.FileUploadController.upload()', 'POST', 1, NULL, NULL, '/file/upload', '127.0.0.1', NULL, '描述: 上传文件：#{#file.originalFilename}', '{\"code\":200,\"message\":\"上传成功\",\"data\":{\"id\":12,\"fileName\":\"0a6fadf4d7804fdf86a1b371f819c0cb.jpg\",\"originalName\":\"profile.jpg\",\"fileSuffix\":\"jpg\",\"url\":\"http://150.158.49.140:9000/test/upload/2025/07/09/0a6fadf4d7804fdf86a1b371f819c0cb.jpg\",\"size\":93672,\"filePath\":\"upload/2025/07/09/0a6fadf4d7804fdf86a1b371f819c0cb.jpg\",\"contentType\":\"image/jpeg\",\"configKey\":\"minio\",\"uploadStatus\":1},\"timestamp\":1752046913335,\"error\":false,\"success\":true}', 0, NULL, '2025-07-09 15:43:21', 27487);
INSERT INTO `sys_oper_log` VALUES (49, '文件管理', 10, 'com.mars.admin.modules.base.controller.FileUploadController.upload()', 'POST', 1, NULL, NULL, '/file/upload', '127.0.0.1', NULL, '描述: 上传文件：#{#file.originalFilename}', '{\"code\":200,\"message\":\"上传成功\",\"data\":{\"id\":13,\"fileName\":\"541f2175a8d94b85bbaa2e89f3c82643.jpg\",\"originalName\":\"profile.jpg\",\"fileSuffix\":\"jpg\",\"url\":\"http://150.158.49.140:9000/test/upload/2025/07/09/541f2175a8d94b85bbaa2e89f3c82643.jpg\",\"size\":93672,\"filePath\":\"upload/2025/07/09/541f2175a8d94b85bbaa2e89f3c82643.jpg\",\"contentType\":\"image/jpeg\",\"configKey\":\"minio\",\"uploadStatus\":1},\"timestamp\":1752047023383,\"error\":false,\"success\":true}', 0, NULL, '2025-07-09 15:44:19', 36373);
INSERT INTO `sys_oper_log` VALUES (50, '岗位管理', 1, 'com.mars.admin.modules.system.controller.SysPostController.save()', 'POST', 1, 'admin', '未知部门', '/system/post', '127.0.0.1', NULL, '{\"entity\":{\"createTime\":\"2025-07-09 16:10:42\",\"updateTime\":null,\"createBy\":1,\"updateBy\":null,\"isDeleted\":0,\"deleteTime\":null,\"id\":5,\"postCode\":\"test111\",\"postName\":\"test\",\"postSort\":0,\"status\":1,\"isSystem\":null,\"remark\":\"\"}} | 描述: 新增岗位：#{#entity.postName}', '{\"code\":200,\"message\":\"新增成功\",\"data\":null,\"timestamp\":1752048642406,\"error\":false,\"success\":true}', 0, NULL, '2025-07-09 16:10:42', 7);
INSERT INTO `sys_oper_log` VALUES (51, '文件管理', 10, 'com.mars.admin.modules.base.controller.FileUploadController.upload()', 'POST', 1, NULL, NULL, '/file/upload', '127.0.0.1', NULL, '描述: 上传文件：#{#file.originalFilename}', '{\"code\":200,\"message\":\"上传成功\",\"data\":{\"id\":14,\"fileName\":\"7c035439baca475e9434b9e2daec2c00.jpg\",\"originalName\":\"profile.jpg\",\"fileSuffix\":\"jpg\",\"url\":\"http://150.158.49.140:9000/test/upload/2025/07/09/7c035439baca475e9434b9e2daec2c00.jpg\",\"size\":93672,\"filePath\":\"upload/2025/07/09/7c035439baca475e9434b9e2daec2c00.jpg\",\"contentType\":\"image/jpeg\",\"configKey\":\"minio\",\"uploadStatus\":1},\"timestamp\":1752049750887,\"error\":false,\"success\":true}', 0, NULL, '2025-07-09 16:29:10', 26);
INSERT INTO `sys_oper_log` VALUES (52, '岗位管理', 1, 'com.mars.admin.modules.system.controller.SysPostController.save()', 'POST', 1, 'admin', '未知部门', '/system/post', '127.0.0.1', NULL, '{\"entity\":{\"createTime\":\"2025-07-09 16:30:04\",\"updateTime\":null,\"createBy\":1,\"updateBy\":null,\"isDeleted\":0,\"deleteTime\":null,\"id\":6,\"postCode\":\"2323\",\"postName\":\"test1213\",\"postSort\":0,\"status\":1,\"isSystem\":null,\"remark\":\"\"}} | 描述: 新增岗位：#{#entity.postName}', '{\"code\":200,\"message\":\"新增成功\",\"data\":null,\"timestamp\":1752049804698,\"error\":false,\"success\":true}', 0, NULL, '2025-07-09 16:30:04', 23);
INSERT INTO `sys_oper_log` VALUES (53, '岗位管理', 2, 'com.mars.admin.modules.system.controller.SysPostController.changeStatus()', 'PUT', 1, 'admin', '未知部门', '/system/post/changeStatus', '127.0.0.1', NULL, '{\"post\":{\"createTime\":null,\"updateTime\":\"2025-07-09 16:31:29\",\"createBy\":null,\"updateBy\":1,\"isDeleted\":null,\"deleteTime\":null,\"id\":6,\"postCode\":null,\"postName\":null,\"postSort\":null,\"status\":0,\"isSystem\":null,\"remark\":null}} | 描述: 修改岗位状态，ID：#{#post.id}，状态：#{#post.status}', '{\"code\":200,\"message\":\"操作成功\",\"data\":null,\"timestamp\":1752049889266,\"error\":false,\"success\":true}', 0, NULL, '2025-07-09 16:31:29', 10);
INSERT INTO `sys_oper_log` VALUES (54, '岗位管理', 2, 'com.mars.admin.modules.system.controller.SysPostController.changeStatus()', 'PUT', 1, 'admin', '未知部门', '/system/post/changeStatus', '127.0.0.1', NULL, '{\"post\":{\"createTime\":null,\"updateTime\":\"2025-07-09 16:31:37\",\"createBy\":null,\"updateBy\":1,\"isDeleted\":null,\"deleteTime\":null,\"id\":6,\"postCode\":null,\"postName\":null,\"postSort\":null,\"status\":1,\"isSystem\":null,\"remark\":null}} | 描述: 修改岗位状态，ID：#{#post.id}，状态：#{#post.status}', '{\"code\":200,\"message\":\"操作成功\",\"data\":null,\"timestamp\":1752049897212,\"error\":false,\"success\":true}', 0, NULL, '2025-07-09 16:31:37', 4);
INSERT INTO `sys_oper_log` VALUES (55, '岗位管理', 3, 'com.mars.admin.modules.system.controller.SysPostController.deleteById()', 'DELETE', 1, 'admin', '未知部门', '/system/post/6', '127.0.0.1', NULL, '{\"id\":6} | 描述: 删除岗位，ID：#{#id}', '{\"code\":200,\"message\":\"删除成功\",\"data\":null,\"timestamp\":1752049900015,\"error\":false,\"success\":true}', 0, NULL, '2025-07-09 16:31:40', 5);
INSERT INTO `sys_oper_log` VALUES (56, '岗位管理', 3, 'com.mars.admin.modules.system.controller.SysPostController.deleteById()', 'DELETE', 1, 'admin', '未知部门', '/system/post/5', '127.0.0.1', NULL, '{\"id\":5} | 描述: 删除岗位，ID：#{#id}', '{\"code\":200,\"message\":\"删除成功\",\"data\":null,\"timestamp\":1752049902826,\"error\":false,\"success\":true}', 0, NULL, '2025-07-09 16:31:42', 4);
INSERT INTO `sys_oper_log` VALUES (57, '文件管理', 10, 'com.mars.admin.modules.base.controller.FileUploadController.upload()', 'POST', 1, NULL, NULL, '/api/file/upload', '127.0.0.1', NULL, '描述: 上传文件：#{#file.originalFilename}', '{\"code\":500,\"message\":\"上传失败: MinIO文件上传失败: Failed to connect to /150.158.49.140:9000\",\"data\":null,\"timestamp\":1753533678232,\"error\":true,\"success\":false}', 0, NULL, '2025-07-26 20:41:18', 17);
INSERT INTO `sys_oper_log` VALUES (58, '文件管理', 10, 'com.mars.admin.modules.base.controller.FileUploadController.upload()', 'POST', 1, NULL, NULL, '/api/file/upload', '127.0.0.1', NULL, '描述: 上传文件：#{#file.originalFilename}', '{\"code\":500,\"message\":\"上传失败: MinIO文件上传失败: Failed to connect to /150.158.49.140:9000\",\"data\":null,\"timestamp\":1753533754062,\"error\":true,\"success\":false}', 0, NULL, '2025-07-26 20:42:34', 5);
INSERT INTO `sys_oper_log` VALUES (59, '文件管理', 10, 'com.mars.admin.modules.base.controller.FileUploadController.upload()', 'POST', 1, NULL, NULL, '/api/file/upload', '127.0.0.1', NULL, '描述: 上传文件：#{#file.originalFilename}', '{\"code\":500,\"message\":\"上传失败: OSS配置已停用: minio\",\"data\":null,\"timestamp\":1753534229498,\"error\":true,\"success\":false}', 0, NULL, '2025-07-26 20:50:29', 20);
INSERT INTO `sys_oper_log` VALUES (60, '文件管理', 10, 'com.mars.admin.modules.base.controller.FileUploadController.upload()', 'POST', 1, NULL, NULL, '/api/file/upload', '127.0.0.1', NULL, '描述: 上传文件：#{#file.originalFilename}', '{\"code\":200,\"message\":\"上传成功\",\"data\":{\"id\":15,\"fileName\":\"0aef8b1285d84b3ca99f2a39860d7f0b.jpeg\",\"originalName\":\"tzyi1tdCU3Iu2cbed3f626e7813cee7e279cd18288f8.jpeg\",\"fileSuffix\":\"jpeg\",\"url\":\"https://chaoyou-image.oss-cn-beijing.aliyuncs.com/upload/2025/07/26/0aef8b1285d84b3ca99f2a39860d7f0b.jpeg\",\"size\":6115,\"filePath\":\"upload/2025/07/26/0aef8b1285d84b3ca99f2a39860d7f0b.jpeg\",\"contentType\":\"image/jpeg\",\"configKey\":\"aliyun\",\"uploadStatus\":1},\"timestamp\":1753534528015,\"error\":false,\"success\":true}', 0, NULL, '2025-07-26 20:55:28', 55);
INSERT INTO `sys_oper_log` VALUES (61, '文件管理', 10, 'com.mars.admin.modules.base.controller.FileUploadController.upload()', 'POST', 1, NULL, NULL, '/api/file/upload', '127.0.0.1', NULL, '描述: 上传文件：#{#file.originalFilename}', '{\"code\":200,\"message\":\"上传成功\",\"data\":{\"id\":16,\"fileName\":\"ac104032a04b490c8e3d330b52827ee7.jpeg\",\"originalName\":\"oVymYG1WmE7D5e75040c2f7570a26fae82f691341d99.jpeg\",\"fileSuffix\":\"jpeg\",\"url\":\"https://chaoyou-image.oss-cn-beijing.aliyuncs.com/upload/2025/07/26/ac104032a04b490c8e3d330b52827ee7.jpeg\",\"size\":6116,\"filePath\":\"upload/2025/07/26/ac104032a04b490c8e3d330b52827ee7.jpeg\",\"contentType\":\"image/jpeg\",\"configKey\":\"aliyun\",\"uploadStatus\":1},\"timestamp\":1753534713983,\"error\":false,\"success\":true}', 0, NULL, '2025-07-26 20:58:33', 4);
INSERT INTO `sys_oper_log` VALUES (62, '文件管理', 10, 'com.mars.admin.modules.base.controller.FileUploadController.upload()', 'POST', 1, NULL, NULL, '/api/file/upload', '127.0.0.1', NULL, '描述: 上传文件：#{#file.originalFilename}', '{\"code\":200,\"message\":\"上传成功\",\"data\":{\"id\":17,\"fileName\":\"d347ff6277f24ffaa072a7f37a5603f8.jpeg\",\"originalName\":\"HYjhCKNnt9GE2bcebbfcc87490f3d422bec3a690206b.jpeg\",\"fileSuffix\":\"jpeg\",\"url\":\"https://chaoyou-image.oss-cn-beijing.aliyuncs.com/upload/2025/07/26/d347ff6277f24ffaa072a7f37a5603f8.jpeg\",\"size\":6116,\"filePath\":\"upload/2025/07/26/d347ff6277f24ffaa072a7f37a5603f8.jpeg\",\"contentType\":\"image/jpeg\",\"configKey\":\"aliyun\",\"uploadStatus\":1},\"timestamp\":1753534864987,\"error\":false,\"success\":true}', 0, NULL, '2025-07-26 21:01:05', 15);
INSERT INTO `sys_oper_log` VALUES (63, '文件管理', 10, 'com.mars.admin.modules.base.controller.FileUploadController.upload()', 'POST', 1, NULL, NULL, '/api/file/upload', '127.0.0.1', NULL, '描述: 上传文件：#{#file.originalFilename}', '{\"code\":200,\"message\":\"上传成功\",\"data\":{\"id\":18,\"fileName\":\"826da3e5d2ce474cb2dd298e8a160815.jpeg\",\"originalName\":\"NaTXxnjsvj192086e58c6a08447de0ea9fad0be096d5.jpeg\",\"fileSuffix\":\"jpeg\",\"url\":\"https://chaoyou-image.oss-cn-beijing.aliyuncs.com/upload/2025/07/26/826da3e5d2ce474cb2dd298e8a160815.jpeg\",\"size\":6116,\"filePath\":\"upload/2025/07/26/826da3e5d2ce474cb2dd298e8a160815.jpeg\",\"contentType\":\"image/jpeg\",\"configKey\":\"aliyun\",\"uploadStatus\":1},\"timestamp\":1753534943904,\"error\":false,\"success\":true}', 0, NULL, '2025-07-26 21:02:23', 4);
INSERT INTO `sys_oper_log` VALUES (64, '文件管理', 10, 'com.mars.admin.modules.base.controller.FileUploadController.upload()', 'POST', 1, NULL, NULL, '/api/file/upload', '127.0.0.1', NULL, '描述: 上传文件：#{#file.originalFilename}', '{\"code\":200,\"message\":\"上传成功\",\"data\":{\"id\":19,\"fileName\":\"0a7eda40b9a84fe38a3264ece079316c.jpeg\",\"originalName\":\"vHgNekKcp0k70a8b96f797c26034734b43dbebdbdfa2.jpeg\",\"fileSuffix\":\"jpeg\",\"url\":\"https://chaoyou-image.oss-cn-beijing.aliyuncs.com/upload/2025/07/26/0a7eda40b9a84fe38a3264ece079316c.jpeg\",\"size\":6112,\"filePath\":\"upload/2025/07/26/0a7eda40b9a84fe38a3264ece079316c.jpeg\",\"contentType\":\"image/jpeg\",\"configKey\":\"aliyun\",\"uploadStatus\":1},\"timestamp\":1753536443722,\"error\":false,\"success\":true}', 0, NULL, '2025-07-26 21:27:23', 11);
INSERT INTO `sys_oper_log` VALUES (65, '文件管理', 10, 'com.mars.admin.modules.base.controller.FileUploadController.upload()', 'POST', 1, NULL, NULL, '/api/file/upload', '127.0.0.1', NULL, '描述: 上传文件：#{#file.originalFilename}', '{\"code\":200,\"message\":\"上传成功\",\"data\":{\"id\":20,\"fileName\":\"ef08e2e96638405cab9eb9e7da7f7ade.jpeg\",\"originalName\":\"rfBtQiltaFJ16494ba00ce54a62402ea805ec2f0ae75.jpeg\",\"fileSuffix\":\"jpeg\",\"url\":\"https://chaoyou-image.oss-cn-beijing.aliyuncs.com/upload/2025/07/26/ef08e2e96638405cab9eb9e7da7f7ade.jpeg\",\"size\":6116,\"filePath\":\"upload/2025/07/26/ef08e2e96638405cab9eb9e7da7f7ade.jpeg\",\"contentType\":\"image/jpeg\",\"configKey\":\"aliyun\",\"uploadStatus\":1},\"timestamp\":1753536522734,\"error\":false,\"success\":true}', 0, NULL, '2025-07-26 21:28:42', 0);
INSERT INTO `sys_oper_log` VALUES (66, '文件管理', 10, 'com.mars.admin.modules.base.controller.FileUploadController.upload()', 'POST', 1, NULL, NULL, '/api/file/upload', '127.0.0.1', NULL, '描述: 上传文件：#{#file.originalFilename}', '{\"code\":200,\"message\":\"上传成功\",\"data\":{\"id\":21,\"fileName\":\"266ede8491e24f758a0607a22aa9046a.jpeg\",\"originalName\":\"mPj6F60kH4rqf4ee31691e7282a156a1464e8e595faf.jpeg\",\"fileSuffix\":\"jpeg\",\"url\":\"https://chaoyou-image.oss-cn-beijing.aliyuncs.com/upload/2025/07/27/266ede8491e24f758a0607a22aa9046a.jpeg\",\"size\":6113,\"filePath\":\"upload/2025/07/27/266ede8491e24f758a0607a22aa9046a.jpeg\",\"contentType\":\"image/jpeg\",\"configKey\":\"aliyun\",\"uploadStatus\":1},\"timestamp\":1753584290253,\"error\":false,\"success\":true}', 0, NULL, '2025-07-27 10:44:50', 38);
INSERT INTO `sys_oper_log` VALUES (67, '文件管理', 10, 'com.mars.admin.modules.base.controller.FileUploadController.upload()', 'POST', 1, NULL, NULL, '/api/file/upload', '127.0.0.1', NULL, '描述: 上传文件：#{#file.originalFilename}', '{\"code\":200,\"message\":\"上传成功\",\"data\":{\"id\":22,\"fileName\":\"4ef5fbbf47e242b28a23e1f9f662aa12.jpeg\",\"originalName\":\"ZFbhfpyN9Jn0c0ee4e14a897f47daef5918fef5032b0.jpeg\",\"fileSuffix\":\"jpeg\",\"url\":\"https://chaoyou-image.oss-cn-beijing.aliyuncs.com/upload/2025/07/27/4ef5fbbf47e242b28a23e1f9f662aa12.jpeg\",\"size\":6116,\"filePath\":\"upload/2025/07/27/4ef5fbbf47e242b28a23e1f9f662aa12.jpeg\",\"contentType\":\"image/jpeg\",\"configKey\":\"aliyun\",\"uploadStatus\":1},\"timestamp\":1753584477342,\"error\":false,\"success\":true}', 0, NULL, '2025-07-27 10:47:57', 43);
INSERT INTO `sys_oper_log` VALUES (68, '文件管理', 10, 'com.mars.admin.modules.base.controller.FileUploadController.upload()', 'POST', 1, NULL, NULL, '/api/file/upload', '127.0.0.1', NULL, '描述: 上传文件：#{#file.originalFilename}', '{\"code\":200,\"message\":\"上传成功\",\"data\":{\"id\":23,\"fileName\":\"fa3a52446fcd4066ac72d8faf5dc9854.jpeg\",\"originalName\":\"SBS1YmiTl0LN5e45eeb75f1e176a7755bcc6e20b2258.jpeg\",\"fileSuffix\":\"jpeg\",\"url\":\"https://chaoyou-image.oss-cn-beijing.aliyuncs.com/upload/2025/07/27/fa3a52446fcd4066ac72d8faf5dc9854.jpeg\",\"size\":6116,\"filePath\":\"upload/2025/07/27/fa3a52446fcd4066ac72d8faf5dc9854.jpeg\",\"contentType\":\"image/jpeg\",\"configKey\":\"aliyun\",\"uploadStatus\":1},\"timestamp\":1753585998430,\"error\":false,\"success\":true}', 0, NULL, '2025-07-27 11:13:18', 3);

-- ----------------------------
-- Table structure for sys_oss
-- ----------------------------
DROP TABLE IF EXISTS `sys_oss`;
CREATE TABLE `sys_oss`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '对象存储主键',
  `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文件名',
  `original_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '原名',
  `file_suffix` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文件后缀名',
  `url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文件地址',
  `size` bigint NULL DEFAULT 0 COMMENT '文件大小',
  `config_key` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '配置key',
  `file_path` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '文件路径',
  `content_type` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '文件类型',
  `upload_id` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '上传ID(用于分片上传)',
  `upload_status` tinyint(1) NULL DEFAULT 1 COMMENT '上传状态：0-失败，1-成功',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建人',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新人',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除：0-否，1-是',
  `delete_time` datetime NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_config_key`(`config_key` ASC) USING BTREE,
  INDEX `idx_upload_status`(`upload_status` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE,
  INDEX `idx_is_deleted`(`is_deleted` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '对象存储表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_oss
-- ----------------------------
INSERT INTO `sys_oss` VALUES (1, '59e354e153c64b9886e4f5c7a83f214d.jpg', 'logo.jpg', 'jpg', 'http://150.158.49.140:9000/test/upload/2025/06/28/59e354e153c64b9886e4f5c7a83f214d.jpg', 60453, 'minio', 'upload/2025/06/28/59e354e153c64b9886e4f5c7a83f214d.jpg', 'image/jpeg', NULL, 1, NULL, '2025-06-28 11:55:40', '2025-06-28 11:55:40', 1, NULL, 0, NULL);
INSERT INTO `sys_oss` VALUES (2, 'b5f0f4fbb41c489fa1799c50db6247de.jpg', 'img_v3_02mm_6eaf2ac0-71ba-43ed-a56f-3913e28ab79g.jpg', 'jpg', 'http://150.158.49.140:9000/test/upload/2025/07/03/b5f0f4fbb41c489fa1799c50db6247de.jpg', 100276, 'minio', 'upload/2025/07/03/b5f0f4fbb41c489fa1799c50db6247de.jpg', 'image/jpeg', NULL, 1, NULL, '2025-07-03 13:44:25', '2025-07-03 13:44:25', NULL, NULL, 0, NULL);
INSERT INTO `sys_oss` VALUES (3, '55afdcc5602c458ea03a22a2bc55bf16.jpeg', '头像.jpeg', 'jpeg', 'http://150.158.49.140:9000/test/upload/2025/07/04/55afdcc5602c458ea03a22a2bc55bf16.jpeg', 8838, 'minio', 'upload/2025/07/04/55afdcc5602c458ea03a22a2bc55bf16.jpeg', 'image/jpeg', NULL, 1, NULL, '2025-07-04 11:04:33', '2025-07-04 11:04:33', NULL, NULL, 0, NULL);
INSERT INTO `sys_oss` VALUES (4, 'ce27368b3efa4c1d81c0dc8c49ea8f89.jpg', 'Bears.jpg', 'jpg', 'http://150.158.49.140:9000/test/upload/2025/07/04/ce27368b3efa4c1d81c0dc8c49ea8f89.jpg', 123500, 'minio', 'upload/2025/07/04/ce27368b3efa4c1d81c0dc8c49ea8f89.jpg', 'image/jpeg', NULL, 1, NULL, '2025-07-04 11:18:33', '2025-07-04 11:18:33', NULL, NULL, 0, NULL);
INSERT INTO `sys_oss` VALUES (5, '7af03b4667b14d4ba3f274a194365c19.jpeg', '头像.jpeg', 'jpeg', 'http://150.158.49.140:9000/test/upload/2025/07/04/7af03b4667b14d4ba3f274a194365c19.jpeg', 8838, 'minio', 'upload/2025/07/04/7af03b4667b14d4ba3f274a194365c19.jpeg', 'image/jpeg', NULL, 1, NULL, '2025-07-04 11:18:40', '2025-07-04 11:18:40', NULL, NULL, 0, NULL);
INSERT INTO `sys_oss` VALUES (6, 'fdebb9be36184ceaa0bebf3c49f63b00.jpg', 'sex.jpg', 'jpg', 'http://150.158.49.140:9000/test/upload/2025/07/08/fdebb9be36184ceaa0bebf3c49f63b00.jpg', 39854, 'minio', 'upload/2025/07/08/fdebb9be36184ceaa0bebf3c49f63b00.jpg', 'image/jpeg', NULL, 1, NULL, '2025-07-08 13:56:10', '2025-07-08 13:58:54', NULL, NULL, 1, '2025-07-08 13:58:54');
INSERT INTO `sys_oss` VALUES (7, '3098111a10b340d79926b877bedbb8ea.jpg', 'img_v3_02mm_6eaf2ac0-71ba-43ed-a56f-3913e28ab79g.jpg', 'jpg', 'http://150.158.49.140:9000/test/upload/2025/07/08/3098111a10b340d79926b877bedbb8ea.jpg', 100276, 'minio', 'upload/2025/07/08/3098111a10b340d79926b877bedbb8ea.jpg', 'image/jpeg', NULL, 1, NULL, '2025-07-08 15:55:44', '2025-07-08 15:55:44', NULL, NULL, 0, NULL);
INSERT INTO `sys_oss` VALUES (8, '05d75ad7b8aa400183ea2712293ca9c4.jpg', 'profile.jpg', 'jpg', 'http://150.158.49.140:9000/test/upload/2025/07/08/05d75ad7b8aa400183ea2712293ca9c4.jpg', 93672, 'minio', 'upload/2025/07/08/05d75ad7b8aa400183ea2712293ca9c4.jpg', 'image/jpeg', NULL, 1, NULL, '2025-07-08 15:56:26', '2025-07-08 15:56:26', NULL, NULL, 0, NULL);
INSERT INTO `sys_oss` VALUES (9, '6a6007c5eea44aca847344b0ea689c36.jpg', 'profile.jpg', 'jpg', 'http://150.158.49.140:9000/test/upload/2025/07/08/6a6007c5eea44aca847344b0ea689c36.jpg', 93672, 'minio', 'upload/2025/07/08/6a6007c5eea44aca847344b0ea689c36.jpg', 'image/jpeg', NULL, 1, NULL, '2025-07-08 15:57:00', '2025-07-08 15:57:00', NULL, NULL, 0, NULL);
INSERT INTO `sys_oss` VALUES (10, '2e6040c282ca4023b99154d64e256b1c.jpg', 'profile.jpg', 'jpg', 'http://localhost:8080/file/2025/07/09/2e6040c282ca4023b99154d64e256b1c.jpg', 93672, 'local', '2025/07/09\\2e6040c282ca4023b99154d64e256b1c.jpg', 'image/jpeg', NULL, 1, NULL, '2025-07-09 15:23:25', '2025-07-09 15:23:25', NULL, NULL, 0, NULL);
INSERT INTO `sys_oss` VALUES (11, '738b8d79e4ae4354958001222ddd4004.jpg', 'profile.jpg', 'jpg', 'http://150.158.49.140:9000/test/upload/2025/07/09/738b8d79e4ae4354958001222ddd4004.jpg', 93672, 'minio', 'upload/2025/07/09/738b8d79e4ae4354958001222ddd4004.jpg', 'image/jpeg', NULL, 1, NULL, '2025-07-09 15:35:51', '2025-07-09 15:35:51', NULL, NULL, 0, NULL);
INSERT INTO `sys_oss` VALUES (12, '0a6fadf4d7804fdf86a1b371f819c0cb.jpg', 'profile.jpg', 'jpg', 'http://150.158.49.140:9000/test/upload/2025/07/09/0a6fadf4d7804fdf86a1b371f819c0cb.jpg', 93672, 'minio', 'upload/2025/07/09/0a6fadf4d7804fdf86a1b371f819c0cb.jpg', 'image/jpeg', NULL, 1, NULL, '2025-07-09 15:41:53', '2025-07-09 15:41:53', NULL, NULL, 0, NULL);
INSERT INTO `sys_oss` VALUES (13, '541f2175a8d94b85bbaa2e89f3c82643.jpg', 'profile.jpg', 'jpg', 'http://150.158.49.140:9000/test/upload/2025/07/09/541f2175a8d94b85bbaa2e89f3c82643.jpg', 93672, 'minio', 'upload/2025/07/09/541f2175a8d94b85bbaa2e89f3c82643.jpg', 'image/jpeg', NULL, 1, NULL, '2025-07-09 15:43:43', '2025-07-09 15:43:43', NULL, NULL, 0, NULL);
INSERT INTO `sys_oss` VALUES (14, '7c035439baca475e9434b9e2daec2c00.jpg', 'profile.jpg', 'jpg', 'http://150.158.49.140:9000/test/upload/2025/07/09/7c035439baca475e9434b9e2daec2c00.jpg', 93672, 'minio', 'upload/2025/07/09/7c035439baca475e9434b9e2daec2c00.jpg', 'image/jpeg', NULL, 1, NULL, '2025-07-09 16:29:10', '2025-07-09 16:29:10', NULL, NULL, 0, NULL);
INSERT INTO `sys_oss` VALUES (15, '0aef8b1285d84b3ca99f2a39860d7f0b.jpeg', 'tzyi1tdCU3Iu2cbed3f626e7813cee7e279cd18288f8.jpeg', 'jpeg', 'https://chaoyou-image.oss-cn-beijing.aliyuncs.com/upload/2025/07/26/0aef8b1285d84b3ca99f2a39860d7f0b.jpeg', 6115, 'aliyun', 'upload/2025/07/26/0aef8b1285d84b3ca99f2a39860d7f0b.jpeg', 'image/jpeg', NULL, 1, NULL, '2025-07-26 20:55:27', '2025-07-26 20:55:27', 7, NULL, 0, NULL);
INSERT INTO `sys_oss` VALUES (16, 'ac104032a04b490c8e3d330b52827ee7.jpeg', 'oVymYG1WmE7D5e75040c2f7570a26fae82f691341d99.jpeg', 'jpeg', 'https://chaoyou-image.oss-cn-beijing.aliyuncs.com/upload/2025/07/26/ac104032a04b490c8e3d330b52827ee7.jpeg', 6116, 'aliyun', 'upload/2025/07/26/ac104032a04b490c8e3d330b52827ee7.jpeg', 'image/jpeg', NULL, 1, NULL, '2025-07-26 20:58:33', '2025-07-26 20:58:33', 7, NULL, 0, NULL);
INSERT INTO `sys_oss` VALUES (17, 'd347ff6277f24ffaa072a7f37a5603f8.jpeg', 'HYjhCKNnt9GE2bcebbfcc87490f3d422bec3a690206b.jpeg', 'jpeg', 'https://chaoyou-image.oss-cn-beijing.aliyuncs.com/upload/2025/07/26/d347ff6277f24ffaa072a7f37a5603f8.jpeg', 6116, 'aliyun', 'upload/2025/07/26/d347ff6277f24ffaa072a7f37a5603f8.jpeg', 'image/jpeg', NULL, 1, NULL, '2025-07-26 21:01:04', '2025-07-26 21:01:04', 7, NULL, 0, NULL);
INSERT INTO `sys_oss` VALUES (18, '826da3e5d2ce474cb2dd298e8a160815.jpeg', 'NaTXxnjsvj192086e58c6a08447de0ea9fad0be096d5.jpeg', 'jpeg', 'https://chaoyou-image.oss-cn-beijing.aliyuncs.com/upload/2025/07/26/826da3e5d2ce474cb2dd298e8a160815.jpeg', 6116, 'aliyun', 'upload/2025/07/26/826da3e5d2ce474cb2dd298e8a160815.jpeg', 'image/jpeg', NULL, 1, NULL, '2025-07-26 21:02:23', '2025-07-26 21:02:23', 7, NULL, 0, NULL);
INSERT INTO `sys_oss` VALUES (19, '0a7eda40b9a84fe38a3264ece079316c.jpeg', 'vHgNekKcp0k70a8b96f797c26034734b43dbebdbdfa2.jpeg', 'jpeg', 'https://chaoyou-image.oss-cn-beijing.aliyuncs.com/upload/2025/07/26/0a7eda40b9a84fe38a3264ece079316c.jpeg', 6112, 'aliyun', 'upload/2025/07/26/0a7eda40b9a84fe38a3264ece079316c.jpeg', 'image/jpeg', NULL, 1, NULL, '2025-07-26 21:27:23', '2025-07-26 21:27:23', NULL, NULL, 0, NULL);
INSERT INTO `sys_oss` VALUES (20, 'ef08e2e96638405cab9eb9e7da7f7ade.jpeg', 'rfBtQiltaFJ16494ba00ce54a62402ea805ec2f0ae75.jpeg', 'jpeg', 'https://chaoyou-image.oss-cn-beijing.aliyuncs.com/upload/2025/07/26/ef08e2e96638405cab9eb9e7da7f7ade.jpeg', 6116, 'aliyun', 'upload/2025/07/26/ef08e2e96638405cab9eb9e7da7f7ade.jpeg', 'image/jpeg', NULL, 1, NULL, '2025-07-26 21:28:42', '2025-07-26 21:28:42', NULL, NULL, 0, NULL);
INSERT INTO `sys_oss` VALUES (21, '266ede8491e24f758a0607a22aa9046a.jpeg', 'mPj6F60kH4rqf4ee31691e7282a156a1464e8e595faf.jpeg', 'jpeg', 'https://chaoyou-image.oss-cn-beijing.aliyuncs.com/upload/2025/07/27/266ede8491e24f758a0607a22aa9046a.jpeg', 6113, 'aliyun', 'upload/2025/07/27/266ede8491e24f758a0607a22aa9046a.jpeg', 'image/jpeg', NULL, 1, NULL, '2025-07-27 10:44:50', '2025-07-27 10:44:50', NULL, NULL, 0, NULL);
INSERT INTO `sys_oss` VALUES (22, '4ef5fbbf47e242b28a23e1f9f662aa12.jpeg', 'ZFbhfpyN9Jn0c0ee4e14a897f47daef5918fef5032b0.jpeg', 'jpeg', 'https://chaoyou-image.oss-cn-beijing.aliyuncs.com/upload/2025/07/27/4ef5fbbf47e242b28a23e1f9f662aa12.jpeg', 6116, 'aliyun', 'upload/2025/07/27/4ef5fbbf47e242b28a23e1f9f662aa12.jpeg', 'image/jpeg', NULL, 1, NULL, '2025-07-27 10:47:57', '2025-07-27 10:47:57', 9, NULL, 0, NULL);
INSERT INTO `sys_oss` VALUES (23, 'fa3a52446fcd4066ac72d8faf5dc9854.jpeg', 'SBS1YmiTl0LN5e45eeb75f1e176a7755bcc6e20b2258.jpeg', 'jpeg', 'https://chaoyou-image.oss-cn-beijing.aliyuncs.com/upload/2025/07/27/fa3a52446fcd4066ac72d8faf5dc9854.jpeg', 6116, 'aliyun', 'upload/2025/07/27/fa3a52446fcd4066ac72d8faf5dc9854.jpeg', 'image/jpeg', NULL, 1, NULL, '2025-07-27 11:13:18', '2025-07-27 11:13:18', NULL, NULL, 0, NULL);

-- ----------------------------
-- Table structure for sys_oss_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_oss_config`;
CREATE TABLE `sys_oss_config`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '配置ID',
  `config_key` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '配置key',
  `access_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'accessKey',
  `secret_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'secretKey',
  `bucket_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '桶名称',
  `prefix` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '前缀',
  `endpoint` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '访问站点',
  `domain` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '自定义域名',
  `is_https` tinyint(1) NULL DEFAULT 0 COMMENT '是否https：0-否，1-是',
  `region` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '区域',
  `access_policy` tinyint(1) NULL DEFAULT 1 COMMENT '桶权限类型：0-private，1-public，2-custom',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '状态：0-停用，1-启用',
  `ext1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '扩展字段1',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建人',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新人',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除：0-否，1-是',
  `delete_time` datetime NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_config_key`(`config_key` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_is_deleted`(`is_deleted` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'OSS配置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_oss_config
-- ----------------------------
INSERT INTO `sys_oss_config` VALUES (1, 'minio', 'admin', 'admin123mars', 'test', '', 'http://150.158.49.140:9000', 'http://150.158.49.140:9000', 0, 'us-east-1', 1, 0, NULL, 'MinIO本地存储配置', '2025-06-27 16:00:00', '2025-07-26 20:43:09', 1, NULL, 0, NULL);
INSERT INTO `sys_oss_config` VALUES (2, 'aliyun', 'LTAI5tEeaW8Hw5j43v9siDS3', 'aUZ22ePUjNUUulUhAqBrJNVEA6nrgQ', 'chaoyou-image', '', 'oss-cn-beijing.aliyuncs.com', 'https://chaoyou-image.oss-cn-beijing.aliyuncs.com', 1, 'oss-cn-beijing', 0, 1, NULL, '阿里云OSS配置', '2025-06-27 16:00:00', '2025-07-26 20:47:21', 1, NULL, 0, NULL);
INSERT INTO `sys_oss_config` VALUES (3, 'local', '', '', '', 'upload', '', '', 0, '', 1, 0, NULL, '本地存储配置', '2025-06-27 16:00:00', '2025-07-26 20:43:11', 1, NULL, 0, NULL);

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int NULL DEFAULT 0 COMMENT '显示顺序',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '状态：0-停用，1-正常',
  `is_system` tinyint(1) NULL DEFAULT 0 COMMENT '是否系统岗位：0-否，1-是(不可删除)',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建人',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新人',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除：0-否，1-是',
  `delete_time` datetime NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_post_code`(`post_code` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_post_sort`(`post_sort` ASC) USING BTREE,
  INDEX `idx_is_deleted`(`is_deleted` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '系统岗位表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'CEO', '董事长', 1, 1, 1, NULL, '2025-06-25 16:34:16', '2025-06-25 16:34:16', 1, NULL, 0, NULL);
INSERT INTO `sys_post` VALUES (2, 'CTO', '技术总监', 2, 1, 1, NULL, '2025-06-25 16:34:16', '2025-06-25 16:34:16', 1, NULL, 0, NULL);
INSERT INTO `sys_post` VALUES (3, 'DEV', '开发工程师', 3, 1, 1, NULL, '2025-06-25 16:34:16', '2025-06-25 16:34:16', 1, NULL, 0, NULL);
INSERT INTO `sys_post` VALUES (4, 'TEST', '测试工程师', 4, 1, 1, NULL, '2025-06-25 16:34:16', '2025-06-25 16:34:16', 1, NULL, 0, NULL);
INSERT INTO `sys_post` VALUES (5, 'test111', 'test', 0, 1, 0, '', '2025-07-09 16:10:42', '2025-07-09 16:31:42', 1, NULL, 1, '2025-07-09 16:31:42');
INSERT INTO `sys_post` VALUES (6, '2323', 'test1213', 0, 1, 0, '', '2025-07-09 16:30:04', '2025-07-09 16:31:40', 1, 1, 1, '2025-07-09 16:31:40');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色名称',
  `role_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色编码',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NULL DEFAULT 0 COMMENT '显示顺序',
  `data_scope` tinyint(1) NULL DEFAULT 1 COMMENT '数据范围：1-全部，2-自定义，3-本部门，4-本部门及以下，5-仅本人',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '状态：0-禁用，1-启用',
  `is_system` tinyint(1) NULL DEFAULT 0 COMMENT '是否系统角色：0-否，1-是(不可删除)',
  `description` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色描述',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建人',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新人',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除：0-否，1-是',
  `delete_time` datetime NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_role_code`(`role_code` ASC) USING BTREE,
  UNIQUE INDEX `uk_role_key`(`role_key` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_role_sort`(`role_sort` ASC) USING BTREE,
  INDEX `idx_is_deleted`(`is_deleted` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '系统角色表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'SUPER_ADMIN', 'admin', 1, 1, 1, 1, 1, 1, '超级管理员', '', '2025-06-25 16:34:16', '2025-07-08 11:33:30', 1, 1, 0, NULL);
INSERT INTO `sys_role` VALUES (2, '系统管理员', 'SYSTEM_ADMIN', 'system', 2, 2, 1, 1, 1, 1, '系统管理员', NULL, '2025-06-25 16:34:16', '2025-06-25 16:34:16', 1, NULL, 0, NULL);
INSERT INTO `sys_role` VALUES (3, '普通用户', 'COMMON_USER', 'common', 3, 5, 1, 1, 1, 0, '普通用户', NULL, '2025-06-25 16:34:16', '2025-06-25 16:34:16', 1, NULL, 0, NULL);

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE,
  INDEX `idx_role_id`(`role_id` ASC) USING BTREE,
  INDEX `idx_dept_id`(`dept_id` ASC) USING BTREE,
  CONSTRAINT `fk_sys_role_dept_dept` FOREIGN KEY (`dept_id`) REFERENCES `sys_dept` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `fk_sys_role_dept_role` FOREIGN KEY (`role_id`) REFERENCES `sys_role` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '角色和部门关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE,
  INDEX `idx_role_id`(`role_id` ASC) USING BTREE,
  INDEX `idx_menu_id`(`menu_id` ASC) USING BTREE,
  CONSTRAINT `fk_sys_role_menu_menu` FOREIGN KEY (`menu_id`) REFERENCES `sys_menu` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `fk_sys_role_menu_role` FOREIGN KEY (`role_id`) REFERENCES `sys_role` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '角色菜单关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (1, 1, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 2, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 100, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 101, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 102, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 103, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 104, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 105, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 106, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 107, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 108, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 109, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 301, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 302, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 303, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 1000, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 1001, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 1002, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 1003, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 1004, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 1005, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 1006, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 1007, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 1008, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 1009, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 1010, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 1011, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 1012, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 1013, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 1014, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 1015, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 1016, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 1017, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 1018, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 1070, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 1071, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 1072, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 1080, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 1081, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 1082, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 1083, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 1084, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 2100, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 2101, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 2102, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 2103, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 2104, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 2105, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 2106, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 2107, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 2108, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 2109, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 2110, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 2111, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 2112, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 2113, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 30201, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 30202, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 30203, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 30204, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 30301, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 30302, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 30303, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 30304, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 30305, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 30306, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 30308, '2025-07-08 11:33:28', 1);
INSERT INTO `sys_role_menu` VALUES (1, 30309, '2025-07-08 11:57:25', NULL);
INSERT INTO `sys_role_menu` VALUES (1, 30310, '2025-07-08 15:02:41', NULL);
INSERT INTO `sys_role_menu` VALUES (1, 30311, '2025-07-08 15:02:49', NULL);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码(MD5加密)',
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '昵称',
  `real_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '真实姓名',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '手机号',
  `open_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '微信OpenId，用于小程序登录',
  `avatar` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '头像URL',
  `gender` tinyint(1) NULL DEFAULT 0 COMMENT '性别：0-未知，1-男，2-女',
  `birthday` date NULL DEFAULT NULL COMMENT '生日',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '状态：0-禁用，1-启用',
  `user_type` tinyint(1) NULL DEFAULT 1 COMMENT '用户类型：1-系统用户，2-普通用户',
  `login_count` int NULL DEFAULT 0 COMMENT '登录次数',
  `last_login_time` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `last_login_ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '最后登录IP',
  `password_update_time` datetime NULL DEFAULT NULL COMMENT '密码修改时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建人',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新人',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除：0-否，1-是',
  `delete_time` datetime NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_username`(`username` ASC) USING BTREE,
  UNIQUE INDEX `uk_email`(`email` ASC) USING BTREE,
  UNIQUE INDEX `uk_phone`(`phone` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_user_type`(`user_type` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE,
  INDEX `idx_is_deleted`(`is_deleted` ASC) USING BTREE,
  INDEX `idx_open_id`(`open_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '系统用户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'admin', 'e10adc3949ba59abbe56e057f20f883e', '超级管理员', '系统管理员', 'admin@mars.com', '184****8369', NULL, 'http://150.158.49.140:9000/test/upload/2025/07/08/6a6007c5eea44aca847344b0ea689c36.jpg', 0, '2025-07-03', 1, 1, 127, '2025-07-27 21:20:45', '0:0:0:0:0:0:0:1', '2025-07-04 11:19:05', '系统默认超级管理员', '2025-06-25 16:34:16', '2025-07-27 21:20:45', 1, 1, 0, NULL);
INSERT INTO `sys_user` VALUES (2, 'lisi', 'e10adc3949ba59abbe56e057f20f883e', '用户', '用户', 'admin1@mars.com', '184****8363', NULL, 'http://150.158.49.140:9000/test/upload/2025/07/08/6a6007c5eea44aca847344b0ea689c36.jpg', 0, '2025-07-03', 1, 1, 127, '2025-07-27 21:19:37', '0:0:0:0:0:0:0:1', '2025-07-04 11:19:05', '系统默认超级管理员', '2025-06-25 16:34:16', '2025-07-27 21:19:36', 1, 2, 0, NULL);

-- ----------------------------
-- Table structure for sys_user_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_dept`;
CREATE TABLE `sys_user_dept`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  `is_main` tinyint(1) NULL DEFAULT 0 COMMENT '是否主部门：0-否，1-是',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`user_id`, `dept_id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_dept_id`(`dept_id` ASC) USING BTREE,
  INDEX `idx_is_main`(`is_main` ASC) USING BTREE,
  CONSTRAINT `fk_sys_user_dept_dept` FOREIGN KEY (`dept_id`) REFERENCES `sys_dept` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `fk_sys_user_dept_user` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户部门关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_dept
-- ----------------------------
INSERT INTO `sys_user_dept` VALUES (1, 100, 1, '2025-06-25 16:34:16', 1);

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_post_id`(`post_id` ASC) USING BTREE,
  CONSTRAINT `fk_sys_user_post_post` FOREIGN KEY (`post_id`) REFERENCES `sys_post` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `fk_sys_user_post_user` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户岗位关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1, '2025-06-25 16:34:16', 1);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_role_id`(`role_id` ASC) USING BTREE,
  CONSTRAINT `fk_sys_user_role_role` FOREIGN KEY (`role_id`) REFERENCES `sys_role` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `fk_sys_user_role_user` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户角色关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1, '2025-06-25 16:34:16', 1);

-- ----------------------------
-- Table structure for tb_activity
-- ----------------------------
DROP TABLE IF EXISTS `tb_activity`;
CREATE TABLE `tb_activity`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '活动ID',
  `category_id` bigint NOT NULL COMMENT '分类ID',
  `user_id` bigint NOT NULL COMMENT '发布者用户ID',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '活动标题',
  `subtitle` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '活动副标题',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '活动描述',
  `cover_image` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '封面图片',
  `images` json NULL COMMENT '活动图片集合',
  `video_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '活动视频',
  `location` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '活动地点',
  `address` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '详细地址',
  `latitude` decimal(10, 7) NULL DEFAULT NULL COMMENT '纬度',
  `longitude` decimal(10, 7) NULL DEFAULT NULL COMMENT '经度',
  `region_id` bigint NULL DEFAULT NULL COMMENT '地区ID',
  `start_time` datetime NOT NULL COMMENT '开始时间',
  `end_time` datetime NOT NULL COMMENT '结束时间',
  `registration_start_time` datetime NULL DEFAULT NULL COMMENT '报名开始时间',
  `registration_end_time` datetime NULL DEFAULT NULL COMMENT '报名结束时间',
  `max_participants` int NULL DEFAULT 0 COMMENT '最大参与人数，0表示不限制',
  `min_participants` int NULL DEFAULT 1 COMMENT '最小参与人数',
  `current_participants` int NULL DEFAULT 0 COMMENT '当前参与人数',
  `price` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '活动价格',
  `original_price` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '原价',
  `is_free` tinyint NULL DEFAULT 1 COMMENT '是否免费：0-收费，1-免费',
  `need_approval` tinyint NULL DEFAULT 0 COMMENT '是否需要审核：0-不需要，1-需要',
  `activity_type` tinyint NULL DEFAULT 1 COMMENT '活动类型：1-线下活动，2-线上活动，3-混合活动',
  `difficulty_level` tinyint NULL DEFAULT 1 COMMENT '难度等级：1-简单，2-中等，3-困难，4-极限',
  `age_limit_min` int NULL DEFAULT 0 COMMENT '最小年龄限制',
  `age_limit_max` int NULL DEFAULT 100 COMMENT '最大年龄限制',
  `gender_limit` tinyint NULL DEFAULT 0 COMMENT '性别限制：0-不限，1-仅男性，2-仅女性',
  `contact_person` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '联系人',
  `contact_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '联系电话',
  `contact_wechat` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '微信号',
  `requirements` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '参与要求',
  `includes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '费用包含',
  `excludes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '费用不含',
  `notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '注意事项',
  `refund_policy` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '退款政策',
  `tags` json NULL COMMENT '活动标签',
  `view_count` int NULL DEFAULT 0 COMMENT '浏览次数',
  `like_count` int NULL DEFAULT 0 COMMENT '点赞数',
  `comment_count` int NULL DEFAULT 0 COMMENT '评论数',
  `share_count` int NULL DEFAULT 0 COMMENT '分享数',
  `collect_count` int NULL DEFAULT 0 COMMENT '收藏数',
  `is_top` tinyint NULL DEFAULT 0 COMMENT '是否置顶：0-否，1-是',
  `is_hot` tinyint NULL DEFAULT 0 COMMENT '是否热门：0-否，1-是',
  `is_recommend` tinyint NULL DEFAULT 0 COMMENT '是否推荐：0-否，1-是',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态：0-草稿，1-已发布，2-已取消，3-已结束，4-审核中，5-审核拒绝',
  `audit_status` tinyint NULL DEFAULT 0 COMMENT '审核状态：0-待审核，1-审核通过，2-审核拒绝',
  `audit_reason` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '审核原因',
  `audit_time` datetime NULL DEFAULT NULL COMMENT '审核时间',
  `audit_user_id` bigint NULL DEFAULT NULL COMMENT '审核人ID',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint NULL DEFAULT 0 COMMENT '是否删除：0-否，1-是',
  `delete_time` datetime NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_category_id`(`category_id` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_region_id`(`region_id` ASC) USING BTREE,
  INDEX `idx_start_time`(`start_time` ASC) USING BTREE,
  INDEX `idx_end_time`(`end_time` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_is_top`(`is_top` ASC) USING BTREE,
  INDEX `idx_is_hot`(`is_hot` ASC) USING BTREE,
  INDEX `idx_is_recommend`(`is_recommend` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE,
  INDEX `idx_is_deleted`(`is_deleted` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '活动表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_activity
-- ----------------------------
INSERT INTO `tb_activity` VALUES (1, 1, 1, '西湖环湖徒步活动', '感受杭州西湖的美丽风光', '一起徒步西湖，欣赏美景，结交朋友。活动包含专业领队、保险、纪念品等。适合所有年龄段参与。', 'https://example.com/activity1.jpg', NULL, NULL, '杭州西湖', '浙江省杭州市西湖区西湖风景名胜区', 30.2741000, 120.1551000, 4, '2025-01-15 09:00:00', '2025-01-15 17:00:00', NULL, '2025-01-14 18:00:00', 30, 1, 3, 0.00, 0.00, 1, 0, 1, 1, 0, 100, 0, '小王', '13800138001', NULL, NULL, NULL, NULL, NULL, NULL, '[\"徒步\", \"西湖\", \"摄影\"]', 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, NULL, NULL, NULL, '2025-07-26 17:01:56', '2025-07-26 17:03:42', 0, NULL);
INSERT INTO `tb_activity` VALUES (2, 2, 2, '古镇摄影创作之旅', '乌镇古镇摄影创作活动', '专业摄影师带队，深度游览乌镇，学习古镇摄影技巧，创作优秀摄影作品。', 'https://example.com/activity2.jpg', NULL, NULL, '乌镇古镇', '浙江省嘉兴市桐乡市乌镇', 30.7408000, 120.4912000, 4, '2025-01-20 08:00:00', '2025-01-21 18:00:00', NULL, '2025-01-18 20:00:00', 15, 1, 2, 299.00, 0.00, 0, 0, 1, 2, 0, 100, 0, '摄影师小李', '13800138002', NULL, NULL, NULL, NULL, NULL, NULL, '[\"摄影\", \"古镇\", \"创作\"]', 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, NULL, NULL, NULL, '2025-07-26 17:01:56', '2025-07-26 17:03:42', 0, NULL);
INSERT INTO `tb_activity` VALUES (3, 3, 3, '成都美食探索团', '品味正宗川菜文化', '深度探索成都美食文化，品尝地道川菜，了解川菜历史，学习简单川菜制作。', 'https://example.com/activity3.jpg', NULL, NULL, '成都市区', '四川省成都市锦江区春熙路', 30.6598000, 104.0633000, 6, '2025-01-25 10:00:00', '2025-01-27 20:00:00', NULL, '2025-01-23 12:00:00', 20, 1, 2, 599.00, 0.00, 0, 0, 1, 1, 0, 100, 0, '美食达人', '13800138003', NULL, NULL, NULL, NULL, NULL, NULL, '[\"美食\", \"川菜\", \"文化\"]', 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, NULL, NULL, NULL, '2025-07-26 17:01:56', '2025-07-26 17:03:42', 0, NULL);
INSERT INTO `tb_activity` VALUES (4, 1, 4, '泰山日出登山活动', '登泰山观日出，感受五岳之首的壮美', '凌晨登山，山顶观日出，体验泰山文化，挑战自我极限。包含登山装备、早餐。', 'https://example.com/activity4.jpg', NULL, NULL, '泰山', '山东省泰安市泰山区', 36.2542000, 117.1013000, 5, '2025-02-01 02:00:00', '2025-02-01 12:00:00', NULL, '2025-01-30 18:00:00', 25, 1, 3, 199.00, 0.00, 0, 0, 1, 3, 0, 100, 0, '户外领队', '13800138004', NULL, NULL, NULL, NULL, NULL, NULL, '[\"登山\", \"日出\", \"挑战\"]', 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, NULL, NULL, NULL, '2025-07-26 17:01:56', '2025-07-26 17:03:42', 0, NULL);
INSERT INTO `tb_activity` VALUES (5, 4, 5, '樱花季摄影工作坊', '春季樱花摄影技巧学习', '专业摄影师指导樱花摄影技巧，实地拍摄练习，后期处理教学。', 'https://example.com/activity5.jpg', NULL, NULL, '玉渊潭公园', '北京市海淀区玉渊潭公园', 39.9197000, 116.3230000, 1, '2025-03-15 09:00:00', '2025-03-15 16:00:00', NULL, '2025-03-13 20:00:00', 12, 1, 0, 399.00, 0.00, 0, 0, 1, 1, 0, 100, 0, '摄影导师', '13800138005', NULL, NULL, NULL, NULL, NULL, NULL, '[\"摄影\", \"樱花\", \"春季\"]', 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, NULL, NULL, NULL, '2025-07-26 17:01:56', '2025-07-26 17:01:56', 0, NULL);

-- ----------------------------
-- Table structure for tb_activity_category
-- ----------------------------
DROP TABLE IF EXISTS `tb_activity_category`;
CREATE TABLE `tb_activity_category`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父分类ID，0为根分类',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '分类名称',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '分类图标',
  `cover_image` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '分类封面图',
  `description` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '分类描述',
  `sort_order` int NULL DEFAULT 0 COMMENT '排序',
  `is_hot` tinyint NULL DEFAULT 0 COMMENT '是否热门：0-否，1-是',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态：0-禁用，1-启用',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_parent_id`(`parent_id` ASC) USING BTREE,
  INDEX `idx_is_hot`(`is_hot` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_sort_order`(`sort_order` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '活动分类表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_activity_category
-- ----------------------------
INSERT INTO `tb_activity_category` VALUES (1, 0, '户外运动', 'icon-outdoor', NULL, '户外运动类活动', 1, 1, 1, '2025-07-26 17:01:19', '2025-07-26 17:01:19');
INSERT INTO `tb_activity_category` VALUES (2, 0, '文化体验', 'icon-culture', NULL, '文化体验类活动', 2, 1, 1, '2025-07-26 17:01:19', '2025-07-26 17:01:19');
INSERT INTO `tb_activity_category` VALUES (3, 0, '美食探索', 'icon-food', NULL, '美食探索类活动', 3, 1, 1, '2025-07-26 17:01:19', '2025-07-26 17:01:19');
INSERT INTO `tb_activity_category` VALUES (4, 0, '摄影采风', 'icon-camera', NULL, '摄影采风类活动', 4, 1, 1, '2025-07-26 17:01:19', '2025-07-26 17:01:19');
INSERT INTO `tb_activity_category` VALUES (5, 0, '亲子活动', 'icon-family', NULL, '亲子活动类', 5, 1, 1, '2025-07-26 17:01:19', '2025-07-26 17:01:19');
INSERT INTO `tb_activity_category` VALUES (6, 0, '商务活动', 'icon-business', NULL, '商务活动类', 6, 0, 1, '2025-07-26 17:01:19', '2025-07-26 17:01:19');
INSERT INTO `tb_activity_category` VALUES (7, 0, '学习培训', 'icon-study', NULL, '学习培训类活动', 7, 0, 1, '2025-07-26 17:01:19', '2025-07-26 17:01:19');
INSERT INTO `tb_activity_category` VALUES (8, 0, '公益活动', 'icon-volunteer', NULL, '公益志愿类活动', 8, 0, 1, '2025-07-26 17:01:19', '2025-07-26 17:01:19');
INSERT INTO `tb_activity_category` VALUES (9, 1, '徒步登山', 'icon-hiking', NULL, '徒步登山活动', 1, 1, 1, '2025-07-26 17:01:19', '2025-07-26 17:01:19');
INSERT INTO `tb_activity_category` VALUES (10, 1, '骑行', 'icon-cycling', NULL, '骑行活动', 2, 1, 1, '2025-07-26 17:01:19', '2025-07-26 17:01:19');
INSERT INTO `tb_activity_category` VALUES (11, 1, '露营', 'icon-camping', NULL, '露营活动', 3, 1, 1, '2025-07-26 17:01:19', '2025-07-26 17:01:19');
INSERT INTO `tb_activity_category` VALUES (12, 1, '水上运动', 'icon-water', NULL, '水上运动活动', 4, 0, 1, '2025-07-26 17:01:19', '2025-07-26 17:01:19');
INSERT INTO `tb_activity_category` VALUES (13, 1, '滑雪', 'icon-skiing', NULL, '滑雪活动', 5, 0, 1, '2025-07-26 17:01:19', '2025-07-26 17:01:19');
INSERT INTO `tb_activity_category` VALUES (14, 2, '古镇游览', 'icon-town', NULL, '古镇游览活动', 1, 1, 1, '2025-07-26 17:01:19', '2025-07-26 17:01:19');
INSERT INTO `tb_activity_category` VALUES (15, 2, '博物馆', 'icon-museum', NULL, '博物馆参观', 2, 0, 1, '2025-07-26 17:01:19', '2025-07-26 17:01:19');
INSERT INTO `tb_activity_category` VALUES (16, 2, '传统手工', 'icon-craft', NULL, '传统手工体验', 3, 0, 1, '2025-07-26 17:01:19', '2025-07-26 17:01:19');
INSERT INTO `tb_activity_category` VALUES (17, 2, '民俗体验', 'icon-folk', NULL, '民俗文化体验', 4, 0, 1, '2025-07-26 17:01:19', '2025-07-26 17:01:19');

-- ----------------------------
-- Table structure for tb_activity_collect
-- ----------------------------
DROP TABLE IF EXISTS `tb_activity_collect`;
CREATE TABLE `tb_activity_collect`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '收藏ID',
  `activity_id` bigint NOT NULL COMMENT '活动ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '收藏时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_activity_user`(`activity_id` ASC, `user_id` ASC) USING BTREE,
  INDEX `idx_activity_id`(`activity_id` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '活动收藏表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_activity_collect
-- ----------------------------

-- ----------------------------
-- Table structure for tb_activity_comment
-- ----------------------------
DROP TABLE IF EXISTS `tb_activity_comment`;
CREATE TABLE `tb_activity_comment`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '评论ID',
  `activity_id` bigint NOT NULL COMMENT '活动ID',
  `user_id` bigint NOT NULL COMMENT '评论用户ID',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父评论ID，0为根评论',
  `reply_user_id` bigint NULL DEFAULT NULL COMMENT '回复的用户ID',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '评论内容',
  `images` json NULL COMMENT '评论图片',
  `like_count` int NULL DEFAULT 0 COMMENT '点赞数',
  `reply_count` int NULL DEFAULT 0 COMMENT '回复数',
  `is_top` tinyint NULL DEFAULT 0 COMMENT '是否置顶：0-否，1-是',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态：0-删除，1-正常，2-审核中',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '评论时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint NULL DEFAULT 0 COMMENT '是否删除：0-否，1-是',
  `delete_time` datetime NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_activity_id`(`activity_id` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_parent_id`(`parent_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE,
  INDEX `idx_is_deleted`(`is_deleted` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '活动评论表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_activity_comment
-- ----------------------------

-- ----------------------------
-- Table structure for tb_activity_comment_like
-- ----------------------------
DROP TABLE IF EXISTS `tb_activity_comment_like`;
CREATE TABLE `tb_activity_comment_like`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '点赞ID',
  `comment_id` bigint NOT NULL COMMENT '评论ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '点赞时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_comment_user`(`comment_id` ASC, `user_id` ASC) USING BTREE,
  INDEX `idx_comment_id`(`comment_id` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '活动评论点赞表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_activity_comment_like
-- ----------------------------

-- ----------------------------
-- Table structure for tb_activity_like
-- ----------------------------
DROP TABLE IF EXISTS `tb_activity_like`;
CREATE TABLE `tb_activity_like`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '点赞ID',
  `activity_id` bigint NOT NULL COMMENT '活动ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '点赞时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_activity_user`(`activity_id` ASC, `user_id` ASC) USING BTREE,
  INDEX `idx_activity_id`(`activity_id` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '活动点赞表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_activity_like
-- ----------------------------

-- ----------------------------
-- Table structure for tb_activity_registration
-- ----------------------------
DROP TABLE IF EXISTS `tb_activity_registration`;
CREATE TABLE `tb_activity_registration`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '报名ID',
  `activity_id` bigint NOT NULL COMMENT '活动ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `real_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '真实姓名',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '联系电话',
  `id_card` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '身份证号',
  `emergency_contact` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '紧急联系人',
  `emergency_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '紧急联系电话',
  `participants_count` int NULL DEFAULT 1 COMMENT '参与人数',
  `participants_info` json NULL COMMENT '参与者信息',
  `special_requirements` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '特殊要求',
  `payment_amount` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '支付金额',
  `payment_status` tinyint NULL DEFAULT 0 COMMENT '支付状态：0-未支付，1-已支付，2-已退款',
  `payment_time` datetime NULL DEFAULT NULL COMMENT '支付时间',
  `payment_method` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '支付方式',
  `order_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '订单号',
  `status` tinyint NULL DEFAULT 0 COMMENT '报名状态：0-待审核，1-已通过，2-已拒绝，3-已取消',
  `audit_reason` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '审核原因',
  `audit_time` datetime NULL DEFAULT NULL COMMENT '审核时间',
  `check_in_status` tinyint NULL DEFAULT 0 COMMENT '签到状态：0-未签到，1-已签到',
  `check_in_time` datetime NULL DEFAULT NULL COMMENT '签到时间',
  `rating` tinyint NULL DEFAULT 0 COMMENT '评分：1-5分',
  `review` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '评价内容',
  `review_time` datetime NULL DEFAULT NULL COMMENT '评价时间',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '报名时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_activity_user`(`activity_id` ASC, `user_id` ASC) USING BTREE,
  INDEX `idx_activity_id`(`activity_id` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_payment_status`(`payment_status` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '活动报名表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_activity_registration
-- ----------------------------
INSERT INTO `tb_activity_registration` VALUES (1, 1, 2, '李摄影', '13800138002', NULL, NULL, NULL, 1, NULL, NULL, 0.00, 1, NULL, NULL, NULL, 1, NULL, NULL, 0, NULL, 0, NULL, NULL, '2025-07-26 17:01:56', '2025-07-26 17:01:56');
INSERT INTO `tb_activity_registration` VALUES (2, 1, 3, '张美食', '13800138003', NULL, NULL, NULL, 1, NULL, NULL, 0.00, 1, NULL, NULL, NULL, 1, NULL, NULL, 0, NULL, 0, NULL, NULL, '2025-07-26 17:01:56', '2025-07-26 17:01:56');
INSERT INTO `tb_activity_registration` VALUES (3, 1, 4, '王户外', '13800138004', NULL, NULL, NULL, 1, NULL, NULL, 0.00, 1, NULL, NULL, NULL, 1, NULL, NULL, 0, NULL, 0, NULL, NULL, '2025-07-26 17:01:56', '2025-07-26 17:01:56');
INSERT INTO `tb_activity_registration` VALUES (4, 2, 1, '小王', '13800138001', NULL, NULL, NULL, 1, NULL, NULL, 299.00, 1, NULL, NULL, NULL, 1, NULL, NULL, 0, NULL, 0, NULL, NULL, '2025-07-26 17:01:56', '2025-07-26 17:01:56');
INSERT INTO `tb_activity_registration` VALUES (5, 2, 4, '王户外', '13800138004', NULL, NULL, NULL, 1, NULL, NULL, 299.00, 1, NULL, NULL, NULL, 1, NULL, NULL, 0, NULL, 0, NULL, NULL, '2025-07-26 17:01:56', '2025-07-26 17:01:56');
INSERT INTO `tb_activity_registration` VALUES (6, 3, 1, '小王', '13800138001', NULL, NULL, NULL, 1, NULL, NULL, 599.00, 1, NULL, NULL, NULL, 1, NULL, NULL, 0, NULL, 0, NULL, NULL, '2025-07-26 17:01:56', '2025-07-26 17:01:56');
INSERT INTO `tb_activity_registration` VALUES (7, 3, 2, '李摄影', '13800138002', NULL, NULL, NULL, 1, NULL, NULL, 599.00, 1, NULL, NULL, NULL, 1, NULL, NULL, 0, NULL, 0, NULL, NULL, '2025-07-26 17:01:56', '2025-07-26 17:01:56');
INSERT INTO `tb_activity_registration` VALUES (8, 4, 2, '李摄影', '13800138002', NULL, NULL, NULL, 1, NULL, NULL, 199.00, 1, NULL, NULL, NULL, 1, NULL, NULL, 0, NULL, 0, NULL, NULL, '2025-07-26 17:01:56', '2025-07-26 17:01:56');
INSERT INTO `tb_activity_registration` VALUES (9, 4, 3, '张美食', '13800138003', NULL, NULL, NULL, 1, NULL, NULL, 199.00, 1, NULL, NULL, NULL, 1, NULL, NULL, 0, NULL, 0, NULL, NULL, '2025-07-26 17:01:56', '2025-07-26 17:01:56');
INSERT INTO `tb_activity_registration` VALUES (10, 4, 5, '小张', '13800138005', NULL, NULL, NULL, 1, NULL, NULL, 199.00, 1, NULL, NULL, NULL, 1, NULL, NULL, 0, NULL, 0, NULL, NULL, '2025-07-26 17:01:56', '2025-07-26 17:01:56');

-- ----------------------------
-- Table structure for tb_activity_share
-- ----------------------------
DROP TABLE IF EXISTS `tb_activity_share`;
CREATE TABLE `tb_activity_share`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '分享记录ID',
  `activity_id` bigint NOT NULL COMMENT '活动ID',
  `user_id` bigint NOT NULL COMMENT '分享用户ID',
  `share_platform` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '分享平台：wechat,weibo,qq,link',
  `share_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '分享时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_activity_id`(`activity_id` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_share_platform`(`share_platform` ASC) USING BTREE,
  INDEX `idx_share_time`(`share_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '活动分享记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_activity_share
-- ----------------------------

-- ----------------------------
-- Table structure for tb_activity_view
-- ----------------------------
DROP TABLE IF EXISTS `tb_activity_view`;
CREATE TABLE `tb_activity_view`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '浏览记录ID',
  `activity_id` bigint NOT NULL COMMENT '活动ID',
  `user_id` bigint NULL DEFAULT NULL COMMENT '用户ID，未登录用户为NULL',
  `ip_address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'IP地址',
  `user_agent` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户代理',
  `view_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '浏览时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_activity_id`(`activity_id` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_view_time`(`view_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '活动浏览记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_activity_view
-- ----------------------------

-- ----------------------------
-- Table structure for tb_chat_message
-- ----------------------------
DROP TABLE IF EXISTS `tb_chat_message`;
CREATE TABLE `tb_chat_message`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '消息ID',
  `session_id` bigint NOT NULL COMMENT '会话ID',
  `sender_id` bigint NOT NULL COMMENT '发送者ID',
  `receiver_id` bigint NOT NULL COMMENT '接收者ID',
  `message_type` tinyint NOT NULL DEFAULT 1 COMMENT '消息类型：1-文本，2-图片，3-语音，4-视频，5-文件',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '消息内容',
  `media_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '媒体文件URL（图片、语音、视频、文件）',
  `status` tinyint(1) NULL DEFAULT 0 COMMENT '消息状态：0-未读，1-已读',
  `send_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发送时间',
  `read_time` datetime NULL DEFAULT NULL COMMENT '阅读时间',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建人',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新人',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除：0-否，1-是',
  `delete_time` datetime NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_session_id`(`session_id` ASC) USING BTREE,
  INDEX `idx_sender_id`(`sender_id` ASC) USING BTREE,
  INDEX `idx_receiver_id`(`receiver_id` ASC) USING BTREE,
  INDEX `idx_send_time`(`send_time` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_message_type`(`message_type` ASC) USING BTREE,
  INDEX `idx_is_deleted`(`is_deleted` ASC) USING BTREE,
  CONSTRAINT `fk_chat_message_session` FOREIGN KEY (`session_id`) REFERENCES `tb_chat_session` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 466 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '聊天消息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_chat_message
-- ----------------------------
INSERT INTO `tb_chat_message` VALUES (6, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:18:52', '2025-07-27 17:40:34', '2025-07-27 17:18:51', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (7, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:19:03', '2025-07-27 17:40:34', '2025-07-27 17:19:02', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (8, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:19:05', '2025-07-27 17:40:34', '2025-07-27 17:19:05', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (9, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:19:06', '2025-07-27 17:40:34', '2025-07-27 17:19:06', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (10, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:19:07', '2025-07-27 17:40:34', '2025-07-27 17:19:07', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (11, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:19:12', '2025-07-27 17:40:34', '2025-07-27 17:19:11', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (12, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:19:12', '2025-07-27 17:40:34', '2025-07-27 17:19:12', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (13, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:19:12', '2025-07-27 17:40:34', '2025-07-27 17:19:12', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (14, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:19:13', '2025-07-27 17:40:34', '2025-07-27 17:19:12', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (15, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:19:13', '2025-07-27 17:40:34', '2025-07-27 17:19:12', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (16, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:19:13', '2025-07-27 17:40:34', '2025-07-27 17:19:13', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (17, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:19:13', '2025-07-27 17:40:34', '2025-07-27 17:19:13', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (18, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:19:17', '2025-07-27 17:40:34', '2025-07-27 17:19:17', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (19, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:19:18', '2025-07-27 17:40:34', '2025-07-27 17:19:17', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (20, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:19:18', '2025-07-27 17:40:34', '2025-07-27 17:19:18', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (21, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:19:19', '2025-07-27 17:40:34', '2025-07-27 17:19:18', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (22, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:19:19', '2025-07-27 17:40:34', '2025-07-27 17:19:18', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (23, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:19:19', '2025-07-27 17:40:34', '2025-07-27 17:19:19', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (24, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:19:19', '2025-07-27 17:40:34', '2025-07-27 17:19:19', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (25, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:19:19', '2025-07-27 17:40:34', '2025-07-27 17:19:19', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (26, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:19:23', '2025-07-27 17:40:34', '2025-07-27 17:19:22', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (27, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:19:55', '2025-07-27 17:40:34', '2025-07-27 17:19:55', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (28, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:20:11', '2025-07-27 17:40:34', '2025-07-27 17:20:10', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (29, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:20:11', '2025-07-27 17:40:34', '2025-07-27 17:20:11', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (30, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:20:11', '2025-07-27 17:40:34', '2025-07-27 17:20:11', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (31, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:20:12', '2025-07-27 17:40:34', '2025-07-27 17:20:11', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (32, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:20:12', '2025-07-27 17:40:34', '2025-07-27 17:20:11', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (33, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:20:12', '2025-07-27 17:40:34', '2025-07-27 17:20:11', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (34, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:20:12', '2025-07-27 17:40:34', '2025-07-27 17:20:12', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (35, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:20:12', '2025-07-27 17:40:34', '2025-07-27 17:20:12', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (36, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:20:12', '2025-07-27 17:40:34', '2025-07-27 17:20:12', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (37, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:20:13', '2025-07-27 17:40:34', '2025-07-27 17:20:12', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (38, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:20:13', '2025-07-27 17:40:34', '2025-07-27 17:20:12', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (39, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:20:13', '2025-07-27 17:40:34', '2025-07-27 17:20:12', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (40, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:20:13', '2025-07-27 17:40:34', '2025-07-27 17:20:13', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (41, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:20:13', '2025-07-27 17:40:34', '2025-07-27 17:20:13', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (42, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:20:13', '2025-07-27 17:40:34', '2025-07-27 17:20:13', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (43, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:20:14', '2025-07-27 17:40:34', '2025-07-27 17:20:13', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (44, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:20:14', '2025-07-27 17:40:34', '2025-07-27 17:20:13', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (45, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:20:14', '2025-07-27 17:40:34', '2025-07-27 17:20:13', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (46, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:20:14', '2025-07-27 17:40:34', '2025-07-27 17:20:14', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (47, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:20:14', '2025-07-27 17:40:34', '2025-07-27 17:20:14', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (48, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:20:14', '2025-07-27 17:40:34', '2025-07-27 17:20:14', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (49, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:20:15', '2025-07-27 17:40:34', '2025-07-27 17:20:14', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (50, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:20:15', '2025-07-27 17:40:34', '2025-07-27 17:20:14', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (51, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:20:15', '2025-07-27 17:40:34', '2025-07-27 17:20:14', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (52, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:20:15', '2025-07-27 17:40:34', '2025-07-27 17:20:15', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (53, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:20:15', '2025-07-27 17:40:34', '2025-07-27 17:20:15', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (54, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:20:15', '2025-07-27 17:40:34', '2025-07-27 17:20:15', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (55, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:20:16', '2025-07-27 17:40:34', '2025-07-27 17:20:15', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (56, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:20:16', '2025-07-27 17:40:34', '2025-07-27 17:20:15', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (57, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:20:21', '2025-07-27 17:40:34', '2025-07-27 17:20:20', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (58, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:20:21', '2025-07-27 17:40:34', '2025-07-27 17:20:20', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (59, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:20:21', '2025-07-27 17:40:34', '2025-07-27 17:20:20', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (60, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:20:21', '2025-07-27 17:40:34', '2025-07-27 17:20:21', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (61, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:20:21', '2025-07-27 17:40:34', '2025-07-27 17:20:21', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (62, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:20:21', '2025-07-27 17:40:34', '2025-07-27 17:20:21', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (63, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:20:22', '2025-07-27 17:40:34', '2025-07-27 17:20:21', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (64, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:20:22', '2025-07-27 17:40:34', '2025-07-27 17:20:21', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (65, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:39:46', '2025-07-27 17:40:34', '2025-07-27 17:39:46', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (66, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:40:00', '2025-07-27 17:40:34', '2025-07-27 17:39:59', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (67, 3, 1, 10, 1, '你好，这是消息内容', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:40:07', '2025-07-27 17:40:34', '2025-07-27 17:40:07', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (68, 3, 1, 10, 1, 'mars666', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:40:19', '2025-07-27 17:40:34', '2025-07-27 17:40:19', '2025-07-27 17:40:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (69, 3, 10, 1, 1, '1', NULL, 0, '2025-07-27 17:40:45', NULL, '2025-07-27 17:40:44', '2025-07-27 17:40:44', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (70, 3, 10, 1, 1, '你好', NULL, 0, '2025-07-27 17:41:01', NULL, '2025-07-27 17:41:00', '2025-07-27 17:41:00', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (71, 3, 1, 10, 1, 'mars666', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:41:06', '2025-07-27 17:45:27', '2025-07-27 17:41:05', '2025-07-27 17:45:27', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (72, 3, 1, 10, 1, '1111', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:41:13', '2025-07-27 17:45:27', '2025-07-27 17:41:12', '2025-07-27 17:45:27', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (73, 3, 10, 1, 1, '111', NULL, 0, '2025-07-27 17:41:32', NULL, '2025-07-27 17:41:31', '2025-07-27 17:41:31', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (74, 3, 1, 10, 1, '2222', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:41:38', '2025-07-27 17:45:27', '2025-07-27 17:41:38', '2025-07-27 17:45:27', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (75, 3, 1, 10, 1, '331212', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:41:51', '2025-07-27 17:45:27', '2025-07-27 17:41:51', '2025-07-27 17:45:27', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (76, 3, 1, 10, 1, '331212', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:50:58', '2025-07-27 17:51:47', '2025-07-27 17:50:58', '2025-07-27 17:51:47', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (77, 3, 1, 10, 1, '331212', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:51:00', '2025-07-27 17:51:47', '2025-07-27 17:51:00', '2025-07-27 17:51:47', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (78, 3, 1, 10, 1, '331212', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:51:02', '2025-07-27 17:51:47', '2025-07-27 17:51:02', '2025-07-27 17:51:47', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (79, 3, 1, 10, 1, '331212', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:51:03', '2025-07-27 17:51:47', '2025-07-27 17:51:03', '2025-07-27 17:51:47', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (80, 3, 1, 10, 1, '331212', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:51:35', '2025-07-27 17:51:47', '2025-07-27 17:51:35', '2025-07-27 17:51:47', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (81, 3, 1, 10, 1, '331212', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:51:40', '2025-07-27 17:51:47', '2025-07-27 17:51:39', '2025-07-27 17:51:47', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (82, 3, 1, 10, 1, '331212', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:51:41', '2025-07-27 17:51:47', '2025-07-27 17:51:40', '2025-07-27 17:51:47', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (83, 3, 1, 10, 1, '331212', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:51:42', '2025-07-27 17:51:47', '2025-07-27 17:51:41', '2025-07-27 17:51:47', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (84, 3, 1, 10, 1, '331212', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:51:42', '2025-07-27 17:51:47', '2025-07-27 17:51:42', '2025-07-27 17:51:47', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (85, 3, 1, 10, 1, '331212', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:51:43', '2025-07-27 17:51:47', '2025-07-27 17:51:42', '2025-07-27 17:51:47', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (86, 3, 10, 1, 1, '111', NULL, 0, '2025-07-27 17:51:53', NULL, '2025-07-27 17:51:53', '2025-07-27 17:51:53', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (87, 3, 1, 10, 1, '331212', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:52:03', '2025-07-27 17:58:25', '2025-07-27 17:52:03', '2025-07-27 17:58:25', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (88, 3, 1, 10, 1, '33121111112', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:52:10', '2025-07-27 17:58:25', '2025-07-27 17:52:10', '2025-07-27 17:58:25', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (89, 3, 1, 10, 1, '33121111112', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:56:55', '2025-07-27 17:58:25', '2025-07-27 17:56:54', '2025-07-27 17:58:25', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (90, 3, 1, 10, 1, '33121111112', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:56:59', '2025-07-27 17:58:25', '2025-07-27 17:56:58', '2025-07-27 17:58:25', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (91, 3, 1, 10, 1, '33121111112', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:58:12', '2025-07-27 17:58:25', '2025-07-27 17:58:11', '2025-07-27 17:58:25', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (92, 3, 1, 10, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:58:15', '2025-07-27 17:58:25', '2025-07-27 17:58:15', '2025-07-27 17:58:25', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (93, 3, 1, 10, 1, '222', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:58:19', '2025-07-27 17:58:25', '2025-07-27 17:58:19', '2025-07-27 17:58:25', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (94, 3, 10, 1, 1, '1111', NULL, 0, '2025-07-27 17:58:31', NULL, '2025-07-27 17:58:31', '2025-07-27 17:58:31', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (95, 3, 10, 1, 1, '112', NULL, 0, '2025-07-27 17:58:36', NULL, '2025-07-27 17:58:35', '2025-07-27 17:58:35', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (96, 3, 1, 10, 1, '222', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:58:38', '2025-07-27 18:00:40', '2025-07-27 17:58:37', '2025-07-27 18:00:40', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (97, 3, 1, 10, 1, '222', 'https://example.com/media/image.jpg', 1, '2025-07-27 17:58:42', '2025-07-27 18:00:40', '2025-07-27 17:58:42', '2025-07-27 18:00:40', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (98, 3, 1, 10, 1, '222', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:04:41', '2025-07-27 18:04:45', '2025-07-27 18:04:41', '2025-07-27 18:04:45', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (99, 3, 1, 10, 1, '222', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:04:43', '2025-07-27 18:04:45', '2025-07-27 18:04:43', '2025-07-27 18:04:45', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (100, 3, 10, 1, 1, '1212', NULL, 0, '2025-07-27 18:04:48', NULL, '2025-07-27 18:04:48', '2025-07-27 18:04:48', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (101, 3, 1, 10, 1, '222', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:04:51', '2025-07-27 18:04:51', '2025-07-27 18:04:50', '2025-07-27 18:04:51', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (102, 3, 1, 10, 1, '22212', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:04:55', '2025-07-27 18:04:55', '2025-07-27 18:04:55', '2025-07-27 18:04:55', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (103, 3, 1, 10, 1, '22212', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:05:04', '2025-07-27 18:05:04', '2025-07-27 18:05:03', '2025-07-27 18:05:04', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (104, 3, 1, 10, 1, '22212', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:05:05', '2025-07-27 18:05:05', '2025-07-27 18:05:04', '2025-07-27 18:05:05', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (105, 3, 1, 10, 1, '22212', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:05:05', '2025-07-27 18:05:06', '2025-07-27 18:05:05', '2025-07-27 18:05:06', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (106, 3, 1, 10, 1, '22212', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:05:06', '2025-07-27 18:05:06', '2025-07-27 18:05:06', '2025-07-27 18:05:06', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (107, 3, 1, 10, 1, '22212', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:05:08', '2025-07-27 18:05:08', '2025-07-27 18:05:07', '2025-07-27 18:05:08', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (108, 3, 1, 10, 1, '牛逼', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:05:15', '2025-07-27 18:05:15', '2025-07-27 18:05:15', '2025-07-27 18:05:15', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (109, 3, 1, 10, 1, '牛逼', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:05:17', '2025-07-27 18:05:17', '2025-07-27 18:05:17', '2025-07-27 18:05:17', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (110, 3, 1, 10, 1, '牛逼', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:05:18', '2025-07-27 18:05:17', '2025-07-27 18:05:17', '2025-07-27 18:05:17', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (111, 3, 1, 10, 1, '牛逼', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:05:19', '2025-07-27 18:05:19', '2025-07-27 18:05:18', '2025-07-27 18:05:19', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (112, 3, 1, 10, 1, '牛逼', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:05:20', '2025-07-27 18:05:20', '2025-07-27 18:05:19', '2025-07-27 18:05:20', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (113, 3, 1, 10, 1, '牛逼', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:05:20', '2025-07-27 18:05:20', '2025-07-27 18:05:20', '2025-07-27 18:05:20', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (114, 3, 1, 10, 1, '牛逼', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:05:21', '2025-07-27 18:05:21', '2025-07-27 18:05:20', '2025-07-27 18:05:21', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (115, 3, 1, 10, 1, '牛逼', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:05:21', '2025-07-27 18:05:21', '2025-07-27 18:05:21', '2025-07-27 18:05:21', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (116, 3, 1, 10, 1, '牛逼', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:05:22', '2025-07-27 18:05:21', '2025-07-27 18:05:21', '2025-07-27 18:05:21', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (117, 3, 1, 10, 1, '牛逼', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:05:22', '2025-07-27 18:05:22', '2025-07-27 18:05:22', '2025-07-27 18:05:22', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (118, 3, 1, 10, 1, '牛逼', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:05:22', '2025-07-27 18:05:22', '2025-07-27 18:05:22', '2025-07-27 18:05:22', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (119, 3, 1, 10, 1, '牛逼', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:05:23', '2025-07-27 18:05:22', '2025-07-27 18:05:22', '2025-07-27 18:05:22', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (120, 3, 1, 10, 1, '牛逼', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:05:23', '2025-07-27 18:05:23', '2025-07-27 18:05:23', '2025-07-27 18:05:23', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (121, 3, 1, 10, 1, '牛逼', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:05:23', '2025-07-27 18:05:23', '2025-07-27 18:05:23', '2025-07-27 18:05:23', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (122, 3, 1, 10, 1, '牛逼', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:05:24', '2025-07-27 18:05:23', '2025-07-27 18:05:23', '2025-07-27 18:05:23', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (123, 3, 1, 10, 1, '牛逼', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:05:24', '2025-07-27 18:05:24', '2025-07-27 18:05:23', '2025-07-27 18:05:24', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (124, 3, 1, 10, 1, '牛逼', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:05:24', '2025-07-27 18:05:25', '2025-07-27 18:05:24', '2025-07-27 18:05:25', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (125, 3, 1, 10, 1, '牛逼', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:05:25', '2025-07-27 18:05:25', '2025-07-27 18:05:24', '2025-07-27 18:05:25', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (126, 3, 1, 10, 1, '牛逼', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:05:25', '2025-07-27 18:05:25', '2025-07-27 18:05:24', '2025-07-27 18:05:25', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (127, 3, 1, 10, 1, '牛逼', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:05:25', '2025-07-27 18:05:25', '2025-07-27 18:05:24', '2025-07-27 18:05:25', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (128, 3, 1, 10, 1, '牛逼', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:05:25', '2025-07-27 18:05:25', '2025-07-27 18:05:25', '2025-07-27 18:05:25', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (129, 3, 1, 10, 1, '牛逼', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:05:25', '2025-07-27 18:05:25', '2025-07-27 18:05:25', '2025-07-27 18:05:25', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (130, 3, 1, 10, 1, '牛逼', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:05:26', '2025-07-27 18:05:25', '2025-07-27 18:05:25', '2025-07-27 18:05:25', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (131, 3, 1, 10, 1, '牛逼', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:05:26', '2025-07-27 18:05:26', '2025-07-27 18:05:26', '2025-07-27 18:05:26', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (132, 3, 1, 10, 1, '牛逼', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:05:26', '2025-07-27 18:05:26', '2025-07-27 18:05:26', '2025-07-27 18:05:26', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (133, 3, 1, 10, 1, '牛逼', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:05:27', '2025-07-27 18:05:26', '2025-07-27 18:05:26', '2025-07-27 18:05:26', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (134, 3, 1, 10, 1, '牛逼', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:05:27', '2025-07-27 18:05:26', '2025-07-27 18:05:26', '2025-07-27 18:05:26', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (135, 3, 1, 10, 1, '牛逼', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:05:27', '2025-07-27 18:05:27', '2025-07-27 18:05:26', '2025-07-27 18:05:27', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (136, 3, 1, 10, 1, '牛逼', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:05:27', '2025-07-27 18:05:27', '2025-07-27 18:05:27', '2025-07-27 18:05:27', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (137, 3, 1, 10, 1, '牛逼', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:05:27', '2025-07-27 18:05:28', '2025-07-27 18:05:27', '2025-07-27 18:05:28', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (138, 3, 1, 10, 1, '牛逼', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:05:27', '2025-07-27 18:05:28', '2025-07-27 18:05:27', '2025-07-27 18:05:28', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (139, 3, 10, 1, 1, '1112', NULL, 0, '2025-07-27 18:05:35', NULL, '2025-07-27 18:05:34', '2025-07-27 18:05:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (140, 3, 10, 1, 1, '12', NULL, 0, '2025-07-27 18:05:38', NULL, '2025-07-27 18:05:38', '2025-07-27 18:05:38', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (141, 3, 10, 1, 1, '111', NULL, 0, '2025-07-27 18:05:41', NULL, '2025-07-27 18:05:40', '2025-07-27 18:05:40', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (142, 3, 1, 10, 1, '1111', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:05:48', '2025-07-27 18:05:48', '2025-07-27 18:05:48', '2025-07-27 18:05:48', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (143, 3, 1, 10, 1, '1111', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:09:46', '2025-07-27 18:09:46', '2025-07-27 18:09:46', '2025-07-27 18:09:46', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (144, 3, 10, 1, 1, '11', NULL, 0, '2025-07-27 18:09:51', NULL, '2025-07-27 18:09:51', '2025-07-27 18:09:51', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (145, 3, 10, 1, 1, '12', NULL, 0, '2025-07-27 18:09:56', NULL, '2025-07-27 18:09:55', '2025-07-27 18:09:55', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (146, 3, 10, 1, 1, '1', NULL, 0, '2025-07-27 18:09:59', NULL, '2025-07-27 18:09:58', '2025-07-27 18:09:58', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (147, 3, 1, 10, 1, '1111', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:10:01', '2025-07-27 18:10:01', '2025-07-27 18:10:00', '2025-07-27 18:10:01', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (148, 3, 1, 10, 1, '12', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:10:04', '2025-07-27 18:10:04', '2025-07-27 18:10:04', '2025-07-27 18:10:04', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (149, 3, 1, 10, 1, '12', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:10:06', '2025-07-27 18:10:06', '2025-07-27 18:10:06', '2025-07-27 18:10:06', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (150, 3, 1, 10, 1, '12', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:10:07', '2025-07-27 18:10:06', '2025-07-27 18:10:06', '2025-07-27 18:10:06', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (151, 3, 1, 10, 1, '222', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:10:12', '2025-07-27 18:10:12', '2025-07-27 18:10:11', '2025-07-27 18:10:12', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (152, 3, 1, 10, 1, '2222', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:10:15', '2025-07-27 18:10:15', '2025-07-27 18:10:15', '2025-07-27 18:10:15', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (153, 3, 1, 10, 1, '2222', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:10:18', '2025-07-27 18:10:18', '2025-07-27 18:10:17', '2025-07-27 18:10:18', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (154, 3, 1, 10, 1, '2222', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:10:19', '2025-07-27 18:10:19', '2025-07-27 18:10:18', '2025-07-27 18:10:19', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (155, 3, 1, 10, 1, '2222', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:10:26', '2025-07-27 18:10:26', '2025-07-27 18:10:25', '2025-07-27 18:10:26', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (156, 3, 1, 10, 1, '2222', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:10:35', '2025-07-27 18:10:35', '2025-07-27 18:10:34', '2025-07-27 18:10:35', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (157, 3, 10, 1, 1, '111', NULL, 0, '2025-07-27 18:15:06', NULL, '2025-07-27 18:15:05', '2025-07-27 18:15:05', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (158, 3, 1, 10, 1, '2222', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:15:10', '2025-07-27 18:15:10', '2025-07-27 18:15:09', '2025-07-27 18:15:10', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (159, 3, 1, 10, 1, '2222', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:15:11', '2025-07-27 18:15:11', '2025-07-27 18:15:11', '2025-07-27 18:15:11', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (160, 3, 1, 10, 1, '2222', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:15:12', '2025-07-27 18:15:12', '2025-07-27 18:15:11', '2025-07-27 18:15:12', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (161, 3, 1, 10, 1, '1212', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:15:16', '2025-07-27 18:15:16', '2025-07-27 18:15:15', '2025-07-27 18:15:16', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (162, 3, 1, 10, 1, '131212', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:15:19', '2025-07-27 18:15:19', '2025-07-27 18:15:18', '2025-07-27 18:15:19', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (163, 3, 10, 1, 1, '111', NULL, 0, '2025-07-27 18:15:22', NULL, '2025-07-27 18:15:22', '2025-07-27 18:15:22', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (164, 3, 1, 10, 1, '1212', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:15:27', '2025-07-27 18:15:27', '2025-07-27 18:15:26', '2025-07-27 18:15:27', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (165, 3, 1, 10, 1, '1212', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:15:37', '2025-07-27 18:15:37', '2025-07-27 18:15:36', '2025-07-27 18:15:37', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (166, 3, 1, 10, 1, '1212', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:15:37', '2025-07-27 18:15:37', '2025-07-27 18:15:37', '2025-07-27 18:15:37', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (167, 3, 1, 10, 1, '1212', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:15:39', '2025-07-27 18:15:39', '2025-07-27 18:15:38', '2025-07-27 18:15:39', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (168, 3, 1, 10, 1, '1212', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:15:39', '2025-07-27 18:15:39', '2025-07-27 18:15:39', '2025-07-27 18:15:39', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (169, 3, 1, 10, 1, '1212', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:15:40', '2025-07-27 18:15:40', '2025-07-27 18:15:40', '2025-07-27 18:15:40', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (170, 3, 1, 10, 1, '1212', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:15:41', '2025-07-27 18:15:40', '2025-07-27 18:15:40', '2025-07-27 18:15:40', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (171, 3, 1, 10, 1, '1212', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:15:41', '2025-07-27 18:15:41', '2025-07-27 18:15:41', '2025-07-27 18:15:41', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (172, 3, 1, 10, 1, '1212', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:15:42', '2025-07-27 18:15:42', '2025-07-27 18:15:41', '2025-07-27 18:15:42', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (173, 3, 1, 10, 1, '1212', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:15:43', '2025-07-27 18:15:43', '2025-07-27 18:15:43', '2025-07-27 18:15:43', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (174, 3, 1, 10, 1, '1212', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:15:45', '2025-07-27 18:15:45', '2025-07-27 18:15:45', '2025-07-27 18:15:45', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (175, 3, 1, 10, 1, '1212', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:15:46', '2025-07-27 18:15:46', '2025-07-27 18:15:46', '2025-07-27 18:15:46', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (176, 3, 1, 10, 1, '1212', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:15:47', '2025-07-27 18:15:48', '2025-07-27 18:15:47', '2025-07-27 18:15:48', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (177, 3, 1, 10, 1, '1212', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:15:48', '2025-07-27 18:15:48', '2025-07-27 18:15:47', '2025-07-27 18:15:48', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (178, 3, 1, 10, 1, '1212', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:15:48', '2025-07-27 18:15:48', '2025-07-27 18:15:47', '2025-07-27 18:15:48', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (179, 3, 1, 10, 1, '1212', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:15:48', '2025-07-27 18:15:48', '2025-07-27 18:15:48', '2025-07-27 18:15:48', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (180, 3, 1, 10, 1, '1212', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:15:48', '2025-07-27 18:15:48', '2025-07-27 18:15:48', '2025-07-27 18:15:48', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (181, 3, 1, 10, 1, '1212', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:15:49', '2025-07-27 18:15:48', '2025-07-27 18:15:48', '2025-07-27 18:15:48', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (182, 3, 1, 10, 1, '1212', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:15:49', '2025-07-27 18:15:49', '2025-07-27 18:15:48', '2025-07-27 18:15:49', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (183, 3, 1, 10, 1, '1212', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:15:49', '2025-07-27 18:15:49', '2025-07-27 18:15:49', '2025-07-27 18:15:49', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (184, 3, 1, 10, 1, '1212', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:15:49', '2025-07-27 18:15:49', '2025-07-27 18:15:49', '2025-07-27 18:15:49', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (185, 3, 1, 10, 1, '1212', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:15:50', '2025-07-27 18:15:50', '2025-07-27 18:15:49', '2025-07-27 18:15:50', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (186, 3, 1, 10, 1, '1212', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:15:50', '2025-07-27 18:15:50', '2025-07-27 18:15:49', '2025-07-27 18:15:50', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (187, 3, 1, 10, 1, '1212', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:15:50', '2025-07-27 18:15:50', '2025-07-27 18:15:50', '2025-07-27 18:15:50', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (188, 3, 1, 10, 1, '1212', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:15:50', '2025-07-27 18:15:50', '2025-07-27 18:15:50', '2025-07-27 18:15:50', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (189, 3, 1, 10, 1, '1212', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:15:50', '2025-07-27 18:15:50', '2025-07-27 18:15:50', '2025-07-27 18:15:50', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (190, 3, 1, 10, 1, '1212', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:15:51', '2025-07-27 18:15:50', '2025-07-27 18:15:50', '2025-07-27 18:15:50', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (191, 3, 1, 10, 1, '1212', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:15:51', '2025-07-27 18:15:51', '2025-07-27 18:15:50', '2025-07-27 18:15:51', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (192, 3, 1, 10, 1, '1212', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:15:51', '2025-07-27 18:15:51', '2025-07-27 18:15:51', '2025-07-27 18:15:51', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (193, 3, 1, 10, 1, '1212', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:15:52', '2025-07-27 18:15:52', '2025-07-27 18:15:51', '2025-07-27 18:15:52', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (194, 3, 1, 10, 1, '1212', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:15:52', '2025-07-27 18:15:52', '2025-07-27 18:15:51', '2025-07-27 18:15:52', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (195, 3, 1, 10, 1, '1212', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:15:52', '2025-07-27 18:15:52', '2025-07-27 18:15:51', '2025-07-27 18:15:52', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (196, 3, 10, 1, 1, '11', NULL, 0, '2025-07-27 18:15:57', NULL, '2025-07-27 18:15:56', '2025-07-27 18:15:56', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (197, 3, 10, 1, 1, '222', NULL, 0, '2025-07-27 18:16:01', NULL, '2025-07-27 18:16:00', '2025-07-27 18:16:00', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (198, 3, 1, 10, 1, '1212', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:16:40', '2025-07-27 18:16:44', '2025-07-27 18:16:39', '2025-07-27 18:16:44', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (199, 3, 10, 1, 1, '2', NULL, 0, '2025-07-27 18:16:48', NULL, '2025-07-27 18:16:48', '2025-07-27 18:16:48', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (200, 3, 1, 10, 1, '2312', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:16:53', '2025-07-27 18:16:53', '2025-07-27 18:16:52', '2025-07-27 18:16:53', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (201, 3, 1, 10, 1, '2121212', 'https://example.com/media/image.jpg', 1, '2025-07-27 18:17:05', '2025-07-27 18:17:08', '2025-07-27 18:17:05', '2025-07-27 18:17:08', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (202, 4, 2, 10, 1, '1213', 'https://example.com/media/image.jpg', 1, '2025-07-27 19:20:15', '2025-07-27 19:41:48', '2025-07-27 19:20:14', '2025-07-27 19:41:48', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (203, 4, 2, 10, 1, '1213', 'https://example.com/media/image.jpg', 1, '2025-07-27 19:27:42', '2025-07-27 19:41:48', '2025-07-27 19:27:41', '2025-07-27 19:41:48', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (204, 4, 2, 10, 1, '1213', 'https://example.com/media/image.jpg', 1, '2025-07-27 19:27:46', '2025-07-27 19:41:48', '2025-07-27 19:27:46', '2025-07-27 19:41:48', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (205, 4, 2, 10, 1, '1213', 'https://example.com/media/image.jpg', 1, '2025-07-27 19:27:47', '2025-07-27 19:41:48', '2025-07-27 19:27:47', '2025-07-27 19:41:48', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (206, 4, 2, 10, 1, '1213', 'https://example.com/media/image.jpg', 1, '2025-07-27 19:27:48', '2025-07-27 19:41:48', '2025-07-27 19:27:48', '2025-07-27 19:41:48', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (207, 4, 2, 10, 1, '1213', 'https://example.com/media/image.jpg', 1, '2025-07-27 19:27:49', '2025-07-27 19:41:48', '2025-07-27 19:27:48', '2025-07-27 19:41:48', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (208, 4, 2, 10, 1, '1213', 'https://example.com/media/image.jpg', 1, '2025-07-27 19:27:49', '2025-07-27 19:41:48', '2025-07-27 19:27:49', '2025-07-27 19:41:48', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (209, 4, 2, 10, 1, '1213', 'https://example.com/media/image.jpg', 1, '2025-07-27 19:29:06', '2025-07-27 19:41:48', '2025-07-27 19:29:06', '2025-07-27 19:41:48', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (210, 4, 2, 10, 1, '1213', 'https://example.com/media/image.jpg', 1, '2025-07-27 19:29:07', '2025-07-27 19:41:48', '2025-07-27 19:29:06', '2025-07-27 19:41:48', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (211, 4, 2, 10, 1, '1213', 'https://example.com/media/image.jpg', 1, '2025-07-27 19:38:43', '2025-07-27 19:41:48', '2025-07-27 19:38:43', '2025-07-27 19:41:48', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (212, 3, 1, 10, 1, '2121212', 'https://example.com/media/image.jpg', 1, '2025-07-27 19:38:53', '2025-07-27 19:46:25', '2025-07-27 19:38:53', '2025-07-27 19:46:25', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (213, 3, 1, 10, 1, '2121212', 'https://example.com/media/image.jpg', 1, '2025-07-27 19:38:56', '2025-07-27 19:46:25', '2025-07-27 19:38:55', '2025-07-27 19:46:25', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (214, 3, 1, 10, 1, '2121212', 'https://example.com/media/image.jpg', 1, '2025-07-27 19:38:57', '2025-07-27 19:46:25', '2025-07-27 19:38:56', '2025-07-27 19:46:25', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (215, 3, 1, 10, 1, '2121212', 'https://example.com/media/image.jpg', 1, '2025-07-27 19:38:57', '2025-07-27 19:46:25', '2025-07-27 19:38:57', '2025-07-27 19:46:25', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (216, 3, 1, 10, 1, '2121212', 'https://example.com/media/image.jpg', 1, '2025-07-27 19:39:03', '2025-07-27 19:46:25', '2025-07-27 19:39:03', '2025-07-27 19:46:25', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (217, 3, 1, 10, 1, '2121212', 'https://example.com/media/image.jpg', 1, '2025-07-27 19:41:03', '2025-07-27 19:46:25', '2025-07-27 19:41:02', '2025-07-27 19:46:25', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (218, 3, 1, 10, 1, '2121212', 'https://example.com/media/image.jpg', 1, '2025-07-27 19:41:06', '2025-07-27 19:46:25', '2025-07-27 19:41:06', '2025-07-27 19:46:25', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (219, 3, 1, 10, 1, '2121212', 'https://example.com/media/image.jpg', 1, '2025-07-27 19:41:23', '2025-07-27 19:46:25', '2025-07-27 19:41:23', '2025-07-27 19:46:25', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (220, 3, 1, 10, 1, '2121212', 'https://example.com/media/image.jpg', 1, '2025-07-27 19:41:24', '2025-07-27 19:46:25', '2025-07-27 19:41:24', '2025-07-27 19:46:25', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (221, 3, 1, 10, 1, '牛逼', 'https://example.com/media/image.jpg', 1, '2025-07-27 19:41:33', '2025-07-27 19:46:25', '2025-07-27 19:41:32', '2025-07-27 19:46:25', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (222, 4, 2, 10, 1, '666', 'https://example.com/media/image.jpg', 1, '2025-07-27 19:41:45', '2025-07-27 19:41:48', '2025-07-27 19:41:44', '2025-07-27 19:41:48', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (223, 3, 1, 10, 1, '牛逼', 'https://example.com/media/image.jpg', 1, '2025-07-27 19:46:23', '2025-07-27 19:46:25', '2025-07-27 19:46:22', '2025-07-27 19:46:25', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (224, 3, 10, 1, 1, '12', NULL, 0, '2025-07-27 19:46:39', NULL, '2025-07-27 19:46:39', '2025-07-27 19:46:39', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (225, 3, 1, 10, 1, '牛逼', 'https://example.com/media/image.jpg', 1, '2025-07-27 19:46:44', '2025-07-27 19:46:44', '2025-07-27 19:46:44', '2025-07-27 19:46:44', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (226, 3, 1, 10, 1, '哈哈哈哈哈', 'https://example.com/media/image.jpg', 1, '2025-07-27 19:46:55', '2025-07-27 19:46:55', '2025-07-27 19:46:54', '2025-07-27 19:46:55', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (227, 3, 1, 10, 1, '哈哈哈哈哈', 'https://example.com/media/image.jpg', 1, '2025-07-27 19:53:15', '2025-07-27 19:53:18', '2025-07-27 19:53:15', '2025-07-27 19:53:18', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (228, 3, 10, 1, 1, '112', NULL, 0, '2025-07-27 19:53:34', NULL, '2025-07-27 19:53:34', '2025-07-27 19:53:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (229, 3, 10, 1, 1, '111', NULL, 0, '2025-07-27 19:58:45', NULL, '2025-07-27 19:58:45', '2025-07-27 19:58:45', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (230, 3, 1, 10, 1, '哈哈哈哈哈', 'https://example.com/media/image.jpg', 1, '2025-07-27 19:59:00', '2025-07-27 19:59:00', '2025-07-27 19:58:59', '2025-07-27 19:59:00', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (231, 3, 1, 10, 1, '哈哈哈哈哈', 'https://example.com/media/image.jpg', 1, '2025-07-27 19:59:13', '2025-07-27 19:59:13', '2025-07-27 19:59:12', '2025-07-27 19:59:13', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (232, 3, 10, 1, 1, '11', NULL, 0, '2025-07-27 19:59:41', NULL, '2025-07-27 19:59:40', '2025-07-27 19:59:40', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (233, 3, 10, 1, 1, '111', NULL, 0, '2025-07-27 20:09:10', NULL, '2025-07-27 20:09:10', '2025-07-27 20:09:10', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (234, 3, 1, 10, 1, '哈哈哈哈哈', 'https://example.com/media/image.jpg', 1, '2025-07-27 20:09:18', '2025-07-27 20:09:18', '2025-07-27 20:09:18', '2025-07-27 20:09:18', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (235, 3, 1, 10, 1, '哈哈哈哈哈', 'https://example.com/media/image.jpg', 1, '2025-07-27 20:09:21', '2025-07-27 20:09:21', '2025-07-27 20:09:21', '2025-07-27 20:09:21', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (236, 3, 10, 1, 1, '2212', NULL, 0, '2025-07-27 20:09:24', NULL, '2025-07-27 20:09:24', '2025-07-27 20:09:24', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (237, 3, 10, 1, 1, '1212', NULL, 0, '2025-07-27 20:09:27', NULL, '2025-07-27 20:09:26', '2025-07-27 20:09:26', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (238, 4, 10, 2, 1, '11', NULL, 0, '2025-07-27 20:09:42', NULL, '2025-07-27 20:09:42', '2025-07-27 20:09:42', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (239, 4, 10, 2, 1, '22212', NULL, 0, '2025-07-27 20:09:44', NULL, '2025-07-27 20:09:44', '2025-07-27 20:09:44', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (240, 3, 1, 10, 1, '哈哈哈哈哈', 'https://example.com/media/image.jpg', 0, '2025-07-27 20:09:53', NULL, '2025-07-27 20:09:53', '2025-07-27 20:09:53', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (241, 3, 1, 10, 1, '哈哈哈哈哈', 'https://example.com/media/image.jpg', 0, '2025-07-27 20:09:54', NULL, '2025-07-27 20:09:54', '2025-07-27 20:09:54', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (242, 3, 1, 10, 1, '哈哈哈哈哈', 'https://example.com/media/image.jpg', 0, '2025-07-27 20:09:55', NULL, '2025-07-27 20:09:54', '2025-07-27 20:09:54', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (243, 4, 2, 10, 1, '666', 'https://example.com/media/image.jpg', 0, '2025-07-27 20:10:01', NULL, '2025-07-27 20:10:00', '2025-07-27 20:10:00', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (244, 4, 2, 10, 1, '666', 'https://example.com/media/image.jpg', 0, '2025-07-27 20:10:02', NULL, '2025-07-27 20:10:01', '2025-07-27 20:10:01', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (245, 4, 2, 10, 1, '666', 'https://example.com/media/image.jpg', 0, '2025-07-27 20:10:02', NULL, '2025-07-27 20:10:02', '2025-07-27 20:10:02', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (246, 4, 2, 10, 1, '666', 'https://example.com/media/image.jpg', 0, '2025-07-27 20:10:02', NULL, '2025-07-27 20:10:02', '2025-07-27 20:10:02', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (247, 4, 2, 10, 1, '666', 'https://example.com/media/image.jpg', 0, '2025-07-27 20:10:04', NULL, '2025-07-27 20:10:04', '2025-07-27 20:10:04', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (248, 5, 2, 12, 1, '哈哈哈哈哈', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:19:51', '2025-07-27 21:20:05', '2025-07-27 21:19:51', '2025-07-27 21:20:05', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (249, 5, 2, 12, 1, '哈哈哈哈哈', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:19:57', '2025-07-27 21:20:05', '2025-07-27 21:19:57', '2025-07-27 21:20:05', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (250, 5, 2, 12, 1, '哈哈哈哈哈', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:19:58', '2025-07-27 21:20:05', '2025-07-27 21:19:58', '2025-07-27 21:20:05', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (251, 5, 2, 12, 1, '哈哈哈哈哈', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:19:59', '2025-07-27 21:20:05', '2025-07-27 21:19:58', '2025-07-27 21:20:05', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (252, 5, 2, 12, 1, '哈哈哈哈哈', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:19:59', '2025-07-27 21:20:05', '2025-07-27 21:19:58', '2025-07-27 21:20:05', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (253, 5, 2, 12, 1, '哈哈哈哈哈', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:19:59', '2025-07-27 21:20:05', '2025-07-27 21:19:59', '2025-07-27 21:20:05', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (254, 5, 2, 12, 1, '哈哈哈哈哈', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:19:59', '2025-07-27 21:20:05', '2025-07-27 21:19:59', '2025-07-27 21:20:05', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (255, 5, 2, 12, 1, '哈哈哈哈哈', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:19:59', '2025-07-27 21:20:05', '2025-07-27 21:19:59', '2025-07-27 21:20:05', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (256, 5, 2, 12, 1, '哈哈哈哈哈', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:20:00', '2025-07-27 21:20:05', '2025-07-27 21:19:59', '2025-07-27 21:20:05', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (257, 5, 2, 12, 1, '哈哈哈哈哈', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:20:00', '2025-07-27 21:20:05', '2025-07-27 21:19:59', '2025-07-27 21:20:05', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (258, 5, 2, 12, 1, '哈哈哈哈哈', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:20:00', '2025-07-27 21:20:05', '2025-07-27 21:19:59', '2025-07-27 21:20:05', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (259, 5, 2, 12, 1, '哈哈哈哈哈', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:20:00', '2025-07-27 21:20:05', '2025-07-27 21:20:00', '2025-07-27 21:20:05', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (260, 5, 2, 12, 1, '哈哈哈哈哈', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:20:00', '2025-07-27 21:20:05', '2025-07-27 21:20:00', '2025-07-27 21:20:05', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (261, 5, 2, 12, 1, '哈哈哈哈哈', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:20:00', '2025-07-27 21:20:05', '2025-07-27 21:20:00', '2025-07-27 21:20:05', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (262, 5, 2, 12, 1, '哈哈哈哈哈', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:20:01', '2025-07-27 21:20:05', '2025-07-27 21:20:00', '2025-07-27 21:20:05', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (263, 5, 2, 12, 1, '哈哈哈哈哈', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:20:01', '2025-07-27 21:20:05', '2025-07-27 21:20:01', '2025-07-27 21:20:05', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (264, 5, 2, 12, 1, '哈哈哈哈哈', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:20:01', '2025-07-27 21:20:05', '2025-07-27 21:20:01', '2025-07-27 21:20:05', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (265, 5, 2, 12, 1, '哈哈哈哈哈', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:20:01', '2025-07-27 21:20:05', '2025-07-27 21:20:01', '2025-07-27 21:20:05', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (266, 5, 2, 12, 1, '哈哈哈哈哈', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:20:02', '2025-07-27 21:20:05', '2025-07-27 21:20:01', '2025-07-27 21:20:05', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (267, 5, 12, 2, 1, '牛逼', NULL, 0, '2025-07-27 21:20:10', NULL, '2025-07-27 21:20:09', '2025-07-27 21:20:09', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (268, 5, 12, 2, 1, '可以的', NULL, 0, '2025-07-27 21:20:13', NULL, '2025-07-27 21:20:13', '2025-07-27 21:20:13', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (269, 5, 12, 2, 1, '哈哈哈', NULL, 0, '2025-07-27 21:20:20', NULL, '2025-07-27 21:20:20', '2025-07-27 21:20:20', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (270, 6, 1, 12, 1, 'mars', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:21:06', '2025-07-27 21:21:33', '2025-07-27 21:21:06', '2025-07-27 21:21:33', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (271, 6, 1, 12, 1, '1234234', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:21:15', '2025-07-27 21:21:33', '2025-07-27 21:21:15', '2025-07-27 21:21:33', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (272, 6, 1, 12, 1, '阿斯蒂芬', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:21:21', '2025-07-27 21:21:33', '2025-07-27 21:21:20', '2025-07-27 21:21:33', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (273, 6, 1, 12, 1, '阿嘎水电费', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:21:25', '2025-07-27 21:21:33', '2025-07-27 21:21:25', '2025-07-27 21:21:33', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (274, 6, 12, 1, 1, '哈塞', NULL, 0, '2025-07-27 21:21:38', NULL, '2025-07-27 21:21:37', '2025-07-27 21:21:37', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (275, 6, 12, 1, 1, '嗯KKK', NULL, 0, '2025-07-27 21:21:41', NULL, '2025-07-27 21:21:41', '2025-07-27 21:21:41', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (276, 6, 12, 1, 1, '咯KKK', NULL, 0, '2025-07-27 21:21:45', NULL, '2025-07-27 21:21:45', '2025-07-27 21:21:45', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (277, 6, 12, 1, 1, 'LOMO', NULL, 0, '2025-07-27 21:21:51', NULL, '2025-07-27 21:21:51', '2025-07-27 21:21:51', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (278, 6, 12, 1, 1, '看见咯', NULL, 0, '2025-07-27 21:21:54', NULL, '2025-07-27 21:21:54', '2025-07-27 21:21:54', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (279, 6, 1, 12, 1, '阿嘎水电费', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:21:58', '2025-07-27 21:21:58', '2025-07-27 21:21:57', '2025-07-27 21:21:58', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (280, 6, 1, 12, 1, '阿嘎水电费', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:21:59', '2025-07-27 21:21:59', '2025-07-27 21:21:59', '2025-07-27 21:21:59', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (281, 6, 1, 12, 1, '阿嘎水电费', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:22:00', '2025-07-27 21:22:00', '2025-07-27 21:21:59', '2025-07-27 21:22:00', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (282, 6, 1, 12, 1, '阿嘎水电费', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:22:01', '2025-07-27 21:22:01', '2025-07-27 21:22:00', '2025-07-27 21:22:01', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (283, 6, 1, 12, 1, '阿嘎水电费', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:22:02', '2025-07-27 21:22:02', '2025-07-27 21:22:01', '2025-07-27 21:22:02', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (284, 6, 1, 12, 1, '阿嘎水电费', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:22:02', '2025-07-27 21:22:02', '2025-07-27 21:22:02', '2025-07-27 21:22:02', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (285, 6, 1, 12, 1, '阿嘎水电费', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:22:03', '2025-07-27 21:22:02', '2025-07-27 21:22:02', '2025-07-27 21:22:02', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (286, 6, 1, 12, 1, '阿嘎水电费', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:22:03', '2025-07-27 21:22:03', '2025-07-27 21:22:03', '2025-07-27 21:22:03', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (287, 6, 1, 12, 1, '阿嘎水电费', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:22:04', '2025-07-27 21:22:04', '2025-07-27 21:22:03', '2025-07-27 21:22:04', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (288, 6, 1, 12, 1, '阿嘎水电费', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:22:05', '2025-07-27 21:22:05', '2025-07-27 21:22:04', '2025-07-27 21:22:05', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (289, 6, 1, 12, 1, '阿嘎水电费', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:22:05', '2025-07-27 21:22:05', '2025-07-27 21:22:05', '2025-07-27 21:22:05', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (290, 6, 1, 12, 1, '阿嘎水电费', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:22:12', '2025-07-27 21:22:12', '2025-07-27 21:22:11', '2025-07-27 21:22:12', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (291, 6, 1, 12, 1, '阿嘎水电费', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:22:13', '2025-07-27 21:22:13', '2025-07-27 21:22:12', '2025-07-27 21:22:13', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (292, 6, 1, 12, 1, '阿嘎水电费', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:22:13', '2025-07-27 21:22:13', '2025-07-27 21:22:13', '2025-07-27 21:22:13', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (293, 6, 12, 1, 1, '咯KKK', NULL, 0, '2025-07-27 21:22:16', NULL, '2025-07-27 21:22:16', '2025-07-27 21:22:16', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (294, 6, 12, 1, 1, '漏漏漏', NULL, 0, '2025-07-27 21:22:25', NULL, '2025-07-27 21:22:24', '2025-07-27 21:22:24', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (295, 6, 12, 1, 1, '咯KKK', NULL, 0, '2025-07-27 21:22:31', NULL, '2025-07-27 21:22:30', '2025-07-27 21:22:30', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (296, 6, 12, 1, 1, '李克农', NULL, 0, '2025-07-27 21:22:34', NULL, '2025-07-27 21:22:34', '2025-07-27 21:22:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (297, 5, 12, 2, 1, '你还看', NULL, 0, '2025-07-27 21:23:23', NULL, '2025-07-27 21:23:22', '2025-07-27 21:23:22', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (298, 5, 12, 2, 1, '印logo', NULL, 0, '2025-07-27 21:23:26', NULL, '2025-07-27 21:23:25', '2025-07-27 21:23:25', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (299, 5, 12, 2, 1, '剃秃所以', NULL, 0, '2025-07-27 21:23:29', NULL, '2025-07-27 21:23:28', '2025-07-27 21:23:28', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (300, 5, 12, 2, 1, '嗯', NULL, 0, '2025-07-27 21:23:33', NULL, '2025-07-27 21:23:33', '2025-07-27 21:23:33', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (301, 6, 12, 1, 1, '可以的', NULL, 0, '2025-07-27 21:23:38', NULL, '2025-07-27 21:23:37', '2025-07-27 21:23:37', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (302, 6, 12, 1, 1, '没', NULL, 0, '2025-07-27 21:23:44', NULL, '2025-07-27 21:23:43', '2025-07-27 21:23:43', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (303, 6, 1, 12, 1, '阿嘎水电费', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:23:58', '2025-07-27 21:23:58', '2025-07-27 21:23:57', '2025-07-27 21:23:58', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (304, 6, 1, 12, 1, '阿嘎水电费', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:23:59', '2025-07-27 21:23:59', '2025-07-27 21:23:58', '2025-07-27 21:23:59', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (305, 6, 1, 12, 1, '阿嘎水电费', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:00', '2025-07-27 21:24:00', '2025-07-27 21:24:00', '2025-07-27 21:24:00', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (306, 6, 1, 12, 1, '阿嘎水电费', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:01', '2025-07-27 21:24:02', '2025-07-27 21:24:01', '2025-07-27 21:24:02', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (307, 6, 1, 12, 1, '阿嘎水电费', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:02', '2025-07-27 21:24:02', '2025-07-27 21:24:02', '2025-07-27 21:24:02', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (308, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:07', '2025-07-27 21:24:07', '2025-07-27 21:24:06', '2025-07-27 21:24:07', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (309, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:08', '2025-07-27 21:24:08', '2025-07-27 21:24:07', '2025-07-27 21:24:08', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (310, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:09', '2025-07-27 21:24:09', '2025-07-27 21:24:09', '2025-07-27 21:24:09', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (311, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:10', '2025-07-27 21:24:09', '2025-07-27 21:24:09', '2025-07-27 21:24:09', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (312, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:10', '2025-07-27 21:24:10', '2025-07-27 21:24:10', '2025-07-27 21:24:10', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (313, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:10', '2025-07-27 21:24:10', '2025-07-27 21:24:10', '2025-07-27 21:24:10', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (314, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:11', '2025-07-27 21:24:10', '2025-07-27 21:24:10', '2025-07-27 21:24:10', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (315, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:11', '2025-07-27 21:24:10', '2025-07-27 21:24:10', '2025-07-27 21:24:10', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (316, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:11', '2025-07-27 21:24:11', '2025-07-27 21:24:10', '2025-07-27 21:24:11', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (317, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:11', '2025-07-27 21:24:11', '2025-07-27 21:24:11', '2025-07-27 21:24:11', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (318, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:11', '2025-07-27 21:24:11', '2025-07-27 21:24:11', '2025-07-27 21:24:11', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (319, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:12', '2025-07-27 21:24:11', '2025-07-27 21:24:11', '2025-07-27 21:24:11', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (320, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:12', '2025-07-27 21:24:11', '2025-07-27 21:24:11', '2025-07-27 21:24:11', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (321, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:12', '2025-07-27 21:24:12', '2025-07-27 21:24:12', '2025-07-27 21:24:12', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (322, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:12', '2025-07-27 21:24:12', '2025-07-27 21:24:12', '2025-07-27 21:24:12', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (323, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:12', '2025-07-27 21:24:12', '2025-07-27 21:24:12', '2025-07-27 21:24:12', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (324, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:24', '2025-07-27 21:24:24', '2025-07-27 21:24:24', '2025-07-27 21:24:24', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (325, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:34', '2025-07-27 21:24:35', '2025-07-27 21:24:34', '2025-07-27 21:24:35', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (326, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:35', '2025-07-27 21:24:35', '2025-07-27 21:24:35', '2025-07-27 21:24:35', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (327, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:35', '2025-07-27 21:24:35', '2025-07-27 21:24:35', '2025-07-27 21:24:35', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (328, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:36', '2025-07-27 21:24:35', '2025-07-27 21:24:35', '2025-07-27 21:24:35', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (329, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:36', '2025-07-27 21:24:35', '2025-07-27 21:24:35', '2025-07-27 21:24:35', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (330, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:36', '2025-07-27 21:24:36', '2025-07-27 21:24:35', '2025-07-27 21:24:36', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (331, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:36', '2025-07-27 21:24:36', '2025-07-27 21:24:36', '2025-07-27 21:24:36', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (332, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:36', '2025-07-27 21:24:36', '2025-07-27 21:24:36', '2025-07-27 21:24:36', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (333, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:36', '2025-07-27 21:24:36', '2025-07-27 21:24:36', '2025-07-27 21:24:36', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (334, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:37', '2025-07-27 21:24:36', '2025-07-27 21:24:36', '2025-07-27 21:24:36', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (335, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:37', '2025-07-27 21:24:36', '2025-07-27 21:24:36', '2025-07-27 21:24:36', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (336, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:37', '2025-07-27 21:24:37', '2025-07-27 21:24:37', '2025-07-27 21:24:37', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (337, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:37', '2025-07-27 21:24:37', '2025-07-27 21:24:37', '2025-07-27 21:24:37', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (338, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:37', '2025-07-27 21:24:37', '2025-07-27 21:24:37', '2025-07-27 21:24:37', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (339, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:38', '2025-07-27 21:24:37', '2025-07-27 21:24:37', '2025-07-27 21:24:37', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (340, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:38', '2025-07-27 21:24:37', '2025-07-27 21:24:37', '2025-07-27 21:24:37', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (341, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:38', '2025-07-27 21:24:38', '2025-07-27 21:24:38', '2025-07-27 21:24:38', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (342, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:38', '2025-07-27 21:24:38', '2025-07-27 21:24:38', '2025-07-27 21:24:38', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (343, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:38', '2025-07-27 21:24:38', '2025-07-27 21:24:38', '2025-07-27 21:24:38', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (344, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:39', '2025-07-27 21:24:38', '2025-07-27 21:24:38', '2025-07-27 21:24:38', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (345, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:39', '2025-07-27 21:24:38', '2025-07-27 21:24:38', '2025-07-27 21:24:38', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (346, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:39', '2025-07-27 21:24:38', '2025-07-27 21:24:38', '2025-07-27 21:24:38', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (347, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:39', '2025-07-27 21:24:39', '2025-07-27 21:24:39', '2025-07-27 21:24:39', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (348, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:39', '2025-07-27 21:24:39', '2025-07-27 21:24:39', '2025-07-27 21:24:39', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (349, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:39', '2025-07-27 21:24:39', '2025-07-27 21:24:39', '2025-07-27 21:24:39', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (350, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:40', '2025-07-27 21:24:39', '2025-07-27 21:24:39', '2025-07-27 21:24:39', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (351, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:40', '2025-07-27 21:24:39', '2025-07-27 21:24:39', '2025-07-27 21:24:39', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (352, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:40', '2025-07-27 21:24:40', '2025-07-27 21:24:40', '2025-07-27 21:24:40', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (353, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:40', '2025-07-27 21:24:40', '2025-07-27 21:24:40', '2025-07-27 21:24:40', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (354, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:40', '2025-07-27 21:24:40', '2025-07-27 21:24:40', '2025-07-27 21:24:40', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (355, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:41', '2025-07-27 21:24:40', '2025-07-27 21:24:40', '2025-07-27 21:24:40', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (356, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:41', '2025-07-27 21:24:40', '2025-07-27 21:24:40', '2025-07-27 21:24:40', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (357, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:41', '2025-07-27 21:24:40', '2025-07-27 21:24:40', '2025-07-27 21:24:40', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (358, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:41', '2025-07-27 21:24:41', '2025-07-27 21:24:41', '2025-07-27 21:24:41', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (359, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:41', '2025-07-27 21:24:41', '2025-07-27 21:24:41', '2025-07-27 21:24:41', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (360, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:41', '2025-07-27 21:24:41', '2025-07-27 21:24:41', '2025-07-27 21:24:41', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (361, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:42', '2025-07-27 21:24:41', '2025-07-27 21:24:41', '2025-07-27 21:24:41', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (362, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:42', '2025-07-27 21:24:41', '2025-07-27 21:24:41', '2025-07-27 21:24:41', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (363, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:42', '2025-07-27 21:24:41', '2025-07-27 21:24:41', '2025-07-27 21:24:41', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (364, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:42', '2025-07-27 21:24:42', '2025-07-27 21:24:42', '2025-07-27 21:24:42', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (365, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:42', '2025-07-27 21:24:42', '2025-07-27 21:24:42', '2025-07-27 21:24:42', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (366, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:42', '2025-07-27 21:24:42', '2025-07-27 21:24:42', '2025-07-27 21:24:42', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (367, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:43', '2025-07-27 21:24:42', '2025-07-27 21:24:42', '2025-07-27 21:24:42', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (368, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:43', '2025-07-27 21:24:42', '2025-07-27 21:24:42', '2025-07-27 21:24:42', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (369, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:43', '2025-07-27 21:24:42', '2025-07-27 21:24:42', '2025-07-27 21:24:42', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (370, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:43', '2025-07-27 21:24:43', '2025-07-27 21:24:43', '2025-07-27 21:24:43', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (371, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:43', '2025-07-27 21:24:43', '2025-07-27 21:24:43', '2025-07-27 21:24:43', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (372, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:43', '2025-07-27 21:24:43', '2025-07-27 21:24:43', '2025-07-27 21:24:43', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (373, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:44', '2025-07-27 21:24:43', '2025-07-27 21:24:43', '2025-07-27 21:24:43', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (374, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:44', '2025-07-27 21:24:43', '2025-07-27 21:24:43', '2025-07-27 21:24:43', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (375, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:44', '2025-07-27 21:24:44', '2025-07-27 21:24:43', '2025-07-27 21:24:44', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (376, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:44', '2025-07-27 21:24:44', '2025-07-27 21:24:44', '2025-07-27 21:24:44', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (377, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:44', '2025-07-27 21:24:44', '2025-07-27 21:24:44', '2025-07-27 21:24:44', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (378, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:44', '2025-07-27 21:24:44', '2025-07-27 21:24:44', '2025-07-27 21:24:44', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (379, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:45', '2025-07-27 21:24:44', '2025-07-27 21:24:44', '2025-07-27 21:24:44', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (380, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:45', '2025-07-27 21:24:44', '2025-07-27 21:24:44', '2025-07-27 21:24:44', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (381, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:45', '2025-07-27 21:24:45', '2025-07-27 21:24:44', '2025-07-27 21:24:45', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (382, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:45', '2025-07-27 21:24:45', '2025-07-27 21:24:45', '2025-07-27 21:24:45', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (383, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:45', '2025-07-27 21:24:45', '2025-07-27 21:24:45', '2025-07-27 21:24:45', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (384, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:45', '2025-07-27 21:24:45', '2025-07-27 21:24:45', '2025-07-27 21:24:45', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (385, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:46', '2025-07-27 21:24:45', '2025-07-27 21:24:45', '2025-07-27 21:24:45', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (386, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:46', '2025-07-27 21:24:45', '2025-07-27 21:24:45', '2025-07-27 21:24:45', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (387, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:46', '2025-07-27 21:24:46', '2025-07-27 21:24:46', '2025-07-27 21:24:46', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (388, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:46', '2025-07-27 21:24:46', '2025-07-27 21:24:46', '2025-07-27 21:24:46', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (389, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:46', '2025-07-27 21:24:46', '2025-07-27 21:24:46', '2025-07-27 21:24:46', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (390, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:47', '2025-07-27 21:24:46', '2025-07-27 21:24:46', '2025-07-27 21:24:46', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (391, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:47', '2025-07-27 21:24:46', '2025-07-27 21:24:46', '2025-07-27 21:24:46', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (392, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:47', '2025-07-27 21:24:46', '2025-07-27 21:24:46', '2025-07-27 21:24:46', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (393, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:47', '2025-07-27 21:24:47', '2025-07-27 21:24:47', '2025-07-27 21:24:47', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (394, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:47', '2025-07-27 21:24:47', '2025-07-27 21:24:47', '2025-07-27 21:24:47', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (395, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:47', '2025-07-27 21:24:47', '2025-07-27 21:24:47', '2025-07-27 21:24:47', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (396, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:48', '2025-07-27 21:24:47', '2025-07-27 21:24:47', '2025-07-27 21:24:47', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (397, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:48', '2025-07-27 21:24:47', '2025-07-27 21:24:47', '2025-07-27 21:24:47', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (398, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:48', '2025-07-27 21:24:48', '2025-07-27 21:24:47', '2025-07-27 21:24:48', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (399, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:48', '2025-07-27 21:24:48', '2025-07-27 21:24:48', '2025-07-27 21:24:48', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (400, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:48', '2025-07-27 21:24:48', '2025-07-27 21:24:48', '2025-07-27 21:24:48', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (401, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:48', '2025-07-27 21:24:48', '2025-07-27 21:24:48', '2025-07-27 21:24:48', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (402, 6, 1, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:24:49', '2025-07-27 21:24:48', '2025-07-27 21:24:48', '2025-07-27 21:24:48', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (403, 6, 12, 1, 1, '牛逼', NULL, 0, '2025-07-27 21:25:50', NULL, '2025-07-27 21:25:50', '2025-07-27 21:25:50', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (404, 6, 12, 1, 1, '牛逼', NULL, 0, '2025-07-27 21:25:57', NULL, '2025-07-27 21:25:57', '2025-07-27 21:25:57', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (405, 6, 12, 1, 1, '魔攻', NULL, 0, '2025-07-27 21:26:02', NULL, '2025-07-27 21:26:02', '2025-07-27 21:26:02', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (406, 7, 10, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:29:08', '2025-07-27 21:29:31', '2025-07-27 21:29:08', '2025-07-27 21:29:31', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (407, 7, 10, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:29:15', '2025-07-27 21:29:31', '2025-07-27 21:29:15', '2025-07-27 21:29:31', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (408, 7, 10, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:29:16', '2025-07-27 21:29:31', '2025-07-27 21:29:16', '2025-07-27 21:29:31', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (409, 7, 10, 12, 1, '1', 'https://example.com/media/image.jpg', 1, '2025-07-27 21:29:17', '2025-07-27 21:29:31', '2025-07-27 21:29:17', '2025-07-27 21:29:31', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (410, 7, 12, 10, 1, '嗯', NULL, 1, '2025-07-27 21:29:35', '2025-07-27 21:29:54', '2025-07-27 21:29:35', '2025-07-27 21:29:54', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (411, 7, 12, 10, 1, '牛', NULL, 1, '2025-07-27 21:29:48', '2025-07-27 21:29:54', '2025-07-27 21:29:47', '2025-07-27 21:29:54', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (412, 7, 12, 10, 1, '哈哈哈', NULL, 1, '2025-07-27 21:29:51', '2025-07-27 21:29:54', '2025-07-27 21:29:50', '2025-07-27 21:29:54', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (413, 7, 10, 12, 1, '可以的', NULL, 1, '2025-07-27 21:30:01', '2025-07-27 21:30:01', '2025-07-27 21:30:00', '2025-07-27 21:30:01', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (414, 7, 12, 10, 1, '牛逼', NULL, 1, '2025-07-27 21:30:10', '2025-07-27 21:30:10', '2025-07-27 21:30:09', '2025-07-27 21:30:10', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (415, 7, 12, 10, 1, '进口', NULL, 1, '2025-07-27 21:30:13', '2025-07-27 21:30:13', '2025-07-27 21:30:12', '2025-07-27 21:30:13', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (416, 7, 12, 10, 1, '李敏咯', NULL, 1, '2025-07-27 21:30:16', '2025-07-27 21:30:16', '2025-07-27 21:30:16', '2025-07-27 21:30:16', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (417, 7, 12, 10, 1, '听一下', NULL, 1, '2025-07-27 21:30:34', '2025-07-27 21:30:34', '2025-07-27 21:30:33', '2025-07-27 21:30:34', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (418, 7, 12, 10, 1, '我公公', NULL, 1, '2025-07-27 21:30:37', '2025-07-27 21:30:37', '2025-07-27 21:30:36', '2025-07-27 21:30:37', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (419, 7, 12, 10, 1, '咯KKK', NULL, 1, '2025-07-27 21:30:41', '2025-07-27 21:30:41', '2025-07-27 21:30:40', '2025-07-27 21:30:41', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (420, 7, 12, 10, 1, '您咯', NULL, 1, '2025-07-27 21:30:54', '2025-07-27 21:30:54', '2025-07-27 21:30:53', '2025-07-27 21:30:54', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (421, 7, 10, 12, 1, '哈哈哈', NULL, 1, '2025-07-27 21:31:03', '2025-07-27 21:31:03', '2025-07-27 21:31:03', '2025-07-27 21:31:03', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (422, 7, 10, 12, 1, '牛逼', NULL, 1, '2025-07-27 21:31:12', '2025-07-27 21:31:12', '2025-07-27 21:31:11', '2025-07-27 21:31:12', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (423, 7, 12, 10, 1, '您咯', NULL, 1, '2025-07-27 21:47:00', '2025-07-27 21:47:13', '2025-07-27 21:46:59', '2025-07-27 21:47:13', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (424, 7, 10, 12, 1, '可以的', NULL, 1, '2025-07-27 21:47:17', '2025-07-27 21:47:17', '2025-07-27 21:47:16', '2025-07-27 21:47:17', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (425, 7, 12, 10, 1, '可以', NULL, 1, '2025-07-27 21:47:26', '2025-07-27 21:47:26', '2025-07-27 21:47:25', '2025-07-27 21:47:26', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (426, 7, 10, 12, 1, '哈哈哈', NULL, 1, '2025-07-27 21:47:37', '2025-07-27 21:47:38', '2025-07-27 21:47:37', '2025-07-27 21:47:38', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (427, 7, 12, 10, 1, '老公', NULL, 1, '2025-07-27 21:47:38', '2025-07-27 21:47:38', '2025-07-27 21:47:38', '2025-07-27 21:47:38', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (428, 7, 12, 10, 1, '嘻嘻嘻', NULL, 1, '2025-07-27 21:47:43', '2025-07-27 21:47:43', '2025-07-27 21:47:43', '2025-07-27 21:47:43', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (429, 7, 10, 12, 1, '老婆', NULL, 1, '2025-07-27 21:47:45', '2025-07-27 21:47:45', '2025-07-27 21:47:45', '2025-07-27 21:47:45', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (430, 7, 10, 12, 1, '嘿嘿', NULL, 1, '2025-07-27 21:47:51', '2025-07-27 21:47:51', '2025-07-27 21:47:50', '2025-07-27 21:47:51', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (431, 7, 12, 10, 1, '虐虐虐', NULL, 1, '2025-07-27 21:47:52', '2025-07-27 21:47:52', '2025-07-27 21:47:52', '2025-07-27 21:47:52', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (432, 7, 12, 10, 1, '哼哼哼', NULL, 1, '2025-07-27 21:47:59', '2025-07-27 21:47:59', '2025-07-27 21:47:58', '2025-07-27 21:47:59', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (433, 7, 10, 12, 1, '哈哈哈', NULL, 1, '2025-07-27 21:48:11', '2025-07-27 21:48:11', '2025-07-27 21:48:10', '2025-07-27 21:48:11', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (434, 7, 12, 10, 1, '😊', NULL, 1, '2025-07-27 21:48:13', '2025-07-27 21:48:13', '2025-07-27 21:48:12', '2025-07-27 21:48:13', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (435, 7, 12, 10, 1, '👅', NULL, 1, '2025-07-27 21:48:20', '2025-07-27 21:48:20', '2025-07-27 21:48:19', '2025-07-27 21:48:20', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (436, 7, 10, 12, 1, '牛逼啊', NULL, 1, '2025-07-27 21:48:23', '2025-07-27 21:48:24', '2025-07-27 21:48:23', '2025-07-27 21:48:24', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (437, 7, 12, 10, 1, '🍸', NULL, 1, '2025-07-27 21:48:27', '2025-07-27 21:48:27', '2025-07-27 21:48:26', '2025-07-27 21:48:27', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (438, 7, 10, 12, 1, '聊天', NULL, 1, '2025-07-27 21:48:33', '2025-07-27 21:48:33', '2025-07-27 21:48:32', '2025-07-27 21:48:33', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (439, 7, 12, 10, 1, '🎄◟(˶> ᎑ <˶)◞🎄', NULL, 1, '2025-07-27 21:48:41', '2025-07-27 21:48:41', '2025-07-27 21:48:40', '2025-07-27 21:48:41', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (440, 7, 12, 10, 1, '加扣扣', NULL, 1, '2025-07-27 21:48:58', '2025-07-27 21:48:58', '2025-07-27 21:48:57', '2025-07-27 21:48:58', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (441, 7, 12, 10, 1, '您咯', NULL, 1, '2025-07-27 21:49:00', '2025-07-27 21:49:00', '2025-07-27 21:49:00', '2025-07-27 21:49:00', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (442, 7, 10, 12, 1, '1', NULL, 1, '2025-07-27 21:49:12', '2025-07-27 21:49:38', '2025-07-27 21:49:11', '2025-07-27 21:49:38', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (443, 7, 10, 12, 1, '2222', NULL, 1, '2025-07-27 21:49:15', '2025-07-27 21:49:38', '2025-07-27 21:49:15', '2025-07-27 21:49:38', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (444, 7, 10, 12, 1, '1212', NULL, 1, '2025-07-27 21:49:18', '2025-07-27 21:49:38', '2025-07-27 21:49:17', '2025-07-27 21:49:38', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (445, 7, 10, 12, 1, '1212', NULL, 1, '2025-07-27 21:49:19', '2025-07-27 21:49:38', '2025-07-27 21:49:19', '2025-07-27 21:49:38', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (446, 7, 10, 12, 1, '2222', NULL, 1, '2025-07-27 21:49:22', '2025-07-27 21:49:38', '2025-07-27 21:49:21', '2025-07-27 21:49:38', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (447, 7, 10, 12, 1, '1111', NULL, 1, '2025-07-27 21:49:25', '2025-07-27 21:49:38', '2025-07-27 21:49:25', '2025-07-27 21:49:38', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (448, 7, 10, 12, 1, '1', NULL, 1, '2025-07-27 21:49:53', '2025-07-27 21:50:17', '2025-07-27 21:49:53', '2025-07-27 21:50:17', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (449, 7, 10, 12, 1, '2222', NULL, 1, '2025-07-27 21:49:59', '2025-07-27 21:50:17', '2025-07-27 21:49:59', '2025-07-27 21:50:17', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (450, 7, 10, 12, 1, '12', NULL, 1, '2025-07-27 21:50:03', '2025-07-27 21:50:17', '2025-07-27 21:50:02', '2025-07-27 21:50:17', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (451, 7, 10, 12, 1, '1', NULL, 1, '2025-07-27 21:50:06', '2025-07-27 21:50:17', '2025-07-27 21:50:05', '2025-07-27 21:50:17', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (452, 7, 12, 10, 1, '可以', NULL, 1, '2025-07-27 21:50:23', '2025-07-27 21:50:23', '2025-07-27 21:50:23', '2025-07-27 21:50:23', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (453, 7, 12, 10, 1, '牛逼', NULL, 1, '2025-07-27 21:50:46', '2025-07-27 21:50:46', '2025-07-27 21:50:45', '2025-07-27 21:50:46', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (454, 7, 12, 10, 1, '牛哥', NULL, 1, '2025-07-27 21:54:25', '2025-07-27 21:54:28', '2025-07-27 21:54:24', '2025-07-27 21:54:28', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (455, 7, 10, 12, 1, '112', NULL, 1, '2025-07-27 21:54:32', '2025-07-27 21:54:32', '2025-07-27 21:54:31', '2025-07-27 21:54:32', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (456, 7, 10, 12, 1, '哈哈哈', NULL, 1, '2025-07-27 21:54:40', '2025-07-27 21:54:41', '2025-07-27 21:54:40', '2025-07-27 21:54:41', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (457, 7, 12, 10, 1, '牛逼', NULL, 1, '2025-07-27 21:54:46', '2025-07-27 21:54:46', '2025-07-27 21:54:45', '2025-07-27 21:54:46', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (458, 7, 12, 10, 1, '你莫咯', NULL, 1, '2025-07-27 21:54:48', '2025-07-27 21:54:48', '2025-07-27 21:54:48', '2025-07-27 21:54:48', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (459, 7, 12, 10, 1, '您咯', NULL, 1, '2025-07-27 21:54:51', '2025-07-27 21:54:51', '2025-07-27 21:54:51', '2025-07-27 21:54:51', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (460, 7, 12, 10, 1, '测试', NULL, 1, '2025-07-27 21:55:14', '2025-07-27 21:55:15', '2025-07-27 21:55:14', '2025-07-27 21:55:15', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (461, 7, 12, 10, 1, '哈哈', NULL, 1, '2025-07-27 21:56:04', '2025-07-27 21:56:04', '2025-07-27 21:56:03', '2025-07-27 21:56:04', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (462, 7, 12, 10, 1, '牛逼', NULL, 0, '2025-07-27 21:58:37', NULL, '2025-07-27 21:58:37', '2025-07-27 21:58:37', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (463, 7, 12, 10, 1, '1', NULL, 0, '2025-07-27 21:58:47', NULL, '2025-07-27 21:58:46', '2025-07-27 21:58:46', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (464, 7, 12, 10, 1, '郭敬明你看你', NULL, 0, '2025-07-27 21:58:51', NULL, '2025-07-27 21:58:51', '2025-07-27 21:58:51', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_message` VALUES (465, 7, 12, 10, 1, '日', NULL, 0, '2025-07-27 22:15:35', NULL, '2025-07-27 22:15:35', '2025-07-27 22:15:35', NULL, NULL, 0, NULL);

-- ----------------------------
-- Table structure for tb_chat_session
-- ----------------------------
DROP TABLE IF EXISTS `tb_chat_session`;
CREATE TABLE `tb_chat_session`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '会话ID',
  `user1_id` bigint NOT NULL COMMENT '用户1 ID（较小的用户ID）',
  `user2_id` bigint NOT NULL COMMENT '用户2 ID（较大的用户ID）',
  `last_message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '最后一条消息内容',
  `last_message_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后消息时间',
  `user1_unread_count` int NULL DEFAULT 0 COMMENT '用户1未读消息数',
  `user2_unread_count` int NULL DEFAULT 0 COMMENT '用户2未读消息数',
  `status` tinyint(1) NULL DEFAULT 0 COMMENT '会话状态：0-正常，1-已删除',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建人',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新人',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除：0-否，1-是',
  `delete_time` datetime NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_users`(`user1_id` ASC, `user2_id` ASC) USING BTREE COMMENT '用户组合唯一索引',
  INDEX `idx_user1_id`(`user1_id` ASC) USING BTREE,
  INDEX `idx_user2_id`(`user2_id` ASC) USING BTREE,
  INDEX `idx_last_message_time`(`last_message_time` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_is_deleted`(`is_deleted` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '聊天会话表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_chat_session
-- ----------------------------
INSERT INTO `tb_chat_session` VALUES (3, 1, 10, '哈哈哈哈哈', '2025-07-27 20:09:55', 25, 3, 0, '2025-07-27 17:18:52', '2025-07-27 20:09:54', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_session` VALUES (4, 2, 10, '666', '2025-07-27 20:10:04', 2, 5, 0, '2025-07-27 19:20:15', '2025-07-27 20:10:04', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_session` VALUES (5, 2, 12, '嗯', '2025-07-27 21:23:33', 7, 0, 0, '2025-07-27 21:19:51', '2025-07-27 21:23:33', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_session` VALUES (6, 1, 12, '魔攻', '2025-07-27 21:26:02', 14, 0, 0, '2025-07-27 21:21:06', '2025-07-27 21:26:02', NULL, NULL, 0, NULL);
INSERT INTO `tb_chat_session` VALUES (7, 10, 12, '日', '2025-07-27 22:15:35', 4, 0, 0, '2025-07-27 21:29:08', '2025-07-27 22:15:35', NULL, NULL, 0, NULL);

-- ----------------------------
-- Table structure for tb_collection_folder
-- ----------------------------
DROP TABLE IF EXISTS `tb_collection_folder`;
CREATE TABLE `tb_collection_folder`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '收藏夹ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `folder_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '收藏夹名称',
  `folder_icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '收藏夹图标',
  `description` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '收藏夹描述',
  `is_private` tinyint NULL DEFAULT 0 COMMENT '是否私密：0-公开，1-私密',
  `items_count` int NULL DEFAULT 0 COMMENT '收藏数量',
  `sort_order` int NULL DEFAULT 0 COMMENT '排序',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_sort_order`(`sort_order` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '收藏夹表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_collection_folder
-- ----------------------------
INSERT INTO `tb_collection_folder` VALUES (1, 1, '我的收藏', NULL, '默认收藏夹', 0, 3, 0, '2025-07-26 17:02:29', '2025-07-26 17:02:29');
INSERT INTO `tb_collection_folder` VALUES (2, 1, '美食攻略', NULL, '收藏的美食相关内容', 0, 1, 0, '2025-07-26 17:02:29', '2025-07-26 17:02:29');
INSERT INTO `tb_collection_folder` VALUES (3, 2, '我的收藏', NULL, '默认收藏夹', 0, 2, 0, '2025-07-26 17:02:29', '2025-07-26 17:02:29');
INSERT INTO `tb_collection_folder` VALUES (4, 2, '摄影技巧', NULL, '摄影相关收藏', 0, 1, 0, '2025-07-26 17:02:29', '2025-07-26 17:02:29');
INSERT INTO `tb_collection_folder` VALUES (5, 3, '我的收藏', NULL, '默认收藏夹', 0, 2, 0, '2025-07-26 17:02:29', '2025-07-26 17:02:29');

-- ----------------------------
-- Table structure for tb_file_upload
-- ----------------------------
DROP TABLE IF EXISTS `tb_file_upload`;
CREATE TABLE `tb_file_upload`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '文件ID',
  `user_id` bigint NULL DEFAULT NULL COMMENT '上传用户ID',
  `original_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '原始文件名',
  `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '存储文件名',
  `file_path` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文件路径',
  `file_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '访问URL',
  `file_size` bigint NULL DEFAULT 0 COMMENT '文件大小（字节）',
  `file_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '文件类型',
  `mime_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'MIME类型',
  `storage_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'local' COMMENT '存储类型：local,oss,cos,qiniu',
  `md5` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'MD5值',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态：0-失败，1-成功',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '上传时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_file_type`(`file_type` ASC) USING BTREE,
  INDEX `idx_md5`(`md5` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '文件上传记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_file_upload
-- ----------------------------

-- ----------------------------
-- Table structure for tb_message_statistics
-- ----------------------------
DROP TABLE IF EXISTS `tb_message_statistics`;
CREATE TABLE `tb_message_statistics`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '统计ID',
  `stat_date` date NOT NULL COMMENT '统计日期',
  `message_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '消息类型',
  `send_count` int NULL DEFAULT 0 COMMENT '发送数量',
  `success_count` int NULL DEFAULT 0 COMMENT '成功数量',
  `fail_count` int NULL DEFAULT 0 COMMENT '失败数量',
  `read_count` int NULL DEFAULT 0 COMMENT '已读数量',
  `click_count` int NULL DEFAULT 0 COMMENT '点击数量',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_date_type`(`stat_date` ASC, `message_type` ASC) USING BTREE,
  INDEX `idx_stat_date`(`stat_date` ASC) USING BTREE,
  INDEX `idx_message_type`(`message_type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '消息统计表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_message_statistics
-- ----------------------------

-- ----------------------------
-- Table structure for tb_message_template
-- ----------------------------
DROP TABLE IF EXISTS `tb_message_template`;
CREATE TABLE `tb_message_template`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '模板ID',
  `template_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模板编码',
  `template_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模板名称',
  `title_template` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '标题模板',
  `content_template` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '内容模板',
  `template_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模板类型：like,comment,follow,activity,system',
  `variables` json NULL COMMENT '模板变量说明',
  `is_push` tinyint NULL DEFAULT 1 COMMENT '是否推送：0-否，1-是',
  `is_sms` tinyint NULL DEFAULT 0 COMMENT '是否短信：0-否，1-是',
  `is_email` tinyint NULL DEFAULT 0 COMMENT '是否邮件：0-否，1-是',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态：0-禁用，1-启用',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_template_code`(`template_code` ASC) USING BTREE,
  INDEX `idx_template_type`(`template_type` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '消息模板表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_message_template
-- ----------------------------
INSERT INTO `tb_message_template` VALUES (1, 'USER_LIKE_POST', '帖子点赞通知', '收到新的点赞', '{username}赞了你的帖子', 'like', '[\"username\"]', 1, 0, 0, 1, '2025-07-26 17:01:28', '2025-07-26 17:01:28');
INSERT INTO `tb_message_template` VALUES (2, 'USER_COMMENT_POST', '帖子评论通知', '收到新的评论', '{username}评论了你的帖子：{content}', 'comment', '[\"username\", \"content\"]', 1, 0, 0, 1, '2025-07-26 17:01:28', '2025-07-26 17:01:28');
INSERT INTO `tb_message_template` VALUES (3, 'USER_FOLLOW', '用户关注通知', '收到新的关注', '{username}关注了你', 'follow', '[\"username\"]', 1, 0, 0, 1, '2025-07-26 17:01:28', '2025-07-26 17:01:28');
INSERT INTO `tb_message_template` VALUES (4, 'ACTIVITY_REMIND', '活动提醒通知', '活动即将开始', '你报名的活动\"{title}\"将在{time}开始', 'activity', '[\"title\", \"time\"]', 1, 0, 0, 1, '2025-07-26 17:01:28', '2025-07-26 17:01:28');
INSERT INTO `tb_message_template` VALUES (5, 'ACTIVITY_CANCEL', '活动取消通知', '活动已取消', '很抱歉，活动\"{title}\"已被取消', 'activity', '[\"title\"]', 1, 0, 0, 1, '2025-07-26 17:01:28', '2025-07-26 17:01:28');
INSERT INTO `tb_message_template` VALUES (6, 'SYSTEM_NOTICE', '系统通知', '系统通知', '{content}', 'system', '[\"content\"]', 1, 0, 0, 1, '2025-07-26 17:01:28', '2025-07-26 17:01:28');
INSERT INTO `tb_message_template` VALUES (7, 'USER_REPLY_COMMENT', '评论回复通知', '收到新的回复', '{username}回复了你的评论：{content}', 'comment', '[\"username\", \"content\"]', 1, 0, 0, 1, '2025-07-26 17:01:28', '2025-07-26 17:01:28');
INSERT INTO `tb_message_template` VALUES (8, 'ACTIVITY_APPROVED', '活动审核通过', '活动审核通过', '你发布的活动\"{title}\"已审核通过', 'activity', '[\"title\"]', 1, 0, 0, 1, '2025-07-26 17:01:28', '2025-07-26 17:01:28');
INSERT INTO `tb_message_template` VALUES (9, 'ACTIVITY_REJECTED', '活动审核拒绝', '活动审核拒绝', '你发布的活动\"{title}\"审核未通过，原因：{reason}', 'activity', '[\"title\", \"reason\"]', 1, 0, 0, 1, '2025-07-26 17:01:28', '2025-07-26 17:01:28');
INSERT INTO `tb_message_template` VALUES (10, 'POST_LIKED_MILESTONE', '点赞里程碑', '恭喜！', '你的帖子获得了{count}个赞！', 'like', '[\"count\"]', 1, 0, 0, 1, '2025-07-26 17:01:28', '2025-07-26 17:01:28');

-- ----------------------------
-- Table structure for tb_points_rule
-- ----------------------------
DROP TABLE IF EXISTS `tb_points_rule`;
CREATE TABLE `tb_points_rule`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '规则ID',
  `rule_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '规则编码',
  `rule_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '规则名称',
  `rule_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '规则类型：earn,consume',
  `action_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '动作类型：login,post,comment,like,share,activity',
  `points` int NOT NULL COMMENT '积分数量',
  `daily_limit` int NULL DEFAULT 0 COMMENT '每日限制次数，0表示不限制',
  `description` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '规则描述',
  `is_active` tinyint NULL DEFAULT 1 COMMENT '是否启用：0-否，1-是',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_rule_code`(`rule_code` ASC) USING BTREE,
  INDEX `idx_rule_type`(`rule_type` ASC) USING BTREE,
  INDEX `idx_action_type`(`action_type` ASC) USING BTREE,
  INDEX `idx_is_active`(`is_active` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '积分规则表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_points_rule
-- ----------------------------
INSERT INTO `tb_points_rule` VALUES (1, 'DAILY_LOGIN', '每日登录', 'earn', 'login', 10, 1, '每日首次登录获得积分', 1, '2025-07-26 17:01:33', '2025-07-26 17:01:33');
INSERT INTO `tb_points_rule` VALUES (2, 'PUBLISH_POST', '发布帖子', 'earn', 'post', 20, 5, '发布帖子获得积分', 1, '2025-07-26 17:01:33', '2025-07-26 17:01:33');
INSERT INTO `tb_points_rule` VALUES (3, 'PUBLISH_ACTIVITY', '发布活动', 'earn', 'activity', 50, 3, '发布活动获得积分', 1, '2025-07-26 17:01:33', '2025-07-26 17:01:33');
INSERT INTO `tb_points_rule` VALUES (4, 'COMMENT_POST', '评论帖子', 'earn', 'comment', 5, 10, '评论帖子获得积分', 1, '2025-07-26 17:01:33', '2025-07-26 17:01:33');
INSERT INTO `tb_points_rule` VALUES (5, 'LIKE_POST', '点赞帖子', 'earn', 'like', 2, 20, '点赞帖子获得积分', 1, '2025-07-26 17:01:33', '2025-07-26 17:01:33');
INSERT INTO `tb_points_rule` VALUES (6, 'SHARE_POST', '分享帖子', 'earn', 'share', 10, 5, '分享帖子获得积分', 1, '2025-07-26 17:01:33', '2025-07-26 17:01:33');
INSERT INTO `tb_points_rule` VALUES (7, 'COMPLETE_PROFILE', '完善资料', 'earn', 'profile', 100, 1, '完善个人资料获得积分', 1, '2025-07-26 17:01:33', '2025-07-26 17:01:33');
INSERT INTO `tb_points_rule` VALUES (8, 'FIRST_POST', '首次发帖', 'earn', 'post', 100, 1, '首次发帖奖励', 1, '2025-07-26 17:01:33', '2025-07-26 17:01:33');
INSERT INTO `tb_points_rule` VALUES (9, 'INVITE_FRIEND', '邀请好友', 'earn', 'invite', 200, 10, '成功邀请好友注册', 1, '2025-07-26 17:01:33', '2025-07-26 17:01:33');

-- ----------------------------
-- Table structure for tb_post
-- ----------------------------
DROP TABLE IF EXISTS `tb_post`;
CREATE TABLE `tb_post`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '帖子ID',
  `user_id` bigint NOT NULL COMMENT '发布用户ID',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '帖子标题（可选）',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '帖子内容',
  `images` json NULL COMMENT '图片集合',
  `video_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '视频URL',
  `video_cover` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '视频封面',
  `location` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '位置信息',
  `address` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '详细地址',
  `latitude` decimal(10, 7) NULL DEFAULT NULL COMMENT '纬度',
  `longitude` decimal(10, 7) NULL DEFAULT NULL COMMENT '经度',
  `region_id` bigint NULL DEFAULT NULL COMMENT '地区ID',
  `topics` json NULL COMMENT '关联话题ID集合',
  `tags` json NULL COMMENT '标签集合',
  `post_type` tinyint NULL DEFAULT 1 COMMENT '帖子类型：1-图文，2-视频，3-纯文字，4-链接分享',
  `link_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '分享链接URL',
  `link_title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '链接标题',
  `link_description` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '链接描述',
  `link_image` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '链接缩略图',
  `is_original` tinyint NULL DEFAULT 1 COMMENT '是否原创：0-转发，1-原创',
  `original_post_id` bigint NULL DEFAULT NULL COMMENT '原帖ID（转发时）',
  `view_count` int NULL DEFAULT 0 COMMENT '浏览次数',
  `like_count` int NULL DEFAULT 0 COMMENT '点赞数',
  `comment_count` int NULL DEFAULT 0 COMMENT '评论数',
  `share_count` int NULL DEFAULT 0 COMMENT '分享数',
  `collect_count` int NULL DEFAULT 0 COMMENT '收藏数',
  `is_top` tinyint NULL DEFAULT 0 COMMENT '是否置顶：0-否，1-是',
  `is_hot` tinyint NULL DEFAULT 0 COMMENT '是否热门：0-否，1-是',
  `is_recommend` tinyint NULL DEFAULT 0 COMMENT '是否推荐：0-否，1-是',
  `visibility` tinyint NULL DEFAULT 1 COMMENT '可见性：1-公开，2-仅关注者，3-私密',
  `allow_comment` tinyint NULL DEFAULT 1 COMMENT '允许评论：0-不允许，1-允许',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态：0-草稿，1-已发布，2-已删除，3-审核中，4-审核拒绝',
  `audit_status` tinyint NULL DEFAULT 0 COMMENT '审核状态：0-待审核，1-审核通过，2-审核拒绝',
  `audit_reason` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '审核原因',
  `audit_time` datetime NULL DEFAULT NULL COMMENT '审核时间',
  `audit_user_id` bigint NULL DEFAULT NULL COMMENT '审核人ID',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint NULL DEFAULT 0 COMMENT '是否删除：0-否，1-是',
  `delete_time` datetime NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_region_id`(`region_id` ASC) USING BTREE,
  INDEX `idx_post_type`(`post_type` ASC) USING BTREE,
  INDEX `idx_original_post_id`(`original_post_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_is_top`(`is_top` ASC) USING BTREE,
  INDEX `idx_is_hot`(`is_hot` ASC) USING BTREE,
  INDEX `idx_is_recommend`(`is_recommend` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE,
  INDEX `idx_is_deleted`(`is_deleted` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '圈子帖子表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_post
-- ----------------------------
INSERT INTO `tb_post` VALUES (1, 1, '西湖十景，每一处都是诗', '今天终于把西湖十景都走了一遍，每一处风景都让人流连忘返。特别是断桥残雪的意境，虽然现在不是雪季，但依然能感受到那份诗意。分享几张照片给大家～', '[\"https://example.com/post1_1.jpg\", \"https://example.com/post1_2.jpg\", \"https://example.com/post1_3.jpg\"]', NULL, NULL, '杭州西湖', NULL, 30.2741000, 120.1551000, 4, '[1, 6]', '[\"西湖\", \"风景\", \"摄影\"]', 1, NULL, NULL, NULL, NULL, 1, NULL, 156, 23, 8, 0, 0, 0, 0, 0, 1, 1, 1, 0, NULL, NULL, NULL, '2025-07-26 17:01:56', '2025-07-26 17:01:56', 0, NULL);
INSERT INTO `tb_post` VALUES (2, 2, '乌镇夜景摄影分享', '昨晚在乌镇拍摄的夜景，古镇在灯光的映衬下格外迷人。分享一些拍摄心得：1.使用三脚架稳定画面 2.适当降低ISO避免噪点 3.利用倒影增加画面层次', '[\"https://example.com/post2_1.jpg\", \"https://example.com/post2_2.jpg\"]', NULL, NULL, '乌镇古镇', NULL, 30.7408000, 120.4912000, 4, '[3, 5]', '[\"摄影\", \"夜景\", \"古镇\"]', 1, NULL, NULL, NULL, NULL, 1, NULL, 89, 15, 5, 0, 0, 0, 0, 0, 1, 1, 1, 0, NULL, NULL, NULL, '2025-07-26 17:01:56', '2025-07-26 17:01:56', 0, NULL);
INSERT INTO `tb_post` VALUES (3, 3, '成都火锅攻略来了！', '在成都待了一周，吃遍了各种火锅，总结了一份最全攻略！从老字号到网红店，从麻辣到清汤，每一家都有自己的特色。最推荐的还是那些藏在巷子里的小店～', '[\"https://example.com/post3_1.jpg\", \"https://example.com/post3_2.jpg\", \"https://example.com/post3_3.jpg\", \"https://example.com/post3_4.jpg\"]', NULL, NULL, '成都市', NULL, 30.6598000, 104.0633000, 6, '[2]', '[\"美食\", \"火锅\", \"成都\", \"攻略\"]', 1, NULL, NULL, NULL, NULL, 1, NULL, 234, 45, 12, 0, 0, 0, 0, 0, 1, 1, 1, 0, NULL, NULL, NULL, '2025-07-26 17:01:56', '2025-07-26 17:01:56', 0, NULL);
INSERT INTO `tb_post` VALUES (4, 4, '徒步泰山，挑战自我', '凌晨2点开始登山，经过4小时的努力终于登顶看到日出！那一刻所有的疲惫都值得了。泰山不愧是五岳之首，气势磅礴！', '[\"https://example.com/post4_1.jpg\", \"https://example.com/post4_2.jpg\"]', NULL, NULL, '泰山', NULL, 36.2542000, 117.1013000, 5, '[4]', '[\"登山\", \"泰山\", \"日出\", \"挑战\"]', 1, NULL, NULL, NULL, NULL, 1, NULL, 178, 32, 9, 0, 0, 0, 0, 0, 1, 1, 1, 0, NULL, NULL, NULL, '2025-07-26 17:01:56', '2025-07-26 17:01:56', 0, NULL);
INSERT INTO `tb_post` VALUES (5, 5, '春天来了，樱花开了', '今天路过公园，发现樱花已经开始绽放了。粉色的花瓣在春风中轻舞，美得让人心醉。春天真的来了呢～', '[\"https://example.com/post5_1.jpg\"]', NULL, NULL, '玉渊潭公园', NULL, 39.9197000, 116.3230000, 1, '[6]', '[\"樱花\", \"春天\", \"赏花\"]', 1, NULL, NULL, NULL, NULL, 1, NULL, 67, 18, 3, 0, 0, 0, 0, 0, 1, 1, 1, 0, NULL, NULL, NULL, '2025-07-26 17:01:56', '2025-07-26 17:01:56', 0, NULL);

-- ----------------------------
-- Table structure for tb_post_collect
-- ----------------------------
DROP TABLE IF EXISTS `tb_post_collect`;
CREATE TABLE `tb_post_collect`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '收藏ID',
  `post_id` bigint NOT NULL COMMENT '帖子ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '收藏时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_post_user`(`post_id` ASC, `user_id` ASC) USING BTREE,
  INDEX `idx_post_id`(`post_id` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '帖子收藏表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_post_collect
-- ----------------------------

-- ----------------------------
-- Table structure for tb_post_comment
-- ----------------------------
DROP TABLE IF EXISTS `tb_post_comment`;
CREATE TABLE `tb_post_comment`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '评论ID',
  `post_id` bigint NOT NULL COMMENT '帖子ID',
  `user_id` bigint NOT NULL COMMENT '评论用户ID',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父评论ID，0为根评论',
  `reply_user_id` bigint NULL DEFAULT NULL COMMENT '回复的用户ID',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '评论内容',
  `images` json NULL COMMENT '评论图片',
  `like_count` int NULL DEFAULT 0 COMMENT '点赞数',
  `reply_count` int NULL DEFAULT 0 COMMENT '回复数',
  `is_top` tinyint NULL DEFAULT 0 COMMENT '是否置顶：0-否，1-是',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态：0-删除，1-正常，2-审核中',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '评论时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint NULL DEFAULT 0 COMMENT '是否删除：0-否，1-是',
  `delete_time` datetime NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_post_id`(`post_id` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_parent_id`(`parent_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE,
  INDEX `idx_is_deleted`(`is_deleted` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '帖子评论表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_post_comment
-- ----------------------------
INSERT INTO `tb_post_comment` VALUES (1, 1, 2, 0, NULL, '西湖真的很美，特别是夕阳西下的时候！', NULL, 3, 0, 0, 1, '2025-07-26 17:01:56', '2025-07-26 17:01:56', 0, NULL);
INSERT INTO `tb_post_comment` VALUES (2, 1, 3, 0, NULL, '断桥残雪确实很有诗意，下次雪季一定要去看看', NULL, 2, 0, 0, 1, '2025-07-26 17:01:56', '2025-07-26 17:01:56', 0, NULL);
INSERT INTO `tb_post_comment` VALUES (3, 1, 4, 0, NULL, '照片拍得真不错，构图很棒！', NULL, 1, 0, 0, 1, '2025-07-26 17:01:56', '2025-07-26 17:01:56', 0, NULL);
INSERT INTO `tb_post_comment` VALUES (4, 2, 1, 0, NULL, '夜景摄影技巧很实用，学习了！', NULL, 4, 0, 0, 1, '2025-07-26 17:01:56', '2025-07-26 17:01:56', 0, NULL);
INSERT INTO `tb_post_comment` VALUES (5, 2, 3, 0, NULL, '乌镇的夜景确实很迷人，下次也要去拍拍', NULL, 2, 0, 0, 1, '2025-07-26 17:01:56', '2025-07-26 17:01:56', 0, NULL);
INSERT INTO `tb_post_comment` VALUES (6, 3, 1, 0, NULL, '成都火锅真的太香了，看得我都饿了', NULL, 5, 0, 0, 1, '2025-07-26 17:01:56', '2025-07-26 17:01:56', 0, NULL);
INSERT INTO `tb_post_comment` VALUES (7, 3, 2, 0, NULL, '收藏了，下次去成都就按这个攻略吃！', NULL, 3, 0, 0, 1, '2025-07-26 17:01:56', '2025-07-26 17:01:56', 0, NULL);
INSERT INTO `tb_post_comment` VALUES (8, 3, 4, 0, NULL, '那家巷子里的小店在哪里？求具体地址', NULL, 1, 0, 0, 1, '2025-07-26 17:01:56', '2025-07-26 17:01:56', 0, NULL);
INSERT INTO `tb_post_comment` VALUES (9, 4, 2, 0, NULL, '太厉害了，我都不敢想象凌晨爬山', NULL, 2, 0, 0, 1, '2025-07-26 17:01:56', '2025-07-26 17:01:56', 0, NULL);
INSERT INTO `tb_post_comment` VALUES (10, 4, 3, 0, NULL, '泰山日出确实震撼，值得挑战！', NULL, 1, 0, 0, 1, '2025-07-26 17:01:56', '2025-07-26 17:01:56', 0, NULL);
INSERT INTO `tb_post_comment` VALUES (11, 5, 2, 0, NULL, '樱花季到了，赏花走起！', NULL, 1, 0, 0, 1, '2025-07-26 17:01:56', '2025-07-26 17:01:56', 0, NULL);
INSERT INTO `tb_post_comment` VALUES (12, 5, 4, 0, NULL, '粉色樱花真的很治愈呢', NULL, 2, 0, 0, 1, '2025-07-26 17:01:56', '2025-07-26 17:01:56', 0, NULL);

-- ----------------------------
-- Table structure for tb_post_comment_like
-- ----------------------------
DROP TABLE IF EXISTS `tb_post_comment_like`;
CREATE TABLE `tb_post_comment_like`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '点赞ID',
  `comment_id` bigint NOT NULL COMMENT '评论ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '点赞时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_comment_user`(`comment_id` ASC, `user_id` ASC) USING BTREE,
  INDEX `idx_comment_id`(`comment_id` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '帖子评论点赞表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_post_comment_like
-- ----------------------------

-- ----------------------------
-- Table structure for tb_post_like
-- ----------------------------
DROP TABLE IF EXISTS `tb_post_like`;
CREATE TABLE `tb_post_like`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '点赞ID',
  `post_id` bigint NOT NULL COMMENT '帖子ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '点赞时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_post_user`(`post_id` ASC, `user_id` ASC) USING BTREE,
  INDEX `idx_post_id`(`post_id` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '帖子点赞表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_post_like
-- ----------------------------
INSERT INTO `tb_post_like` VALUES (1, 1, 2, '2025-07-26 17:01:56');
INSERT INTO `tb_post_like` VALUES (2, 1, 3, '2025-07-26 17:01:56');
INSERT INTO `tb_post_like` VALUES (3, 1, 4, '2025-07-26 17:01:56');
INSERT INTO `tb_post_like` VALUES (4, 1, 5, '2025-07-26 17:01:56');
INSERT INTO `tb_post_like` VALUES (5, 2, 1, '2025-07-26 17:01:56');
INSERT INTO `tb_post_like` VALUES (6, 2, 3, '2025-07-26 17:01:56');
INSERT INTO `tb_post_like` VALUES (7, 2, 4, '2025-07-26 17:01:56');
INSERT INTO `tb_post_like` VALUES (8, 3, 1, '2025-07-26 17:01:56');
INSERT INTO `tb_post_like` VALUES (9, 3, 2, '2025-07-26 17:01:56');
INSERT INTO `tb_post_like` VALUES (10, 3, 4, '2025-07-26 17:01:56');
INSERT INTO `tb_post_like` VALUES (11, 3, 5, '2025-07-26 17:01:56');
INSERT INTO `tb_post_like` VALUES (12, 4, 1, '2025-07-26 17:01:56');
INSERT INTO `tb_post_like` VALUES (13, 4, 2, '2025-07-26 17:01:56');
INSERT INTO `tb_post_like` VALUES (14, 4, 3, '2025-07-26 17:01:56');
INSERT INTO `tb_post_like` VALUES (15, 4, 5, '2025-07-26 17:01:56');
INSERT INTO `tb_post_like` VALUES (16, 5, 1, '2025-07-26 17:01:56');
INSERT INTO `tb_post_like` VALUES (17, 5, 2, '2025-07-26 17:01:56');
INSERT INTO `tb_post_like` VALUES (18, 5, 3, '2025-07-26 17:01:56');
INSERT INTO `tb_post_like` VALUES (19, 5, 4, '2025-07-26 17:01:56');

-- ----------------------------
-- Table structure for tb_post_share
-- ----------------------------
DROP TABLE IF EXISTS `tb_post_share`;
CREATE TABLE `tb_post_share`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '分享记录ID',
  `post_id` bigint NOT NULL COMMENT '帖子ID',
  `user_id` bigint NOT NULL COMMENT '分享用户ID',
  `share_platform` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '分享平台：wechat,weibo,qq,link',
  `share_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '分享时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_post_id`(`post_id` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_share_platform`(`share_platform` ASC) USING BTREE,
  INDEX `idx_share_time`(`share_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '帖子分享记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_post_share
-- ----------------------------

-- ----------------------------
-- Table structure for tb_post_topic
-- ----------------------------
DROP TABLE IF EXISTS `tb_post_topic`;
CREATE TABLE `tb_post_topic`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '关联ID',
  `post_id` bigint NOT NULL COMMENT '帖子ID',
  `topic_id` bigint NOT NULL COMMENT '话题ID',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_post_topic`(`post_id` ASC, `topic_id` ASC) USING BTREE,
  INDEX `idx_post_id`(`post_id` ASC) USING BTREE,
  INDEX `idx_topic_id`(`topic_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '帖子话题关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_post_topic
-- ----------------------------
INSERT INTO `tb_post_topic` VALUES (1, 1, 1, '2025-07-26 17:01:56');
INSERT INTO `tb_post_topic` VALUES (2, 1, 6, '2025-07-26 17:01:56');
INSERT INTO `tb_post_topic` VALUES (3, 2, 3, '2025-07-26 17:01:56');
INSERT INTO `tb_post_topic` VALUES (4, 2, 5, '2025-07-26 17:01:56');
INSERT INTO `tb_post_topic` VALUES (5, 3, 2, '2025-07-26 17:01:56');
INSERT INTO `tb_post_topic` VALUES (6, 4, 4, '2025-07-26 17:01:56');
INSERT INTO `tb_post_topic` VALUES (7, 5, 6, '2025-07-26 17:01:56');

-- ----------------------------
-- Table structure for tb_post_view
-- ----------------------------
DROP TABLE IF EXISTS `tb_post_view`;
CREATE TABLE `tb_post_view`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '浏览记录ID',
  `post_id` bigint NOT NULL COMMENT '帖子ID',
  `user_id` bigint NULL DEFAULT NULL COMMENT '用户ID，未登录用户为NULL',
  `ip_address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'IP地址',
  `user_agent` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户代理',
  `view_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '浏览时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_post_id`(`post_id` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_view_time`(`view_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '帖子浏览记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_post_view
-- ----------------------------

-- ----------------------------
-- Table structure for tb_push_record
-- ----------------------------
DROP TABLE IF EXISTS `tb_push_record`;
CREATE TABLE `tb_push_record`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '推送记录ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `device_token` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '设备令牌',
  `platform` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '推送平台：ios,android,wechat',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '推送标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '推送内容',
  `badge` int NULL DEFAULT 0 COMMENT '角标数量',
  `sound` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'default' COMMENT '提示音',
  `extra_data` json NULL COMMENT '扩展数据',
  `push_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '推送时间',
  `status` tinyint NULL DEFAULT 0 COMMENT '推送状态：0-待推送，1-推送成功，2-推送失败',
  `result_message` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '推送结果消息',
  `retry_count` int NULL DEFAULT 0 COMMENT '重试次数',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_platform`(`platform` ASC) USING BTREE,
  INDEX `idx_push_time`(`push_time` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '消息推送记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_push_record
-- ----------------------------

-- ----------------------------
-- Table structure for tb_region
-- ----------------------------
DROP TABLE IF EXISTS `tb_region`;
CREATE TABLE `tb_region`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '地区ID',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父级ID，0为根级',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '地区名称',
  `name_en` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '英文名称',
  `code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '地区编码',
  `level` tinyint NOT NULL COMMENT '层级：1-国家，2-省/州，3-市，4-区县',
  `latitude` decimal(10, 7) NULL DEFAULT NULL COMMENT '纬度',
  `longitude` decimal(10, 7) NULL DEFAULT NULL COMMENT '经度',
  `is_hot` tinyint NULL DEFAULT 0 COMMENT '是否热门：0-否，1-是',
  `sort_order` int NULL DEFAULT 0 COMMENT '排序',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态：0-禁用，1-启用',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_parent_id`(`parent_id` ASC) USING BTREE,
  INDEX `idx_level`(`level` ASC) USING BTREE,
  INDEX `idx_is_hot`(`is_hot` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_sort_order`(`sort_order` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '地区表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_region
-- ----------------------------
INSERT INTO `tb_region` VALUES (1, 0, '中国', 'China', 'CN', 1, 35.0000000, 105.0000000, 1, 1, 1, '2025-07-26 17:01:08', '2025-07-26 17:01:08');
INSERT INTO `tb_region` VALUES (2, 0, '美国', 'United States', 'US', 1, 39.0000000, -98.0000000, 1, 2, 1, '2025-07-26 17:01:08', '2025-07-26 17:01:08');
INSERT INTO `tb_region` VALUES (3, 0, '日本', 'Japan', 'JP', 1, 36.0000000, 138.0000000, 1, 3, 1, '2025-07-26 17:01:08', '2025-07-26 17:01:08');
INSERT INTO `tb_region` VALUES (4, 1, '北京市', 'Beijing', '110000', 2, 39.9041999, 116.4073963, 1, 1, 1, '2025-07-26 17:01:08', '2025-07-26 17:01:08');
INSERT INTO `tb_region` VALUES (5, 1, '上海市', 'Shanghai', '310000', 2, 31.2303904, 121.4737021, 1, 2, 1, '2025-07-26 17:01:08', '2025-07-26 17:01:08');
INSERT INTO `tb_region` VALUES (6, 1, '广东省', 'Guangdong', '440000', 2, 23.3790333, 113.7632828, 1, 3, 1, '2025-07-26 17:01:08', '2025-07-26 17:01:08');
INSERT INTO `tb_region` VALUES (7, 1, '浙江省', 'Zhejiang', '330000', 2, 30.2873928, 120.1537746, 1, 4, 1, '2025-07-26 17:01:08', '2025-07-26 17:01:08');
INSERT INTO `tb_region` VALUES (8, 1, '江苏省', 'Jiangsu', '320000', 2, 32.0609736, 118.7916458, 1, 5, 1, '2025-07-26 17:01:08', '2025-07-26 17:01:08');
INSERT INTO `tb_region` VALUES (9, 1, '四川省', 'Sichuan', '510000', 2, 30.6170216, 104.0648438, 1, 6, 1, '2025-07-26 17:01:08', '2025-07-26 17:01:08');

-- ----------------------------
-- Table structure for tb_report
-- ----------------------------
DROP TABLE IF EXISTS `tb_report`;
CREATE TABLE `tb_report`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '举报ID',
  `reporter_id` bigint NOT NULL COMMENT '举报人ID',
  `target_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '举报类型：post,comment,user,activity',
  `target_id` bigint NOT NULL COMMENT '举报对象ID',
  `target_user_id` bigint NULL DEFAULT NULL COMMENT '被举报用户ID',
  `reason` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '举报原因',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '详细描述',
  `images` json NULL COMMENT '举报截图',
  `status` tinyint NULL DEFAULT 0 COMMENT '处理状态：0-待处理，1-已处理，2-已驳回',
  `handle_result` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '处理结果',
  `handle_time` datetime NULL DEFAULT NULL COMMENT '处理时间',
  `handle_user_id` bigint NULL DEFAULT NULL COMMENT '处理人ID',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '举报时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_reporter_id`(`reporter_id` ASC) USING BTREE,
  INDEX `idx_target_type`(`target_type` ASC) USING BTREE,
  INDEX `idx_target_id`(`target_id` ASC) USING BTREE,
  INDEX `idx_target_user_id`(`target_user_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '举报记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_report
-- ----------------------------

-- ----------------------------
-- Table structure for tb_system_config
-- ----------------------------
DROP TABLE IF EXISTS `tb_system_config`;
CREATE TABLE `tb_system_config`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '配置ID',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '配置键',
  `config_value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '配置值',
  `config_desc` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '配置描述',
  `config_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'string' COMMENT '配置类型：string,number,boolean,json',
  `is_system` tinyint NULL DEFAULT 0 COMMENT '是否系统配置：0-否，1-是',
  `sort_order` int NULL DEFAULT 0 COMMENT '排序',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态：0-禁用，1-启用',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_config_key`(`config_key` ASC) USING BTREE,
  INDEX `idx_is_system`(`is_system` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '系统配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_system_config
-- ----------------------------
INSERT INTO `tb_system_config` VALUES (1, 'app_name', '潮游', '应用名称', 'string', 1, 0, 1, '2025-07-26 17:01:08', '2025-07-26 17:01:08');
INSERT INTO `tb_system_config` VALUES (2, 'app_version', '1.0.0', '应用版本', 'string', 1, 0, 1, '2025-07-26 17:01:08', '2025-07-26 17:01:08');
INSERT INTO `tb_system_config` VALUES (3, 'app_logo', '', '应用Logo', 'string', 1, 0, 1, '2025-07-26 17:01:08', '2025-07-26 17:01:08');
INSERT INTO `tb_system_config` VALUES (4, 'user_default_avatar', '', '用户默认头像', 'string', 1, 0, 1, '2025-07-26 17:01:08', '2025-07-26 17:01:08');
INSERT INTO `tb_system_config` VALUES (5, 'user_init_points', '100', '用户初始积分', 'number', 1, 0, 1, '2025-07-26 17:01:08', '2025-07-26 17:01:08');
INSERT INTO `tb_system_config` VALUES (6, 'post_max_images', '9', '帖子最大图片数', 'number', 1, 0, 1, '2025-07-26 17:01:08', '2025-07-26 17:01:08');
INSERT INTO `tb_system_config` VALUES (7, 'comment_max_length', '500', '评论最大长度', 'number', 1, 0, 1, '2025-07-26 17:01:08', '2025-07-26 17:01:08');
INSERT INTO `tb_system_config` VALUES (8, 'upload_max_size', '10485760', '上传文件最大大小（字节）', 'number', 1, 0, 1, '2025-07-26 17:01:08', '2025-07-26 17:01:08');
INSERT INTO `tb_system_config` VALUES (9, 'upload_allowed_types', 'jpg,jpeg,png,gif,mp4,mov', '允许上传的文件类型', 'string', 1, 0, 1, '2025-07-26 17:01:08', '2025-07-26 17:01:08');

-- ----------------------------
-- Table structure for tb_system_notification
-- ----------------------------
DROP TABLE IF EXISTS `tb_system_notification`;
CREATE TABLE `tb_system_notification`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '通知ID',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '通知标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '通知内容',
  `cover_image` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '封面图片',
  `notification_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'system' COMMENT '通知类型：system,activity,promotion,update',
  `target_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'all' COMMENT '目标类型：all,user,role,region',
  `target_ids` json NULL COMMENT '目标ID集合',
  `link_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '链接类型：page,url,activity,post',
  `link_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '链接值',
  `send_type` tinyint NULL DEFAULT 1 COMMENT '发送方式：1-立即发送，2-定时发送',
  `send_time` datetime NULL DEFAULT NULL COMMENT '发送时间',
  `is_top` tinyint NULL DEFAULT 0 COMMENT '是否置顶：0-否，1-是',
  `priority` tinyint NULL DEFAULT 1 COMMENT '优先级：1-低，2-中，3-高',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态：0-草稿，1-已发送，2-已撤回',
  `read_count` int NULL DEFAULT 0 COMMENT '已读人数',
  `total_count` int NULL DEFAULT 0 COMMENT '总发送人数',
  `creator_id` bigint NOT NULL COMMENT '创建者ID',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_notification_type`(`notification_type` ASC) USING BTREE,
  INDEX `idx_target_type`(`target_type` ASC) USING BTREE,
  INDEX `idx_send_time`(`send_time` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '系统通知表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_system_notification
-- ----------------------------
INSERT INTO `tb_system_notification` VALUES (1, '欢迎使用潮游APP', '欢迎加入潮游大家庭！在这里你可以分享旅行经历，发现有趣的活动，结交志同道合的朋友。快来开启你的潮流旅行之旅吧！', NULL, 'system', 'all', NULL, NULL, NULL, 1, '2025-07-26 17:03:42', 0, 1, 1, 0, 0, 1, '2025-07-26 17:03:42', '2025-07-26 17:03:42');
INSERT INTO `tb_system_notification` VALUES (2, '春季活动上线啦', '春暖花开，正是出游好时节！我们为大家准备了丰富的春季活动，包括赏花、踏青、摄影等主题。快来参加吧！', NULL, 'activity', 'all', NULL, NULL, NULL, 1, '2025-07-26 17:03:42', 0, 1, 1, 0, 0, 1, '2025-07-26 17:03:42', '2025-07-26 17:03:42');
INSERT INTO `tb_system_notification` VALUES (3, '社区规范提醒', '为了维护良好的社区环境，请大家遵守社区规范，发布积极正面的内容，共同营造和谐的交流氛围。', NULL, 'system', 'all', NULL, NULL, NULL, 1, '2025-07-26 17:03:42', 0, 1, 1, 0, 0, 1, '2025-07-26 17:03:42', '2025-07-26 17:03:42');

-- ----------------------------
-- Table structure for tb_tag
-- ----------------------------
DROP TABLE IF EXISTS `tb_tag`;
CREATE TABLE `tb_tag`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '标签ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '标签名称',
  `color` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '#1890ff' COMMENT '标签颜色',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '标签图标',
  `description` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '标签描述',
  `category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'general' COMMENT '标签分类：general,travel,food,hotel,transport',
  `use_count` int NULL DEFAULT 0 COMMENT '使用次数',
  `is_hot` tinyint NULL DEFAULT 0 COMMENT '是否热门：0-否，1-是',
  `sort_order` int NULL DEFAULT 0 COMMENT '排序',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态：0-禁用，1-启用',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_name`(`name` ASC) USING BTREE,
  INDEX `idx_category`(`category` ASC) USING BTREE,
  INDEX `idx_is_hot`(`is_hot` ASC) USING BTREE,
  INDEX `idx_use_count`(`use_count` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '标签表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_tag
-- ----------------------------
INSERT INTO `tb_tag` VALUES (1, '旅行', '#ff4d4f', NULL, '旅行相关内容', 'travel', 0, 1, 1, 1, '2025-07-26 17:01:08', '2025-07-26 17:01:08');
INSERT INTO `tb_tag` VALUES (2, '美食', '#fa8c16', NULL, '美食分享', 'food', 0, 1, 2, 1, '2025-07-26 17:01:08', '2025-07-26 17:01:08');
INSERT INTO `tb_tag` VALUES (3, '酒店', '#1890ff', NULL, '住宿推荐', 'hotel', 0, 1, 3, 1, '2025-07-26 17:01:08', '2025-07-26 17:01:08');
INSERT INTO `tb_tag` VALUES (4, '交通', '#52c41a', NULL, '交通出行', 'transport', 0, 1, 4, 1, '2025-07-26 17:01:08', '2025-07-26 17:01:08');
INSERT INTO `tb_tag` VALUES (5, '攻略', '#722ed1', NULL, '旅行攻略', 'travel', 0, 1, 5, 1, '2025-07-26 17:01:08', '2025-07-26 17:01:08');
INSERT INTO `tb_tag` VALUES (6, '风景', '#13c2c2', NULL, '风景摄影', 'travel', 0, 1, 6, 1, '2025-07-26 17:01:08', '2025-07-26 17:01:08');
INSERT INTO `tb_tag` VALUES (7, '人文', '#eb2f96', NULL, '人文历史', 'travel', 0, 1, 7, 1, '2025-07-26 17:01:08', '2025-07-26 17:01:08');
INSERT INTO `tb_tag` VALUES (8, '购物', '#fa541c', NULL, '购物分享', 'general', 0, 0, 8, 1, '2025-07-26 17:01:08', '2025-07-26 17:01:08');
INSERT INTO `tb_tag` VALUES (9, '摄影', '#2f54eb', NULL, '摄影技巧', 'general', 0, 0, 9, 1, '2025-07-26 17:01:08', '2025-07-26 17:01:08');
INSERT INTO `tb_tag` VALUES (10, '民宿', '#52c41a', NULL, '民宿推荐', 'hotel', 0, 0, 10, 1, '2025-07-26 17:01:08', '2025-07-26 17:01:08');

-- ----------------------------
-- Table structure for tb_topic
-- ----------------------------
DROP TABLE IF EXISTS `tb_topic`;
CREATE TABLE `tb_topic`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '话题ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '话题名称',
  `description` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '话题描述',
  `cover_image` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '话题封面图',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '话题图标',
  `color` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '#1890ff' COMMENT '话题颜色',
  `category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'general' COMMENT '话题分类：travel,food,culture,outdoor,photography',
  `posts_count` int NULL DEFAULT 0 COMMENT '帖子数量',
  `followers_count` int NULL DEFAULT 0 COMMENT '关注数量',
  `is_hot` tinyint NULL DEFAULT 0 COMMENT '是否热门：0-否，1-是',
  `is_official` tinyint NULL DEFAULT 0 COMMENT '是否官方话题：0-否，1-是',
  `sort_order` int NULL DEFAULT 0 COMMENT '排序',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态：0-禁用，1-启用',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_name`(`name` ASC) USING BTREE,
  INDEX `idx_category`(`category` ASC) USING BTREE,
  INDEX `idx_is_hot`(`is_hot` ASC) USING BTREE,
  INDEX `idx_is_official`(`is_official` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_posts_count`(`posts_count` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '话题表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_topic
-- ----------------------------
INSERT INTO `tb_topic` VALUES (1, '潮游分享', '分享你的潮流旅行体验', NULL, NULL, '#ff4d4f', 'travel', 1, 0, 1, 1, 1, 1, '2025-07-26 17:01:24', '2025-07-26 17:03:42');
INSERT INTO `tb_topic` VALUES (2, '美食探店', '发现城市里的美味', NULL, NULL, '#fa8c16', 'food', 1, 0, 1, 1, 2, 1, '2025-07-26 17:01:24', '2025-07-26 17:03:42');
INSERT INTO `tb_topic` VALUES (3, '风景摄影', '用镜头记录美好瞬间', NULL, NULL, '#1890ff', 'photography', 1, 0, 1, 1, 3, 1, '2025-07-26 17:01:24', '2025-07-26 17:03:42');
INSERT INTO `tb_topic` VALUES (4, '户外徒步', '徒步旅行经验分享', NULL, NULL, '#52c41a', 'outdoor', 1, 0, 1, 1, 4, 1, '2025-07-26 17:01:24', '2025-07-26 17:03:42');
INSERT INTO `tb_topic` VALUES (5, '古镇漫游', '探索古镇的文化魅力', NULL, NULL, '#722ed1', 'culture', 1, 0, 1, 1, 5, 1, '2025-07-26 17:01:24', '2025-07-26 17:03:42');
INSERT INTO `tb_topic` VALUES (6, '民宿体验', '特色民宿住宿分享', NULL, NULL, '#13c2c2', 'travel', 2, 0, 1, 1, 6, 1, '2025-07-26 17:01:24', '2025-07-26 17:03:42');
INSERT INTO `tb_topic` VALUES (7, '自驾游', '自驾旅行路线推荐', NULL, NULL, '#eb2f96', 'travel', 0, 0, 1, 1, 7, 1, '2025-07-26 17:01:24', '2025-07-26 17:01:24');
INSERT INTO `tb_topic` VALUES (8, '背包客', '背包旅行攻略分享', NULL, NULL, '#fa541c', 'travel', 0, 0, 1, 1, 8, 1, '2025-07-26 17:01:24', '2025-07-26 17:01:24');
INSERT INTO `tb_topic` VALUES (9, '城市漫步', '城市探索与发现', NULL, NULL, '#2f54eb', 'travel', 0, 0, 0, 0, 9, 1, '2025-07-26 17:01:24', '2025-07-26 17:01:24');
INSERT INTO `tb_topic` VALUES (10, '旅行装备', '旅行装备推荐与评测', NULL, NULL, '#52c41a', 'general', 0, 0, 0, 0, 10, 1, '2025-07-26 17:01:24', '2025-07-26 17:01:24');

-- ----------------------------
-- Table structure for tb_topic_follow
-- ----------------------------
DROP TABLE IF EXISTS `tb_topic_follow`;
CREATE TABLE `tb_topic_follow`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '关注ID',
  `topic_id` bigint NOT NULL COMMENT '话题ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '关注时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_topic_user`(`topic_id` ASC, `user_id` ASC) USING BTREE,
  INDEX `idx_topic_id`(`topic_id` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '话题关注表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_topic_follow
-- ----------------------------

-- ----------------------------
-- Table structure for tb_user
-- ----------------------------
DROP TABLE IF EXISTS `tb_user`;
CREATE TABLE `tb_user`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '昵称',
  `real_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '真实姓名',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '手机号',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  `avatar` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '头像URL',
  `gender` tinyint NULL DEFAULT 0 COMMENT '性别：0-未知，1-男，2-女',
  `birthday` date NULL DEFAULT NULL COMMENT '生日',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密码（加密）',
  `salt` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密码盐值',
  `wechat_openid` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '微信OpenID',
  `wechat_unionid` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '微信UnionID',
  `qq_openid` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'QQ OpenID',
  `level` int NULL DEFAULT 1 COMMENT '用户等级',
  `experience` int NULL DEFAULT 0 COMMENT '经验值',
  `points` int NULL DEFAULT 0 COMMENT '积分',
  `travel_days` int NULL DEFAULT 0 COMMENT '旅行天数',
  `travel_cities` int NULL DEFAULT 0 COMMENT '到过城市数',
  `travel_countries` int NULL DEFAULT 0 COMMENT '到过国家数',
  `followers_count` int NULL DEFAULT 0 COMMENT '粉丝数',
  `following_count` int NULL DEFAULT 0 COMMENT '关注数',
  `posts_count` int NULL DEFAULT 0 COMMENT '发帖数',
  `likes_count` int NULL DEFAULT 0 COMMENT '获赞数',
  `signature` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '个性签名',
  `location` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '所在地',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态：0-禁用，1-正常，2-审核中',
  `is_verified` tinyint NULL DEFAULT 0 COMMENT '是否认证：0-否，1-是',
  `verified_type` tinyint NULL DEFAULT 0 COMMENT '认证类型：0-无，1-个人，2-企业，3-官方',
  `last_login_time` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `last_login_ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '最后登录IP',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建人',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新人',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint NULL DEFAULT 0 COMMENT '是否删除：0-否，1-是',
  `delete_time` datetime NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_username`(`username` ASC) USING BTREE,
  UNIQUE INDEX `uk_phone`(`phone` ASC) USING BTREE,
  UNIQUE INDEX `uk_email`(`email` ASC) USING BTREE,
  UNIQUE INDEX `uk_wechat_openid`(`wechat_openid` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_level`(`level` ASC) USING BTREE,
  INDEX `idx_is_deleted`(`is_deleted` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户基础表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_user
-- ----------------------------
INSERT INTO `tb_user` VALUES (10, 'Mars', 'Mars', NULL, NULL, NULL, 'https://chaoyou-image.oss-cn-beijing.aliyuncs.com/upload/2025/07/27/4ef5fbbf47e242b28a23e1f9f662aa12.jpeg', 0, NULL, NULL, NULL, 'opzUF43XlvnVUw5S9qS2cI6L7p9M', NULL, NULL, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 1, 0, 0, '2025-07-27 21:45:09', NULL, 9, 10, '2025-07-27 10:47:58', '2025-07-27 21:45:29', 0, NULL);
INSERT INTO `tb_user` VALUES (11, 'lisi', 'lisi', NULL, NULL, NULL, 'https://chaoyou-image.oss-cn-beijing.aliyuncs.com/upload/2025/07/27/4ef5fbbf47e242b28a23e1f9f662aa12.jpeg', 0, NULL, '123456', NULL, 'opzUF43XlvnVUw5S9qS2cI6L7p92', NULL, NULL, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 1, 0, 0, '2025-07-27 16:34:51', NULL, 9, 10, '2025-07-27 10:47:58', '2025-07-27 17:07:14', 0, NULL);
INSERT INTO `tb_user` VALUES (12, 'mars666', NULL, NULL, '18483678377', '', NULL, NULL, NULL, '$2a$10$EMM9IYUgQiQstR.3mWq6iuHyy3WZ5BJAIopr8gjk59DWhN.or/0r.', '3e89236131004290b80c098b4c5eb33f', NULL, NULL, NULL, 1, 0, 100, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 1, 0, 0, '2025-07-27 21:15:55', NULL, NULL, 12, '2025-07-27 20:56:31', '2025-07-27 22:14:21', 0, NULL);

-- ----------------------------
-- Table structure for tb_user_collection
-- ----------------------------
DROP TABLE IF EXISTS `tb_user_collection`;
CREATE TABLE `tb_user_collection`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '收藏ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `folder_id` bigint NULL DEFAULT 0 COMMENT '收藏夹ID，0为默认收藏夹',
  `object_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '收藏类型：post,activity,user',
  `object_id` bigint NOT NULL COMMENT '收藏对象ID',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '收藏时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_user_object`(`user_id` ASC, `object_type` ASC, `object_id` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_folder_id`(`folder_id` ASC) USING BTREE,
  INDEX `idx_object_type`(`object_type` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户收藏表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_user_collection
-- ----------------------------

-- ----------------------------
-- Table structure for tb_user_device
-- ----------------------------
DROP TABLE IF EXISTS `tb_user_device`;
CREATE TABLE `tb_user_device`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '设备ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `device_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '设备唯一标识',
  `device_token` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '推送令牌',
  `platform` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '平台：ios,android,wechat,web',
  `device_model` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '设备型号',
  `system_version` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '系统版本',
  `app_version` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'APP版本',
  `is_active` tinyint NULL DEFAULT 1 COMMENT '是否活跃：0-否，1-是',
  `last_active_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后活跃时间',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_user_device`(`user_id` ASC, `device_id` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_platform`(`platform` ASC) USING BTREE,
  INDEX `idx_is_active`(`is_active` ASC) USING BTREE,
  INDEX `idx_last_active_time`(`last_active_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户设备表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_user_device
-- ----------------------------

-- ----------------------------
-- Table structure for tb_user_feed
-- ----------------------------
DROP TABLE IF EXISTS `tb_user_feed`;
CREATE TABLE `tb_user_feed`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '动态ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `target_user_id` bigint NULL DEFAULT NULL COMMENT '目标用户ID',
  `object_id` bigint NOT NULL COMMENT '对象ID（帖子ID、活动ID等）',
  `object_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '对象类型：post,activity,comment,like,follow',
  `action_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '动作类型：publish,like,comment,share,follow,join',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '动态内容',
  `extra_data` json NULL COMMENT '额外数据',
  `is_public` tinyint NULL DEFAULT 1 COMMENT '是否公开：0-私密，1-公开',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_target_user_id`(`target_user_id` ASC) USING BTREE,
  INDEX `idx_object_type`(`object_type` ASC) USING BTREE,
  INDEX `idx_action_type`(`action_type` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户动态表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_user_feed
-- ----------------------------

-- ----------------------------
-- Table structure for tb_user_follow
-- ----------------------------
DROP TABLE IF EXISTS `tb_user_follow`;
CREATE TABLE `tb_user_follow`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` bigint NOT NULL COMMENT '关注者用户ID',
  `follow_user_id` bigint NOT NULL COMMENT '被关注者用户ID',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态：0-取消关注，1-关注中',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '关注时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_user_follow`(`user_id` ASC, `follow_user_id` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_follow_user_id`(`follow_user_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户关注关系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_user_follow
-- ----------------------------
INSERT INTO `tb_user_follow` VALUES (1, 1, 2, 1, '2025-07-26 17:01:56', '2025-07-26 17:01:56');
INSERT INTO `tb_user_follow` VALUES (2, 1, 3, 1, '2025-07-26 17:01:56', '2025-07-26 17:01:56');
INSERT INTO `tb_user_follow` VALUES (3, 1, 4, 1, '2025-07-26 17:01:56', '2025-07-26 17:01:56');
INSERT INTO `tb_user_follow` VALUES (4, 2, 1, 1, '2025-07-26 17:01:56', '2025-07-26 17:01:56');
INSERT INTO `tb_user_follow` VALUES (5, 2, 3, 1, '2025-07-26 17:01:56', '2025-07-26 17:01:56');
INSERT INTO `tb_user_follow` VALUES (6, 2, 5, 1, '2025-07-26 17:01:56', '2025-07-26 17:01:56');
INSERT INTO `tb_user_follow` VALUES (7, 3, 1, 1, '2025-07-26 17:01:56', '2025-07-26 17:01:56');
INSERT INTO `tb_user_follow` VALUES (8, 3, 2, 1, '2025-07-26 17:01:56', '2025-07-26 17:01:56');
INSERT INTO `tb_user_follow` VALUES (9, 3, 4, 1, '2025-07-26 17:01:56', '2025-07-26 17:01:56');
INSERT INTO `tb_user_follow` VALUES (10, 3, 5, 1, '2025-07-26 17:01:56', '2025-07-26 17:01:56');
INSERT INTO `tb_user_follow` VALUES (11, 4, 1, 1, '2025-07-26 17:01:56', '2025-07-26 17:01:56');
INSERT INTO `tb_user_follow` VALUES (12, 4, 2, 1, '2025-07-26 17:01:56', '2025-07-26 17:01:56');
INSERT INTO `tb_user_follow` VALUES (13, 4, 3, 1, '2025-07-26 17:01:56', '2025-07-26 17:01:56');
INSERT INTO `tb_user_follow` VALUES (14, 5, 1, 1, '2025-07-26 17:01:56', '2025-07-26 17:01:56');
INSERT INTO `tb_user_follow` VALUES (15, 5, 2, 1, '2025-07-26 17:01:56', '2025-07-26 17:01:56');
INSERT INTO `tb_user_follow` VALUES (16, 5, 3, 1, '2025-07-26 17:01:56', '2025-07-26 17:01:56');
INSERT INTO `tb_user_follow` VALUES (17, 5, 4, 1, '2025-07-26 17:01:56', '2025-07-26 17:01:56');

-- ----------------------------
-- Table structure for tb_user_footprint
-- ----------------------------
DROP TABLE IF EXISTS `tb_user_footprint`;
CREATE TABLE `tb_user_footprint`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '足迹ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `region_id` bigint NOT NULL COMMENT '地区ID',
  `visit_date` date NOT NULL COMMENT '到访日期',
  `location_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '具体位置名称',
  `latitude` decimal(10, 7) NULL DEFAULT NULL COMMENT '纬度',
  `longitude` decimal(10, 7) NULL DEFAULT NULL COMMENT '经度',
  `photos` json NULL COMMENT '照片集合',
  `notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '足迹备注',
  `is_public` tinyint NULL DEFAULT 1 COMMENT '是否公开：0-私密，1-公开',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_region_id`(`region_id` ASC) USING BTREE,
  INDEX `idx_visit_date`(`visit_date` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户足迹表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_user_footprint
-- ----------------------------
INSERT INTO `tb_user_footprint` VALUES (1, 1, 4, '2024-12-15', '杭州西湖', NULL, NULL, '[\"https://example.com/footprint1.jpg\"]', '西湖美景让人流连忘返', 1, '2025-07-26 17:03:42', '2025-07-26 17:03:42');
INSERT INTO `tb_user_footprint` VALUES (2, 1, 1, '2024-12-20', '北京故宫', NULL, NULL, '[\"https://example.com/footprint2.jpg\"]', '感受历史文化的厚重', 1, '2025-07-26 17:03:42', '2025-07-26 17:03:42');
INSERT INTO `tb_user_footprint` VALUES (3, 2, 4, '2024-12-10', '乌镇古镇', NULL, NULL, '[\"https://example.com/footprint3.jpg\"]', '古镇夜景很适合摄影', 1, '2025-07-26 17:03:42', '2025-07-26 17:03:42');
INSERT INTO `tb_user_footprint` VALUES (4, 3, 6, '2024-12-25', '成都宽窄巷子', NULL, NULL, '[\"https://example.com/footprint4.jpg\"]', '成都美食文化体验', 1, '2025-07-26 17:03:42', '2025-07-26 17:03:42');
INSERT INTO `tb_user_footprint` VALUES (5, 4, 5, '2025-01-01', '泰山', NULL, NULL, '[\"https://example.com/footprint5.jpg\"]', '新年第一天登泰山看日出', 1, '2025-07-26 17:03:42', '2025-07-26 17:03:42');

-- ----------------------------
-- Table structure for tb_user_level
-- ----------------------------
DROP TABLE IF EXISTS `tb_user_level`;
CREATE TABLE `tb_user_level`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '等级ID',
  `level` int NOT NULL COMMENT '等级数值',
  `level_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '等级名称',
  `min_experience` int NOT NULL COMMENT '最小经验值',
  `max_experience` int NOT NULL COMMENT '最大经验值',
  `level_icon` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '等级图标',
  `level_color` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '#1890ff' COMMENT '等级颜色',
  `privileges` json NULL COMMENT '等级特权',
  `description` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '等级描述',
  `is_active` tinyint NULL DEFAULT 1 COMMENT '是否启用：0-否，1-是',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_level`(`level` ASC) USING BTREE,
  INDEX `idx_min_experience`(`min_experience` ASC) USING BTREE,
  INDEX `idx_is_active`(`is_active` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户等级表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_user_level
-- ----------------------------
INSERT INTO `tb_user_level` VALUES (1, 1, '新手旅行者', 0, 99, NULL, '#52c41a', NULL, '刚开始旅行的新手', 1, '2025-07-26 17:01:33', '2025-07-26 17:01:33');
INSERT INTO `tb_user_level` VALUES (2, 2, '探索者', 100, 299, NULL, '#1890ff', NULL, '开始探索世界的旅行者', 1, '2025-07-26 17:01:33', '2025-07-26 17:01:33');
INSERT INTO `tb_user_level` VALUES (3, 3, '资深驴友', 300, 599, NULL, '#722ed1', NULL, '经验丰富的旅行达人', 1, '2025-07-26 17:01:33', '2025-07-26 17:01:33');
INSERT INTO `tb_user_level` VALUES (4, 4, '旅行专家', 600, 999, NULL, '#fa8c16', NULL, '旅行经验非常丰富', 1, '2025-07-26 17:01:33', '2025-07-26 17:01:33');
INSERT INTO `tb_user_level` VALUES (5, 5, '环球旅行家', 1000, 1999, NULL, '#eb2f96', NULL, '走遍世界的旅行家', 1, '2025-07-26 17:01:33', '2025-07-26 17:01:33');
INSERT INTO `tb_user_level` VALUES (6, 6, '旅行大师', 2000, 3999, NULL, '#f5222d', NULL, '旅行界的大师级人物', 1, '2025-07-26 17:01:33', '2025-07-26 17:01:33');
INSERT INTO `tb_user_level` VALUES (7, 7, '传奇旅者', 4000, 7999, NULL, '#fa541c', NULL, '传奇级别的旅行者', 1, '2025-07-26 17:01:33', '2025-07-26 17:01:33');
INSERT INTO `tb_user_level` VALUES (8, 8, '世界行者', 8000, 15999, NULL, '#13c2c2', NULL, '行走世界的传奇人物', 1, '2025-07-26 17:01:33', '2025-07-26 17:01:33');
INSERT INTO `tb_user_level` VALUES (9, 9, '旅行之神', 16000, 31999, NULL, '#2f54eb', NULL, '旅行界的神级人物', 1, '2025-07-26 17:01:33', '2025-07-26 17:01:33');
INSERT INTO `tb_user_level` VALUES (10, 10, '无界行者', 32000, 999999, NULL, '#000000', NULL, '超越一切界限的行者', 1, '2025-07-26 17:01:33', '2025-07-26 17:01:33');

-- ----------------------------
-- Table structure for tb_user_message_setting
-- ----------------------------
DROP TABLE IF EXISTS `tb_user_message_setting`;
CREATE TABLE `tb_user_message_setting`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '设置ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `setting_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '设置类型：like,comment,follow,activity,system,chat',
  `push_enabled` tinyint NULL DEFAULT 1 COMMENT '推送开关：0-关闭，1-开启',
  `sound_enabled` tinyint NULL DEFAULT 1 COMMENT '声音开关：0-关闭，1-开启',
  `vibrate_enabled` tinyint NULL DEFAULT 1 COMMENT '震动开关：0-关闭，1-开启',
  `time_start` time NULL DEFAULT '08:00:00' COMMENT '免打扰开始时间',
  `time_end` time NULL DEFAULT '22:00:00' COMMENT '免打扰结束时间',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_user_setting`(`user_id` ASC, `setting_type` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户消息设置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_user_message_setting
-- ----------------------------
INSERT INTO `tb_user_message_setting` VALUES (1, 0, 'like', 1, 1, 1, '08:00:00', '22:00:00', '2025-07-26 17:01:28', '2025-07-26 17:01:28');
INSERT INTO `tb_user_message_setting` VALUES (2, 0, 'comment', 1, 1, 1, '08:00:00', '22:00:00', '2025-07-26 17:01:28', '2025-07-26 17:01:28');
INSERT INTO `tb_user_message_setting` VALUES (3, 0, 'follow', 1, 1, 1, '08:00:00', '22:00:00', '2025-07-26 17:01:28', '2025-07-26 17:01:28');
INSERT INTO `tb_user_message_setting` VALUES (4, 0, 'activity', 1, 1, 1, '08:00:00', '22:00:00', '2025-07-26 17:01:28', '2025-07-26 17:01:28');
INSERT INTO `tb_user_message_setting` VALUES (5, 0, 'system', 1, 1, 1, '08:00:00', '22:00:00', '2025-07-26 17:01:28', '2025-07-26 17:01:28');
INSERT INTO `tb_user_message_setting` VALUES (6, 0, 'chat', 1, 1, 1, '08:00:00', '22:00:00', '2025-07-26 17:01:28', '2025-07-26 17:01:28');

-- ----------------------------
-- Table structure for tb_user_notification
-- ----------------------------
DROP TABLE IF EXISTS `tb_user_notification`;
CREATE TABLE `tb_user_notification`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户通知ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `notification_id` bigint NULL DEFAULT NULL COMMENT '系统通知ID（系统通知时）',
  `from_user_id` bigint NULL DEFAULT NULL COMMENT '来源用户ID（用户行为通知时）',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '通知标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '通知内容',
  `avatar` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '头像（来源用户头像或系统图标）',
  `notification_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '通知类型：system,like,comment,follow,activity,message',
  `object_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '对象类型：post,activity,comment,user',
  `object_id` bigint NULL DEFAULT NULL COMMENT '对象ID',
  `link_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '链接类型：page,url,activity,post',
  `link_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '链接值',
  `extra_data` json NULL COMMENT '扩展数据',
  `is_read` tinyint NULL DEFAULT 0 COMMENT '是否已读：0-未读，1-已读',
  `read_time` datetime NULL DEFAULT NULL COMMENT '读取时间',
  `is_deleted` tinyint NULL DEFAULT 0 COMMENT '是否删除：0-否，1-是',
  `delete_time` datetime NULL DEFAULT NULL COMMENT '删除时间',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_notification_id`(`notification_id` ASC) USING BTREE,
  INDEX `idx_from_user_id`(`from_user_id` ASC) USING BTREE,
  INDEX `idx_notification_type`(`notification_type` ASC) USING BTREE,
  INDEX `idx_object_type`(`object_type` ASC) USING BTREE,
  INDEX `idx_object_id`(`object_id` ASC) USING BTREE,
  INDEX `idx_is_read`(`is_read` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE,
  INDEX `idx_is_deleted`(`is_deleted` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户通知表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_user_notification
-- ----------------------------
INSERT INTO `tb_user_notification` VALUES (1, 1, NULL, 2, '收到新的点赞', '李摄影赞了你的帖子', NULL, 'like', 'post', 1, NULL, NULL, NULL, 0, NULL, 0, NULL, '2025-07-26 17:03:42');
INSERT INTO `tb_user_notification` VALUES (2, 1, NULL, 3, '收到新的评论', '张美食评论了你的帖子：西湖真的很美！', NULL, 'comment', 'post', 1, NULL, NULL, NULL, 0, NULL, 0, NULL, '2025-07-26 17:03:42');
INSERT INTO `tb_user_notification` VALUES (3, 1, NULL, 4, '收到新的关注', '王户外关注了你', NULL, 'follow', 'user', 4, NULL, NULL, NULL, 0, NULL, 0, NULL, '2025-07-26 17:03:42');
INSERT INTO `tb_user_notification` VALUES (4, 2, NULL, 1, '收到新的点赞', '小王赞了你的帖子', NULL, 'like', 'post', 2, NULL, NULL, NULL, 0, NULL, 0, NULL, '2025-07-26 17:03:42');
INSERT INTO `tb_user_notification` VALUES (5, 3, NULL, 1, '活动报名成功', '你已成功报名参加\"成都美食探索团\"活动', NULL, 'activity', 'activity', 3, NULL, NULL, NULL, 0, NULL, 0, NULL, '2025-07-26 17:03:42');

-- ----------------------------
-- Table structure for tb_user_points_log
-- ----------------------------
DROP TABLE IF EXISTS `tb_user_points_log`;
CREATE TABLE `tb_user_points_log`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `rule_id` bigint NULL DEFAULT NULL COMMENT '规则ID',
  `points_change` int NOT NULL COMMENT '积分变化（正数为增加，负数为减少）',
  `points_before` int NOT NULL COMMENT '变化前积分',
  `points_after` int NOT NULL COMMENT '变化后积分',
  `change_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '变化类型：earn,consume,admin,system',
  `action_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '动作类型：login,post,comment,like,share,activity',
  `object_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '对象类型：post,activity,comment',
  `object_id` bigint NULL DEFAULT NULL COMMENT '对象ID',
  `description` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '变化描述',
  `extra_data` json NULL COMMENT '扩展数据',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_rule_id`(`rule_id` ASC) USING BTREE,
  INDEX `idx_change_type`(`change_type` ASC) USING BTREE,
  INDEX `idx_action_type`(`action_type` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户积分记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_user_points_log
-- ----------------------------
INSERT INTO `tb_user_points_log` VALUES (1, 1, 1, 10, 0, 10, 'earn', 'login', NULL, NULL, '每日登录奖励', NULL, '2025-07-26 17:01:56');
INSERT INTO `tb_user_points_log` VALUES (2, 1, 2, 20, 10, 30, 'earn', 'post', NULL, NULL, '发布帖子奖励', NULL, '2025-07-26 17:01:56');
INSERT INTO `tb_user_points_log` VALUES (3, 1, 3, 50, 30, 80, 'earn', 'activity', NULL, NULL, '发布活动奖励', NULL, '2025-07-26 17:01:56');
INSERT INTO `tb_user_points_log` VALUES (4, 2, 1, 10, 0, 10, 'earn', 'login', NULL, NULL, '每日登录奖励', NULL, '2025-07-26 17:01:56');
INSERT INTO `tb_user_points_log` VALUES (5, 2, 2, 20, 10, 30, 'earn', 'post', NULL, NULL, '发布帖子奖励', NULL, '2025-07-26 17:01:56');
INSERT INTO `tb_user_points_log` VALUES (6, 3, 1, 10, 0, 10, 'earn', 'login', NULL, NULL, '每日登录奖励', NULL, '2025-07-26 17:01:56');
INSERT INTO `tb_user_points_log` VALUES (7, 3, 2, 20, 10, 30, 'earn', 'post', NULL, NULL, '发布帖子奖励', NULL, '2025-07-26 17:01:56');
INSERT INTO `tb_user_points_log` VALUES (8, 4, 1, 10, 0, 10, 'earn', 'login', NULL, NULL, '每日登录奖励', NULL, '2025-07-26 17:01:56');
INSERT INTO `tb_user_points_log` VALUES (9, 4, 2, 20, 10, 30, 'earn', 'post', NULL, NULL, '发布帖子奖励', NULL, '2025-07-26 17:01:56');
INSERT INTO `tb_user_points_log` VALUES (10, 5, 1, 10, 0, 10, 'earn', 'login', NULL, NULL, '每日登录奖励', NULL, '2025-07-26 17:01:56');

-- ----------------------------
-- Table structure for tb_user_setting
-- ----------------------------
DROP TABLE IF EXISTS `tb_user_setting`;
CREATE TABLE `tb_user_setting`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '设置ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `setting_key` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '设置键',
  `setting_value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '设置值',
  `setting_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'string' COMMENT '设置类型：string,number,boolean,json',
  `description` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '设置描述',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_user_setting`(`user_id` ASC, `setting_key` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户设置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_user_setting
-- ----------------------------
INSERT INTO `tb_user_setting` VALUES (1, 0, 'privacy_profile', '1', 'boolean', '个人资料是否公开', '2025-07-26 17:01:51', '2025-07-26 17:01:51');
INSERT INTO `tb_user_setting` VALUES (2, 0, 'privacy_footprint', '1', 'boolean', '足迹是否公开', '2025-07-26 17:01:51', '2025-07-26 17:01:51');
INSERT INTO `tb_user_setting` VALUES (3, 0, 'privacy_activity', '1', 'boolean', '活动参与是否公开', '2025-07-26 17:01:51', '2025-07-26 17:01:51');
INSERT INTO `tb_user_setting` VALUES (4, 0, 'notification_like', '1', 'boolean', '点赞通知开关', '2025-07-26 17:01:51', '2025-07-26 17:01:51');
INSERT INTO `tb_user_setting` VALUES (5, 0, 'notification_comment', '1', 'boolean', '评论通知开关', '2025-07-26 17:01:51', '2025-07-26 17:01:51');
INSERT INTO `tb_user_setting` VALUES (6, 0, 'notification_follow', '1', 'boolean', '关注通知开关', '2025-07-26 17:01:51', '2025-07-26 17:01:51');
INSERT INTO `tb_user_setting` VALUES (7, 0, 'notification_activity', '1', 'boolean', '活动通知开关', '2025-07-26 17:01:51', '2025-07-26 17:01:51');
INSERT INTO `tb_user_setting` VALUES (8, 0, 'theme_mode', 'auto', 'string', '主题模式：light,dark,auto', '2025-07-26 17:01:51', '2025-07-26 17:01:51');
INSERT INTO `tb_user_setting` VALUES (9, 0, 'language', 'zh-CN', 'string', '语言设置', '2025-07-26 17:01:51', '2025-07-26 17:01:51');
INSERT INTO `tb_user_setting` VALUES (10, 0, 'location_sharing', '1', 'boolean', '位置分享开关', '2025-07-26 17:01:51', '2025-07-26 17:01:51');

-- ----------------------------
-- Table structure for tb_user_verification
-- ----------------------------
DROP TABLE IF EXISTS `tb_user_verification`;
CREATE TABLE `tb_user_verification`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '认证ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `verification_type` tinyint NOT NULL COMMENT '认证类型：1-个人认证，2-企业认证，3-官方认证',
  `real_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '真实姓名',
  `id_card` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '身份证号',
  `id_card_front` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '身份证正面照',
  `id_card_back` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '身份证背面照',
  `company_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '公司名称',
  `company_license` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '营业执照',
  `contact_person` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '联系人',
  `contact_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '联系电话',
  `verification_materials` json NULL COMMENT '认证材料',
  `apply_reason` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '申请理由',
  `status` tinyint NULL DEFAULT 0 COMMENT '认证状态：0-待审核，1-审核通过，2-审核拒绝',
  `audit_reason` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '审核原因',
  `audit_time` datetime NULL DEFAULT NULL COMMENT '审核时间',
  `audit_user_id` bigint NULL DEFAULT NULL COMMENT '审核人ID',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '申请时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_verification_type`(`verification_type` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户认证表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_user_verification
-- ----------------------------

-- ----------------------------
-- Table structure for tb_user_wallet
-- ----------------------------
DROP TABLE IF EXISTS `tb_user_wallet`;
CREATE TABLE `tb_user_wallet`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '钱包ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `balance` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '账户余额',
  `frozen_amount` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '冻结金额',
  `total_recharge` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '累计充值',
  `total_consume` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '累计消费',
  `pay_password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '支付密码',
  `pay_password_salt` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '支付密码盐值',
  `is_pay_password_set` tinyint NULL DEFAULT 0 COMMENT '是否设置支付密码：0-否，1-是',
  `status` tinyint NULL DEFAULT 1 COMMENT '钱包状态：0-冻结，1-正常',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户钱包表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_user_wallet
-- ----------------------------
INSERT INTO `tb_user_wallet` VALUES (1, 1, 500.00, 0.00, 1000.00, 500.00, NULL, NULL, 0, 1, '2025-07-26 17:01:56', '2025-07-26 17:01:56');
INSERT INTO `tb_user_wallet` VALUES (2, 2, 200.00, 0.00, 800.00, 600.00, NULL, NULL, 0, 1, '2025-07-26 17:01:56', '2025-07-26 17:01:56');
INSERT INTO `tb_user_wallet` VALUES (3, 3, 100.00, 0.00, 900.00, 800.00, NULL, NULL, 0, 1, '2025-07-26 17:01:56', '2025-07-26 17:01:56');
INSERT INTO `tb_user_wallet` VALUES (4, 4, 300.00, 0.00, 700.00, 400.00, NULL, NULL, 0, 1, '2025-07-26 17:01:56', '2025-07-26 17:01:56');
INSERT INTO `tb_user_wallet` VALUES (5, 5, 150.00, 0.00, 350.00, 200.00, NULL, NULL, 0, 1, '2025-07-26 17:01:56', '2025-07-26 17:01:56');

-- ----------------------------
-- Table structure for tb_wallet_transaction
-- ----------------------------
DROP TABLE IF EXISTS `tb_wallet_transaction`;
CREATE TABLE `tb_wallet_transaction`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '交易ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `transaction_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '交易单号',
  `transaction_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '交易类型：recharge,consume,refund,withdraw',
  `amount` decimal(10, 2) NOT NULL COMMENT '交易金额',
  `balance_before` decimal(10, 2) NOT NULL COMMENT '交易前余额',
  `balance_after` decimal(10, 2) NOT NULL COMMENT '交易后余额',
  `object_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '关联对象类型：activity,order',
  `object_id` bigint NULL DEFAULT NULL COMMENT '关联对象ID',
  `payment_method` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '支付方式：wechat,alipay,bank',
  `third_party_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '第三方交易号',
  `description` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '交易描述',
  `status` tinyint NULL DEFAULT 1 COMMENT '交易状态：0-失败，1-成功，2-处理中',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '交易时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_transaction_no`(`transaction_no` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_transaction_type`(`transaction_type` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '钱包交易记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_wallet_transaction
-- ----------------------------

-- ----------------------------
-- Procedure structure for insert_fake_users
-- ----------------------------
DROP PROCEDURE IF EXISTS `insert_fake_users`;
delimiter ;;
CREATE PROCEDURE `insert_fake_users`()
BEGIN
  DECLARE i INT DEFAULT 1;
  WHILE i <= 100000 DO
    INSERT INTO tb_user (
      username,
      password,
      email,
      phone,
      status,
      create_time,
      update_time,
      create_by,
      update_by,
      is_deleted,
      delete_time
    )
    VALUES (
      CONCAT('user_', i),
      MD5('123456'),  -- 所有密码都为123456的MD5
      CONCAT('user_', i, '@example.com'),
      CONCAT('139', LPAD(FLOOR(RAND() * 100000000), 8, '0')),
      IF(MOD(i, 2) = 0, 1, 0),
      NOW(),
      NOW(),
      1,
      1,
      0,
      NULL
    );
    SET i = i + 1;
  END WHILE;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
