package blog.common.core.domain.vo;

import blog.common.core.domain.entity.SysUser;
import lombok.Data;

import java.io.Serializable;
import java.util.List;

/**
 * 用户授权角色响应VO
 *
 * @author leejie
 */
@Data
public class UserAuthRoleVO implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * 用户信息
     */
    private SysUser user;

    /**
     * 角色列表
     */
    private List<?> roles;
}
