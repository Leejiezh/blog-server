## Login 接口完整流程详解

### 一、请求流程概览

```
前端请求 → Spring Security 过滤器链 → /login 接口 → 登录验证 → 返回 Token
```

---

### 二、详细步骤分解

#### **步骤1：前端发起登录请求**
```http
POST /login
Content-Type: application/json

{
  "username": "admin",
  "password": "123456",
  "code": "abc123",
  "uuid": "xxx-xxx-xxx"
}
```

#### **步骤2：Spring Security 过滤器链处理**
文件：`SecurityConfig.java:84-116`

**关键配置：**
```java
SecurityFilterChain filterChain(HttpSecurity httpSecurity) {
    // 1. 禁用 CSRF（使用 JWT 不需要）
    .csrf(csrf -> csrf.disable())
    
    // 2. 无状态 Session（JWT 无状态）
    .sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
    
    // 3. 权限配置
    .authorizeHttpRequests(requests -> {
        requests.requestMatchers("/login").permitAll()  // 登录接口允许匿名访问
        .anyRequest().authenticated();  // 其他请求需要认证
    })
    
    // 4. 添加 JWT 过滤器（在 UsernamePasswordAuthenticationFilter 之前）
    .addFilterBefore(authenticationTokenFilter, UsernamePasswordAuthenticationFilter.class)
    
    // 5. 添加 CORS 过滤器
    .addFilterBefore(corsFilter, JwtAuthenticationTokenFilter.class)
}
```

**过滤器执行顺序：**
```
CorsFilter → JwtAuthenticationTokenFilter → UsernamePasswordAuthenticationFilter → ...
```

**JwtAuthenticationTokenFilter 作用：**（`JwtAuthenticationTokenFilter.java:30-41`）
- 从请求头获取 Token
- 验证 Token 有效性
- 解析 Token 获取用户信息
- 将用户信息存入 SecurityContext
- **对于 /login 请求：** 没有 Token，直接放行

#### **步骤3：Controller 接收请求**
文件：`SysLoginController.java:56-64`

```java
@PostMapping("/login")
public Result login(@RequestBody LoginBody loginBody) {
    // 调用登录服务
    String token = loginService.login(
        loginBody.getUsername(), 
        loginBody.getPassword(), 
        loginBody.getCode(),
        loginBody.getUuid()
    );
    ajax.put(Constants.TOKEN, token);
    return ajax;
}
```

**LoginBody 包含：**
- `username`：用户名
- `password`：密码
- `code`：验证码
- `uuid`：验证码唯一标识

#### **步骤4：登录服务处理**
文件：`SysLoginService.java:62-90`

**4.1 验证码校验**（第 64 行）
```java
validateCaptcha(username, code, uuid);
```
- 检查验证码是否启用
- 从 Redis 获取验证码：`captcha_codes:uuid`
- 验证通过后删除验证码
- 验证码错误或过期抛出异常

**4.2 登录前置校验**（第 66 行）
```java
loginPreCheck(username, password);
```
- 用户名、密码非空检查
- 用户名长度检查（2-20 字符）
- 密码长度检查（5-20 字符）
- IP 黑名单检查

**4.3 Spring Security 认证**（第 70-73 行）
```java
UsernamePasswordAuthenticationToken authenticationToken = 
    new UsernamePasswordAuthenticationToken(username, password);

authentication = authenticationManager.authenticate(authenticationToken);
```

**关键：** 这行代码触发 Spring Security 认证流程！

---

#### **步骤5：Spring Security 认证流程**

**5.1 AuthenticationManager.authenticate()**
- 接收 `UsernamePasswordAuthenticationToken`
- 委托给 `ProviderManager`
- `ProviderManager` 找到支持的 `AuthenticationProvider`
- 默认使用 `DaoAuthenticationProvider`

**5.2 DaoAuthenticationProvider 执行认证**
```
retrieveUser() → additionalAuthenticationChecks() → createSuccessAuthentication()
```

**a) retrieveUser() - 获取用户信息**
调用 `UserDetailsServiceImpl.loadUserByUsername()`

文件：`UserDetailsServiceImpl.java:37-53`

