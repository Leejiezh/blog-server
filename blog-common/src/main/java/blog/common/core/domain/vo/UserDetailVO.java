package blog.common.core.domain.vo;

import blog.common.core.domain.entity.SysUser;
import lombok.Data;

import java.io.Serializable;
import java.util.List;

/**
 * 用户详情响应VO
 *
 * @author leejie
 */
@Data
public class UserDetailVO implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * 用户信息
     */
    private SysUser data;

    /**
     * 岗位ID列表
     */
    private List<Long> postIds;

    /**
     * 角色ID列表
     */
    private List<Long> roleIds;

    /**
     * 角色列表
     */
    private List<?> roles;

    /**
     * 岗位列表
     */
    private List<?> posts;
}
