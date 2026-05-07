package blog.common.core.domain.vo;

import lombok.Data;

import java.io.Serializable;
import java.util.List;

/**
 * 角色部门树响应VO
 *
 * @author leejie
 */
@Data
public class RoleDeptTreeVO implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * 选中的部门ID列表
     */
    private List<Long> checkedKeys;

    /**
     * 部门树列表
     */
    private List<?> depts;
}
