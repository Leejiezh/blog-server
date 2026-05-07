package blog.common.core.domain.vo;

import lombok.Data;

import java.io.Serializable;

/**
 * 头像上传响应VO
 *
 * @author leejie
 */
@Data
public class AvatarVO implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * 图片URL
     */
    private String imgUrl;
}
