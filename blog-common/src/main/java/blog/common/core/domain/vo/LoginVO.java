package blog.common.core.domain.vo;

import lombok.Data;

import java.io.Serializable;

/**
 * 登录响应VO
 *
 * @author leejie
 */
@Data
public class LoginVO implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * 令牌
     */
    private String token;
}