```java
@Override
public UserDetails loadUserByUsername(String username) {
    // 1. 查询用户
    SysUser user = userService.selectUserByUserName(username);
    
    // 2. 校验用户状态
    if (StringUtils.isNull(user)) {
        throw new ServiceException("用户不存在");
    }
    if (UserStatus.DELETED.getCode().equals(user.getDelFlag())) {
        throw new ServiceException("用户已被删除");
    }
    if (UserStatus.DISABLE.getCode().equals(user.getStatus())) {
        throw new ServiceException("用户已被停用");
    }
    
    // 3. 密码验证和登录失败次数检查
    passwordService.validate(user);
    
    // 4. 创建 LoginUser 对象
    return new LoginUser(
        user.getUserId(), 
        user.getDeptId(), 
        user, 
        permissionService.getMenuPermission(user)  // 获取用户权限
    );
}
```

**b) additionalAuthenticationChecks() - 密码验证**

在 `SysPasswordService.validate()` 中实现：`SysPasswordService.java:43-65`

```java
public void validate(SysUser user) {
    // 1. 从上下文获取用户输入的密码
    Authentication token = AuthenticationContextHolder.getContext();
    String username = token.getName();
    String password = token.getCredentials().toString();
    
    // 2. 获取登录失败次数
    Integer retryCount = redisCache.getCacheObject(
        CacheConstants.PWD_ERR_CNT_KEY + username
    );
    
    // 3. 检查是否超过最大失败次数
    if (retryCount >= maxRetryCount) {
        throw new UserPasswordRetryLimitExceedException(maxRetryCount, lockTime);
    }
    
    // 4. 验证密码（BCrypt 匹配）
    if (!matches(user, password)) {
        // 密码错误：失败次数 +1，存入 Redis
        retryCount = retryCount + 1;
        redisCache.setCacheObject(getCacheKey(username), retryCount, lockTime, TimeUnit.MINUTES);
        throw new UserPasswordNotMatchException();
    } else {
        // 密码正确：清除失败记录
        clearLoginRecordCache(username);
    }
}

// BCrypt 密码匹配
public boolean matches(SysUser user, String rawPassword) {
    return SecurityUtils.matchesPassword(rawPassword, user.getPassword());
}
```

**c) createSuccessAuthentication() - 创建认证成功的 Token**
返回已认证的 `UsernamePasswordAuthenticationToken`

**5.3 认证成功**
返回 `Authentication` 对象，包含：
- `principal`：LoginUser 对象
- `credentials`：null（安全考虑）
- `authorities`：用户权限列表

---

#### **步骤6：生成 Token**
文件：`SysLoginService.java:86-89`

```java
LoginUser loginUser = (LoginUser) authentication.getPrincipal();
recordLoginInfo(loginUser.getUserId());  // 记录登录信息
return tokenService.createToken(loginUser);  // 生成 Token
```

**TokenService.createToken() 详细流程：**`TokenService.java:105-115`

```java
public String createToken(LoginUser loginUser) {
    // 1. 生成 UUID 作为 Token 唯一标识
    String token = IdUtils.fastUUID();
    loginUser.setToken(token);
    
    // 2. 设置用户代理信息（IP、浏览器、操作系统）
    setUserAgent(loginUser);
    
    // 3. 刷新 Token（存入 Redis）
    refreshToken(loginUser);
    
    // 4. 创建 JWT Token
    Map<String, Object> claims = new HashMap<>();
    claims.put(Constants.LOGIN_USER_KEY, token);  // UUID
    claims.put(Constants.JWT_USERNAME, loginUser.getUsername());
    
    // 5. 生成 JWT（使用 HS512 算法）
    return Jwts.builder()
        .setClaims(claims)
        .signWith(SignatureAlgorithm.HS512, secret)
        .compact();
}
```

**refreshToken() - 存储用户信息到 Redis：**`TokenService.java:136-142`

```java
public void refreshToken(LoginUser loginUser) {
    loginUser.setLoginTime(System.currentTimeMillis());
    loginUser.setExpireTime(loginUser.getLoginTime() + expireTime * 60 * 1000);
    
    // 存入 Redis，key: login_tokens:uuid
    String userKey = CacheConstants.LOGIN_TOKEN_KEY + loginUser.getToken();
    redisCache.setCacheObject(userKey, loginUser, expireTime, TimeUnit.MINUTES);
}
```

**Redis 存储结构：**
```
key: login_tokens:xxx-xxx-xxx
value: LoginUser {
    userId: 1,
    username: "admin",
    token: "xxx-xxx-xxx",
    permissions: ["system:user:list", ...],
    loginTime: 1234567890,
    expireTime: 1234569890,
    ipaddr: "127.0.0.1",
    ...
}
expire: 30分钟（默认）
```

---

#### **步骤7：返回 Token 给前端**

