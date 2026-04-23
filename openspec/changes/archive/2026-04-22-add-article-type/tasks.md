# 任务清单：文章类型管理功能

## 阶段一：数据库设计与初始化

### 任务 1.1：创建数据库迁移脚本
- [x] 创建 `biz_article_type` 表
- [x] 添加唯一索引 `uk_type_code`
- [x] 插入初始化数据（ID=1,2,3 对应原创、转载、翻译）
- [x] 编写回滚脚本

**文件位置：**
- `sql/add_article_type.sql`
- `sql/rollback_add_article_type.sql`

**验收标准：**
- SQL 脚本可重复执行（使用 `IF NOT EXISTS`）
- 初始化数据 ID 与现有文章 type 值匹配

---

## 阶段二：实体层与 DTO/VO

### 任务 2.1：创建 ArticleType 实体类
- [x] 创建 `blog-biz/src/main/java/blog/biz/domain/ArticleType.java`
- [x] 继承 `BaseEntity`
- [x] 添加 `@TableName("biz_article_type")`
- [x] 定义所有字段及注解
- [x] 添加 `@TableLogic` 逻辑删除字段

**验收标准：**
- 字段与数据库表结构一致
- Lombok 注解正确（@Data, @EqualsAndHashCode）

### 任务 2.2：创建 ArticleTypeDTO
- [x] 创建 `blog-biz/src/main/java/blog/biz/domain/dto/ArticleTypeDTO.java`
- [x] 添加 Jakarta Validation 注解
- [x] 添加验证分组（AddGroup, EditGroup）

**验收标准：**
- typeName 必填校验
- EditGroup 需要 id 字段

### 任务 2.3：创建 ArticleTypeVO
- [x] 创建 `blog-biz/src/main/java/blog/biz/domain/vo/ArticleTypeVO.java`
- [x] 添加 Swagger @Schema 注解
- [x] 包含展示所需的所有字段

**验收标准：**
- 包含审计字段（createBy, createTime）
- 可扩展 articleCount 字段

---

## 阶段三：数据访问层（Mapper）

### 任务 3.1：创建 ArticleTypeMapper 接口
- [x] 创建 `blog-biz/src/main/java/blog/biz/mapper/ArticleTypeMapper.java`
- [x] 继承 `BaseMapperPlus<ArticleType, ArticleTypeVO>`
- [x] 添加自定义查询方法（如有需要）

**验收标准：**
- 继承正确的基类
- 包路径符合项目规范

### 任务 3.2：创建 ArticleTypeMapper.xml
- [x] 创建 `blog-biz/src/main/resources/mapper/ArticleTypeMapper.xml`
- [x] 定义 resultMap 映射
- [x] 编写查询 SQL（如需自定义）

**验收标准：**
- resultMap 字段映射正确
- SQL 语句包含 is_delete 条件

---

## 阶段四：服务层（Service）

### 任务 4.1：创建 IArticleTypeService 接口
- [x] 创建 `blog-biz/src/main/java/blog/biz/service/IArticleTypeService.java`
- [x] 定义标准 CRUD 方法
- [x] 添加方法注释

**方法清单：**
```java
ArticleTypeVO queryById(Long id);
TableDataInfo<ArticleTypeVO> queryPageList(ArticleTypeDTO dto, PageQuery pageQuery);
List<ArticleTypeVO> queryList(ArticleTypeDTO dto);
Boolean insertByDto(ArticleTypeDTO dto);
Boolean updateByDto(ArticleTypeDTO dto);
Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid);
```

### 任务 4.2：实现 ArticleTypeServiceImpl
- [x] 创建 `blog-biz/src/main/java/blog/biz/service/impl/ArticleTypeServiceImpl.java`
- [x] 实现所有接口方法
- [x] 添加 `@Service` 注解
- [x] 注入 ArticleTypeMapper

**关键业务逻辑：**
- [x] insertByDto: 校验 typeCode 唯一性
- [x] updateByDto: 校验 id 存在性
- [x] deleteWithValidByIds: 逻辑删除
- [x] 填充审计字段（createBy, updateBy 等）

**验收标准：**
- 所有方法有事务注解（@Transactional）
- 异常处理完善
- 日志记录关键操作

---

## 阶段五：控制器层（Controller）

### 任务 5.1：创建 ArticleTypeController
- [x] 创建 `blog-admin/src/main/java/blog/web/controller/business/ArticleTypeController.java`
- [x] 继承 BaseController
- [x] 添加 @RestController, @RequestMapping, @Tag 注解
- [x] 实现 5 个标准接口（list, getInfo, add, edit, remove）

**接口清单：**
| 方法 | 路径 | 权限 | 说明 |
|-----|------|------|------|
| GET | /biz/articleType/list | biz:articleType:list | 分页查询 |
| GET | /biz/articleType/{id} | biz:articleType:query | 详情查询 |
| POST | /biz/articleType | biz:articleType:add | 新增 |
| PUT | /biz/articleType | biz:articleType:edit | 修改 |
| DELETE | /biz/articleType/{ids} | biz:articleType:remove | 删除 |

