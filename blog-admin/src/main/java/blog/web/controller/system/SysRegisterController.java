package blog.web.controller.system;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import blog.common.core.controller.BaseController;
import blog.common.core.domain.Result;
import blog.common.core.domain.model.RegisterBody;
import blog.common.utils.StringUtils;
import blog.framework.web.service.SysRegisterService;
import blog.system.service.ISysConfigService;

/**
 * 注册验证
 *
 * @author leejie
 */
@RestController
public class SysRegisterController extends BaseController {
    @Autowired
    private SysRegisterService registerService;

    @Autowired
    private ISysConfigService configService;

    @PostMapping("/register")
    public Result register(@RequestBody RegisterBody user) {
        if (!("true".equals(configService.selectConfigByKey("sys.account.registerUser")))) {
            return error("当前系统没有开启注册功能！");
        }
        String msg = registerService.register(user);
        return StringUtils.isEmpty(msg) ? success() : error(msg);
    }
}
