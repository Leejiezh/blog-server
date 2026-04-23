# 设计：文章类型管理功能

## 架构概述

采用与 Category（分类管理）相同的设计模式，保持代码风格一致性：

```
biz_article_type (表)
    ↓
ArticleType (实体) ← Category 设计模式
    ↓
ArticleTypeDTO / ArticleTypeVO (数据传输对象)
    ↓
IArticleTypeService / ArticleTypeServiceImpl (服务层)
    ↓
ArticleTypeMapper (数据访问层)
    ↓
ArticleTypeController (控制器层)
```

## 数据库设计

### 新建表：biz_article_type

```sql
CREATE TABLE `biz_article_type` (
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

-- 初始化默认数据（保持向后兼容）
INSERT INTO `biz_article_type` (`id`, `type_name`, `type_code`, `sort_order`, `status`, `create_by_id`, `create_by`, `create_time`) VALUES
(1, '原创', 'original', 1, 1, 1, 'admin', NOW()),
(2, '转载', 'reprint', 2, 1, 1, 'admin', NOW()),
(3, '翻译', 'translate', 3, 1, 1, 'admin', NOW());
```

**设计说明：**
- 保留原有 1/2/3 的 ID，确保与现有 `biz_article.type` 字段兼容
- 新增 `type_code` 字段作为业务编码，支持更灵活的查询
- `sort_order` 支持前端排序展示
- `status` 支持启用/停用类型

### 修改表：biz_article

**方案选择：保持现有 type 字段不变**

理由：
1. 向后兼容性最好，不需要数据迁移
2. `biz_article.type` 存储 `biz_article_type.id`，建立外键关联
3. 通过 LEFT JOIN 查询获取类型名称

**可选优化（后续迭代）：**
- 添加外键约束（需谨慎评估性能影响）
- 添加冗余字段 `type_name` 提升查询性能

## 代码设计

### 1. 实体层 (Domain)

**ArticleType.java**
```java
@TableName("biz_article_type")
public class ArticleType extends BaseEntity {
    @TableId(value = "id")
    private Long id;
    
    private String typeName;        // 类型名称
    private String typeCode;        // 类型编码
    private Integer sortOrder;      // 排序
    private String description;     // 描述
    private Integer status;         // 状态 0停用 1启用
    private Integer isDelete;       // 逻辑删除
}
```

### 2. 数据传输对象 (DTO/VO)

**ArticleTypeDTO.java** - 新增/编辑使用
```java
public class ArticleTypeDTO {
    @NotNull(groups = EditGroup.class)
    private Long id;
    
    @NotBlank(message = "类型名称不能为空")
    private String typeName;
    
    private String typeCode;
    private Integer sortOrder;
    private String description;
    private Integer status;
}
```

**ArticleTypeVO.java** - 查询返回使用
```java
public class ArticleTypeVO {
    private Long id;
    private String typeName;
    private String typeCode;
    private Integer sortOrder;
    private String description;
    private Integer status;
    private Long articleCount;  // 关联文章数量（可选）
    private String createBy;
    private Date createTime;
}
```

### 3. Mapper 层

**ArticleTypeMapper.java**
```java
public interface ArticleTypeMapper extends BaseMapperPlus<ArticleType, ArticleTypeVO> {
    // 继承 BaseMapperPlus 获得通用方法
    // 可扩展自定义查询方法
}
```

**ArticleTypeMapper.xml**
```xml
<resultMap id="ArticleTypeVOResult" type="ArticleTypeVO">
    <id property="id" column="id"/>
    <result property="typeName" column="type_name"/>
    <result property="typeCode" column="type_code"/>
    <result property="sortOrder" column="sort_order"/>
    <result property="description" column="description"/>
    <result property="status" column="status"/>
    <result property="createBy" column="create_by"/>
    <result property="createTime" column="create_time"/>
</resultMap>
```

### 4. Service 层

**IArticleTypeService.java**
```java
public interface IArticleTypeService {
    ArticleTypeVO queryById(Long id);
    TableDataInfo<ArticleTypeVO> queryPageList(ArticleTypeDTO dto, PageQuery pageQuery);
    List<ArticleTypeVO> queryList(ArticleTypeDTO dto);
    Boolean insertByDto(ArticleTypeDTO dto);
    Boolean updateByDto(ArticleTypeDTO dto);
    Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid);
}
```

**ArticleTypeServiceImpl.java** - 关键业务逻辑
```java
@Service
public class ArticleTypeServiceImpl implements IArticleTypeService {
    
    @Autowired
    private ArticleTypeMapper baseMapper;
    
    @Override
    public Boolean insertByDto(ArticleTypeDTO dto) {
        // 1. 校验 typeCode 唯一性
        // 2. 转换为 ArticleType 实体
        // 3. 填充审计字段
        // 4. 插入数据库
    }
    
    @Override
    public Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid) {
        if (isValid) {
            // 校验是否有关联文章（可选）
            // 当前设计：不阻止删除，文章保留类型ID
        }
        return baseMapper.deleteBatchIds(ids) > 0;
    }
}
```

### 5. Controller 层