```json
{
  "code": 200,
  "msg": "操作成功",
  "token": "eyJhbGciOiJIUzUxMiJ9.eyJsb2dpbl91c2VyX2tleSI6IjEyMzQ1Njc4..."
}
```

---

### 三、后续请求流程（携带 Token）

**前端请求：**
```http
GET /getInfo
Authorization: Bearer eyJhbGciOiJIUzUxMiJ9...
```

**JwtAuthenticationTokenFilter 处理：**`JwtAuthenticationTokenFilter.java:30-41`

```java
protected void doFilterInternal(HttpServletRequest request, ...) {
    // 1. 从请求头获取 Token
    LoginUser loginUser = tokenService.getLoginUser(request);
    
    // 2. 如果用户存在且未认证
    if (StringUtils.isNotNull(loginUser) && StringUtils.isNull(SecurityUtils.getAuthentication())) {
        // 3. 验证 Token 有效期（不足20分钟自动续期）
        tokenService.verifyToken(loginUser);
        
        // 4. 创建认证 Token
        UsernamePasswordAuthenticationToken authenticationToken = 
            new UsernamePasswordAuthenticationToken(loginUser, null, loginUser.getAuthorities());
        
        // 5. 存入 SecurityContext
        SecurityContextHolder.getContext().setAuthentication(authenticationToken);
    }
    
    // 6. 放行
    chain.doFilter(request, response);
}
```

**getLoginUser() 流程：**`TokenService.java:62-78`

```java
public LoginUser getLoginUser(HttpServletRequest request) {
    // 1. 获取 JWT Token
    String token = getToken(request);
    
    // 2. 解析 JWT 获取 UUID
    Claims claims = parseToken(token);
    String uuid = (String) claims.get(Constants.LOGIN_USER_KEY);
    
    // 3. 从 Redis 获取用户信息
    String userKey = CacheConstants.LOGIN_TOKEN_KEY + uuid;
    LoginUser user = redisCache.getCacheObject(userKey);
    
    return user;
}
```

---

### 四、核心 Spring Security 接口总结

| 接口 | 实现类 | 作用 |
|------|--------|------|
| `AuthenticationManager` | `ProviderManager` | 认证管理器，协调认证流程 |
| `AuthenticationProvider` | `DaoAuthenticationProvider` | 实际执行认证的提供者 |
| `UserDetailsService` | `UserDetailsServiceImpl` | 加载用户信息 |
| `UserDetails` | `LoginUser` | 用户详情对象 |
| `PasswordEncoder` | `BCryptPasswordEncoder` | 密码加密和验证 |
| `AuthenticationEntryPoint` | `AuthenticationEntryPointImpl` | 认证失败处理 |
| `OncePerRequestFilter` | `JwtAuthenticationTokenFilter` | JWT Token 验证过滤器 |

---

### 五、登录流程时序图

```
前端              Controller         LoginService        AuthenticationManager      UserDetailsService       PasswordService       TokenService
 |                  |                   |                       |                          |                      |                    |
 |--POST /login---->|                   |                       |                          |                      |                    |
 |                  |--login()--------->|                       |                          |                      |                    |
 |                  |                   |--validateCaptcha()    |                          |                      |                    |
 |                  |                   |--loginPreCheck()      |                          |                      |                    |
 |                  |                   |--authenticate()------>|                          |                      |                    |
 |                  |                   |                       |--loadUserByUsername()--->|                      |                    |
 |                  |                   |                       |                          |--validate()-------->|                    |
 |                  |                   |                       |                          |<----LoginUser--------|                    |
 |                  |                   |<---Authentication-----|                          |                      |                    |
 |                  |                   |--createToken()----------------------------------------------------------->|                    |
 |                  |                   |<---JWT Token--------------------------------------------------------------|                    |
 |                  |<---token----------|                       |                          |                      |                    |
 |<---token---------|                   |                       |                          |                      |                    |
```

---

### 六、关键配置文件

**application.yml**
```yaml
# Token 配置
token:
  header: Authorization        # Token 请求头名称
  secret: abcdefghijklmnop...  # JWT 密钥
  expireTime: 30               # Token 有效期（分钟）

# 用户密码配置
user:
  password:
    maxRetryCount: 5           # 最大登录失败次数
    lockTime: 10               # 锁定时间（分钟）
```

---

这就是完整的登录流程！核心是 **Spring Security 的认证流程** + **JWT Token 生成** + **Redis 存储用户信息**。

---