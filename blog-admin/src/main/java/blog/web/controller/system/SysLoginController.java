package blog.web.controller.system;

import java.util.Date;
import java.util.List;
import java.util.Set;

import blog.system.domain.vo.RouterVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import blog.common.base.resp.R;
import blog.common.core.domain.vo.LoginVO;
import blog.common.core.domain.vo.UserInfoVO;
import blog.common.core.domain.entity.SysMenu;
import blog.common.core.domain.entity.SysUser;
import blog.common.core.domain.model.LoginBody;
import blog.common.core.domain.model.LoginUser;
import blog.common.core.text.Convert;
import blog.common.utils.DateUtils;
import blog.common.utils.SecurityUtils;
import blog.common.utils.StringUtils;
import blog.framework.web.service.SysLoginService;
import blog.framework.web.service.SysPermissionService;
import blog.framework.web.service.TokenService;
import blog.system.service.ISysConfigService;
import blog.system.service.ISysMenuService;

/**
 * 登录验证
 *
 * @author leejie
 */
@RestController
public class SysLoginController {
    @Autowired
    private SysLoginService loginService;

    @Autowired
    private ISysMenuService menuService;

    @Autowired
    private SysPermissionService permissionService;

    @Autowired
    private TokenService tokenService;

    @Autowired
    private ISysConfigService configService;

    /**
     * 登录方法
     *
     * @param loginBody 登录信息
     * @return 结果
     */
    @PostMapping("/login")
    public R<LoginVO> login(@RequestBody LoginBody loginBody) {
        String token = loginService.login(loginBody.getUsername(), loginBody.getPassword(), loginBody.getCode(),
                loginBody.getUuid());
        LoginVO vo = new LoginVO();
        vo.setToken(token);
        return R.ok(vo);
    }

    /**
     * 获取用户信息
     *
     * @return 用户信息
     */
    @GetMapping("getInfo")
    public R<UserInfoVO> getInfo() {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        SysUser user = loginUser.getUser();
        Set<String> roles = permissionService.getRolePermission(user);
        Set<String> permissions = permissionService.getMenuPermission(user);
        if (!loginUser.getPermissions().equals(permissions)) {
            loginUser.setPermissions(permissions);
            tokenService.refreshToken(loginUser);
        }
        UserInfoVO vo = new UserInfoVO();
        vo.setUser(user);
        vo.setRoles(roles);
        vo.setPermissions(permissions);
        vo.setIsDefaultModifyPwd(initPasswordIsModify(user.getPwdUpdateDate()));
        vo.setIsPasswordExpired(passwordIsExpiration(user.getPwdUpdateDate()));
        return R.ok(vo);
    }

    /**
     * 获取路由信息
     *
     * @return 路由信息
     */
    @GetMapping("getRouters")
    public R<List<RouterVo>> getRouters() {
        Long userId = SecurityUtils.getUserId();
        List<SysMenu> menus = menuService.selectMenuTreeByUserId(userId);
        return R.ok(menuService.buildMenus(menus));
    }

    // 检查初始密码是否提醒修改
    public boolean initPasswordIsModify(Date pwdUpdateDate) {
        Integer initPasswordModify = Convert.toInt(configService.selectConfigByKey("sys.account.initPasswordModify"));
        return initPasswordModify != null && initPasswordModify == 1 && pwdUpdateDate == null;
    }

    // 检查密码是否过期
    public boolean passwordIsExpiration(Date pwdUpdateDate) {
        Integer passwordValidateDays = Convert.toInt(configService.selectConfigByKey("sys.account.passwordValidateDays"));
        if (passwordValidateDays != null && passwordValidateDays > 0) {
            if (StringUtils.isNull(pwdUpdateDate)) {
                // 如果从未修改过初始密码，直接提醒过期
                return true;
            }
            Date nowDate = DateUtils.getNowDate();
            return DateUtils.differentDaysByMillisecond(nowDate, pwdUpdateDate) > passwordValidateDays;
        }
        return false;
    }
}
