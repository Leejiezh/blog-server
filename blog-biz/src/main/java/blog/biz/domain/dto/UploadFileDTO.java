package blog.biz.domain.dto;

import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
public class UploadFileDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 业务类型，如 USER_AVATAR、BLOG_IMAGE
     */
    @NotBlank(message = "业务类型不能为空")
    private String bizType;

    /**
     * 业务ID，如用户ID、博客ID
     */
    @NotBlank(message = "业务ID不能为空")
    private String bizId;


    public String getDir() {
        return String.join("/", bizType, bizId);
    }
}
