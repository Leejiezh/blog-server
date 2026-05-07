# 返回类型统一 - 实际案例

## 案例 1: 登录接口改造

### Before

```java
package blog.web.controller.system;

import blog.common.base.resp.Result;

@RestController
@RequestMapping("/system/login")
public class SysLoginController {
    
    @Autowired
    private LoginService loginService;
    
    /**
     * 登录方法
     */
    @PostMapping("/login")
    public Result login(@RequestBody LoginBody loginBody) {
        Result ajax = Result.success();
        
        // 生成令牌
        String token = loginService.login(
            loginBody.getUsername(),
            loginBody.getPassword()
        );
        
        ajax.put("token", token);
        return ajax;
    }
    
    /**
     * 获取用户信息
     */
    @GetMapping("/getInfo")
    public Result getInfo() {
        LoginUser loginUser = getLoginUser();
        return Result.success(loginUser.getUser());
    }
}
```

### After

```java
package blog.web.controller.system;

import blog.common.base.resp.R;
import blog.web.domain.vo.LoginResponseVO;

@RestController
@RequestMapping("/system/login")
public class SysLoginController {
    
    @Autowired
    private LoginService loginService;
    
    /**
     * 登录方法
     */
    @PostMapping("/login")
    public R<LoginResponseVO> login(@RequestBody LoginBody loginBody) {
        // 生成令牌
        String token = loginService.login(
            loginBody.getUsername(),
            loginBody.getPassword()
        );
        
        // 使用 VO 替代动态 put
        LoginResponseVO vo = new LoginResponseVO();
        vo.setToken(token);
        return R.ok(vo);
    }
    
    /**
     * 获取用户信息
     */
    @GetMapping("/getInfo")
    public R<SysUser> getInfo() {
        LoginUser loginUser = getLoginUser();
        return R.ok(loginUser.getUser());
    }
}
```

### LoginResponseVO

```java
package blog.web.domain.vo;

import lombok.Data;
import java.io.Serializable;

/**
 * 登录响应 VO
 *
 * @author leejie
 */
@Data
public class LoginResponseVO implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * 令牌
     */
    private String token;
}
```

---

## 案例 2: 用户列表分页接口改造

### Before

```java
package blog.web.controller.system;

import blog.common.base.resp.TableDataInfo;
import blog.common.base.controller.BaseController;

@RestController
@RequestMapping("/system/user")
public class SysUserController extends BaseController {
    
    @Autowired
    private ISysUserService userService;
    
    /**
     * 获取用户列表
     */
    @PreAuthorize("@ss.hasPermi('system:user:list')")
    @GetMapping("/list")
    public TableDataInfo<SysUser> list(SysUser user) {
        startPage();
        List<SysUser> list = userService.selectUserList(user);
        return getDataTable(list);
    }
}
```

**返回 JSON**:
```json
{
  "code": 200,
  "msg": "查询成功",
  "total": 100,
  "rows": [
    {"userId": 1, "userName": "admin"},
    {"userId": 2, "userName": "user"}
  ]
}
```

### After

```java
package blog.web.controller.system;

import blog.common.base.resp.R;
import blog.common.base.resp.Page;
import blog.common.base.controller.BaseController;

@RestController
@RequestMapping("/system/user")
public class SysUserController extends BaseController {
    
    @Autowired
    private ISysUserService userService;
    
    /**
     * 获取用户列表
     */
    @PreAuthorize("@ss.hasPermi('system:user:list')")
    @GetMapping("/list")
    public R<Page<SysUser>> list(SysUser user) {
        startPage();
        List<SysUser> list = userService.selectUserList(user);
        return getDataTable(list);  // getDataTable 已返回 R<Page<?>>
    }
}
```

**返回 JSON**:
```json
{
  "code": 200,
  "msg": "查询成功",
  "data": {
    "total": 100,
    "rows": [
      {"userId": 1, "userName": "admin"},
      {"userId": 2, "userName": "user"}
    ]
  }
}
```

---

## 案例 3: 删除操作改造

### Before

```java
/**
 * 删除用户
 */
@PreAuthorize("@ss.hasPermi('system:user:remove')")
@Log(title = "用户管理", businessType = BusinessType.DELETE)
@DeleteMapping("/{userIds}")
public Result remove(@PathVariable Long[] userIds) {
    if (ArrayUtils.contains(userIds, getUserId())) {
        return Result.error("当前用户不能删除");
    }
    return toAjax(userService.deleteUserByIds(userIds));
}
```

### After

```java
/**
 * 删除用户
 */
@PreAuthorize("@ss.hasPermi('system:user:remove')")
@Log(title = "用户管理", businessType = BusinessType.DELETE)
@DeleteMapping("/{userIds}")
public R<Void> remove(@PathVariable Long[] userIds) {
    if (ArrayUtils.contains(userIds, getUserId())) {
        return R.fail("当前用户不能删除");
    }
    return toAjax(userService.deleteUserByIds(userIds));
}
```

---

## 案例 4: 带警告消息的接口

### Before

