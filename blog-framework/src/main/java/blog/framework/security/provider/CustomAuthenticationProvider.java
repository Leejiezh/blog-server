package blog.framework.security.provider;

import blog.common.core.domain.model.LoginUser;
import blog.common.utils.DateUtils;
import blog.common.utils.ip.IpUtils;
import blog.framework.web.service.SysPasswordService;
import blog.framework.web.service.SysPermissionService;
import blog.system.service.ISysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

/**
 * @Author leejie
 * @Date 2026/4/3
 * @Description
 */
@Component
public class CustomAuthenticationProvider extends DaoAuthenticationProvider {

    private final SysPasswordService sysPasswordService;

    /**
     * 通过构造函数注入
     */
    public CustomAuthenticationProvider(
            UserDetailsService userDetailsService,
            PasswordEncoder passwordEncoder,
            SysPasswordService passwordService) {

        // Spring Security 6.x 推荐通过构造函数设置
        super(userDetailsService);
        super.setPasswordEncoder(passwordEncoder);

        this.sysPasswordService = passwordService;
    }

    /**
     * 重写密码验证逻辑
     * @param userDetails as retrieved from the
     * {@link #retrieveUser(String, UsernamePasswordAuthenticationToken)} or
     * <code>UserCache</code>
     * @param authentication the current request that needs to be authenticated
     */
    @Override
    protected void additionalAuthenticationChecks(UserDetails userDetails, UsernamePasswordAuthenticationToken authentication) throws AuthenticationException {
        //1. 获取用户输入的密码
        LoginUser loginUser = (LoginUser) userDetails;
        //2. 密码验证 + 登录失败次数检查
        sysPasswordService.validate(loginUser.getUser());
    }

}