**验收标准：**
- 所有接口添加 @Operation 注解
- 权限注解 @PreAuthorize 正确
- 操作日志 @Log 注解完整
- 参数校验 @Validated 正确

---

## 阶段六：修改 Article 关联

### 任务 6.1：修改 ArticleMapper.xml
- [x] 在查询 SQL 中添加 `LEFT JOIN biz_article_type t ON t.id = a.type`
- [x] 在 resultMap 中添加 type_name 映射
- [x] 确保所有查询文章的 SQL 都包含类型关联

**验收标准：**
- 文章列表返回 typeName 字段
- 不影响现有查询性能

### 任务 6.2：修改 ArticleVO
- [x] 在 `Article` 实体中添加 `typeName` 字段
- [x] 添加 @TableField(exist = false) 注解

**验收标准：**
- 字段名与 Mapper XML 一致

---

## 阶段七：权限与菜单配置

### 任务 7.1：创建菜单 SQL 脚本
- [x] 创建 `sql/sys_menu_article_type.sql`
- [x] 添加文章类型管理菜单
- [x] 添加 5 个按钮权限（list, query, add, edit, remove, export）

**菜单结构：**
```
业务管理 (已有)
└── 文章类型管理 (新增菜单)
    ├── 查询 (按钮)
    ├── 详情 (按钮)
    ├── 新增 (按钮)
    ├── 修改 (按钮)
    └── 删除 (按钮)
```

**验收标准：**
- menu_type 正确（M=目录, C=菜单, F=按钮）
- perms 字段与 Controller 权限一致

---

## 阶段八：测试与验证

### 任务 8.1：API 接口测试
- [x] 测试新增文章类型接口
- [x] 测试修改文章类型接口
- [x] 测试删除文章类型接口
- [x] 测试分页查询接口
- [x] 测试详情查询接口

**测试工具：**
- Swagger UI: http://localhost:port/swagger-ui.html
- Postman 或 curl

### 任务 8.2：数据完整性测试
- [x] 验证 typeCode 唯一性约束
- [x] 验证逻辑删除不物理删除数据
- [x] 验证审计字段自动填充
- [x] 验证初始化数据 ID=1,2,3

### 任务 8.3：集成测试
- [x] 创建文章时选择类型，验证保存成功
- [x] 查询文章列表，验证显示类型名称
- [x] 删除文章类型，验证文章不受影响
- [x] 修改文章类型名称，验证文章列表同步更新

---

## 阶段九：文档与部署

### 任务 9.1：更新 API 文档
- [x] 验证 Swagger 文档自动生成
- [x] 补充接口说明（如需要）
- [x] 添加请求/响应示例

### 任务 9.2：编写部署说明
- [x] 创建 `docs/deploy_article_type.md`
- [x] 说明数据库迁移步骤
- [x] 说明配置更新（如有）

### 任务 9.3：代码审查
- [x] 检查代码规范（命名、注释、格式）
- [x] 检查异常处理
- [x] 检查事务管理
- [x] 检查权限控制

---

## 依赖关系

```
阶段一（数据库）
    ↓
阶段二（实体/DTO/VO）
    ↓
阶段三（Mapper）
    ↓
阶段四（Service）
    ↓
阶段五（Controller）
    ↓
阶段六（Article 关联）  ← 可并行
    ↓
阶段七（权限配置）
    ↓
阶段八（测试）
    ↓
阶段九（文档/部署）
```

**可并行任务：**
- 阶段六可在阶段五完成后立即开始
- 阶段七可与阶段六并行

---

## 预估工时

| 阶段 | 任务数 | 预估时间 |
|-----|-------|---------|
| 阶段一 | 1 | 0.5 小时 |
| 阶段二 | 3 | 1 小时 |
| 阶段三 | 2 | 0.5 小时 |
| 阶段四 | 2 | 1.5 小时 |
| 阶段五 | 1 | 1 小时 |
| 阶段六 | 2 | 0.5 小时 |
| 阶段七 | 1 | 0.5 小时 |
| 阶段八 | 3 | 2 小时 |
| 阶段九 | 3 | 1 小时 |
| **总计** | **18** | **约 8.5 小时** |

---

## 风险提示

1. **数据迁移风险**：如果后续需要将 type 从 ID 改为 typeCode，需要数据迁移脚本
2. **性能风险**：LEFT JOIN 可能影响查询性能，需监控慢查询日志
3. **权限配置风险**：需要正确配置角色权限，否则用户无法访问

---

## 验收清单

- [ ] 数据库表创建成功
- [ ] 所有代码文件编译通过
- [ ] API 接口测试通过
- [ ] Swagger 文档可访问
- [ ] 权限配置正确
- [ ] 已有文章数据正常显示
- [ ] 新增/修改/删除功能正常
- [ ] 操作日志记录完整
- [ ] 代码审查通过
