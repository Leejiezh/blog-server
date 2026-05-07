package blog.common.core.domain.vo;

import blog.common.core.domain.entity.SysUser;
import lombok.Data;

import java.io.Serializable;
import java.util.Set;

/**
 * 用户信息响应VO
 *
 * @author leejie
 */
@Data
public class UserInfoVO implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * 用户信息
     */
    private SysUser user;

    /**
     * 角色集合
     */
    private Set<String> roles;

    /**
     * 权限集合
     */
    private Set<String> permissions;

    /**
     * 是否默认修改密码
     */
    private Boolean isDefaultModifyPwd;

    /**
     * 密码是否过期
     */
    private Boolean isPasswordExpired;
}
