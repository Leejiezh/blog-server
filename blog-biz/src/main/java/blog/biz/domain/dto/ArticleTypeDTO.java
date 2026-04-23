package blog.biz.domain.dto;

import blog.common.base.entity.BaseEntity;
import blog.common.validate.AddGroup;
import blog.common.validate.EditGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

/**
 * 文章类型业务对象 biz_article_type
 *
 * @author leejie
 * @date 2026-04-22
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class ArticleTypeDTO extends BaseEntity {

    /**
     * 类型ID
     */
    @NotNull(message = "类型ID不能为空", groups = { EditGroup.class })
    private Long id;

    /**
     * 类型名称
     */
    @NotBlank(message = "类型名称不能为空", groups = { AddGroup.class, EditGroup.class })
    private String typeName;

    /**
     * 类型编码（唯一标识）
     */
    private String typeCode;

    /**
     * 排序顺序
     */
    private Integer sortOrder;

    /**
     * 类型描述
     */
    private String description;

    /**
     * 状态 0停用 1启用
     */
    private Integer status;
}
