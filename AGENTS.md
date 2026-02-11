# AGENTS.md - Development Guidelines for LEEJIE Blog System

## Project Overview

This is a Spring Boot 3.5.4 multi-module Maven project using Java 17. The blog system includes:
- **blog-admin**: Admin web interface and entry point
- **blog-framework**: Core framework components (security, config, aspects, web services)
- **blog-system**: System management module (users, roles, menus, departments)
- **blog-biz**: Business logic modules
- **blog-quartz**: Scheduled task management
- **blog-generator**: Code generation utilities
- **blog-common**: Shared common utilities and core classes

## Build Commands

### Maven Commands (run from root directory)

```bash
# Full project build
mvn clean install -DskipTests

# Build specific module
mvn clean install -pl blog-common -DskipTests

# Run single module with dependencies
mvn clean install -pl blog-admin -am -DskipTests

# Compile without tests
mvn compile

# Run the application (blog-admin module)
mvn spring-boot:run -pl blog-admin

# Package as JAR
mvn package -DskipTests
```

### Java Version & Encoding
- Java version: 17
- Source encoding: UTF-8
- Target encoding: UTF-8

### IDE Setup
- Import as Maven project in IntelliJ IDEA
- Set Java 17 as project SDK
- Enable annotation processing for Lombok

## Code Style Guidelines

### General Principles
- Follow existing Chinese comment conventions
- Use `@author leejie` in class headers
- Keep methods focused and concise (aim for < 50 lines)
- Use meaningful variable and method names

### Naming Conventions

| Element | Convention | Examples |
|---------|------------|----------|
| Classes | PascalCase | `RedisCache`, `SecurityConfig`, `SysUser` |
| Methods | camelCase | `getCacheObject()`, `expire()` |
| Variables | camelCase | `redisTemplate`, `authenticationTokenFilter` |
| Constants | UPPER_SNAKE_CASE | `DEFAULT_EXPIRE_TIME` |
| Packages | lowercase | `blog.common.core.redis` |
| REST URLs | kebab-case | `/sys/user/list` |

### Java Conventions

**1. Imports:**
```java
// Standard library imports first (alphabetical)
import java.util.Collection;
import java.util.List;

// Blank line before framework imports
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

// Blank line before project imports
import blog.common.utils.StringUtils;
```

**2. Annotations:**
- Place class-level annotations on separate lines
- Order: @Tag, @RestController, @RequestMapping, @EnableMethodSecurity
- Use `@Service`, `@Repository`, `@Component` appropriately
- Constructor injection preferred over field injection where possible

**3. Method Structure:**
```java
/**
 * Description of method
 *
 * @param paramName parameter description
 * @return return description
 */
@Operation(summary = "method summary")
@GetMapping("/endpoint")
public R<Type> methodName(@RequestBody DTO dto) {
    // Validation first
    if (StringUtils.isNull(dto)) {
        return R.fail("error message");
    }
    // Business logic
    // Return result
}
```

**4. Response Pattern:**
- Use `R<T>` wrapper for API responses (`R.ok()`, `R.fail()`)
- Use `TableDataInfo` or `PageDomain` for paginated results
- Include proper error messages

**5. Error Handling:**
- Use `GlobalExceptionHandler` for global exception handling
- Throw custom exceptions with `ServiceException`
- Log errors with appropriate level (error, warn, info)

### Layer Organization

**Controller Layer** (`blog-*/controller/`):
- Handle HTTP requests/responses
- Validate input parameters
- Delegate to service layer
- Return `R<T>` responses
- Use Swagger annotations (@Operation, @Tag, @Schema)

**Service Layer** (`blog-*/service/`):
- Business logic implementation
- Transaction management (@Transactional)
- Interface-based design (I*Service, *ServiceImpl)
- Method-level security checks

**Mapper/Dao Layer** (`blog-*/mapper/`):
- MyBatis XML or注解-based queries
- Database operations
- Match method names with mapper XML

**Entity/Domain Layer** (`blog-*/domain/`):
- Database table mappings
- Use `@Data`, `@TableName`, `@TableField` from MyBatis-Plus
- Validation annotations for DTOs

**Aspect Layer** (`blog-framework/aspectj/`):
- Logging aspect (`LogAspect`)
- Data scope aspect (`DataSourceAspect`)
- Rate limiter aspect (`RateLimiterAspect`)

### Database Patterns

- Use MyBatis-Plus for ORM
- Follow naming: `sys_` prefix for system tables
- Use logical deletion with `@TableLogic`
- Soft delete pattern preferred over hard delete

### Security Guidelines

- All endpoints require authentication unless explicitly permitted
- Use `permitAllUrl.getUrls()` for anonymous access
- JWT-based stateless authentication
- Password encryption with `BCryptPasswordEncoder`
- Use `@PreAuthorize` for method-level security

### Validation

- Use Jakarta validation annotations (`@NotNull`, `@NotBlank`, `@Size`)
- Custom validators in `blog-common/validate/`
- Validation groups: `AddGroup`, `EditGroup`, `QueryGroup`

### Configuration

- Use `@ConfigurationProperties` for configuration binding
- Place configs in `blog-framework/config/` or `blog-framework/config/properties/`
- Environment-specific configs in `application-*.yml`

### Logging

- Use SLF4J (`Logger`, `LoggerFactory`)
- Place logger as static final field
- Log levels: ERROR for failures, WARN for warnings, INFO for significant operations

## Testing

**Note:** No existing tests found in the repository. Consider adding:
- Unit tests for service layer
- Integration tests for controllers
- Use JUnit 5 + Mockito + Spring Boot Test

```bash
# Run all tests (when implemented)
mvn test

# Run specific test class
mvn test -Dtest=UserServiceTest

# Run specific test method
mvn test -Dtest=UserServiceTest#testGetUser
```

## Documentation

- Use Swagger/OpenAPI 3.0 for API documentation
- Add `@Operation` and `@Parameter` annotations
- Schema descriptions with `@Schema`
- Access docs at `/swagger-ui.html` and `/v3/api-docs`

## Important Notes

- Never commit sensitive data (passwords, secrets, API keys)
- Use `application.yml` for environment variables
- Follow the existing package structure when adding new features
- Use Lombok annotations (@Data, @Builder, @AllArgsConstructor, @NoArgsConstructor)
- Minimize third-party dependencies; use existing utilities in blog-common
