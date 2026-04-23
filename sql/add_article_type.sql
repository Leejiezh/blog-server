-- ----------------------------
-- 添加文章类型表
-- ----------------------------
-- 日期: 2026-04-22
-- 说明: 创建文章类型管理表，支持动态管理文章类型（原创、转载、翻译等）
-- ----------------------------

-- 创建文章类型表
CREATE TABLE IF NOT EXISTS `biz_article_type` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '类型ID',
  `type_name` varchar(50) NOT NULL COMMENT '类型名称',
  `type_code` varchar(50) DEFAULT NULL COMMENT '类型编码（唯一标识）',
  `sort_order` int DEFAULT 0 COMMENT '排序顺序',
  `description` varchar(200) DEFAULT NULL COMMENT '类型描述',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '状态 0停用 1启用',
  `create_by_id` bigint NOT NULL COMMENT '创建人ID',
  `create_by` varchar(50) NOT NULL COMMENT '创建人名称',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by_id` bigint DEFAULT NULL COMMENT '更新人ID',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_delete` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除 0否 1是',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_type_code` (`type_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='文章类型表';

-- 初始化默认数据（保持向后兼容，ID与现有biz_article.type值匹配）
INSERT IGNORE INTO `biz_article_type` (`id`, `type_name`, `type_code`, `sort_order`, `status`, `create_by_id`, `create_by`, `create_time`) VALUES
(1, '原创', 'original', 1, 1, 1, 'admin', NOW()),
(2, '转载', 'reprint', 2, 1, 1, 'admin', NOW()),
(3, '翻译', 'translate', 3, 1, 1, 'admin', NOW());
