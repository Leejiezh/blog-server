package blog.biz.domain;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import lombok.Data;
import lombok.EqualsAndHashCode;
import blog.common.annotation.Excel;
import blog.common.base.entity.BaseEntity;
import org.apache.ibatis.type.Alias;

/**
 * 文章对象 biz_article
 * 
 * @author leejie
 * @date 2025-11-07
 */
@EqualsAndHashCode(callSuper = true)
@Data
@Alias("Article")
@TableName("biz_article")
public class Article extends BaseEntity {
    private static final long serialVersionUID = 1L;

    @JsonSerialize(using = ToStringSerializer.class)
    private Long id;

    /** 作者 */
    @Excel(name = "作者")
    private Long userId;

    /** 文章分类 */
    @Excel(name = "文章分类")
    private Long categoryId;

    /** 文章缩略图 */
    @Excel(name = "文章缩略图")
    private String articleCover;

    /** 标题 */
    @Excel(name = "标题")
    private String articleTitle;

    /** 文章摘要，如果该字段为空，默认取文章的前500个字符作为摘要 */
    @Excel(name = "文章摘要，如果该字段为空，默认取文章的前500个字符作为摘要")
    private String articleAbstract;

    /** 内容 */
    @Excel(name = "内容")
    private String articleContent;

    /** 是否置顶 0否 1是 */
    @Excel(name = "是否置顶 0否 1是")
    private Integer isTop;

    /** 是否推荐 0否 1是 */
    @Excel(name = "是否推荐 0否 1是")
    private Integer isFeatured;

    /** 是否删除  0否 1是 */
    @TableLogic
    private Integer isDelete;

    /** 状态值 1公开 2私密 3草稿 */
    @Excel(name = "状态值 1公开 2私密 3草稿")
    private Integer status;

    /** 文章类型 1原创 2转载 3翻译 */
    @Excel(name = "文章类型 1原创 2转载 3翻译")
    private Integer type;

    /** 访问密码 */
    @Excel(name = "访问密码")
    private String password;

    /** 原文链接 */
    @Excel(name = "原文链接")
    private String originalUrl;

    /**
     * 作者
     */
    @TableField(exist = false)
    private String userName;

}
