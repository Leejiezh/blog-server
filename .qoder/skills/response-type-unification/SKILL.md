---
name: response-type-unification
description: 统一项目中多种 API 返回类型为单一标准类型，自动化分析、替换和验证流程。适用于需要统一后端响应格式、重构返回类型、消除重复响应类的场景。
---

# 统一响应类型重构

## 概述

本技能指导 AI 助手完成项目中 API 返回类型的统一重构，包括：
- 分析现有返回类型的使用情况
- 生成类型映射关系表
- 批量替换代码（支持 Before/After 模式）
- 验证替换完整性
- 生成迁移报告

## 触发场景

当用户提到以下关键词时使用此技能：
- "统一返回类型"
- "统一响应格式"
- "重构 R<T>、Result、TableDataInfo"
- "API 返回类型标准化"
- "响应类型收敛"

## 核心工作流

### Phase 1: 分析现状

**步骤**:
1. 搜索项目中所有返回类型类：
   ```bash
   # 搜索响应类定义
   grep -r "public class.*Resp" --include="*.java"
   grep -r "public class.*Result" --include="*.java"
   grep -r "public class.*Response" --include="*.java"
   ```

2. 统计各返回类型的使用频率：
   ```bash
   # 统计 import 次数
   grep -r "import.*R;" --include="*.java" | wc -l
   grep -r "import.*Result;" --include="*.java" | wc -l
   grep -r "import.*TableDataInfo;" --include="*.java" | wc -l
   ```

3. 生成使用报告：
   - 每个返回类型的位置、特点、方法列表
   - 使用频率统计
   - 存在的问题（字段冗余、类型不安全等）

**输出**: 现状分析报告

---

### Phase 2: 设计方案

**步骤**:
1. 确定目标返回类型（保留哪个，废弃哪个）
2. 生成类型映射表：

| 源类型方法 | 目标类型方法 | 说明 |
|-----------|------------|------|
| `Result.success()` | `R.ok()` | 成功无数据 |
| `Result.success(data)` | `R.ok(data)` | 成功带数据 |
| `Result.error(msg)` | `R.fail(msg)` | 失败带消息 |

3. 确定重构策略：
   - **策略 A**: 直接删除废弃类（激进）
   - **策略 B**: 标记 `@Deprecated`，渐进迁移（推荐）

4. 评估影响范围：
   - 需要修改的文件列表
   - 是否需要修改前端
   - JSON 结构是否变化

**输出**: 设计方案文档

---

### Phase 3: 实施替换

#### 3.1 增强目标返回类型

如需补充方法：
```java
// 示例：为 R<T> 添加 warn 方法
public static <T> R<T> warn(String msg) {
    return restResult(null, HttpStatus.WARN, msg);
}
```

#### 3.2 标记废弃类

```java
/**
 * @deprecated 请使用 {@link R} 代替
 */
@Deprecated
public class Result { ... }
```

#### 3.3 批量替换 Controller

**替换规则**:
1. 更新 import 语句
2. 修改方法返回类型（注意泛型）
3. 替换方法调用
4. 处理特殊情况（如动态添加字段需改为 VO）

**Before**:
```java
@PostMapping("/login")
public Result login(@RequestBody LoginBody body) {
    Result ajax = Result.success();
    return Result.success(token);
}
```

**After**:
```java
@PostMapping("/login")
public R<String> login(@RequestBody LoginBody body) {
    R<String> ajax = R.ok();
    return R.ok(token);
}
```

#### 3.4 更新 BaseController

```java
// Before
protected Result success() { return Result.success(); }

// After
protected R<Void> success() { return R.ok(); }
```

**输出**: 修改后的代码文件

---

### Phase 4: 验证完整性

**步骤**:
1. 编译验证：
   ```bash
   mvn clean compile -DskipTests
   ```

2. 检查残留引用：
   ```bash
   # 搜索是否还有使用废弃类的地方
   grep -r "import.*Result" --include="*.java" | grep -v "@Deprecated"
   grep -r "Result\.success\|Result\.error" --include="*.java"
   ```

3. 检查泛型使用：
   ```bash
   # 确保没有原始类型（缺少泛型参数）
   grep -r "public R " --include="*.java"  # 应该是 R<T>
   ```

4. 运行测试（如有）：
   ```bash
   mvn test
   ```

**输出**: 验证报告

---

### Phase 5: 生成迁移报告