```java
/**
 * 修改用户密码
 */
@PreAuthorize("@ss.hasPermi('system:user:edit')")
@Log(title = "用户管理", businessType = BusinessType.UPDATE)
@PutMapping("/resetPwd")
public Result resetPwd(SysUser user) {
    if (!userService.checkUserAllowed(user)) {
        return Result.warn("用户状态异常，无法修改密码");
    }
    return toAjax(userService.resetPwd(user));
}
```

### After

```java
/**
 * 修改用户密码
 */
@PreAuthorize("@ss.hasPermi('system:user:edit')")
@Log(title = "用户管理", businessType = BusinessType.UPDATE)
@PutMapping("/resetPwd")
public R<Void> resetPwd(SysUser user) {
    if (!userService.checkUserAllowed(user)) {
        return R.warn("用户状态异常，无法修改密码");
    }
    return toAjax(userService.resetPwd(user));
}
```

---

## 案例 5: Service 层返回改造

### Before

```java
package blog.system.service.impl;

import blog.common.base.resp.TableDataInfo;

@Service
public class ArticleServiceImpl implements IArticleService {
    
    @Override
    public TableDataInfo<Article> selectArticleList(Article article, PageQuery pageQuery) {
        // 使用 PageHelper
        PageHelper.startPage(pageQuery.getPageNum(), pageQuery.getPageSize());
        List<Article> list = articleMapper.selectArticleList(article);
        
        TableDataInfo<Article> rspData = new TableDataInfo<>();
        rspData.setCode(HttpStatus.SUCCESS);
        rspData.setMsg("查询成功");
        rspData.setRows(list);
        rspData.setTotal(new PageInfo(list).getTotal());
        return rspData;
    }
}
```

### After

```java
package blog.system.service.impl;

import blog.common.base.resp.Page;

@Service
public class ArticleServiceImpl implements IArticleService {
    
    @Override
    public Page<Article> selectArticleList(Article article, PageQuery pageQuery) {
        // 使用 PageHelper
        PageHelper.startPage(pageQuery.getPageNum(), pageQuery.getPageSize());
        List<Article> list = articleMapper.selectArticleList(article);
        
        // 直接返回 Page 对象（仅包含数据）
        return Page.build(list, new PageInfo(list).getTotal());
    }
}
```

**Controller 层调用**:
```java
@GetMapping("/list")
public R<Page<Article>> list(Article article, PageQuery pageQuery) {
    Page<Article> data = articleService.selectArticleList(article, pageQuery);
    return R.ok(data);  // Controller 负责包装 R<T>
}
```

---

## 案例 6: MyBatis-Plus IPage 集成

### Before

```java
import com.baomidou.mybatisplus.core.metadata.IPage;
import blog.common.base.resp.TableDataInfo;

@Override
public TableDataInfo<Article> selectArticleListByMp(Article article, PageQuery pageQuery) {
    // 使用 MyBatis-Plus 分页
    Page<Article> page = new Page<>(pageQuery.getPageNum(), pageQuery.getPageSize());
    IPage<Article> result = articleMapper.selectArticlePage(page, article);
    
    TableDataInfo<Article> rspData = TableDataInfo.build(result);
    return rspData;
}
```

### After

```java
import com.baomidou.mybatisplus.core.metadata.IPage;
import blog.common.base.resp.Page;

@Override
public Page<Article> selectArticleListByMp(Article article, PageQuery pageQuery) {
    // 使用 MyBatis-Plus 分页
    com.baomidou.mybatisplus.extension.plugins.pagination.Page<Article> mpPage = 
        new com.baomidou.mybatisplus.extension.plugins.pagination.Page<>(
            pageQuery.getPageNum(), 
            pageQuery.getPageSize()
        );
    
    IPage<Article> result = articleMapper.selectArticlePage(mpPage, article);
    
    // 使用新的 Page.build() 方法转换
    return Page.build(result);
}
```

---

## 案例 7: 代码生成模板改造

### Before (controller.java.vm)

```velocity
/**
 * 查询${functionName}列表
 */
@PreAuthorize("@ss.hasPermi('${permissionPrefix}:list')")
@GetMapping("/list")
public TableDataInfo<$!{ClassName}> list($!{ClassName} $!{instance}) {
    startPage();
    List<$!{ClassName}> list = $!{instance}Service.select${ClassName}List($!{instance});
    return getDataTable(list);
}
```

### After (controller.java.vm)

```velocity
/**
 * 查询${functionName}列表
 */
@PreAuthorize("@ss.hasPermi('${permissionPrefix}:list')")
@GetMapping("/list")
public R<Page<$!{ClassName}>> list($!{ClassName} $!{instance}) {
    startPage();
    List<$!{ClassName}> list = $!{instance}Service.select${ClassName}List($!{instance});
    return getDataTable(list);
}
```

---

## 案例 8: 批量替换前后对比

### 完整 Controller 改造

