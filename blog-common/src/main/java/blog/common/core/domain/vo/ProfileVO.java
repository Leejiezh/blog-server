package blog.common.core.domain.vo;

import blog.common.core.domain.entity.SysUser;
import lombok.Data;

import java.io.Serializable;

/**
 * 个人信息响应VO
 *
 * @author leejie
 */
@Data
public class ProfileVO implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * 用户信息
     */
    private SysUser user;

    /**
     * 角色组
     */
    private String roleGroup;

    /**
     * 岗位组
     */
    private String postGroup;
}
