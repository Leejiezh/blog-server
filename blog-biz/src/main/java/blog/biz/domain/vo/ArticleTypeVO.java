package blog.biz.domain.vo;

import blog.common.annotation.Excel;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.util.Date;

/**
 * 文章类型视图对象 biz_article_type
 *
 * @author leejie
 * @date 2026-04-22
 */
@Data
public class ArticleTypeVO implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 类型ID
     */
    @JsonSerialize(using = ToStringSerializer.class)
    @Excel(name = "类型ID")
    private Long id;

    /**
     * 类型名称
     */
    @Excel(name = "类型名称")
    private String typeName;

    /**
     * 类型编码
     */
    @Excel(name = "类型编码")
    private String typeCode;

    /**
     * 排序顺序
     */
    @Excel(name = "排序顺序")
    private Integer sortOrder;

    /**
     * 类型描述
     */
    @Excel(name = "类型描述")
    private String description;

    /**
     * 状态 0停用 1启用
     */
    @Excel(name = "状态")
    private Integer status;

    /**
     * 创建人
     */
    @Excel(name = "创建人")
    private String createBy;

    /**
     * 创建时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "创建时间")
    private Date createTime;

    /**
     * 更新人
     */
    @Excel(name = "更新人")
    private String updateBy;

    /**
     * 更新时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "更新时间")
    private Date updateTime;

    /**
     * 关联文章数量（可选）
     */
    private Long articleCount;
}
