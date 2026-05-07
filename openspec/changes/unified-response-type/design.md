# 统一后端返回结果类型 - 技术设计

## 架构决策

### 选择 `R<T>` 作为统一返回类型的原因

1. **类型安全**：泛型设计在编译期即可检查类型错误
2. **代码清晰**：明确的字段定义，IDE 友好，自动补全完整
3. **内存效率**：不继承 HashMap，对象更轻量
4. **序列化为标准 JSON**：直接映射为 `{code, msg, data}` 结构
5. **符合项目规范**：AGENTS.md 中已明确使用 `R<T>` 作为标准响应

## 实施方案

### 阶段 1：增强 `R<T>` 类

在 `blog-common/src/main/java/blog/common/base/resp/R.java` 中补充缺失的方法：

```java
// 新增警告消息方法
public static <T> R<T> warn(String msg) {
    return restResult(null, HttpStatus.WARN, msg);
}

public static <T> R<T> warn(String msg, T data) {
    return restResult(data, HttpStatus.WARN, msg);
}

// 新增链式调用支持（可选）
public R<T> code(int code) {
    this.code = code;
    return this;
}

public R<T> msg(String msg) {
    this.msg = msg;
    return this;
}

public R<T> data(T data) {
    this.data = data;
    return this;
}
```

### 阶段 2：标记 `Result` 为废弃

在 `Result.java` 类和方法上添加 `@Deprecated` 注解：

```java
/**
 * @deprecated 请使用 {@link R} 代替
 */
@Deprecated
public class Result extends HashMap<String, Object> {
    // ...
}
```

### 阶段 3：全局替换策略

#### 替换规则映射表

| 原 Result 方法 | 新 R 方法 | 说明 |
|---------------|----------|------|
| `Result.success()` | `R.ok()` | 成功无数据 |
| `Result.success(data)` | `R.ok(data)` | 成功带数据 |
| `Result.success(msg)` | `R.ok(null, msg)` 或 `R.ok()` | 成功带消息 |
| `Result.success(msg, data)` | `R.ok(data, msg)` | 成功带消息和数据 |
| `Result.error()` | `R.fail()` | 失败无消息 |
| `Result.error(msg)` | `R.fail(msg)` | 失败带消息 |
| `Result.error(msg, data)` | `R.fail(data, msg)` | 失败带消息和数据 |
| `Result.error(code, msg)` | `R.fail(code, msg)` | 失败带状态码和消息 |
| `Result.warn(msg)` | `R.warn(msg)` | 警告消息 |
| `Result.warn(msg, data)` | `R.warn(msg, data)` | 警告消息带数据 |

#### 替换示例

**Before:**
```java
@PostMapping("/login")
public Result login(@RequestBody LoginBody loginBody) {
    Result ajax = Result.success();
    // ...
    return Result.success(token);
}
```

**After:**
```java
@PostMapping("/login")
public R<String> login(@RequestBody LoginBody loginBody) {
    R<String> ajax = R.ok();
    // ...
    return R.ok(token);
}
```

### 阶段 4：特殊场景处理

#### 场景 1：动态添加字段

**Before (Result 基于 HashMap):**
```java
Result ajax = Result.success();
ajax.put("token", token);
return ajax;
```

**After (R 使用包装对象):**
```java
// 方案 A：创建专门的 DTO
LoginVO vo = new LoginVO();
vo.setToken(token);
return R.ok(vo);

// 方案 B：使用 Map 作为 data（不推荐，仅用于兼容）
Map<String, Object> data = new HashMap<>();
data.put("token", token);
return R.ok(data);
```

#### 场景 2：BaseController 中的辅助方法

更新 `BaseController.java` 中的返回方法：

```java
// 保留向后兼容的方法
protected R<Void> success() {
    return R.ok();
}

protected R<Void> success(String msg) {
    return R.ok(null, msg);
}

protected <T> R<T> success(T data) {
    return R.ok(data);
}

protected R<Void> error() {
    return R.fail();
}

protected R<Void> error(String msg) {
    return R.fail(msg);
}
```

#### 场景 3：安全处理器中的返回

`LogoutSuccessHandlerImpl` 和 `AuthenticationEntryPointImpl` 需要直接写入 HTTP 响应：

```java
// Before
Result result = Result.error("未认证，请先登录");
ServletUtils.renderString(response, JSON.toJSONString(result));

// After
R<Void> result = R.fail("未认证，请先登录");
ServletUtils.renderString(response, JSON.toJSONString(result));
```

## 影响分析

### 需要修改的文件清单

#### 核心类（2个）
1. `blog-common/.../resp/R.java` - 增强方法
2. `blog-common/.../resp/Result.java` - 标记废弃

#### 控制器类（约25个）
- `blog-admin/src/main/java/blog/web/controller/` 下所有 Controller
- `blog-quartz/src/main/java/blog/quartz/controller/` 下所有 Controller
- `blog-generator/src/main/java/blog/generator/controller/GenController.java`

#### 框架类（2个）
- `blog-framework/.../security/handle/LogoutSuccessHandlerImpl.java`
- `blog-framework/.../security/handle/AuthenticationEntryPointImpl.java`

### 风险评估

| 风险项 | 影响 | 缓解措施 |
|--------|------|---------|
| 替换遗漏 | 编译错误 | 使用 IDE 全局搜索替换，编译验证 |
| 前端不兼容 | 接口返回变化 | JSON 结构保持一致，仅 Java 类型变化 |
| 功能缺失 | 某些场景无法处理 | 提前补充 `R<T>` 的所有必要方法 |
| 第三方依赖 | 外部系统调用 | 检查是否有外部 API 依赖 Result |

## 验证策略

### 1. 编译验证
```bash
mvn clean compile -DskipTests
```

### 2. 单元测试（如有）
```bash
mvn test
```

### 3. API 测试
- 使用 Swagger UI 测试所有接口
- 验证返回的 JSON 结构：`{ "code": 200, "msg": "...", "data": ... }`
- 对比改造前后的响应格式

### 4. 代码审查检查点
- [ ] 无 `import blog.common.base.resp.Result`
- [ ] 所有 Controller 返回 `R<?>` 或 `TableDataInfo<?>`
- [ ] 无 `Result.success()` 或 `Result.error()` 调用
- [ ] 泛型类型参数正确（不使用原始类型 `R`）

## 回滚方案

如果实施后发现问题：

1. **保留 Result 类**：不删除，仅标记 `@Deprecated`
2. **Git 回滚**：通过 Git  revert 撤销提交
3. **渐进式迁移**：允许新旧并存，逐步迁移

## 后续优化建议

1. **统一异常处理**：确保 `GlobalExceptionHandler` 也返回 `R<T>`
2. **添加响应拦截器**：在框架层统一处理响应
3. **生成 API 文档**：使用 Springdoc 自动生成接口文档
4. **添加响应验证**：单元测试中验证响应结构
