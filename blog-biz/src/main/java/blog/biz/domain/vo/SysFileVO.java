package blog.biz.domain.vo;

import java.util.Date;

import blog.common.annotation.Excel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serial;
import java.io.Serializable;



/**
 * 文件信息视图对象 sys_file
 *
 * @author leejie
 * @date 2025-12-23
 */
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Data
public class SysFileVO implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 原始文件名
     */
    @Excel(name = "原始文件名")
    private String fileName;

    /**
     * 文件后缀，如 jpg、png、pdf
     */
    @Excel(name = "文件后缀，如 jpg、png、pdf")
    private String fileSuffix;

    /**
     * 文件类型，如 image/jpeg
     */
    @Excel(name = "文件类型，如 image/jpeg")
    private String contentType;

    /**
     * 文件大小（字节）
     */
    @Excel(name = "文件大小")
    private Long fileSize;

    /**
     * MinIO桶名
     */
    @Excel(name = "MinIO桶名")
    private String bucketName;

    /**
     * MinIO对象路径
     */
    @Excel(name = "MinIO对象路径")
    private String objectName;

    /**
     * 文件访问URL（永久/临时）
     */
    @Excel(name = "文件访问URL")
    private String fileUrl;

    /**
     * 业务类型，如 USER_AVATAR、BLOG_IMAGE
     */
    @Excel(name = "业务类型，如 USER_AVATAR、BLOG_IMAGE")
    private String bizType;

    /**
     * 业务ID，如用户ID、博客ID
     */
    @Excel(name = "业务ID，如用户ID、博客ID")
    private String bizId;

    /**
     * 是否公开（0-否 1-是）
     */
    @Excel(name = "是否公开")
    private Long isPublic;

    /**
     * 是否删除（0-否 1-是）
     */
    @Excel(name = "是否删除")
    private Long isDeleted;

    /**
     * 上传人
     */
    @Excel(name = "上传人")
    private String createdBy;

    /**
     * 创建时间
     */
    @Excel(name = "创建时间")
    private Date createdTime;


}
