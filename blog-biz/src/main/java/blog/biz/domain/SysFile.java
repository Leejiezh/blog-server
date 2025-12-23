package blog.biz.domain;

import blog.common.base.entity.BaseEntity;
import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import lombok.EqualsAndHashCode;
import java.util.Date;

import java.io.Serial;

/**
 * 文件信息对象 sys_file
 *
 * @author leejie
 * @date 2025-12-23
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("sys_file")
public class SysFile extends BaseEntity {

    /**
     * 主键ID
     */
    @TableId(value = "id")
    private Long id;

    /**
     * 原始文件名
     */
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
    private String bucketName;

    /**
     * MinIO对象路径
     */
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
    private Long isPublic;

    /**
     * 是否删除（0-否 1-是）
     */
    private Long isDeleted;

    /**
     * 上传人
     */
    private String createdBy;

    /**
     * 创建时间
     */
    private Date createdTime;


}