**Before** (约 150 行):
```java
import blog.common.base.resp.Result;
import blog.common.base.resp.TableDataInfo;

@RestController
@RequestMapping("/system/role")
public class SysRoleController extends BaseController {
    
    @GetMapping("/list")
    public TableDataInfo<?> list(SysRole role) {
        startPage();
        List<SysRole> list = roleService.selectRoleList(role);
        return getDataTable(list);
    }
    
    @GetMapping("/{roleId}")
    public Result getInfo(@PathVariable Long roleId) {
        return Result.success(roleService.selectRoleById(roleId));
    }
    
    @PostMapping
    public Result add(@Validated @RequestBody SysRole role) {
        if (!roleService.checkRoleNameUnique(role)) {
            return Result.error("新增角色'" + role.getRoleName() + "'失败，角色名称已存在");
        }
        return toAjax(roleService.insertRole(role));
    }
    
    @PutMapping
    public Result edit(@Validated @RequestBody SysRole role) {
        if (!roleService.checkRoleNameUnique(role)) {
            return Result.error("修改角色'" + role.getRoleName() + "'失败，角色名称已存在");
        }
        return toAjax(roleService.updateRole(role));
    }
    
    @DeleteMapping("/{roleIds}")
    public Result remove(@PathVariable Long[] roleIds) {
        return toAjax(roleService.deleteRoleByIds(roleIds));
    }
}
```

**After** (约 150 行，仅类型变化):
```java
import blog.common.base.resp.R;
import blog.common.base.resp.Page;

@RestController
@RequestMapping("/system/role")
public class SysRoleController extends BaseController {
    
    @GetMapping("/list")
    public R<Page<?>> list(SysRole role) {
        startPage();
        List<SysRole> list = roleService.selectRoleList(role);
        return getDataTable(list);
    }
    
    @GetMapping("/{roleId}")
    public R<SysRole> getInfo(@PathVariable Long roleId) {
        return R.ok(roleService.selectRoleById(roleId));
    }
    
    @PostMapping
    public R<Void> add(@Validated @RequestBody SysRole role) {
        if (!roleService.checkRoleNameUnique(role)) {
            return R.fail("新增角色'" + role.getRoleName() + "'失败，角色名称已存在");
        }
        return toAjax(roleService.insertRole(role));
    }
    
    @PutMapping
    public R<Void> edit(@Validated @RequestBody SysRole role) {
        if (!roleService.checkRoleNameUnique(role)) {
            return R.fail("修改角色'" + role.getRoleName() + "'失败，角色名称已存在");
        }
        return toAjax(roleService.updateRole(role));
    }
    
    @DeleteMapping("/{roleIds}")
    public R<Void> remove(@PathVariable Long[] roleIds) {
        return toAjax(roleService.deleteRoleByIds(roleIds));
    }
}
```

**变化总结**:
- ✅ `TableDataInfo<?>` → `R<Page<?>>`
- ✅ `Result` → `R<SysRole>` 或 `R<Void>`
- ✅ `Result.success()` → `R.ok()`
- ✅ `Result.error()` → `R.fail()`
- ✅ 所有方法都有明确的泛型类型

---

## 错误案例集锦

### ❌ 错误 1: 参数顺序错误

```java
// Result.success(msg, data) - 消息在前
Result.success("操作成功", user);

// 错误：R.ok(msg, data) - 参数顺序搞反了
R.ok("操作成功", user);  // ❌ 编译错误！

// 正确：R.ok(data, msg) - 数据在前
R.ok(user, "操作成功");  // ✅
```

### ❌ 错误 2: 忘记泛型参数

```java
// 错误
public R login() { ... }  // ❌ Raw type warning

// 正确
public R<String> login() { ... }  // ✅
public R<Void> logout() { ... }   // ✅
```

### ❌ 错误 3: 分页数据缺少泛型

```java
// 错误
public R<Page> list() { ... }  // ❌ Page 缺少泛型

// 正确
public R<Page<User>> list() { ... }  // ✅
```

### ❌ 错误 4: 遗漏 import

```java
// 错误：只改了返回类型，忘记改 import
import blog.common.base.resp.Result;  // ❌ 还在用 Result

public R<User> getUser() { ... }

// 正确
import blog.common.base.resp.R;  // ✅
import blog.common.base.resp.Page;  // 如需分页

public R<User> getUser() { ... }
```

---

## 迁移统计示例

### 本次改造统计

| 模块 | 文件数 | 方法数 | 状态 |
|------|--------|--------|------|
| blog-admin/controller | 20 | 150 | ✅ |
| blog-quartz/controller | 2 | 20 | ✅ |
| blog-generator/controller | 1 | 10 | ✅ |
| blog-system/service | 15 | 80 | ✅ |
| blog-framework/handler | 2 | 5 | ✅ |
| **总计** | **40** | **265** | ✅ |

### 替换分布

| 替换类型 | 次数 | 占比 |
|---------|------|------|
| `Result.success()` → `R.ok()` | 120 | 45% |
| `Result.error()` → `R.fail()` | 80 | 30% |
| `TableDataInfo` → `Page` | 40 | 15% |
| `Result.warn()` → `R.warn()` | 10 | 4% |
| 其他 | 15 | 6% |

---

## 相关资源

- [SKILL.md](SKILL.md) - 技能主文档
- [reference.md](reference.md) - 详细参考文档
- [AGENTS.md](../../../AGENTS.md) - 项目开发规范