**ArticleTypeController.java**
```java
@Tag(name = "文章类型管理")
@RestController
@RequestMapping("/biz/articleType")
public class ArticleTypeController extends BaseController {
    
    @Autowired
    private IArticleTypeService articleTypeService;
    
    @Operation(summary = "查询文章类型列表")
    @PreAuthorize("@ss.hasPermi('biz:articleType:list')")
    @GetMapping("/list")
    public TableDataInfo<ArticleTypeVO> list(ArticleTypeDTO dto, PageQuery pageQuery) {
        return articleTypeService.queryPageList(dto, pageQuery);
    }
    
    @Operation(summary = "获取文章类型详情")
    @PreAuthorize("@ss.hasPermi('biz:articleType:query')")
    @GetMapping("/{id}")
    public R<ArticleTypeVO> getInfo(@PathVariable Long id) {
        return R.ok(articleTypeService.queryById(id));
    }
    
    @Operation(summary = "新增文章类型")
    @PreAuthorize("@ss.hasPermi('biz:articleType:add')")
    @Log(title = "文章类型", businessType = BusinessType.INSERT)
    @PostMapping
    public R<Void> add(@Validated @RequestBody ArticleTypeDTO dto) {
        return toAjax(articleTypeService.insertByDto(dto));
    }
    
    @Operation(summary = "修改文章类型")
    @PreAuthorize("@ss.hasPermi('biz:articleType:edit')")
    @Log(title = "文章类型", businessType = BusinessType.UPDATE)
    @PutMapping
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody ArticleTypeDTO dto) {
        return toAjax(articleTypeService.updateByDto(dto));
    }
    
    @Operation(summary = "删除文章类型")
    @PreAuthorize("@ss.hasPermi('biz:articleType:remove')")
    @Log(title = "文章类型", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public R<Void> remove(@PathVariable Long[] ids) {
        return toAjax(articleTypeService.deleteWithValidByIds(Arrays.asList(ids), true));
    }
}
```

### 6. 修改 Article 关联查询

**ArticleMapper.xml** - 添加 LEFT JOIN
```xml
<select id="selectVoPage" resultMap="ArticleVOResult">
    SELECT 
        a.*,
        u.user_name,
        c.category_name,
        t.type_name  <!-- 新增 -->
    FROM biz_article a
    LEFT JOIN sys_user u ON u.user_id = a.user_id
    LEFT JOIN biz_category c ON c.id = a.category_id
    LEFT JOIN biz_article_type t ON t.id = a.type  <!-- 新增 -->
    WHERE a.is_delete = 0
    <!-- 其他条件 -->
</select>
```

**ArticleVO.java** - 添加字段
```java
public class ArticleVO {
    // ... 现有字段
    
    /** 文章类型名称 */
    private String typeName;
}
```

## 权限设计

使用若依框架的标准权限模型：

| 权限标识 | 说明 | 菜单类型 |
|---------|------|---------|
| biz:articleType:list | 查询文章类型列表 | 按钮 |
| biz:articleType:query | 查询文章类型详情 | 按钮 |
| biz:articleType:add | 新增文章类型 | 按钮 |
| biz:articleType:edit | 修改文章类型 | 按钮 |
| biz:articleType:remove | 删除文章类型 | 按钮 |

需要在 `sys_menu` 表中添加对应菜单和权限数据。

## 安全设计

1. **权限控制**：所有接口使用 `@PreAuthorize` 注解
2. **参数校验**：使用 Jakarta Validation 注解
3. **逻辑删除**：使用 `@TableLogic` 避免物理删除
4. **操作日志**：使用 `@Log` 注解记录操作

## 向后兼容策略

1. **保留原有 type 字段**：不修改字段名和类型
2. **初始化数据**：插入 ID 为 1/2/3 的默认类型记录
3. **渐进式迁移**：
   - 第一阶段：添加类型管理功能，文章仍使用整数 type
   - 第二阶段（可选）：前端改造，使用下拉选择替代数字输入
   - 第三阶段（可选）：添加 type_code 字段支持更灵活的业务逻辑

## 测试策略

### 单元测试
- Service 层 CRUD 方法测试
- DTO 验证逻辑测试
- 唯一性约束测试

### 集成测试
- Controller API 端到端测试
- 数据库事务测试
- 权限控制测试

### 兼容性测试
- 已有文章数据查询正常
- 新增文章选择类型正常
- 删除类型后文章显示正常

## 性能考虑

1. **索引设计**：
   - `type_code` 添加唯一索引
   - `status` 和 `is_delete` 添加复合索引（如果查询频繁）

2. **查询优化**：
   - 文章列表使用 LEFT JOIN 关联类型表
   - 可考虑在 `biz_article` 添加冗余 `type_name` 字段（视性能需求）

3. **缓存策略**（可选）：
   - 文章类型数据变化少，可考虑 Redis 缓存
   - 缓存 key: `article_type_list`

## 扩展性设计

1. **类型层级**：未来可扩展为树形结构（添加 parent_id 字段）
2. **类型图标**：可添加 icon 字段用于前端展示
3. **类型模板**：可关联不同的文章编辑模板
4. **统计分析**：统计各类型的文章数量和访问量
