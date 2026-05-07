# 统一后端返回结果类型

## 问题描述

当前项目中存在三套并行的返回结果类型：

1. **`R<T>`** - 基于泛型的强类型响应类
   - 位置：`blog-common/src/main/java/blog/common/base/resp/R.java`
   - 特点：使用泛型 `<T>`，类型安全，有明确的 `code`、`msg`、`data` 字段
   - 方法：`ok()`、`ok(data)`、`fail()`、`fail(msg)` 等
2. **`Result`** - 基于 HashMap 的弱类型响应类
   - 位置：`blog-common/src/main/java/blog/common/base/resp/Result.java`
   - 特点：继承 `HashMap<String, Object>`，通过键值对存储数据
   - 方法：`success()`、`success(data)`、`error()`、`warn()` 等
3. **`TableDataInfo`** - 基于泛型的分页响应类
   - 位置：`blog-common/src/main/java/blog/common/base/resp/TableDataInfo.java`
   - 特点：使用泛型 `<T>`，类型安全，有 `code`、`msg`、`rows`、`total` 字段（**与 R<T> 结构重复**）
   - 方法：`build(page)`

这种重复设计导致：
- **代码不一致**：不同模块使用不同的返回类型，降低代码可读性
- **维护成本高**：需要同时维护多套逻辑相似的代码
- **类型不安全**：`Result` 基于 HashMap，无法在编译期检查类型错误
- **结构冗余**：`TableDataInfo` 和 `R<T>` 都包含 `code`、`msg` 字段
- **前端对接复杂**：需要处理多种返回结构

## 目标

统一使用 `R<T>` 作为唯一的后端返回结果类型，实现：
- 全项目返回类型一致性（所有 Controller 返回 `R<T>`）
- 类型安全的 API 响应
- 降低维护成本
- 提升代码质量
- **重构分页数据结构**：`TableDataInfo` → `Page<T>`，仅保留 `rows` 和 `total` 字段
- **支持 MyBatis-Plus IPage 转换**：提供 `Page.build(IPage<T>)` 静态方法

## 影响范围

### 需要修改的模块
- `blog-common` - 基础响应类
- `blog-system` - 系统管理模块
- `blog-biz` - 业务逻辑模块
- `blog-admin` - 管理后台模块
- `blog-quartz` - 定时任务模块
- `blog-generator` - 代码生成模块，以及资源目录下的vm文件夹中的代码模板文件

### 不受影响的部分
- 前端业务逻辑（仅调整 axios 响应拦截器，业务代码无需改动）

## 方案概述

### 后端改造
1. **保留并增强 `R<T>`** 作为唯一的返回结果类型
2. **删除 `Result`** 类或标记为 `@Deprecated`
   - 手动 put 的键值对改为 VO 实体类，禁止手动定义 key
3. **重构 `TableDataInfo` 为 `Page<T>`**
   - 类名：`TableDataInfo` → `Page`
   - 字段：仅保留 `rows`（List<T>）和 `total`（long）
   - **删除** `code` 和 `msg` 字段（由外层 `R<T>` 提供）
   - 添加 `build(IPage<T>)` 静态方法支持 MyBatis-Plus 分页对象转换
4. **全局替换** 所有使用 `Result` 的地方为 `R<T>`
5. **统一方法命名** 确保 `R<T>` 覆盖 `Result` 的所有功能
6. **补充缺失功能** 如 `warn()` 方法

### 前端改造
7. **修改 axios 响应拦截器**
   - 分页数据从 `response.data` 改为 `response.data.data`
   - 列表数据从 `response.rows` 改为 `response.data.rows`
   - 总数从 `response.total` 改为 `response.data.total`
8. **保持业务代码不变**（仅拦截器层调整）

## 非目标

- 不改变前端业务组件的调用方式（仅调整拦截器）
- 不影响现有业务逻辑
- 不修改 Service 层的核心逻辑

## 成功标准

### 后端
- [ ] 项目中不再使用 `Result` 类
- [ ] 所有 Controller 返回类型统一为 `R<T>`（包括 `R<Page<T>>` 用于分页）
- [ ] `TableDataInfo` 已重命名为 `Page`，仅包含 `rows` 和 `total` 字段
- [ ] 提供 `Page.build(IPage<T>)` 静态方法
- [ ] 编译无错误，所有测试通过

### 前端
- [ ] axios 响应拦截器已适配新的数据结构
- [ ] 分页列表接口正常显示数据
- [ ] 前端业务代码无需修改（仅拦截器层改动）

### JSON 结构对比

**普通接口（Before & After 一致）**:
```json
{
  "code": 200,
  "msg": "操作成功",
  "data": { ... }
}
```

**分页接口（Before → After）**:
```json
// Before
{
  "code": 200,
  "msg": "查询成功",
  "total": 100,
  "rows": [...]
}

// After
{
  "code": 200,
  "msg": "查询成功",
  "data": {
    "total": 100,
    "rows": [...]
  }
}
```