**报告结构**:
```markdown
# 返回类型统一迁移报告

## 概览
- 目标类型: R<T>
- 废弃类型: Result, TableDataInfo
- 修改文件数: 25
- 预计工作量: 3-4 小时

## 修改统计
| 模块 | 修改文件数 | 状态 |
|------|-----------|------|
| blog-admin | 20 | ✅ |
| blog-quartz | 2 | ✅ |
| blog-generator | 3 | ✅ |

## 替换映射
[详细的映射表]

## 验证结果
- 编译: ✅ 通过
- 测试: ✅ 通过
- 残留引用: 0

## 后续建议
- 删除废弃类（可选）
- 更新 API 文档
- 通知前端团队
```

---

## 特殊场景处理

### 场景 1: 动态添加字段

**问题**: 原代码使用 `result.put("key", value)` 动态添加字段

**解决方案**: 创建专门的 VO 类

```java
// Before
Result ajax = Result.success();
ajax.put("token", token);
ajax.put("userId", userId);
return ajax;

// After
LoginVO vo = new LoginVO();
vo.setToken(token);
vo.setUserId(userId);
return R.ok(vo);
```

### 场景 2: 分页数据返回

**问题**: TableDataInfo 与 R<T> 结构重复

**解决方案**: 重构为 Page<T>，仅保留数据字段

```java
// 新的 Page 类
public class Page<T> {
    private List<T> rows;
    private long total;
    // ❌ 不包含 code、msg（由外层 R<T> 提供）
}

// Controller 返回
@GetMapping("/list")
public R<Page<User>> list(UserQuery query) {
    Page<User> data = userService.selectUserList(query);
    return R.ok(data);
}
```

### 场景 3: 代码生成模板

**问题**: 确保以后生成的代码也使用新返回类型

**解决方案**: 更新 Velocity 模板文件

```velocity
## controller.java.vm
@GetMapping("/list")
public R<Page<$!{ClassName}>> list($!{ClassName} $!{instance}) {
    startPage();
    List<$!{ClassName}> list = $!{instance}Service.select${ClassName}List($!{instance});
    return getDataTable(list);
}
```

---

## 验证检查清单

完成任务前，确认以下检查项：

### 代码层面
- [ ] 无 `import` 废弃返回类型（除了废弃类本身）
- [ ] 所有 Controller 方法返回目标类型（带泛型）
- [ ] 无原始类型使用（如 `R` 应为 `R<T>`）
- [ ] 编译无错误、无警告
- [ ] 测试全部通过

### 文档层面
- [ ] 更新 API 文档
- [ ] 更新开发规范文档
- [ ] 生成迁移报告

### 前端层面（如影响）
- [ ] 通知前端团队
- [ ] 提供适配指南
- [ ] 前端接口联调通过

---

## 常见陷阱

### ❌ 陷阱 1: 遗漏泛型参数

**错误**:
```java
public R login() { ... }  // 原始类型
```

**正确**:
```java
public R<String> login() { ... }  // 带泛型
```

### ❌ 陷阱 2: 方法签名不匹配

**错误**:
```java
// Result.success(msg, data) 有两个参数
// R.ok(data, msg) 也是两个参数，但顺序不同
Result.success("成功", data)  // msg, data
R.ok(data, "成功")            // data, msg ✅
```

### ❌ 陷阱 3: 忽略特殊场景

**错误**:
```java
// 原代码使用了 put() 动态添加字段
// 直接替换会丢失这些字段
Result ajax = Result.success();
ajax.put("extra", value);
return ajax;
```

**正确**:
```java
// 创建 VO 类承载所有字段
ResponseVO vo = new ResponseVO();
vo.setExtra(value);
return R.ok(vo);
```

---

## 参考文档

- 详细的类型映射表: [reference.md](reference.md)
- 实际案例演示: [examples.md](examples.md)
- 项目规范: [AGENTS.md](../../../AGENTS.md)

---

## 快速参考

### 常用替换命令

```bash
# 1. 查找所有使用 Result 的文件
grep -r "import.*Result" --include="*.java" -l

# 2. 查找所有 Result 方法调用
grep -r "Result\.\(success\|error\|warn\)" --include="*.java"

# 3. 统计修改文件数
git diff --name-only | wc -l

# 4. 编译验证
mvn clean compile -DskipTests
```

### 替换优先级

1. **优先级 P0**: 核心响应类（R.java）
2. **优先级 P1**: BaseController 辅助方法
3. **优先级 P2**: 所有 Controller 层
4. **优先级 P3**: Service 层（如需要）
5. **优先级 P4**: 代码生成模板

---

**提示**: 每次替换后及时编译验证，避免积累错误！
