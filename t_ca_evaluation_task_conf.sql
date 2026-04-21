/*
 Navicat Premium Dump SQL

 Source Server         : 人才发展-UAT
 Source Server Type    : MySQL
 Source Server Version : 80035 (8.0.35)
 Source Host           : 10.81.140.253:39800
 Source Schema         : hr_tms_biz

 Target Server Type    : MySQL
 Target Server Version : 80035 (8.0.35)
 File Encoding         : 65001

 Date: 16/04/2026 10:24:08
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_ca_evaluation_task_conf
-- ----------------------------
DROP TABLE IF EXISTS `t_ca_evaluation_task_conf`;
CREATE TABLE `t_ca_evaluation_task_conf`  (
  `n_id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `s_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '名称',
  `s_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '编码',
  `n_type` int NOT NULL COMMENT '类型 枚举BusinessConf.EvaluateType',
  `s_rule_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '规则code 枚举BusinessConf.EvaluateRule',
  `n_status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '任务状态 枚举BusinessConf.Status',
  `n_create_id` bigint NOT NULL COMMENT '创建人id',
  `s_create_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '创建人编号',
  `s_create_user` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '创建人',
  `d_create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `n_update_id` bigint NULL DEFAULT NULL COMMENT '修改人id',
  `s_update_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '修改人编号',
  `s_update_user` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '修改人',
  `d_update_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `n_is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`n_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1980515118196523010 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '竞聘委任-评价任务' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_ca_evaluation_task_conf
-- ----------------------------
INSERT INTO `t_ca_evaluation_task_conf` VALUES (1960157523326365698, '述职报告', NULL, 2, 'hundred_point', 1, 1929824200325906433, 'lj', '李杰', '2025-08-26 09:49:06', 1929824200325906433, 'lj', '李杰', '2025-08-26 14:39:41', 0);
INSERT INTO `t_ca_evaluation_task_conf` VALUES (1960157567131676673, '沟通访谈', NULL, 2, 'other', 1, 1929824200325906433, 'lj', '李杰', '2025-08-26 09:49:17', 1929824200325906433, 'lj', '李杰', '2025-08-26 14:39:41', 0);
INSERT INTO `t_ca_evaluation_task_conf` VALUES (1960157623486345217, '管理胜任力评价', NULL, 2, 'hundred_point', 1, 1929824200325906433, 'lj', '李杰', '2025-08-26 09:49:30', 1929824200325906433, 'lj', '李杰', '2025-08-26 14:39:42', 0);
INSERT INTO `t_ca_evaluation_task_conf` VALUES (1960158119546679297, '价值观', NULL, 2, 'twenty_four_point', 1, 1929824200325906433, 'lj', '李杰', '2025-08-26 09:51:28', 1, 'admin', '管理员', '2025-08-26 14:39:42', 0);
INSERT INTO `t_ca_evaluation_task_conf` VALUES (1960158184721969154, '绩效评价', NULL, 2, 'level_point', 1, 1929824200325906433, 'lj', '李杰', '2025-08-26 09:51:44', 1929824200325906433, 'lj', '李杰', '2025-09-09 16:59:03', 0);
INSERT INTO `t_ca_evaluation_task_conf` VALUES (1960158262039769090, '廉洁自律申报', NULL, 2, 'other', 1, 1929824200325906433, 'lj', '李杰', '2025-08-26 09:52:02', 1929824200325906433, 'lj', '李杰', '2025-08-26 14:39:42', 0);
INSERT INTO `t_ca_evaluation_task_conf` VALUES (1961341745185775617, '其他任务', NULL, 1, 'other', 1, 45868, '966770', '邱菊', '2025-08-29 16:14:47', 45868, '966770', '邱菊', '2025-08-29 16:14:47', 0);
INSERT INTO `t_ca_evaluation_task_conf` VALUES (1962447789484478465, '5', NULL, 1, 'five_point', 1, 45868, '966770', '邱菊', '2025-09-01 17:29:48', 45868, '966770', '邱菊', '2025-09-01 17:29:48', 0);
INSERT INTO `t_ca_evaluation_task_conf` VALUES (1962447812876111873, '10', NULL, 1, 'ten_point', 1, 45868, '966770', '邱菊', '2025-09-01 17:29:54', 45868, '966770', '邱菊', '2025-09-01 17:29:54', 0);
INSERT INTO `t_ca_evaluation_task_conf` VALUES (1966042986859012097, '任务一', NULL, 1, 'level_point', 1, 1, 'admin', '超级管理员', '2025-09-11 15:35:50', 1, 'admin', '超级管理员', '2025-09-11 15:35:50', 0);
INSERT INTO `t_ca_evaluation_task_conf` VALUES (1966044174287446018, '任务二', NULL, 1, 'level_point', 1, 1, 'admin', '超级管理员', '2025-09-11 15:40:33', 1, 'admin', '超级管理员', '2025-09-11 15:40:33', 0);
INSERT INTO `t_ca_evaluation_task_conf` VALUES (1977629522948489218, '【测试】360评价', NULL, 1, 'ten_point', 1, 1940286238997215575, '85125', '杜林芋', '2025-10-13 14:56:36', 1940286238997215575, '85125', '杜林芋', '2025-10-13 14:56:36', 0);
INSERT INTO `t_ca_evaluation_task_conf` VALUES (1977641987300098049, '测试评价任务', NULL, 1, 'other', 1, 1940286238997220254, '546660', '桑恬', '2025-10-13 15:46:07', 1940286238997220254, '546660', '桑恬', '2025-10-13 15:46:07', 0);
INSERT INTO `t_ca_evaluation_task_conf` VALUES (1980515118196523009, 'ceshi-leejie', NULL, 1, 'other', 1, 2, 'ym', '袁满', '2025-10-21 14:02:55', 2, 'ym', '袁满', '2025-10-21 14:03:03', -1);

SET FOREIGN_KEY_CHECKS = 1;
