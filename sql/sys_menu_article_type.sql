-- ----------------------------
-- 添加文章类型管理菜单和权限
-- ----------------------------
-- 日期: 2026-04-22
-- 说明: 为文章类型管理功能添加菜单和按钮权限
-- ----------------------------

-- 文章类型管理菜单（父菜单ID为2000 业务管理）
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES
(2014, '文章类型管理', 2000, 3, 'articleType', 'biz/articleType/index', 1, 0, 'C', '0', '0', 'biz:articleType:index', '#', 'admin', NOW(), '', NULL, '文章类型管理菜单');

-- 文章类型管理按钮权限
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES
(2015, '文章类型查询', 2014, 1, '#', '', 1, 0, 'F', '0', '0', 'biz:articleType:query', '#', 'admin', NOW(), '', NULL, ''),
(2016, '文章类型新增', 2014, 2, '#', '', 1, 0, 'F', '0', '0', 'biz:articleType:add', '#', 'admin', NOW(), '', NULL, ''),
(2017, '文章类型修改', 2014, 3, '#', '', 1, 0, 'F', '0', '0', 'biz:articleType:edit', '#', 'admin', NOW(), '', NULL, ''),
(2018, '文章类型删除', 2014, 4, '#', '', 1, 0, 'F', '0', '0', 'biz:articleType:remove', '#', 'admin', NOW(), '', NULL, ''),
(2019, '文章类型导出', 2014, 5, '#', '', 1, 0, 'F', '0', '0', 'biz:articleType:export', '#', 'admin', NOW(), '', NULL, '');
