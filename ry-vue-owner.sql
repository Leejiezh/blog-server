/*
 Navicat Premium Dump SQL

 Source Server         : 若依
 Source Server Type    : MySQL
 Source Server Version : 80043 (8.0.43)
 Source Host           : localhost:3306
 Source Schema         : ry-vue-owner

 Target Server Type    : MySQL
 Target Server Version : 80043 (8.0.43)
 File Encoding         : 65001

 Date: 21/12/2025 21:50:39
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for QRTZ_BLOB_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_BLOB_TRIGGERS`;
CREATE TABLE `QRTZ_BLOB_TRIGGERS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `blob_data` blob NULL COMMENT '存放持久化Trigger对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `QRTZ_BLOB_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'Blob类型的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_BLOB_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_CALENDARS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_CALENDARS`;
CREATE TABLE `QRTZ_CALENDARS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '日历名称',
  `calendar` blob NOT NULL COMMENT '存放持久化calendar对象',
  PRIMARY KEY (`sched_name`, `calendar_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '日历信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_CALENDARS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_CRON_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_CRON_TRIGGERS`;
CREATE TABLE `QRTZ_CRON_TRIGGERS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `cron_expression` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'cron表达式',
  `time_zone_id` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '时区',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `QRTZ_CRON_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'Cron类型的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_CRON_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_FIRED_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_FIRED_TRIGGERS`;
CREATE TABLE `QRTZ_FIRED_TRIGGERS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `entry_id` varchar(95) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度器实例id',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度器实例名',
  `fired_time` bigint NOT NULL COMMENT '触发的时间',
  `sched_time` bigint NOT NULL COMMENT '定时器制定的时间',
  `priority` int NOT NULL COMMENT '优先级',
  `state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '状态',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '任务组名',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否并发',
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否接受恢复执行',
  PRIMARY KEY (`sched_name`, `entry_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '已触发的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_FIRED_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_JOB_DETAILS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_JOB_DETAILS`;
CREATE TABLE `QRTZ_JOB_DETAILS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务组名',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `job_class_name` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '执行任务类名称',
  `is_durable` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '是否持久化',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '是否并发',
  `is_update_data` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '是否更新数据',
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '是否接受恢复执行',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '任务详细信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_JOB_DETAILS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_LOCKS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_LOCKS`;
CREATE TABLE `QRTZ_LOCKS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `lock_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '悲观锁名称',
  PRIMARY KEY (`sched_name`, `lock_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '存储的悲观锁信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_LOCKS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_PAUSED_TRIGGER_GRPS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_PAUSED_TRIGGER_GRPS`;
CREATE TABLE `QRTZ_PAUSED_TRIGGER_GRPS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  PRIMARY KEY (`sched_name`, `trigger_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '暂停的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_PAUSED_TRIGGER_GRPS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_SCHEDULER_STATE
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SCHEDULER_STATE`;
CREATE TABLE `QRTZ_SCHEDULER_STATE`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '实例名称',
  `last_checkin_time` bigint NOT NULL COMMENT '上次检查时间',
  `checkin_interval` bigint NOT NULL COMMENT '检查间隔时间',
  PRIMARY KEY (`sched_name`, `instance_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '调度器状态表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_SCHEDULER_STATE
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_SIMPLE_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SIMPLE_TRIGGERS`;
CREATE TABLE `QRTZ_SIMPLE_TRIGGERS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `repeat_count` bigint NOT NULL COMMENT '重复的次数统计',
  `repeat_interval` bigint NOT NULL COMMENT '重复的间隔时间',
  `times_triggered` bigint NOT NULL COMMENT '已经触发的次数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `QRTZ_SIMPLE_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '简单触发器的信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_SIMPLE_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_SIMPROP_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SIMPROP_TRIGGERS`;
CREATE TABLE `QRTZ_SIMPROP_TRIGGERS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `str_prop_1` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第一个参数',
  `str_prop_2` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第二个参数',
  `str_prop_3` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第三个参数',
  `int_prop_1` int NULL DEFAULT NULL COMMENT 'int类型的trigger的第一个参数',
  `int_prop_2` int NULL DEFAULT NULL COMMENT 'int类型的trigger的第二个参数',
  `long_prop_1` bigint NULL DEFAULT NULL COMMENT 'long类型的trigger的第一个参数',
  `long_prop_2` bigint NULL DEFAULT NULL COMMENT 'long类型的trigger的第二个参数',
  `dec_prop_1` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第一个参数',
  `dec_prop_2` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第二个参数',
  `bool_prop_1` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第一个参数',
  `bool_prop_2` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第二个参数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `QRTZ_SIMPROP_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '同步机制的行锁表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_SIMPROP_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_TRIGGERS`;
CREATE TABLE `QRTZ_TRIGGERS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '触发器的名字',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '触发器所属组的名字',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_job_details表job_name的外键',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_job_details表job_group的外键',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `next_fire_time` bigint NULL DEFAULT NULL COMMENT '上一次触发时间（毫秒）',
  `prev_fire_time` bigint NULL DEFAULT NULL COMMENT '下一次触发时间（默认为-1表示不触发）',
  `priority` int NULL DEFAULT NULL COMMENT '优先级',
  `trigger_state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '触发器状态',
  `trigger_type` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '触发器的类型',
  `start_time` bigint NOT NULL COMMENT '开始时间',
  `end_time` bigint NULL DEFAULT NULL COMMENT '结束时间',
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '日程表名称',
  `misfire_instr` smallint NULL DEFAULT NULL COMMENT '补偿执行的策略',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  INDEX `sched_name`(`sched_name` ASC, `job_name` ASC, `job_group` ASC) USING BTREE,
  CONSTRAINT `QRTZ_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `QRTZ_JOB_DETAILS` (`sched_name`, `job_name`, `job_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '触发器详细信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for biz_article
-- ----------------------------
DROP TABLE IF EXISTS `biz_article`;
CREATE TABLE `biz_article`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL COMMENT '作者',
  `category_id` bigint NULL DEFAULT NULL COMMENT '文章分类',
  `article_cover` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '文章缩略图',
  `article_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '标题',
  `article_abstract` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '文章摘要，如果该字段为空，默认取文章的前500个字符作为摘要',
  `article_content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '内容',
  `is_top` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否置顶 0否 1是',
  `is_featured` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否推荐 0否 1是',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '状态值 1公开 2私密 3草稿',
  `type` tinyint(1) NOT NULL DEFAULT 1 COMMENT '文章类型 1原创 2转载 3翻译',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '访问密码',
  `original_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '原文链接',
  `create_by_id` bigint NOT NULL COMMENT '创建人id',
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '创建人名称',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发表时间',
  `update_by_id` bigint NULL DEFAULT NULL COMMENT '更新人id',
  `update_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人名称',
  `update_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_delete` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除  0否 1是',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1990252710601748482 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '文章表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of biz_article
-- ----------------------------
INSERT INTO `biz_article` VALUES (1988075234175889410, 100, 1989231087648596000, '/profile/upload/2025/11/17/2025-09-16_17.47.14_欧阳娜娜Nana_Nabi_一周生活邊角料_8_20251117155924A006.png,/profile/upload/2025/11/17/2025-09-16_17.47.14_欧阳娜娜Nana_Nabi_一周生活邊角料_11_20251117155949A007.png,/profile/upload/2025/11/17/2025-11-03_18.59.11_赵今麦_右滑_看_7_20251117160108A008.png', '新闻1111', '这是一段文章摘要', '11月10日，外交部发言人林剑主持例行记者会。有记者就日本首相高市早苗在国会答问时发表涉台错误言论提问。林剑表示，日本领导人日前在国会公然发表涉台错误言论，暗示武力介入台海可能性，粗暴干涉中国内政，严重违背一个中国原则、中日四个政治文件精神和国际关系基本准则，同日本政府迄今所做的政治承诺严重不符，性质和影响极其恶劣。中方对此强烈不满、坚决反对，已向日方提出严正交涉和强烈抗议。台湾是中国的台湾，以何种方式解决台湾问题，实现国家统一，纯属中国内政，不容任何外部势力干涉。<strong>日方领导人有关言论到底想向“台独”势力发出何种信号？是否企图挑战中方核心利益、阻挠中国统一大业？究竟想把中日关系引向何方？</strong>今年是中国人民抗日战争暨世界反法西斯战争胜利80周年，也是台湾光复80周年。日本曾对台湾实行殖民统治，犯下罄竹难书的罪行。日本当政者妄图介入台海事务，既是对国际正义的践踏、对战后国际秩序的挑衅，也是对中日关系的严重破坏。中国终将统一，也必将统一。中国人民有坚定的意志、充分的信心、足够的能力，坚决粉碎一切插手和阻挠中国统一大业的图谋。中方敦促日方立即停止干涉中国内政，停止挑衅越线，不要在错误道路上越走越远。', 1, 1, 1, 1, NULL, 'https://baijiahao.baidu.com/s?id=1848389250496052621', 100, 'leejie', '2025-11-11 10:44:07', NULL, NULL, '2025-11-17 16:01:15', 0);
INSERT INTO `biz_article` VALUES (1988803995186331649, 100, 1989231087648595970, NULL, '111111111', '123123', '123123123', 0, 0, 2, 2, '123123', NULL, 100, 'leejie', '2025-11-13 10:59:57', 100, 'leejie', '2025-11-17 15:51:24', 1);
INSERT INTO `biz_article` VALUES (1988850192932458498, 100, 1989230712472264705, NULL, '测试草稿', NULL, NULL, 0, 0, 1, 1, NULL, NULL, 100, 'leejie', '2025-11-13 14:03:32', 100, 'leejie', '2025-11-17 15:51:26', 1);
INSERT INTO `biz_article` VALUES (1988850192932458499, 100, 1, NULL, '1113', '123123', '123123123', 0, 0, 1, 2, '123123', NULL, 100, 'leejie', '2025-11-13 10:59:57', 100, 'leejie', '2025-11-14 17:54:37', 1);
INSERT INTO `biz_article` VALUES (1988850192932458500, 100, 1, NULL, '1113', '123123', '123123123', 0, 0, 1, 2, '123123', NULL, 100, 'leejie', '2025-11-13 10:59:57', 100, 'leejie', '2025-11-14 17:54:37', 1);
INSERT INTO `biz_article` VALUES (1988850192932458501, 100, 1, NULL, '1113', '123123', '123123123', 0, 0, 1, 2, '123123', NULL, 100, 'leejie', '2025-11-13 10:59:57', 100, 'leejie', '2025-11-14 17:54:37', 1);
INSERT INTO `biz_article` VALUES (1988850192932458502, 100, 1, NULL, '1113', '123123', '123123123', 0, 0, 1, 2, '123123', NULL, 100, 'leejie', '2025-11-13 10:59:57', 100, 'leejie', '2025-11-14 17:27:22', 1);
INSERT INTO `biz_article` VALUES (1988850192932458503, 100, 1, NULL, '1113', '123123', '123123123', 0, 0, 1, 2, '123123', NULL, 100, 'leejie', '2025-11-13 10:59:57', 100, 'leejie', '2025-11-14 17:27:22', 1);
INSERT INTO `biz_article` VALUES (1988850192932458504, 100, 1, NULL, '1113', '123123', '123123123', 0, 0, 1, 2, '123123', NULL, 100, 'leejie', '2025-11-13 10:59:57', 100, 'leejie', '2025-11-14 17:27:22', 1);
INSERT INTO `biz_article` VALUES (1990244686067695617, 100, 1989230712472264700, '/profile/upload/2025/11/17/2025-09-16_17.47.14_欧阳娜娜Nana_Nabi_一周生活邊角料_1_20251117155829A003.png', 'java从入门到放弃', 'https://blog.csdn.net/LulGjixu/article/details/154655875', '一、入门阶段初识Java时充满热情，环境配置顺利，第一个Hello World在控制台跃然而出。基本语法看似简单，变量、循环、条件语句信手拈来，面向对象概念令人耳目一新。此时信心满满，以为编程不过如此。二、进阶挑战随着学习深入，开始接触集合框架、异常处理、多线程编程。概念逐渐复杂，代码量成倍增长。调试过程变得棘手，内存泄漏、线程死锁等问题接踵而至。IDE的报错信息令人困惑，文档查阅频率显著增加。三、框架迷局进入企业级开发，Spring全家桶迎面而来。配置文件错综复杂，依赖注入让人头晕目眩。MyBatis的XML映射、Spring Boot的自动配置、微服务架构的分布式特性，每个新概念都在挑战认知极限。版本兼容性问题频发，依赖冲突令人抓狂。四、现实打击实际项目中，需求变更频繁，技术债堆积如山。代码审查意见密密麻麻，性能优化无从下手。生产环境故障排查如同大海捞针，凌晨三点的报警短信成为常态。新技术层出不穷，学习速度永远跟不上技术迭代。五、放弃时刻某个深夜，面对第N个无法解决的Bug，看着满屏的异常堆栈，终于意识到自己可能永远无法完全掌握这门技术。决定关掉IDE，合上电脑，承认自己与Java的缘分到此为止。六、新的开始放弃不是终点。有人转向项目管理，有人投身其他技术领域，也有人休息后重拾信心。编程之路本就充满选择，重要的是找到适合自己的方向。Java只是工具，而非人生的全部。', 1, 0, 2, 1, '123123', NULL, 100, 'leejie', '2025-11-17 10:24:45', NULL, NULL, '2025-11-17 15:58:32', 0);
INSERT INTO `biz_article` VALUES (1990252710601748481, 100, 1989230712472264705, '/profile/upload/2025/11/17/微信图片_20251112101532_36_49_20251117105605A002.jpg', '保存草稿测试', 'ouyangnana', 'ouyanglalallalala', 1, 1, 3, 1, NULL, NULL, 100, 'leejie', '2025-11-17 10:56:38', NULL, NULL, NULL, 0);

-- ----------------------------
-- Table structure for biz_article_tag
-- ----------------------------
DROP TABLE IF EXISTS `biz_article_tag`;
CREATE TABLE `biz_article_tag`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `article_id` bigint NOT NULL COMMENT '文章id',
  `tag_id` bigint NOT NULL COMMENT '标签id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_article_tag_1`(`article_id` ASC) USING BTREE,
  INDEX `fk_article_tag_2`(`tag_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 85 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '文章标签表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of biz_article_tag
-- ----------------------------

-- ----------------------------
-- Table structure for biz_category
-- ----------------------------
DROP TABLE IF EXISTS `biz_category`;
CREATE TABLE `biz_category`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `category_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '分类名',
  `create_by_id` bigint NOT NULL COMMENT '创建人id',
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '创建人名称',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_by_id` bigint NULL DEFAULT NULL COMMENT '更新人id',
  `update_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人名称',
  `update_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_delete` tinyint NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1989266507538644994 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '文章分类表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of biz_category
-- ----------------------------
INSERT INTO `biz_category` VALUES (1989230712472264705, '技术', 100, 'leejie', '2025-11-14 15:15:36', NULL, NULL, '2025-11-14 09:40:54', 0);
INSERT INTO `biz_category` VALUES (1989231087648595970, '生活', 100, 'leejie', '2025-11-14 15:17:04', 100, 'leejie', '2025-11-14 09:42:31', 0);

-- ----------------------------
-- Table structure for biz_comment
-- ----------------------------
DROP TABLE IF EXISTS `biz_comment`;
CREATE TABLE `biz_comment`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint NOT NULL COMMENT '评论用户Id',
  `topic_id` bigint NULL DEFAULT NULL COMMENT '评论主题id',
  `comment_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '评论内容',
  `reply_user_id` bigint NULL DEFAULT NULL COMMENT '回复用户id',
  `parent_id` bigint NULL DEFAULT NULL COMMENT '父评论id',
  `type` tinyint NOT NULL COMMENT '评论类型 1.文章 2.留言 3.关于我 4.友链 5.说说',
  `is_delete` tinyint NOT NULL DEFAULT 0 COMMENT '是否删除  0否 1是',
  `is_review` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否审核',
  `create_by_id` bigint NOT NULL COMMENT '创建人id',
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '创建人名称',
  `create_time` datetime NOT NULL COMMENT '评论时间',
  `update_by_id` bigint NULL DEFAULT NULL COMMENT '更新人id',
  `update_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人名称',
  `update_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_comment_user`(`user_id` ASC) USING BTREE,
  INDEX `fk_comment_parent`(`parent_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1032 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '评论表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of biz_comment
-- ----------------------------

-- ----------------------------
-- Table structure for biz_friend_link
-- ----------------------------
DROP TABLE IF EXISTS `biz_friend_link`;
CREATE TABLE `biz_friend_link`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `link_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '链接名',
  `link_avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '链接头像',
  `link_address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '链接地址',
  `link_intro` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '链接介绍',
  `create_by_id` bigint NOT NULL COMMENT '创建人id',
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '创建人名称',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_by_id` bigint NULL DEFAULT NULL COMMENT '更新人id',
  `update_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人名称',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_friend_link_user`(`link_name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 47 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '友链表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of biz_friend_link
-- ----------------------------

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `tpl_web_type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '前端模板类型（element-ui模版 element-plus模版）',
  `package_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '代码生成业务表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table
-- ----------------------------
INSERT INTO `gen_table` VALUES (2, 'biz_article', '文章表', NULL, NULL, 'BizArticle', 'crud', 'element-plus', 'blog.biz', 'system', 'article', '文章', 'leejie', '0', '/', '{\"parentMenuId\":0}', 'leejie', '2025-11-11 01:30:10', '', '2025-11-12 09:35:40', NULL);
INSERT INTO `gen_table` VALUES (11, 'biz_category', '文章分类表', NULL, NULL, 'Category', 'crud', 'element-plus', 'blog.biz', 'biz', 'category', '文章分类', 'leejie', '0', '/', '{}', 'leejie', '2025-11-14 03:32:54', '', '2025-11-14 03:35:38', NULL);

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  `create_by_id` bigint NULL DEFAULT NULL COMMENT '创建人id',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by_id` bigint NULL DEFAULT NULL COMMENT '更新人id',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 45 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
INSERT INTO `gen_table_column` VALUES (17, 2, 'id', NULL, 'bigint', 'Long', 'id', '1', '1', '0', '0', NULL, NULL, NULL, 'EQ', 'input', '', 1, NULL, 'leejie', '2025-11-11 01:30:10', NULL, '', '2025-11-12 09:35:40');
INSERT INTO `gen_table_column` VALUES (18, 2, 'user_id', '作者', 'bigint', 'Long', 'userId', '0', '0', '1', '0', '0', '1', '1', 'EQ', 'input', '', 2, NULL, 'leejie', '2025-11-11 01:30:10', NULL, '', '2025-11-12 09:35:40');
INSERT INTO `gen_table_column` VALUES (19, 2, 'category_id', '文章分类', 'bigint', 'Long', 'categoryId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 3, NULL, 'leejie', '2025-11-11 01:30:10', NULL, '', '2025-11-12 09:35:40');
INSERT INTO `gen_table_column` VALUES (20, 2, 'article_cover', '文章缩略图', 'varchar(1024)', 'String', 'articleCover', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'imageUpload', '', 4, NULL, 'leejie', '2025-11-11 01:30:10', NULL, '', '2025-11-12 09:35:40');
INSERT INTO `gen_table_column` VALUES (21, 2, 'article_title', '标题', 'varchar(50)', 'String', 'articleTitle', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 5, NULL, 'leejie', '2025-11-11 01:30:10', NULL, '', '2025-11-12 09:35:40');
INSERT INTO `gen_table_column` VALUES (22, 2, 'article_abstract', '文章摘要', 'varchar(500)', 'String', 'articleAbstract', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 6, NULL, 'leejie', '2025-11-11 01:30:10', NULL, '', '2025-11-12 09:35:40');
INSERT INTO `gen_table_column` VALUES (23, 2, 'article_content', '内容', 'longtext', 'String', 'articleContent', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'editor', '', 7, NULL, 'leejie', '2025-11-11 01:30:10', NULL, '', '2025-11-12 09:35:40');
INSERT INTO `gen_table_column` VALUES (24, 2, 'is_top', '是否置顶', 'tinyint(1)', 'Integer', 'isTop', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'radio', 'biz_yes_no', 8, NULL, 'leejie', '2025-11-11 01:30:10', NULL, '', '2025-11-12 09:35:40');
INSERT INTO `gen_table_column` VALUES (25, 2, 'is_featured', '是否推荐', 'tinyint(1)', 'Integer', 'isFeatured', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'radio', 'biz_yes_no', 9, NULL, 'leejie', '2025-11-11 01:30:10', NULL, '', '2025-11-12 09:35:40');
INSERT INTO `gen_table_column` VALUES (26, 2, 'is_delete', '是否删除', 'tinyint(1)', 'Integer', 'isDelete', '0', '0', '1', '0', '0', '0', '0', 'EQ', 'input', 'biz_yes_no', 10, NULL, 'leejie', '2025-11-11 01:30:10', NULL, '', '2025-11-12 09:35:40');
INSERT INTO `gen_table_column` VALUES (27, 2, 'status', '状态值', 'tinyint(1)', 'Integer', 'status', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'radio', '', 11, NULL, 'leejie', '2025-11-11 01:30:10', NULL, '', '2025-11-12 09:35:40');
INSERT INTO `gen_table_column` VALUES (28, 2, 'type', '文章类型', 'tinyint(1)', 'Integer', 'type', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', '', 12, NULL, 'leejie', '2025-11-11 01:30:10', NULL, '', '2025-11-12 09:35:40');
INSERT INTO `gen_table_column` VALUES (29, 2, 'password', '访问密码', 'varchar(255)', 'String', 'password', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 13, NULL, 'leejie', '2025-11-11 01:30:10', NULL, '', '2025-11-12 09:35:40');
INSERT INTO `gen_table_column` VALUES (30, 2, 'original_url', '原文链接', 'varchar(255)', 'String', 'originalUrl', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 14, NULL, 'leejie', '2025-11-11 01:30:10', NULL, '', '2025-11-12 09:35:40');
INSERT INTO `gen_table_column` VALUES (31, 2, 'create_by_id', '创建人id', 'bigint', 'Long', 'createById', '0', '0', '1', '0', '0', '0', '0', 'EQ', 'input', '', 15, NULL, 'leejie', '2025-11-11 01:30:10', NULL, '', '2025-11-12 09:35:40');
INSERT INTO `gen_table_column` VALUES (32, 2, 'create_by', '创建人名称', 'varchar(50)', 'String', 'createBy', '0', '0', '1', '0', NULL, '1', '1', 'EQ', 'input', '', 16, NULL, 'leejie', '2025-11-11 01:30:10', NULL, '', '2025-11-12 09:35:40');
INSERT INTO `gen_table_column` VALUES (33, 2, 'create_time', '发表时间', 'datetime', 'Date', 'createTime', '0', '0', '1', '0', NULL, '1', '1', 'EQ', 'datetime', '', 17, NULL, 'leejie', '2025-11-11 01:30:10', NULL, '', '2025-11-12 09:35:40');
INSERT INTO `gen_table_column` VALUES (34, 2, 'update_by_id', '更新人id', 'bigint', 'Long', 'updateById', '0', '0', '0', '0', '0', '0', '0', 'EQ', 'input', '', 18, NULL, 'leejie', '2025-11-11 01:30:10', NULL, '', '2025-11-12 09:35:40');
INSERT INTO `gen_table_column` VALUES (35, 2, 'update_by', '更新人名称', 'varchar(50)', 'String', 'updateBy', '0', '0', '0', '0', '0', NULL, NULL, 'EQ', 'input', '', 19, NULL, 'leejie', '2025-11-11 01:30:10', NULL, '', '2025-11-12 09:35:40');
INSERT INTO `gen_table_column` VALUES (36, 2, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', '0', '0', '0', '0', 'EQ', 'datetime', '', 20, NULL, 'leejie', '2025-11-11 01:30:10', NULL, '', '2025-11-12 09:35:40');
INSERT INTO `gen_table_column` VALUES (37, 11, 'id', '分类id', 'bigint', 'Long', 'id', '1', '1', '0', '0', NULL, '1', NULL, 'EQ', 'input', '', 1, 100, 'leejie', '2025-11-14 11:32:55', NULL, '', '2025-11-14 03:35:38');
INSERT INTO `gen_table_column` VALUES (38, 11, 'category_name', '分类名', 'varchar(20)', 'String', 'categoryName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 100, 'leejie', '2025-11-14 11:32:55', NULL, '', '2025-11-14 03:35:38');
INSERT INTO `gen_table_column` VALUES (39, 11, 'create_by_id', '创建人id', 'bigint', 'Long', 'createById', '0', '0', '0', '0', '0', '0', '0', 'EQ', 'input', '', 3, 100, 'leejie', '2025-11-14 11:32:55', NULL, '', '2025-11-14 03:35:38');
INSERT INTO `gen_table_column` VALUES (40, 11, 'create_by', '创建人名称', 'varchar(50)', 'String', 'createBy', '0', '0', '0', '0', NULL, '1', NULL, 'EQ', 'input', '', 4, 100, 'leejie', '2025-11-14 11:32:55', NULL, '', '2025-11-14 03:35:38');
INSERT INTO `gen_table_column` VALUES (41, 11, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 5, 100, 'leejie', '2025-11-14 11:32:55', NULL, '', '2025-11-14 03:35:38');
INSERT INTO `gen_table_column` VALUES (42, 11, 'update_by_id', '更新人id', 'bigint', 'Long', 'updateById', '0', '0', '0', '0', '0', '0', '0', 'EQ', 'input', '', 6, 100, 'leejie', '2025-11-14 11:32:55', NULL, '', '2025-11-14 03:35:38');
INSERT INTO `gen_table_column` VALUES (43, 11, 'update_by', '更新人名称', 'varchar(50)', 'String', 'updateBy', '0', '0', '0', '0', '0', NULL, NULL, 'EQ', 'input', '', 7, 100, 'leejie', '2025-11-14 11:32:55', NULL, '', '2025-11-14 03:35:38');
INSERT INTO `gen_table_column` VALUES (44, 11, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', '0', '0', '0', NULL, 'EQ', 'datetime', '', 8, 100, 'leejie', '2025-11-14 11:32:55', NULL, '', '2025-11-14 03:35:38');

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '参数配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2025-09-25 01:37:49', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2025-09-25 01:37:49', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2025-09-25 01:37:49', '', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (4, '账号自助-验证码开关', 'sys.account.captchaEnabled', 'true', 'Y', 'admin', '2025-09-25 01:37:49', '', NULL, '是否开启验证码功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 'admin', '2025-09-25 01:37:49', '', NULL, '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (6, '用户登录-黑名单列表', 'sys.login.blackIPList', '', 'Y', 'admin', '2025-09-25 01:37:49', '', NULL, '设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');
INSERT INTO `sys_config` VALUES (7, '用户管理-初始密码修改策略', 'sys.account.initPasswordModify', '1', 'Y', 'admin', '2025-09-25 01:37:49', '', NULL, '0：初始密码修改策略关闭，没有任何提示，1：提醒用户，如果未修改初始密码，则在登录时就会提醒修改密码对话框');
INSERT INTO `sys_config` VALUES (8, '用户管理-账号密码更新周期', 'sys.account.passwordValidateDays', '0', 'Y', 'admin', '2025-09-25 01:37:49', '', NULL, '密码更新周期（填写数字，数据初始化值为0不限制，若修改必须为大于0小于365的正整数），如果超过这个周期登录系统时，则在登录时就会提醒修改密码对话框');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 200 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '部门表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', '咯咯科技', 0, 'leejie', '18988888888', 'leejieqaq@163.com', '0', '0', 'admin', '2025-09-25 01:37:45', 'leejie', '2025-11-07 02:44:15');
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', '深圳总公司', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-09-25 01:37:45', '', NULL);
INSERT INTO `sys_dept` VALUES (102, 100, '0,100', '长沙分公司', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-09-25 01:37:45', '', NULL);
INSERT INTO `sys_dept` VALUES (103, 101, '0,100,101', '研发部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-09-25 01:37:45', '', NULL);
INSERT INTO `sys_dept` VALUES (104, 101, '0,100,101', '市场部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2025-09-25 01:37:45', '', NULL);
INSERT INTO `sys_dept` VALUES (105, 101, '0,100,101', '测试部门', 3, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-09-25 01:37:45', '', NULL);
INSERT INTO `sys_dept` VALUES (106, 101, '0,100,101', '财务部门', 4, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-09-25 01:37:45', '', NULL);
INSERT INTO `sys_dept` VALUES (107, 101, '0,100,101', '运维部门', 5, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-09-25 01:37:45', '', NULL);
INSERT INTO `sys_dept` VALUES (108, 102, '0,100,102', '市场部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-09-25 01:37:45', '', NULL);
INSERT INTO `sys_dept` VALUES (109, 102, '0,100,102', '财务部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-09-25 01:37:45', '', NULL);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `dict_sort` int NULL DEFAULT 0 COMMENT '字典排序',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 108 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, '男', '0', 'sys_user_sex', 1, '', '', 'Y', '0', 'admin', '2025-09-25 01:37:49', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, '女', '1', 'sys_user_sex', 2, '', '', 'N', '0', 'admin', '2025-09-25 01:37:49', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, '未知', '2', 'sys_user_sex', 3, '', '', 'N', '0', 'admin', '2025-09-25 01:37:49', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, '显示', '0', 'sys_show_hide', 1, '', 'primary', 'Y', '0', 'admin', '2025-09-25 01:37:49', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, '隐藏', '1', 'sys_show_hide', 2, '', 'danger', 'N', '0', 'admin', '2025-09-25 01:37:49', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, '正常', '0', 'sys_normal_disable', 1, '', 'primary', 'Y', '0', 'admin', '2025-09-25 01:37:49', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, '停用', '1', 'sys_normal_disable', 2, '', 'danger', 'N', '0', 'admin', '2025-09-25 01:37:49', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, '正常', '0', 'sys_job_status', 1, '', 'primary', 'Y', '0', 'admin', '2025-09-25 01:37:49', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, '暂停', '1', 'sys_job_status', 2, '', 'danger', 'N', '0', 'admin', '2025-09-25 01:37:49', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, '默认', 'DEFAULT', 'sys_job_group', 1, '', '', 'Y', '0', 'admin', '2025-09-25 01:37:49', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, '系统', 'SYSTEM', 'sys_job_group', 2, '', '', 'N', '0', 'admin', '2025-09-25 01:37:49', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, '是', 'Y', 'sys_yes_no', 1, '', 'primary', 'Y', '0', 'admin', '2025-09-25 01:37:49', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, '否', 'N', 'sys_yes_no', 2, '', 'danger', 'N', '0', 'admin', '2025-09-25 01:37:49', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, '通知', '1', 'sys_notice_type', 1, '', 'warning', 'Y', '0', 'admin', '2025-09-25 01:37:49', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, '公告', '2', 'sys_notice_type', 2, '', 'success', 'N', '0', 'admin', '2025-09-25 01:37:49', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, '正常', '0', 'sys_notice_status', 1, '', 'primary', 'Y', '0', 'admin', '2025-09-25 01:37:49', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, '关闭', '1', 'sys_notice_status', 2, '', 'danger', 'N', '0', 'admin', '2025-09-25 01:37:49', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, '其他', '0', 'sys_oper_type', 99, '', 'info', 'N', '0', 'admin', '2025-09-25 01:37:49', '', NULL, '其他操作');
INSERT INTO `sys_dict_data` VALUES (19, '新增', '1', 'sys_oper_type', 1, '', 'info', 'N', '0', 'admin', '2025-09-25 01:37:49', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (20, '修改', '2', 'sys_oper_type', 2, '', 'info', 'N', '0', 'admin', '2025-09-25 01:37:49', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (21, '删除', '3', 'sys_oper_type', 3, '', 'danger', 'N', '0', 'admin', '2025-09-25 01:37:49', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (22, '授权', '4', 'sys_oper_type', 4, '', 'primary', 'N', '0', 'admin', '2025-09-25 01:37:49', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (23, '导出', '5', 'sys_oper_type', 5, '', 'warning', 'N', '0', 'admin', '2025-09-25 01:37:49', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (24, '导入', '6', 'sys_oper_type', 6, '', 'warning', 'N', '0', 'admin', '2025-09-25 01:37:49', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (25, '强退', '7', 'sys_oper_type', 7, '', 'danger', 'N', '0', 'admin', '2025-09-25 01:37:49', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (26, '生成代码', '8', 'sys_oper_type', 8, '', 'warning', 'N', '0', 'admin', '2025-09-25 01:37:49', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (27, '清空数据', '9', 'sys_oper_type', 9, '', 'danger', 'N', '0', 'admin', '2025-09-25 01:37:49', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (28, '成功', '0', 'sys_common_status', 1, '', 'primary', 'N', '0', 'admin', '2025-09-25 01:37:49', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (29, '失败', '1', 'sys_common_status', 2, '', 'danger', 'N', '0', 'admin', '2025-09-25 01:37:49', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (100, '是', '1', 'biz_yes_no', 0, NULL, 'default', 'N', '0', 'leejie', '2025-11-12 09:33:43', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (101, '否', '0', 'biz_yes_no', 1, NULL, 'default', 'N', '0', 'leejie', '2025-11-12 09:33:58', 'leejie', '2025-11-12 09:34:03', NULL);
INSERT INTO `sys_dict_data` VALUES (102, '原创', '1', 'biz_article_type', 0, NULL, 'default', 'N', '0', 'leejie', '2025-11-13 02:47:02', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (103, '转载', '2', 'biz_article_type', 1, NULL, 'default', 'N', '0', 'leejie', '2025-11-13 02:47:11', 'leejie', '2025-11-13 02:47:29', NULL);
INSERT INTO `sys_dict_data` VALUES (104, '翻译', '3', 'biz_article_type', 2, NULL, 'default', 'N', '0', 'leejie', '2025-11-13 02:47:24', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (105, '公开', '1', 'biz_article_status', 0, NULL, 'default', 'N', '0', 'leejie', '2025-11-13 02:47:24', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (106, '私密', '2', 'biz_article_status', 1, NULL, 'default', 'N', '0', 'leejie', '2025-11-13 06:34:14', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (107, '草稿', '3', 'biz_article_status', 2, NULL, 'default', 'N', '0', 'leejie', '2025-11-13 06:34:24', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 103 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典类型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2025-09-25 01:37:48', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2025-09-25 01:37:48', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2025-09-25 01:37:48', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2025-09-25 01:37:48', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2025-09-25 01:37:48', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2025-09-25 01:37:48', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2025-09-25 01:37:48', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2025-09-25 01:37:48', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2025-09-25 01:37:48', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2025-09-25 01:37:48', '', NULL, '登录状态列表');
INSERT INTO `sys_dict_type` VALUES (100, '业务是否', 'biz_yes_no', '0', 'leejie', '2025-11-12 09:33:25', '', NULL, NULL);
INSERT INTO `sys_dict_type` VALUES (101, '文章类型', 'biz_article_type', '0', 'leejie', '2025-11-13 02:46:23', '', NULL, NULL);
INSERT INTO `sys_dict_type` VALUES (102, '文章状态', 'biz_article_status', '0', 'leejie', '2025-11-13 06:18:43', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `job_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '定时任务调度表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2025-09-25 01:37:49', '', NULL, '');
INSERT INTO `sys_job` VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2025-09-25 01:37:50', '', NULL, '');
INSERT INTO `sys_job` VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2025-09-25 01:37:50', '', NULL, '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `job_log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '异常信息',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE,
  INDEX `idx_sys_logininfor_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_logininfor_lt`(`login_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 138 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统访问记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (100, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码已失效', '2025-09-25 02:44:03');
INSERT INTO `sys_logininfor` VALUES (101, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-25 02:44:20');
INSERT INTO `sys_logininfor` VALUES (102, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-25 03:06:11');
INSERT INTO `sys_logininfor` VALUES (103, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-25 03:06:30');
INSERT INTO `sys_logininfor` VALUES (104, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-25 04:20:33');
INSERT INTO `sys_logininfor` VALUES (105, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-25 04:25:12');
INSERT INTO `sys_logininfor` VALUES (106, 'leejie', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-09-25 04:25:22');
INSERT INTO `sys_logininfor` VALUES (107, 'leejie', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-25 04:29:30');
INSERT INTO `sys_logininfor` VALUES (108, 'leejie', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-25 04:29:50');
INSERT INTO `sys_logininfor` VALUES (109, 'leejie', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-25 04:29:59');
INSERT INTO `sys_logininfor` VALUES (110, 'leejie', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码已失效', '2025-09-25 05:35:40');
INSERT INTO `sys_logininfor` VALUES (111, 'leejie', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-25 05:35:45');
INSERT INTO `sys_logininfor` VALUES (112, 'leejie', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-25 05:36:41');
INSERT INTO `sys_logininfor` VALUES (113, 'leejie', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-25 06:31:22');
INSERT INTO `sys_logininfor` VALUES (114, 'leejie', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-11 09:32:50');
INSERT INTO `sys_logininfor` VALUES (115, 'leejie', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-13 01:16:27');
INSERT INTO `sys_logininfor` VALUES (116, 'leejie', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-13 01:32:16');
INSERT INTO `sys_logininfor` VALUES (117, 'leejie', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-13 01:32:26');
INSERT INTO `sys_logininfor` VALUES (118, 'leejie', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-13 04:36:46');
INSERT INTO `sys_logininfor` VALUES (119, 'leejie', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码已失效', '2025-10-29 02:24:26');
INSERT INTO `sys_logininfor` VALUES (120, 'leejie', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 08:10:57');
INSERT INTO `sys_logininfor` VALUES (121, 'leejie', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-03 09:49:51');
INSERT INTO `sys_logininfor` VALUES (122, 'leejie', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-07 02:41:07');
INSERT INTO `sys_logininfor` VALUES (123, 'leejie', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-07 03:05:54');
INSERT INTO `sys_logininfor` VALUES (124, 'leejie', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-07 03:06:01');
INSERT INTO `sys_logininfor` VALUES (125, 'leejie', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-07 03:06:15');
INSERT INTO `sys_logininfor` VALUES (126, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-11-07 03:06:25');
INSERT INTO `sys_logininfor` VALUES (127, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-11-07 03:06:34');
INSERT INTO `sys_logininfor` VALUES (128, 'leejie', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-07 03:07:17');
INSERT INTO `sys_logininfor` VALUES (129, 'leejie', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-07 03:15:55');
INSERT INTO `sys_logininfor` VALUES (130, 'leejie', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-07 03:20:32');
INSERT INTO `sys_logininfor` VALUES (131, 'leejie', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-07 05:37:29');
INSERT INTO `sys_logininfor` VALUES (132, 'leejie', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-07 07:22:01');
INSERT INTO `sys_logininfor` VALUES (133, 'leejie', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-10 03:23:18');
INSERT INTO `sys_logininfor` VALUES (134, 'leejie', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-11-10 07:06:14');
INSERT INTO `sys_logininfor` VALUES (135, 'leejie', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-10 07:06:17');
INSERT INTO `sys_logininfor` VALUES (136, 'leejie', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-10 09:13:44');
INSERT INTO `sys_logininfor` VALUES (137, 'leejie', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-10 09:24:16');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '路由参数',
  `route_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '路由名称',
  `is_frame` int NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_by_id` bigint NULL DEFAULT NULL COMMENT '创建人id',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_by_id` bigint NULL DEFAULT NULL COMMENT '更新人id',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2015 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '菜单权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 1, 'system', NULL, '', '', 1, 0, 'M', '0', '0', '', 'system', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 2, 'monitor', NULL, '', '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '系统监控目录');
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 3, 'tool', NULL, '', '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '系统工具目录');
INSERT INTO `sys_menu` VALUES (4, '若依官网', 0, 4, 'http://ruoyi.vip', NULL, '', '', 0, 0, 'M', '0', '0', '', 'guide', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '若依官网地址');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '参数设置菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '通知公告菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '日志管理菜单');
INSERT INTO `sys_menu` VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '在线用户菜单');
INSERT INTO `sys_menu` VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', '', '', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '定时任务菜单');
INSERT INTO `sys_menu` VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', '', '', 1, 0, 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '数据监控菜单');
INSERT INTO `sys_menu` VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', '', '', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '服务监控菜单');
INSERT INTO `sys_menu` VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '缓存监控菜单');
INSERT INTO `sys_menu` VALUES (114, '缓存列表', 2, 6, 'cacheList', 'monitor/cache/list', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis-list', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '缓存列表菜单');
INSERT INTO `sys_menu` VALUES (115, '表单构建', 3, 1, 'build', 'tool/build/index', '', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '表单构建菜单');
INSERT INTO `sys_menu` VALUES (116, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '代码生成菜单');
INSERT INTO `sys_menu` VALUES (117, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', '', '', 1, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '系统接口菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1000, '用户查询', 100, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1001, '用户新增', 100, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户修改', 100, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户删除', 100, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户导出', 100, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导入', 100, 6, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '重置密码', 100, 7, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '角色查询', 101, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色新增', 101, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色修改', 101, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色删除', 101, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色导出', 101, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '菜单查询', 102, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单新增', 102, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单修改', 102, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单删除', 102, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '部门查询', 103, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '部门新增', 103, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '部门修改', 103, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '部门删除', 103, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '岗位查询', 104, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '岗位新增', 104, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '岗位修改', 104, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '岗位删除', 104, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '岗位导出', 104, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '字典查询', 105, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典新增', 105, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '字典修改', 105, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '字典删除', 105, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1029, '字典导出', 105, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '参数查询', 106, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '参数新增', 106, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '参数修改', 106, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '参数删除', 106, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1034, '参数导出', 106, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '公告查询', 107, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1036, '公告新增', 107, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1037, '公告修改', 107, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1038, '公告删除', 107, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1039, '操作查询', 500, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '操作删除', 500, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '日志导出', 500, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '登录查询', 501, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '登录删除', 501, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '日志导出', 501, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '账户解锁', 501, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1046, '在线查询', 109, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1047, '批量强退', 109, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1048, '单条强退', 109, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1049, '任务查询', 110, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1050, '任务新增', 110, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1051, '任务修改', 110, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1052, '任务删除', 110, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1053, '状态修改', 110, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1054, '任务导出', 110, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1055, '生成查询', 116, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1056, '生成修改', 116, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1057, '生成删除', 116, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1058, '导入代码', 116, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1059, '预览代码', 116, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1060, '生成代码', 116, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2000, '博客管理', 0, 1, 'blog', NULL, NULL, '', 1, 0, 'M', '0', '0', '', 'edit', 'leejie', NULL, '2025-11-07 03:01:16', 'leejie', NULL, '2025-11-07 03:29:23', '');
INSERT INTO `sys_menu` VALUES (2002, '文章管理', 2000, 1, 'article', 'biz/article/index', NULL, '', 1, 0, 'C', '0', '0', 'biz:article:index', '#', 'admin', NULL, '2025-11-11 01:38:36', 'leejie', NULL, '2025-11-14 06:58:53', '文章菜单');
INSERT INTO `sys_menu` VALUES (2003, '文章查询', 2002, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'blog:article:query', '#', 'admin', NULL, '2025-11-11 01:38:37', 'leejie', NULL, '2025-11-11 01:40:23', '');
INSERT INTO `sys_menu` VALUES (2004, '文章新增', 2002, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'blog:article:add', '#', 'admin', NULL, '2025-11-11 01:38:37', 'leejie', NULL, '2025-11-11 01:40:28', '');
INSERT INTO `sys_menu` VALUES (2005, '文章修改', 2002, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'blog:article:edit', '#', 'admin', NULL, '2025-11-11 01:38:37', 'leejie', NULL, '2025-11-11 01:40:32', '');
INSERT INTO `sys_menu` VALUES (2006, '文章删除', 2002, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'blog:article:remove', '#', 'admin', NULL, '2025-11-11 01:38:37', 'leejie', NULL, '2025-11-11 01:40:36', '');
INSERT INTO `sys_menu` VALUES (2007, '文章导出', 2002, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'blog:article:export', '#', 'admin', NULL, '2025-11-11 01:38:37', 'leejie', NULL, '2025-11-11 01:40:41', '');
INSERT INTO `sys_menu` VALUES (2008, '文章分类', 2000, 2, 'category', 'biz/category/index', NULL, '', 1, 0, 'C', '0', '0', 'biz:category:index', '#', 'admin', NULL, '2025-11-14 06:43:39', '', NULL, NULL, '文章分类菜单');
INSERT INTO `sys_menu` VALUES (2009, '文章分类查询', 2008, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'biz:category:query', '#', 'admin', NULL, '2025-11-14 06:43:40', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2010, '文章分类新增', 2008, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'biz:category:add', '#', 'admin', NULL, '2025-11-14 06:43:40', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2011, '文章分类修改', 2008, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'biz:category:edit', '#', 'admin', NULL, '2025-11-14 06:43:40', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2012, '文章分类删除', 2008, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'biz:category:remove', '#', 'admin', NULL, '2025-11-14 06:43:40', '', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2013, '文章分类导出', 2008, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'biz:category:export', '#', 'admin', NULL, '2025-11-14 06:43:40', '', NULL, NULL, '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_by_id` bigint NULL DEFAULT NULL COMMENT '创建人id',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_by_id` bigint NULL DEFAULT NULL COMMENT '更新人id',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '通知公告表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (1, '温馨提醒：2018-07-01 若依新版本发布啦', '2', 0xE696B0E78988E69CACE58685E5AEB9, '0', 'admin', NULL, '2025-09-25 01:37:50', '', NULL, NULL, '管理员');
INSERT INTO `sys_notice` VALUES (2, '维护通知：2018-07-01 若依系统凌晨维护', '1', 0xE7BBB4E68AA4E58685E5AEB9, '0', 'admin', NULL, '2025-09-25 01:37:50', '', NULL, NULL, '管理员');

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint NULL DEFAULT 0 COMMENT '消耗时间',
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_by_id` bigint NULL DEFAULT NULL COMMENT '创建人id',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`oper_id`) USING BTREE,
  INDEX `idx_sys_oper_log_bt`(`business_type` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_ot`(`oper_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1990329368776077315 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '操作日志记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (100, '角色管理', 3, 'com.ruoyi.web.controller.system.SysRoleController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/role/2', '127.0.0.1', '内网IP', '[2]', NULL, 1, '普通角色已分配,不能删除', '2025-09-25 04:22:14', 155, NULL, NULL, NULL);
INSERT INTO `sys_oper_log` VALUES (101, '角色管理', 1, 'com.ruoyi.web.controller.system.SysRoleController.add()', 'POST', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"deptCheckStrictly\":true,\"deptIds\":[],\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,3,115,116,1055,1056,1057,1058,1059,1060,117],\"params\":{},\"roleId\":100,\"roleKey\":\"lee-admin\",\"roleName\":\"超超管\",\"roleSort\":0,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-25 04:23:33', 105, NULL, NULL, NULL);
INSERT INTO `sys_oper_log` VALUES (102, '用户管理', 3, 'com.ruoyi.web.controller.system.SysUserController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/user/2', '127.0.0.1', '内网IP', '[2]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-25 04:23:54', 85, NULL, NULL, NULL);
INSERT INTO `sys_oper_log` VALUES (103, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.changeStatus()', 'PUT', 1, 'admin', '研发部门', '/system/user/changeStatus', '127.0.0.1', '内网IP', '{\"admin\":true,\"params\":{},\"status\":\"1\",\"userId\":1}', NULL, 1, '不允许操作超级管理员用户', '2025-09-25 04:23:57', 4, NULL, NULL, NULL);
INSERT INTO `sys_oper_log` VALUES (104, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"deptId\":100,\"nickName\":\"leejie\",\"params\":{},\"phonenumber\":\"18888888888\",\"postIds\":[],\"roleIds\":[100],\"status\":\"0\",\"userId\":100,\"userName\":\"leejie\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-25 04:24:29', 227, NULL, NULL, NULL);
INSERT INTO `sys_oper_log` VALUES (105, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.resetPwd()', 'PUT', 1, 'admin', '研发部门', '/system/user/resetPwd', '127.0.0.1', '内网IP', '{\"admin\":false,\"params\":{},\"updateBy\":\"admin\",\"userId\":100}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-25 04:24:43', 115, NULL, NULL, NULL);
INSERT INTO `sys_oper_log` VALUES (106, '个人信息', 2, 'blog.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'leejie', '若依科技', '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"email\":\"leejieqaq@163.com\",\"nickName\":\"leejie\",\"params\":{},\"phonenumber\":\"18888888888\",\"sex\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-07 02:43:20', 104, NULL, NULL, NULL);
INSERT INTO `sys_oper_log` VALUES (107, '部门管理', 2, 'blog.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'leejie', '若依科技', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0\",\"children\":[],\"deptId\":100,\"deptName\":\"咯咯科技\",\"email\":\"leejieqaq@163.com\",\"leader\":\"leejie\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"phone\":\"18988888888\",\"status\":\"0\",\"updateBy\":\"leejie\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-07 02:44:15', 60, NULL, NULL, NULL);
INSERT INTO `sys_oper_log` VALUES (108, '部门管理', 3, 'blog.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'leejie', '若依科技', '/system/dept/101', '127.0.0.1', '内网IP', '101', '{\"msg\":\"存在下级部门,不允许删除\",\"code\":601}', 0, NULL, '2025-11-07 02:44:30', 14, NULL, NULL, NULL);
INSERT INTO `sys_oper_log` VALUES (109, '部门管理', 3, 'blog.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'leejie', '若依科技', '/system/dept/103', '127.0.0.1', '内网IP', '103', '{\"msg\":\"部门存在用户,不允许删除\",\"code\":601}', 0, NULL, '2025-11-07 02:44:36', 21, NULL, NULL, NULL);
INSERT INTO `sys_oper_log` VALUES (110, '部门管理', 3, 'blog.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'leejie', '若依科技', '/system/dept/103', '127.0.0.1', '内网IP', '103', '{\"msg\":\"部门存在用户,不允许删除\",\"code\":601}', 0, NULL, '2025-11-07 02:44:38', 30, NULL, NULL, NULL);
INSERT INTO `sys_oper_log` VALUES (111, '部门管理', 3, 'blog.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'leejie', '若依科技', '/system/dept/103', '127.0.0.1', '内网IP', '103', '{\"msg\":\"部门存在用户,不允许删除\",\"code\":601}', 0, NULL, '2025-11-07 02:44:51', 42, NULL, NULL, NULL);
INSERT INTO `sys_oper_log` VALUES (112, '部门管理', 3, 'blog.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'leejie', '若依科技', '/system/dept/104', '127.0.0.1', '内网IP', '104', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-07 02:55:53', 10063, NULL, NULL, NULL);
INSERT INTO `sys_oper_log` VALUES (113, '部门管理', 3, 'blog.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'leejie', '若依科技', '/system/dept/104', '127.0.0.1', '内网IP', '104', NULL, 1, '没有权限访问部门数据！', '2025-11-07 02:56:00', 1736, NULL, NULL, NULL);
INSERT INTO `sys_oper_log` VALUES (114, '菜单管理', 1, 'blog.web.controller.system.SysMenuController.add()', 'POST', 1, 'leejie', '若依科技', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"leejie\",\"icon\":\"edit\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"博客管理\",\"menuType\":\"M\",\"orderNum\":2,\"params\":{},\"parentId\":0,\"path\":\"blog\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-07 03:01:16', 87, NULL, NULL, NULL);
INSERT INTO `sys_oper_log` VALUES (115, '菜单管理', 1, 'blog.web.controller.system.SysMenuController.add()', 'POST', 1, 'leejie', '若依科技', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"icon\":\"edit\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"博客管理\",\"menuType\":\"M\",\"orderNum\":2,\"params\":{},\"parentId\":0,\"path\":\"blog\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"新增菜单\'博客管理\'失败，菜单名称已存在\",\"code\":500}', 0, NULL, '2025-11-07 03:01:46', 9, NULL, NULL, NULL);
INSERT INTO `sys_oper_log` VALUES (116, '菜单管理', 2, 'blog.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'leejie', '咯咯科技', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-11-07 03:01:16\",\"icon\":\"edit\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"博客管理\",\"menuType\":\"M\",\"orderNum\":1,\"params\":{},\"parentId\":0,\"path\":\"blog\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"leejie\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-07 03:29:24', 86, NULL, NULL, NULL);
INSERT INTO `sys_oper_log` VALUES (117, '菜单管理', 1, 'blog.web.controller.system.SysMenuController.add()', 'POST', 1, 'leejie', '咯咯科技', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"leejie\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"类别管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"blogType\",\"perms\":\"blogType\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-07 03:39:11', 71, NULL, NULL, NULL);
INSERT INTO `sys_oper_log` VALUES (118, '菜单管理', 2, 'blog.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'leejie', '咯咯科技', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-11-07 03:39:11\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"类别管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"blogType\",\"perms\":\"blogType\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"leejie\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-07 03:40:29', 51, NULL, NULL, NULL);
INSERT INTO `sys_oper_log` VALUES (119, '代码生成', 6, 'blog.generator.controller.GenController.importTableSave()', 'POST', 1, 'leejie', '咯咯科技', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"biz_article\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-07 07:22:56', 417, NULL, NULL, NULL);
INSERT INTO `sys_oper_log` VALUES (120, '代码生成', 8, 'blog.generator.controller.GenController.batchGenCode()', 'GET', 1, 'leejie', '咯咯科技', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"biz_article\"}', NULL, 0, NULL, '2025-11-07 07:23:34', 376, NULL, NULL, NULL);
INSERT INTO `sys_oper_log` VALUES (121, '代码生成', 2, 'blog.generator.controller.GenController.editSave()', 'PUT', 1, 'leejie', '咯咯科技', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"article\",\"className\":\"BizArticle\",\"columns\":[{\"capJavaField\":\"Id\",\"columnId\":1,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"leejie\",\"createTime\":\"2025-11-07 07:22:56\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"作者\",\"columnId\":2,\"columnName\":\"user_id\",\"columnType\":\"bigint\",\"createBy\":\"leejie\",\"createTime\":\"2025-11-07 07:22:56\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"CategoryId\",\"columnComment\":\"文章分类\",\"columnId\":3,\"columnName\":\"category_id\",\"columnType\":\"bigint\",\"createBy\":\"leejie\",\"createTime\":\"2025-11-07 07:22:56\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"categoryId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ArticleCover\",\"columnComment\":\"文章缩略图\",\"columnId\":4,\"columnName\":\"article_cover\",\"columnType\":\"varchar(1024)\",\"createBy\":\"leejie\",\"createTime\":\"2025-11-07 07:22:56\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"textarea\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"articleCover\",\"jav', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-07 07:37:03', 261, NULL, NULL, NULL);
INSERT INTO `sys_oper_log` VALUES (122, '代码生成', 8, 'blog.generator.controller.GenController.batchGenCode()', 'GET', 1, 'leejie', '咯咯科技', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"biz_article\"}', NULL, 0, NULL, '2025-11-07 07:37:06', 430, NULL, NULL, NULL);
INSERT INTO `sys_oper_log` VALUES (123, '代码生成', 2, 'blog.generator.controller.GenController.editSave()', 'PUT', 1, 'leejie', '咯咯科技', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"article\",\"className\":\"Article\",\"columns\":[{\"capJavaField\":\"Id\",\"columnId\":1,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"leejie\",\"createTime\":\"2025-11-07 07:22:56\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-11-07 07:37:03\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"作者\",\"columnId\":2,\"columnName\":\"user_id\",\"columnType\":\"bigint\",\"createBy\":\"leejie\",\"createTime\":\"2025-11-07 07:22:56\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-11-07 07:37:03\",\"usableColumn\":false},{\"capJavaField\":\"CategoryId\",\"columnComment\":\"文章分类\",\"columnId\":3,\"columnName\":\"category_id\",\"columnType\":\"bigint\",\"createBy\":\"leejie\",\"createTime\":\"2025-11-07 07:22:56\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"categoryId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-11-07 07:37:03\",\"usableColumn\":false},{\"capJavaField\":\"ArticleCover\",\"columnComment\":\"文章缩略图\",\"columnId\":4,\"columnName\":\"article_cover\",\"columnType\":\"varchar(1024)\",\"createBy\":\"leejie\",\"createTime\":\"2025-11-07 07:22:56\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"textarea\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\"', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-07 07:53:52', 247, NULL, NULL, NULL);
INSERT INTO `sys_oper_log` VALUES (124, '代码生成', 8, 'blog.generator.controller.GenController.batchGenCode()', 'GET', 1, 'leejie', '咯咯科技', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"biz_article\"}', NULL, 0, NULL, '2025-11-07 07:53:56', 517, NULL, NULL, NULL);
INSERT INTO `sys_oper_log` VALUES (125, '用户管理', 2, 'blog.web.controller.system.SysUserController.edit()', 'PUT', 1, 'leejie', '咯咯科技', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":true,\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2025-09-25 04:24:29\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0\",\"children\":[],\"deptId\":100,\"deptName\":\"咯咯科技\",\"leader\":\"leejie\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"status\":\"0\"},\"deptId\":100,\"email\":\"leejieqaq@163.com\",\"loginDate\":\"2025-11-10 15:06:18\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"leejie1\",\"params\":{},\"phonenumber\":\"18888888888\",\"postIds\":[],\"pwdUpdateDate\":\"2025-09-25 04:24:43\",\"roleIds\":[100],\"roles\":[{\"admin\":false,\"dataScope\":\"1\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":100,\"roleKey\":\"lee-admin\",\"roleName\":\"超超管\",\"roleSort\":0,\"status\":\"0\"}],\"sex\":\"0\",\"status\":\"0\",\"userId\":100,\"userName\":\"leejie\"}', NULL, 1, '不允许操作超级管理员用户', '2025-11-10 07:06:29', 36, NULL, NULL, NULL);
INSERT INTO `sys_oper_log` VALUES (126, '菜单管理', 2, 'blog.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'leejie', '咯咯科技', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-11-07 03:39:11\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"文章管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"blog/article/index\",\"perms\":\"blog:article:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"leejie\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-10 09:17:50', 98, NULL, NULL, NULL);
INSERT INTO `sys_oper_log` VALUES (127, '菜单管理', 2, 'blog.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'leejie', '咯咯科技', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"blog/article/index\",\"createTime\":\"2025-11-07 03:39:11\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"文章管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"blog/article/index\",\"perms\":\"blog:article:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"leejie\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-10 09:18:17', 28, NULL, NULL, NULL);
INSERT INTO `sys_oper_log` VALUES (128, '菜单管理', 2, 'blog.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'leejie', '咯咯科技', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"blog/article/index\",\"createTime\":\"2025-11-07 03:39:11\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"文章管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"article\",\"perms\":\"blog:article:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"leejie\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-10 09:18:29', 21, NULL, NULL, NULL);
INSERT INTO `sys_oper_log` VALUES (129, '菜单管理', 2, 'blog.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'leejie', '咯咯科技', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"blog/article/index\",\"createTime\":\"2025-11-07 03:39:11\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"文章管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"article\",\"perms\":\"blog:article:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"leejie\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-10 09:24:09', 59, NULL, NULL, NULL);
INSERT INTO `sys_oper_log` VALUES (1989262192069656577, '文章', 2, 'blog.web.controller.business.ArticleController.edit()', 'PUT', 1, 'leejie', '咯咯科技', '/system/article', '127.0.0.1', '内网IP', '{\"articleAbstract\":\"这是一段文章摘要123\",\"articleContent\":\"11月10日，外交部发言人林剑主持例行记者会。有记者就日本首相高市早苗在国会答问时发表涉台错误言论提问。林剑表示，日本领导人日前在国会公然发表涉台错误言论，暗示武力介入台海可能性，粗暴干涉中国内政，严重违背一个中国原则、中日四个政治文件精神和国际关系基本准则，同日本政府迄今所做的政治承诺严重不符，性质和影响极其恶劣。中方对此强烈不满、坚决反对，已向日方提出严正交涉和强烈抗议。台湾是中国的台湾，以何种方式解决台湾问题，实现国家统一，纯属中国内政，不容任何外部势力干涉。<strong>日方领导人有关言论到底想向“台独”势力发出何种信号？是否企图挑战中方核心利益、阻挠中国统一大业？究竟想把中日关系引向何方？</strong>今年是中国人民抗日战争暨世界反法西斯战争胜利80周年，也是台湾光复80周年。日本曾对台湾实行殖民统治，犯下罄竹难书的罪行。日本当政者妄图介入台海事务，既是对国际正义的践踏、对战后国际秩序的挑衅，也是对中日关系的严重破坏。中国终将统一，也必将统一。中国人民有坚定的意志、充分的信心、足够的能力，坚决粉碎一切插手和阻挠中国统一大业的图谋。中方敦促日方立即停止干涉中国内政，停止挑衅越线，不要在错误道路上越走越远。\",\"articleCover\":\"/profile/upload/2025/11/11/0E27D31F-3A44-4275-BB35-7FD3DCC80B5E_20251111103544A001.png,/profile/upload/2025/11/13/屏幕截图 2025-06-04 121415_20251113135053A001.jpg\",\"articleTitle\":\"新闻1111\",\"categoryId\":1,\"createBy\":\"leejie\",\"createById\":100,\"createTime\":\"2025-11-11 10:44:07\",\"id\":\"1988075234175889410\",\"isDelete\":0,\"isFeatured\":1,\"isTop\":1,\"originalUrl\":\"https://baijiahao.baidu.com/s?id=1848389250496052621\",\"params\":{},\"status\":1,\"type\":1,\"updateBy\":\"leejie\",\"updateById\":100,\"updateTime\":\"2025-11-14 17:20:39\",\"userId\":100}', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 54, 'leejie', 100, '2025-11-14 17:20:40');
INSERT INTO `sys_oper_log` VALUES (1989262268234022913, '文章', 2, 'blog.web.controller.business.ArticleController.edit()', 'PUT', 1, 'leejie', '咯咯科技', '/system/article', '127.0.0.1', '内网IP', '{\"articleAbstract\":\"这是一段文章摘要\",\"articleContent\":\"11月10日，外交部发言人林剑主持例行记者会。有记者就日本首相高市早苗在国会答问时发表涉台错误言论提问。林剑表示，日本领导人日前在国会公然发表涉台错误言论，暗示武力介入台海可能性，粗暴干涉中国内政，严重违背一个中国原则、中日四个政治文件精神和国际关系基本准则，同日本政府迄今所做的政治承诺严重不符，性质和影响极其恶劣。中方对此强烈不满、坚决反对，已向日方提出严正交涉和强烈抗议。台湾是中国的台湾，以何种方式解决台湾问题，实现国家统一，纯属中国内政，不容任何外部势力干涉。<strong>日方领导人有关言论到底想向“台独”势力发出何种信号？是否企图挑战中方核心利益、阻挠中国统一大业？究竟想把中日关系引向何方？</strong>今年是中国人民抗日战争暨世界反法西斯战争胜利80周年，也是台湾光复80周年。日本曾对台湾实行殖民统治，犯下罄竹难书的罪行。日本当政者妄图介入台海事务，既是对国际正义的践踏、对战后国际秩序的挑衅，也是对中日关系的严重破坏。中国终将统一，也必将统一。中国人民有坚定的意志、充分的信心、足够的能力，坚决粉碎一切插手和阻挠中国统一大业的图谋。中方敦促日方立即停止干涉中国内政，停止挑衅越线，不要在错误道路上越走越远。\",\"articleCover\":\"/profile/upload/2025/11/11/0E27D31F-3A44-4275-BB35-7FD3DCC80B5E_20251111103544A001.png,/profile/upload/2025/11/13/屏幕截图 2025-06-04 121415_20251113135053A001.jpg\",\"articleTitle\":\"新闻1111\",\"categoryId\":1,\"createBy\":\"leejie\",\"createById\":100,\"createTime\":\"2025-11-11 10:44:07\",\"id\":\"1988075234175889410\",\"isDelete\":0,\"isFeatured\":1,\"isTop\":1,\"originalUrl\":\"https://baijiahao.baidu.com/s?id=1848389250496052621\",\"params\":{},\"status\":1,\"type\":1,\"updateBy\":\"leejie\",\"updateById\":100,\"updateTime\":\"2025-11-14 17:20:58\",\"userId\":100}', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 27, 'leejie', 100, '2025-11-14 17:20:58');
INSERT INTO `sys_oper_log` VALUES (1989263166452613122, '文章', 3, 'blog.web.controller.business.ArticleController.remove()', 'DELETE', 1, 'leejie', '咯咯科技', '/system/article/1988850192932458505', '127.0.0.1', '内网IP', '[1988850192932458505]', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 65, 'leejie', 100, '2025-11-14 17:24:32');
INSERT INTO `sys_oper_log` VALUES (1989263296195018754, '文章', 3, 'blog.web.controller.business.ArticleController.remove()', 'DELETE', 1, 'leejie', '咯咯科技', '/system/article/1988850192932458506', '127.0.0.1', '内网IP', '[1988850192932458506]', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 37, 'leejie', 100, '2025-11-14 17:25:03');
INSERT INTO `sys_oper_log` VALUES (1989263878616027137, '文章', 3, 'blog.web.controller.business.ArticleController.remove()', 'DELETE', 1, 'leejie', '咯咯科技', '/system/article/1988850192932458504,1988850192932458503,1988850192932458502', '127.0.0.1', '内网IP', '[1988850192932458504,1988850192932458503,1988850192932458502]', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 77, 'leejie', 100, '2025-11-14 17:27:22');
INSERT INTO `sys_oper_log` VALUES (1989265071710965762, '文章分类', 3, 'blog.web.controller.business.CategoryController.remove()', 'DELETE', 1, 'leejie', '咯咯科技', '/biz/category/1989241166292660225', '127.0.0.1', '内网IP', '[1989241166292660225]', '{\"code\":200,\"msg\":\"操作成功\"}', 0, '', NULL, 109377, 'leejie', 100, '2025-11-14 17:32:07');
INSERT INTO `sys_oper_log` VALUES (1989266508247482369, '文章分类', 1, 'blog.web.controller.business.CategoryController.add()', 'POST', 1, 'leejie', '咯咯科技', '/biz/category', '127.0.0.1', '内网IP', '{\"categoryName\":\"123\",\"params\":{}}', '{\"code\":200,\"msg\":\"操作成功\"}', 0, '', NULL, 218, 'leejie', 100, '2025-11-14 17:37:49');
INSERT INTO `sys_oper_log` VALUES (1989266520134139906, '文章分类', 3, 'blog.web.controller.business.CategoryController.remove()', 'DELETE', 1, 'leejie', '咯咯科技', '/biz/category/1989266507538644993', '127.0.0.1', '内网IP', '[1989266507538644993]', '{\"code\":200,\"msg\":\"操作成功\"}', 0, '', NULL, 97, 'leejie', 100, '2025-11-14 17:37:52');
INSERT INTO `sys_oper_log` VALUES (1989267355282980866, '文章分类', 3, 'blog.web.controller.business.CategoryController.remove()', 'DELETE', 1, 'leejie', '咯咯科技', '/biz/category/1989231183710740482', '127.0.0.1', '内网IP', '[1989231183710740482]', '{\"code\":200,\"msg\":\"操作成功\"}', 0, '', NULL, 45, 'leejie', 100, '2025-11-14 17:41:11');
INSERT INTO `sys_oper_log` VALUES (1989267640688631810, '文章分类', 3, 'blog.web.controller.business.CategoryController.remove()', 'DELETE', 1, 'leejie', '咯咯科技', '/biz/category/1989231087648595970', '127.0.0.1', '内网IP', '[1989231087648595970]', '{\"code\":200,\"msg\":\"操作成功\"}', 0, '', NULL, 210, 'leejie', 100, '2025-11-14 17:42:19');
INSERT INTO `sys_oper_log` VALUES (1989269362098102274, '文章', 3, 'blog.web.controller.business.ArticleController.remove()', 'DELETE', 1, 'leejie', '咯咯科技', '/system/article/1988850192932458504', '127.0.0.1', '内网IP', '[1988850192932458504]', '{\"msg\":\"操作失败\",\"code\":500}', 0, '', NULL, 38, 'leejie', 100, '2025-11-14 17:49:09');
INSERT INTO `sys_oper_log` VALUES (1989269404447989761, '文章', 3, 'blog.web.controller.business.ArticleController.remove()', 'DELETE', 1, 'leejie', '咯咯科技', '/system/article/1988850192932458504', '127.0.0.1', '内网IP', '[1988850192932458504]', '{\"msg\":\"操作失败\",\"code\":500}', 0, '', NULL, 14, 'leejie', 100, '2025-11-14 17:49:20');
INSERT INTO `sys_oper_log` VALUES (1989269567203762177, '文章', 3, 'blog.web.controller.business.ArticleController.remove()', 'DELETE', 1, 'leejie', '咯咯科技', '/system/article/1988850192932458504', '127.0.0.1', '内网IP', '[1988850192932458504]', '{\"msg\":\"操作失败\",\"code\":500}', 0, '', NULL, 19, 'leejie', 100, '2025-11-14 17:49:58');
INSERT INTO `sys_oper_log` VALUES (1989270736374415362, '文章', 3, 'blog.web.controller.business.ArticleController.remove()', 'DELETE', 1, 'leejie', '咯咯科技', '/system/article/1988850192932458499,1988850192932458500,1988850192932458501', '127.0.0.1', '内网IP', '[1988850192932458499,1988850192932458500,1988850192932458501]', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 122, 'leejie', 100, '2025-11-14 17:54:37');
INSERT INTO `sys_oper_log` VALUES (1990244687183380481, '文章', 1, 'blog.web.controller.business.ArticleController.add()', 'POST', 1, 'leejie', '咯咯科技', '/system/article', '127.0.0.1', '内网IP', '{\"articleAbstract\":\"https://blog.csdn.net/LulGjixu/article/details/154655875\",\"articleContent\":\"一、入门阶段初识Java时充满热情，环境配置顺利，第一个Hello World在控制台跃然而出。基本语法看似简单，变量、循环、条件语句信手拈来，面向对象概念令人耳目一新。此时信心满满，以为编程不过如此。二、进阶挑战随着学习深入，开始接触集合框架、异常处理、多线程编程。概念逐渐复杂，代码量成倍增长。调试过程变得棘手，内存泄漏、线程死锁等问题接踵而至。IDE的报错信息令人困惑，文档查阅频率显著增加。三、框架迷局进入企业级开发，Spring全家桶迎面而来。配置文件错综复杂，依赖注入让人头晕目眩。MyBatis的XML映射、Spring Boot的自动配置、微服务架构的分布式特性，每个新概念都在挑战认知极限。版本兼容性问题频发，依赖冲突令人抓狂。四、现实打击实际项目中，需求变更频繁，技术债堆积如山。代码审查意见密密麻麻，性能优化无从下手。生产环境故障排查如同大海捞针，凌晨三点的报警短信成为常态。新技术层出不穷，学习速度永远跟不上技术迭代。五、放弃时刻某个深夜，面对第N个无法解决的Bug，看着满屏的异常堆栈，终于意识到自己可能永远无法完全掌握这门技术。决定关掉IDE，合上电脑，承认自己与Java的缘分到此为止。六、新的开始放弃不是终点。有人转向项目管理，有人投身其他技术领域，也有人休息后重拾信心。编程之路本就充满选择，重要的是找到适合自己的方向。Java只是工具，而非人生的全部。\",\"articleCover\":\"/profile/upload/2025/11/17/微信图片_20251112101532_36_49_20251117102302A001.jpg\",\"articleTitle\":\"java从入门到放弃\",\"categoryId\":1989230712472264705,\"createBy\":\"leejie\",\"createById\":100,\"createTime\":\"2025-11-17 10:24:44\",\"id\":\"1990244686067695617\",\"isFeatured\":0,\"isTop\":1,\"params\":{},\"status\":2,\"type\":1,\"userId\":100}', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 255, 'leejie', 100, '2025-11-17 10:24:45');
INSERT INTO `sys_oper_log` VALUES (1990249914871640065, '文章', 2, 'blog.web.controller.business.ArticleController.edit()', 'PUT', 1, 'leejie', '咯咯科技', '/system/article', '127.0.0.1', '内网IP', '{\"articleTitle\":\"测试草稿\",\"categoryId\":1989230712472264705,\"createBy\":\"leejie\",\"createById\":100,\"createTime\":\"2025-11-13 14:03:32\",\"id\":\"1988850192932458498\",\"isDelete\":0,\"isFeatured\":0,\"isTop\":0,\"params\":{},\"status\":1,\"type\":1,\"updateBy\":\"leejie\",\"updateById\":100,\"updateTime\":\"2025-11-17 10:45:30\",\"userId\":100}', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 371, 'leejie', 100, '2025-11-17 10:45:31');
INSERT INTO `sys_oper_log` VALUES (1990249944038830081, '文章', 2, 'blog.web.controller.business.ArticleController.edit()', 'PUT', 1, 'leejie', '咯咯科技', '/system/article', '127.0.0.1', '内网IP', '{\"articleAbstract\":\"123123\",\"articleContent\":\"123123123\",\"articleTitle\":\"111111111\",\"categoryId\":1989231087648595970,\"createBy\":\"leejie\",\"createById\":100,\"createTime\":\"2025-11-13 10:59:57\",\"id\":\"1988803995186331649\",\"isDelete\":0,\"isFeatured\":0,\"isTop\":0,\"params\":{},\"status\":2,\"type\":2,\"updateBy\":\"leejie\",\"updateById\":100,\"updateTime\":\"2025-11-17 10:45:38\",\"userId\":100}', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 72, 'leejie', 100, '2025-11-17 10:45:38');
INSERT INTO `sys_oper_log` VALUES (1990249967799562242, '文章', 2, 'blog.web.controller.business.ArticleController.edit()', 'PUT', 1, 'leejie', '咯咯科技', '/system/article', '127.0.0.1', '内网IP', '{\"articleAbstract\":\"这是一段文章摘要\",\"articleContent\":\"11月10日，外交部发言人林剑主持例行记者会。有记者就日本首相高市早苗在国会答问时发表涉台错误言论提问。林剑表示，日本领导人日前在国会公然发表涉台错误言论，暗示武力介入台海可能性，粗暴干涉中国内政，严重违背一个中国原则、中日四个政治文件精神和国际关系基本准则，同日本政府迄今所做的政治承诺严重不符，性质和影响极其恶劣。中方对此强烈不满、坚决反对，已向日方提出严正交涉和强烈抗议。台湾是中国的台湾，以何种方式解决台湾问题，实现国家统一，纯属中国内政，不容任何外部势力干涉。<strong>日方领导人有关言论到底想向“台独”势力发出何种信号？是否企图挑战中方核心利益、阻挠中国统一大业？究竟想把中日关系引向何方？</strong>今年是中国人民抗日战争暨世界反法西斯战争胜利80周年，也是台湾光复80周年。日本曾对台湾实行殖民统治，犯下罄竹难书的罪行。日本当政者妄图介入台海事务，既是对国际正义的践踏、对战后国际秩序的挑衅，也是对中日关系的严重破坏。中国终将统一，也必将统一。中国人民有坚定的意志、充分的信心、足够的能力，坚决粉碎一切插手和阻挠中国统一大业的图谋。中方敦促日方立即停止干涉中国内政，停止挑衅越线，不要在错误道路上越走越远。\",\"articleCover\":\"/profile/upload/2025/11/11/0E27D31F-3A44-4275-BB35-7FD3DCC80B5E_20251111103544A001.png,/profile/upload/2025/11/13/屏幕截图 2025-06-04 121415_20251113135053A001.jpg\",\"articleTitle\":\"新闻1111\",\"categoryId\":1989231087648595970,\"createBy\":\"leejie\",\"createById\":100,\"createTime\":\"2025-11-11 10:44:07\",\"id\":\"1988075234175889410\",\"isDelete\":0,\"isFeatured\":1,\"isTop\":1,\"originalUrl\":\"https://baijiahao.baidu.com/s?id=1848389250496052621\",\"params\":{},\"status\":1,\"type\":1,\"updateBy\":\"leejie\",\"updateById\":100,\"updateTime\":\"2025-11-17 10:45:43\",\"userId\":100}', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 59, 'leejie', 100, '2025-11-17 10:45:44');
INSERT INTO `sys_oper_log` VALUES (1990252710983430146, '文章', 1, 'blog.web.controller.business.ArticleController.add()', 'POST', 1, 'leejie', '咯咯科技', '/system/article', '127.0.0.1', '内网IP', '{\"articleAbstract\":\"ouyangnana\",\"articleContent\":\"ouyanglalallalala\",\"articleCover\":\"/profile/upload/2025/11/17/微信图片_20251112101532_36_49_20251117105605A002.jpg\",\"articleTitle\":\"保存草稿测试\",\"categoryId\":1989230712472264705,\"createBy\":\"leejie\",\"createById\":100,\"createTime\":\"2025-11-17 10:56:37\",\"id\":\"1990252710601748481\",\"isFeatured\":1,\"isTop\":1,\"params\":{},\"status\":3,\"type\":1,\"userId\":100}', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 69, 'leejie', 100, '2025-11-17 10:56:38');
INSERT INTO `sys_oper_log` VALUES (1990326890785468418, '文章', 3, 'blog.web.controller.business.ArticleController.remove()', 'DELETE', 1, 'leejie', '咯咯科技', '/system/article/1988803995186331649', '127.0.0.1', '内网IP', '[1988803995186331649]', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 568, 'leejie', 100, '2025-11-17 15:51:24');
INSERT INTO `sys_oper_log` VALUES (1990326899060830209, '文章', 3, 'blog.web.controller.business.ArticleController.remove()', 'DELETE', 1, 'leejie', '咯咯科技', '/system/article/1988850192932458498', '127.0.0.1', '内网IP', '[1988850192932458498]', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 54, 'leejie', 100, '2025-11-17 15:51:26');
INSERT INTO `sys_oper_log` VALUES (1990328684991279105, '文章', 2, 'blog.web.controller.business.ArticleController.edit()', 'PUT', 1, 'leejie', '咯咯科技', '/system/article', '127.0.0.1', '内网IP', '{\"articleAbstract\":\"https://blog.csdn.net/LulGjixu/article/details/154655875\",\"articleContent\":\"一、入门阶段初识Java时充满热情，环境配置顺利，第一个Hello World在控制台跃然而出。基本语法看似简单，变量、循环、条件语句信手拈来，面向对象概念令人耳目一新。此时信心满满，以为编程不过如此。二、进阶挑战随着学习深入，开始接触集合框架、异常处理、多线程编程。概念逐渐复杂，代码量成倍增长。调试过程变得棘手，内存泄漏、线程死锁等问题接踵而至。IDE的报错信息令人困惑，文档查阅频率显著增加。三、框架迷局进入企业级开发，Spring全家桶迎面而来。配置文件错综复杂，依赖注入让人头晕目眩。MyBatis的XML映射、Spring Boot的自动配置、微服务架构的分布式特性，每个新概念都在挑战认知极限。版本兼容性问题频发，依赖冲突令人抓狂。四、现实打击实际项目中，需求变更频繁，技术债堆积如山。代码审查意见密密麻麻，性能优化无从下手。生产环境故障排查如同大海捞针，凌晨三点的报警短信成为常态。新技术层出不穷，学习速度永远跟不上技术迭代。五、放弃时刻某个深夜，面对第N个无法解决的Bug，看着满屏的异常堆栈，终于意识到自己可能永远无法完全掌握这门技术。决定关掉IDE，合上电脑，承认自己与Java的缘分到此为止。六、新的开始放弃不是终点。有人转向项目管理，有人投身其他技术领域，也有人休息后重拾信心。编程之路本就充满选择，重要的是找到适合自己的方向。Java只是工具，而非人生的全部。\",\"articleCover\":\"/profile/upload/2025/11/17/2025-09-16_17.47.14_欧阳娜娜Nana_Nabi_一周生活邊角料_1_20251117155829A003.png\",\"articleTitle\":\"java从入门到放弃\",\"categoryId\":1989230712472264700,\"createBy\":\"leejie\",\"createById\":100,\"createTime\":\"2025-11-17 10:24:45\",\"id\":\"1990244686067695617\",\"isDelete\":0,\"isFeatured\":0,\"isTop\":1,\"params\":{},\"status\":2,\"type\":1,\"updateBy\":\"leejie\",\"updateById\":100,\"updateTime\":\"2025-11-17 15:58:31\",\"userId\":100}', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 44, 'leejie', 100, '2025-11-17 15:58:32');
INSERT INTO `sys_oper_log` VALUES (1990328919591284738, '文章', 2, 'blog.web.controller.business.ArticleController.edit()', 'PUT', 1, 'leejie', '咯咯科技', '/system/article', '127.0.0.1', '内网IP', '{\"articleAbstract\":\"这是一段文章摘要\",\"articleContent\":\"11月10日，外交部发言人林剑主持例行记者会。有记者就日本首相高市早苗在国会答问时发表涉台错误言论提问。林剑表示，日本领导人日前在国会公然发表涉台错误言论，暗示武力介入台海可能性，粗暴干涉中国内政，严重违背一个中国原则、中日四个政治文件精神和国际关系基本准则，同日本政府迄今所做的政治承诺严重不符，性质和影响极其恶劣。中方对此强烈不满、坚决反对，已向日方提出严正交涉和强烈抗议。台湾是中国的台湾，以何种方式解决台湾问题，实现国家统一，纯属中国内政，不容任何外部势力干涉。<strong>日方领导人有关言论到底想向“台独”势力发出何种信号？是否企图挑战中方核心利益、阻挠中国统一大业？究竟想把中日关系引向何方？</strong>今年是中国人民抗日战争暨世界反法西斯战争胜利80周年，也是台湾光复80周年。日本曾对台湾实行殖民统治，犯下罄竹难书的罪行。日本当政者妄图介入台海事务，既是对国际正义的践踏、对战后国际秩序的挑衅，也是对中日关系的严重破坏。中国终将统一，也必将统一。中国人民有坚定的意志、充分的信心、足够的能力，坚决粉碎一切插手和阻挠中国统一大业的图谋。中方敦促日方立即停止干涉中国内政，停止挑衅越线，不要在错误道路上越走越远。\",\"articleCover\":\"/profile/upload/2025/11/17/2025-09-16_17.47.14_欧阳娜娜Nana_Nabi_一周生活邊角料_8_20251117155924A006.png\",\"articleTitle\":\"新闻1111\",\"categoryId\":1989231087648596000,\"createBy\":\"leejie\",\"createById\":100,\"createTime\":\"2025-11-11 10:44:07\",\"id\":\"1988075234175889410\",\"isDelete\":0,\"isFeatured\":1,\"isTop\":1,\"params\":{},\"status\":1,\"type\":1,\"updateBy\":\"leejie\",\"updateById\":100,\"updateTime\":\"2025-11-17 15:59:27\",\"userId\":100}', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 55, 'leejie', 100, '2025-11-17 15:59:28');
INSERT INTO `sys_oper_log` VALUES (1990329368776077314, '文章', 2, 'blog.web.controller.business.ArticleController.edit()', 'PUT', 1, 'leejie', '咯咯科技', '/system/article', '127.0.0.1', '内网IP', '{\"articleAbstract\":\"这是一段文章摘要\",\"articleContent\":\"11月10日，外交部发言人林剑主持例行记者会。有记者就日本首相高市早苗在国会答问时发表涉台错误言论提问。林剑表示，日本领导人日前在国会公然发表涉台错误言论，暗示武力介入台海可能性，粗暴干涉中国内政，严重违背一个中国原则、中日四个政治文件精神和国际关系基本准则，同日本政府迄今所做的政治承诺严重不符，性质和影响极其恶劣。中方对此强烈不满、坚决反对，已向日方提出严正交涉和强烈抗议。台湾是中国的台湾，以何种方式解决台湾问题，实现国家统一，纯属中国内政，不容任何外部势力干涉。<strong>日方领导人有关言论到底想向“台独”势力发出何种信号？是否企图挑战中方核心利益、阻挠中国统一大业？究竟想把中日关系引向何方？</strong>今年是中国人民抗日战争暨世界反法西斯战争胜利80周年，也是台湾光复80周年。日本曾对台湾实行殖民统治，犯下罄竹难书的罪行。日本当政者妄图介入台海事务，既是对国际正义的践踏、对战后国际秩序的挑衅，也是对中日关系的严重破坏。中国终将统一，也必将统一。中国人民有坚定的意志、充分的信心、足够的能力，坚决粉碎一切插手和阻挠中国统一大业的图谋。中方敦促日方立即停止干涉中国内政，停止挑衅越线，不要在错误道路上越走越远。\",\"articleCover\":\"/profile/upload/2025/11/17/2025-09-16_17.47.14_欧阳娜娜Nana_Nabi_一周生活邊角料_8_20251117155924A006.png,/profile/upload/2025/11/17/2025-09-16_17.47.14_欧阳娜娜Nana_Nabi_一周生活邊角料_11_20251117155949A007.png,/profile/upload/2025/11/17/2025-11-03_18.59.11_赵今麦_右滑_看_7_20251117160108A008.png\",\"articleTitle\":\"新闻1111\",\"categoryId\":1989231087648596000,\"createBy\":\"leejie\",\"createById\":100,\"createTime\":\"2025-11-11 10:44:07\",\"id\":\"1988075234175889410\",\"isDelete\":0,\"isFeatured\":1,\"isTop\":1,\"params\":{},\"status\":1,\"type\":1,\"updateBy\":\"leejie\",\"updateById\":100,\"updateTime\":\"2025-11-17 16:01:14\",\"userId\":100}', '{\"msg\":\"操作成功\",\"code\":200}', 0, '', NULL, 42, 'leejie', 100, '2025-11-17 16:01:15');

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_by_id` bigint NULL DEFAULT NULL COMMENT '创建人id',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_by_id` bigint NULL DEFAULT NULL COMMENT '更新人id',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '岗位信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'ceo', '董事长', 1, '0', 'admin', NULL, '2025-09-25 01:37:45', '', NULL, NULL, '');
INSERT INTO `sys_post` VALUES (2, 'se', '项目经理', 2, '0', 'admin', NULL, '2025-09-25 01:37:45', '', NULL, NULL, '');
INSERT INTO `sys_post` VALUES (3, 'hr', '人力资源', 3, '0', 'admin', NULL, '2025-09-25 01:37:45', '', NULL, NULL, '');
INSERT INTO `sys_post` VALUES (4, 'user', '普通员工', 4, '0', 'admin', NULL, '2025-09-25 01:37:45', '', NULL, NULL, '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_by_id` bigint NULL DEFAULT NULL COMMENT '创建人id',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_by_id` bigint NULL DEFAULT NULL COMMENT '更新人id',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 101 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '普通角色', 'common', 2, '2', 1, 1, '0', '0', 'admin', NULL, '2025-09-25 01:37:46', '', NULL, NULL, '普通角色');
INSERT INTO `sys_role` VALUES (100, '超超管', 'lee-admin', 0, '1', 1, 1, '0', '0', 'admin', NULL, '2025-09-25 04:23:33', '', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色和部门关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES (2, 100);
INSERT INTO `sys_role_dept` VALUES (2, 101);
INSERT INTO `sys_role_dept` VALUES (2, 105);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (2, 1);
INSERT INTO `sys_role_menu` VALUES (2, 2);
INSERT INTO `sys_role_menu` VALUES (2, 3);
INSERT INTO `sys_role_menu` VALUES (2, 4);
INSERT INTO `sys_role_menu` VALUES (2, 100);
INSERT INTO `sys_role_menu` VALUES (2, 101);
INSERT INTO `sys_role_menu` VALUES (2, 102);
INSERT INTO `sys_role_menu` VALUES (2, 103);
INSERT INTO `sys_role_menu` VALUES (2, 104);
INSERT INTO `sys_role_menu` VALUES (2, 105);
INSERT INTO `sys_role_menu` VALUES (2, 106);
INSERT INTO `sys_role_menu` VALUES (2, 107);
INSERT INTO `sys_role_menu` VALUES (2, 108);
INSERT INTO `sys_role_menu` VALUES (2, 109);
INSERT INTO `sys_role_menu` VALUES (2, 110);
INSERT INTO `sys_role_menu` VALUES (2, 111);
INSERT INTO `sys_role_menu` VALUES (2, 112);
INSERT INTO `sys_role_menu` VALUES (2, 113);
INSERT INTO `sys_role_menu` VALUES (2, 114);
INSERT INTO `sys_role_menu` VALUES (2, 115);
INSERT INTO `sys_role_menu` VALUES (2, 116);
INSERT INTO `sys_role_menu` VALUES (2, 117);
INSERT INTO `sys_role_menu` VALUES (2, 500);
INSERT INTO `sys_role_menu` VALUES (2, 501);
INSERT INTO `sys_role_menu` VALUES (2, 1000);
INSERT INTO `sys_role_menu` VALUES (2, 1001);
INSERT INTO `sys_role_menu` VALUES (2, 1002);
INSERT INTO `sys_role_menu` VALUES (2, 1003);
INSERT INTO `sys_role_menu` VALUES (2, 1004);
INSERT INTO `sys_role_menu` VALUES (2, 1005);
INSERT INTO `sys_role_menu` VALUES (2, 1006);
INSERT INTO `sys_role_menu` VALUES (2, 1007);
INSERT INTO `sys_role_menu` VALUES (2, 1008);
INSERT INTO `sys_role_menu` VALUES (2, 1009);
INSERT INTO `sys_role_menu` VALUES (2, 1010);
INSERT INTO `sys_role_menu` VALUES (2, 1011);
INSERT INTO `sys_role_menu` VALUES (2, 1012);
INSERT INTO `sys_role_menu` VALUES (2, 1013);
INSERT INTO `sys_role_menu` VALUES (2, 1014);
INSERT INTO `sys_role_menu` VALUES (2, 1015);
INSERT INTO `sys_role_menu` VALUES (2, 1016);
INSERT INTO `sys_role_menu` VALUES (2, 1017);
INSERT INTO `sys_role_menu` VALUES (2, 1018);
INSERT INTO `sys_role_menu` VALUES (2, 1019);
INSERT INTO `sys_role_menu` VALUES (2, 1020);
INSERT INTO `sys_role_menu` VALUES (2, 1021);
INSERT INTO `sys_role_menu` VALUES (2, 1022);
INSERT INTO `sys_role_menu` VALUES (2, 1023);
INSERT INTO `sys_role_menu` VALUES (2, 1024);
INSERT INTO `sys_role_menu` VALUES (2, 1025);
INSERT INTO `sys_role_menu` VALUES (2, 1026);
INSERT INTO `sys_role_menu` VALUES (2, 1027);
INSERT INTO `sys_role_menu` VALUES (2, 1028);
INSERT INTO `sys_role_menu` VALUES (2, 1029);
INSERT INTO `sys_role_menu` VALUES (2, 1030);
INSERT INTO `sys_role_menu` VALUES (2, 1031);
INSERT INTO `sys_role_menu` VALUES (2, 1032);
INSERT INTO `sys_role_menu` VALUES (2, 1033);
INSERT INTO `sys_role_menu` VALUES (2, 1034);
INSERT INTO `sys_role_menu` VALUES (2, 1035);
INSERT INTO `sys_role_menu` VALUES (2, 1036);
INSERT INTO `sys_role_menu` VALUES (2, 1037);
INSERT INTO `sys_role_menu` VALUES (2, 1038);
INSERT INTO `sys_role_menu` VALUES (2, 1039);
INSERT INTO `sys_role_menu` VALUES (2, 1040);
INSERT INTO `sys_role_menu` VALUES (2, 1041);
INSERT INTO `sys_role_menu` VALUES (2, 1042);
INSERT INTO `sys_role_menu` VALUES (2, 1043);
INSERT INTO `sys_role_menu` VALUES (2, 1044);
INSERT INTO `sys_role_menu` VALUES (2, 1045);
INSERT INTO `sys_role_menu` VALUES (2, 1046);
INSERT INTO `sys_role_menu` VALUES (2, 1047);
INSERT INTO `sys_role_menu` VALUES (2, 1048);
INSERT INTO `sys_role_menu` VALUES (2, 1049);
INSERT INTO `sys_role_menu` VALUES (2, 1050);
INSERT INTO `sys_role_menu` VALUES (2, 1051);
INSERT INTO `sys_role_menu` VALUES (2, 1052);
INSERT INTO `sys_role_menu` VALUES (2, 1053);
INSERT INTO `sys_role_menu` VALUES (2, 1054);
INSERT INTO `sys_role_menu` VALUES (2, 1055);
INSERT INTO `sys_role_menu` VALUES (2, 1056);
INSERT INTO `sys_role_menu` VALUES (2, 1057);
INSERT INTO `sys_role_menu` VALUES (2, 1058);
INSERT INTO `sys_role_menu` VALUES (2, 1059);
INSERT INTO `sys_role_menu` VALUES (2, 1060);
INSERT INTO `sys_role_menu` VALUES (100, 1);
INSERT INTO `sys_role_menu` VALUES (100, 2);
INSERT INTO `sys_role_menu` VALUES (100, 3);
INSERT INTO `sys_role_menu` VALUES (100, 100);
INSERT INTO `sys_role_menu` VALUES (100, 101);
INSERT INTO `sys_role_menu` VALUES (100, 102);
INSERT INTO `sys_role_menu` VALUES (100, 103);
INSERT INTO `sys_role_menu` VALUES (100, 104);
INSERT INTO `sys_role_menu` VALUES (100, 105);
INSERT INTO `sys_role_menu` VALUES (100, 106);
INSERT INTO `sys_role_menu` VALUES (100, 107);
INSERT INTO `sys_role_menu` VALUES (100, 108);
INSERT INTO `sys_role_menu` VALUES (100, 109);
INSERT INTO `sys_role_menu` VALUES (100, 110);
INSERT INTO `sys_role_menu` VALUES (100, 111);
INSERT INTO `sys_role_menu` VALUES (100, 112);
INSERT INTO `sys_role_menu` VALUES (100, 113);
INSERT INTO `sys_role_menu` VALUES (100, 114);
INSERT INTO `sys_role_menu` VALUES (100, 115);
INSERT INTO `sys_role_menu` VALUES (100, 116);
INSERT INTO `sys_role_menu` VALUES (100, 117);
INSERT INTO `sys_role_menu` VALUES (100, 500);
INSERT INTO `sys_role_menu` VALUES (100, 501);
INSERT INTO `sys_role_menu` VALUES (100, 1000);
INSERT INTO `sys_role_menu` VALUES (100, 1001);
INSERT INTO `sys_role_menu` VALUES (100, 1002);
INSERT INTO `sys_role_menu` VALUES (100, 1003);
INSERT INTO `sys_role_menu` VALUES (100, 1004);
INSERT INTO `sys_role_menu` VALUES (100, 1005);
INSERT INTO `sys_role_menu` VALUES (100, 1006);
INSERT INTO `sys_role_menu` VALUES (100, 1007);
INSERT INTO `sys_role_menu` VALUES (100, 1008);
INSERT INTO `sys_role_menu` VALUES (100, 1009);
INSERT INTO `sys_role_menu` VALUES (100, 1010);
INSERT INTO `sys_role_menu` VALUES (100, 1011);
INSERT INTO `sys_role_menu` VALUES (100, 1012);
INSERT INTO `sys_role_menu` VALUES (100, 1013);
INSERT INTO `sys_role_menu` VALUES (100, 1014);
INSERT INTO `sys_role_menu` VALUES (100, 1015);
INSERT INTO `sys_role_menu` VALUES (100, 1016);
INSERT INTO `sys_role_menu` VALUES (100, 1017);
INSERT INTO `sys_role_menu` VALUES (100, 1018);
INSERT INTO `sys_role_menu` VALUES (100, 1019);
INSERT INTO `sys_role_menu` VALUES (100, 1020);
INSERT INTO `sys_role_menu` VALUES (100, 1021);
INSERT INTO `sys_role_menu` VALUES (100, 1022);
INSERT INTO `sys_role_menu` VALUES (100, 1023);
INSERT INTO `sys_role_menu` VALUES (100, 1024);
INSERT INTO `sys_role_menu` VALUES (100, 1025);
INSERT INTO `sys_role_menu` VALUES (100, 1026);
INSERT INTO `sys_role_menu` VALUES (100, 1027);
INSERT INTO `sys_role_menu` VALUES (100, 1028);
INSERT INTO `sys_role_menu` VALUES (100, 1029);
INSERT INTO `sys_role_menu` VALUES (100, 1030);
INSERT INTO `sys_role_menu` VALUES (100, 1031);
INSERT INTO `sys_role_menu` VALUES (100, 1032);
INSERT INTO `sys_role_menu` VALUES (100, 1033);
INSERT INTO `sys_role_menu` VALUES (100, 1034);
INSERT INTO `sys_role_menu` VALUES (100, 1035);
INSERT INTO `sys_role_menu` VALUES (100, 1036);
INSERT INTO `sys_role_menu` VALUES (100, 1037);
INSERT INTO `sys_role_menu` VALUES (100, 1038);
INSERT INTO `sys_role_menu` VALUES (100, 1039);
INSERT INTO `sys_role_menu` VALUES (100, 1040);
INSERT INTO `sys_role_menu` VALUES (100, 1041);
INSERT INTO `sys_role_menu` VALUES (100, 1042);
INSERT INTO `sys_role_menu` VALUES (100, 1043);
INSERT INTO `sys_role_menu` VALUES (100, 1044);
INSERT INTO `sys_role_menu` VALUES (100, 1045);
INSERT INTO `sys_role_menu` VALUES (100, 1046);
INSERT INTO `sys_role_menu` VALUES (100, 1047);
INSERT INTO `sys_role_menu` VALUES (100, 1048);
INSERT INTO `sys_role_menu` VALUES (100, 1049);
INSERT INTO `sys_role_menu` VALUES (100, 1050);
INSERT INTO `sys_role_menu` VALUES (100, 1051);
INSERT INTO `sys_role_menu` VALUES (100, 1052);
INSERT INTO `sys_role_menu` VALUES (100, 1053);
INSERT INTO `sys_role_menu` VALUES (100, 1054);
INSERT INTO `sys_role_menu` VALUES (100, 1055);
INSERT INTO `sys_role_menu` VALUES (100, 1056);
INSERT INTO `sys_role_menu` VALUES (100, 1057);
INSERT INTO `sys_role_menu` VALUES (100, 1058);
INSERT INTO `sys_role_menu` VALUES (100, 1059);
INSERT INTO `sys_role_menu` VALUES (100, 1060);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '账号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `pwd_update_date` datetime NULL DEFAULT NULL COMMENT '密码最后更新时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_by_id` bigint NULL DEFAULT NULL COMMENT '创建人id',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_by_id` bigint NULL DEFAULT NULL COMMENT '更新人id',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 101 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 103, 'admin', '若依', '00', 'ry@163.com', '15888888888', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2025-11-13 09:34:42', '2025-09-25 01:37:45', 'admin', NULL, '2025-09-25 01:37:45', '', NULL, NULL, '管理员');
INSERT INTO `sys_user` VALUES (2, 105, 'ry', '若依', '00', 'ry@qq.com', '15666666666', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '2', '127.0.0.1', '2025-09-25 01:37:45', '2025-09-25 01:37:45', 'admin', NULL, '2025-09-25 01:37:45', '', NULL, NULL, '测试员');
INSERT INTO `sys_user` VALUES (100, 100, 'leejie', 'leejie', '00', 'leejieqaq@163.com', '18888888888', '0', '', '$2a$10$.JwqGRS/vhO1JXTFyGvuIuypT5jFLz/IZrFt6E1k5R9iNe4K.D6rS', '0', '0', '127.0.0.1', '2025-11-28 16:43:03', '2025-09-25 04:24:43', 'admin', NULL, '2025-09-25 04:24:29', '', NULL, '2025-11-07 02:43:20', NULL);

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户和角色关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (100, 100);

SET FOREIGN_KEY_CHECKS = 1;



--- minio文件表
CREATE TABLE sys_file (
id              BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键ID',
file_name       VARCHAR(255) NOT NULL COMMENT '原始文件名',
file_suffix     VARCHAR(50)  COMMENT '文件后缀，如 jpg、png、pdf',
content_type    VARCHAR(100) COMMENT '文件类型，如 image/jpeg',
file_size       BIGINT COMMENT '文件大小（字节）',
bucket_name     VARCHAR(100) NOT NULL COMMENT 'MinIO桶名',
object_name     VARCHAR(500) NOT NULL COMMENT 'MinIO对象路径',
file_url        VARCHAR(500) COMMENT '文件访问URL（永久/临时）',
biz_type        VARCHAR(100) COMMENT '业务类型，如 USER_AVATAR、BLOG_IMAGE',
biz_id          VARCHAR(100) COMMENT '业务ID，如用户ID、博客ID',
is_public       TINYINT DEFAULT 0 COMMENT '是否公开（0-否 1-是）',
create_by       VARCHAR(64) COMMENT '创建者',
create_by_id    BIGINT COMMENT '创建者ID',
create_time     DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
update_by       VARCHAR(64) COMMENT '更新者',
update_by_id    BIGINT COMMENT '更新者ID',
update_time     DATETIME NULL
ON UPDATE CURRENT_TIMESTAMP
COMMENT '更新时间',

INDEX idx_biz (biz_type, biz_id)
) COMMENT='文件信息表';

