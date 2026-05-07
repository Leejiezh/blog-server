package blog.web.controller.system;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import blog.common.annotation.Log;
import blog.common.config.BlogServerConfig;
import blog.common.base.controller.BaseController;
import blog.common.base.resp.R;
import blog.common.core.domain.vo.AvatarVO;
import blog.common.core.domain.vo.ProfileVO;
import blog.common.core.domain.entity.SysUser;
import blog.common.core.domain.model.LoginUser;
import blog.common.enums.BusinessType;
import blog.common.utils.DateUtils;
import blog.common.utils.SecurityUtils;
import blog.common.utils.StringUtils;
import blog.common.utils.file.FileUploadUtils;
import blog.common.utils.file.FileUtils;
import blog.common.utils.file.MimeTypeUtils;
import blog.framework.web.service.TokenService;
import blog.system.service.ISysUserService;

/**
 * 个人信息 业务处理
 *
 * @author leejie
 */
@RestController
@RequestMapping("/system/user/profile")
public class SysProfileController extends BaseController {
    @Autowired
    private ISysUserService userService;

    @Autowired
    private TokenService tokenService;

    /**
     * 个人信息
     */
    @GetMapping
    public R<ProfileVO> profile() {
        LoginUser loginUser = getLoginUser();
        SysUser user = loginUser.getUser();
        ProfileVO vo = new ProfileVO();
        vo.setUser(user);
        vo.setRoleGroup(userService.selectUserRoleGroup(loginUser.getUsername()));
        vo.setPostGroup(userService.selectUserPostGroup(loginUser.getUsername()));
        return R.ok(vo);
    }

    /**
     * 修改用户
     */
    @Log(title = "个人信息", businessType = BusinessType.UPDATE)
    @PutMapping
    public R<Void> updateProfile(@RequestBody SysUser user) {
        LoginUser loginUser = getLoginUser();
        SysUser currentUser = loginUser.getUser();
        currentUser.setNickName(user.getNickName());
        currentUser.setEmail(user.getEmail());
        currentUser.setPhonenumber(user.getPhonenumber());
        currentUser.setSex(user.getSex());
        if (StringUtils.isNotEmpty(user.getPhonenumber()) && !userService.checkPhoneUnique(currentUser)) {
            return R.fail("修改用户'" + loginUser.getUsername() + "'失败，手机号码已存在");
        }
        if (StringUtils.isNotEmpty(user.getEmail()) && !userService.checkEmailUnique(currentUser)) {
            return R.fail("修改用户'" + loginUser.getUsername() + "'失败，邮箱账号已存在");
        }
        if (userService.updateUserProfile(currentUser) > 0) {
            tokenService.setLoginUser(loginUser);
            return R.ok();
        }
        return R.fail("修改个人信息异常，请联系管理员");
    }

    /**
     * 重置密码
     */
    @Log(title = "个人信息", businessType = BusinessType.UPDATE)
    @PutMapping("/updatePwd")
    public R<Void> updatePwd(@RequestBody Map<String, String> params) {
        String oldPassword = params.get("oldPassword");
        String newPassword = params.get("newPassword");
        LoginUser loginUser = getLoginUser();
        Long userId = loginUser.getUserId();
        String password = loginUser.getPassword();
        if (!SecurityUtils.matchesPassword(oldPassword, password)) {
            return R.fail("修改密码失败，旧密码错误");
        }
        if (SecurityUtils.matchesPassword(newPassword, password)) {
            return R.fail("新密码不能与旧密码相同");
        }
        newPassword = SecurityUtils.encryptPassword(newPassword);
        if (userService.resetUserPwd(userId, newPassword) > 0) {
            loginUser.getUser().setPwdUpdateDate(DateUtils.getNowDate());
            loginUser.getUser().setPassword(newPassword);
            tokenService.setLoginUser(loginUser);
            return R.ok();
        }
        return R.fail("修改密码异常，请联系管理员");
    }

    /**
     * 头像上传
     */
    @Log(title = "用户头像", businessType = BusinessType.UPDATE)
    @PostMapping("/avatar")
    public R<AvatarVO> avatar(@RequestParam("avatarfile") MultipartFile file) throws Exception {
        if (!file.isEmpty()) {
            LoginUser loginUser = getLoginUser();
            String avatar = FileUploadUtils.upload(BlogServerConfig.getAvatarPath(), file, MimeTypeUtils.IMAGE_EXTENSION, true);
            if (userService.updateUserAvatar(loginUser.getUserId(), avatar)) {
                String oldAvatar = loginUser.getUser().getAvatar();
                if (StringUtils.isNotEmpty(oldAvatar)) {
                    FileUtils.deleteFile(BlogServerConfig.getProfile() + FileUtils.stripPrefix(oldAvatar));
                }
                AvatarVO vo = new AvatarVO();
                vo.setImgUrl(avatar);
                loginUser.getUser().setAvatar(avatar);
                tokenService.setLoginUser(loginUser);
                return R.ok(vo);
            }
        }
        return R.fail("上传图片异常，请联系管理员");
    }
}
