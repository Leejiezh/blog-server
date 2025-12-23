package blog.biz.domain.dto;

import blog.biz.domain.SysFile;
import blog.common.base.entity.BaseEntity;
import blog.common.validate.AddGroup;
import blog.common.validate.EditGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;
import jakarta.validation.constraints.*;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 文件信息业务对象 sys_file
 *
 * @author leejie
 * @date 2025-12-23
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class SysFileDTO extends BaseEntity {

    /**
     * 主键ID
     */
    private Long id;

    /**
     * 原始文件名
     */
    @NotBlank(message = "原始文件名不能为空", groups = { AddGroup.class, EditGroup.class })
    private String fileName;

    /**
     * 文件后缀，如 jpg、png、pdf
     */
    private String fileSuffix;

    /**
     * 文件类型，如 image/jpeg
     */
    private String contentType;

    /**
     * 文件大小（字节）
     */
    private Long fileSize;

    /**
     * MinIO桶名
     */
    @NotBlank(message = "MinIO桶名不能为空", groups = { AddGroup.class, EditGroup.class })
    private String bucketName;

    /**
     * MinIO对象路径
     */
    @NotBlank(message = "MinIO对象路径不能为空", groups = { AddGroup.class, EditGroup.class })
    private String objectName;

    /**
     * 文件访问URL（永久/临时）
     */
    private String fileUrl;

    /**
     * 业务类型，如 USER_AVATAR、BLOG_IMAGE
     */
    private String bizType;

    /**
     * 业务ID，如用户ID、博客ID
     */
    private String bizId;

    /**
     * 是否公开（0-否 1-是）
     */
    private Integer isPublic;


}
