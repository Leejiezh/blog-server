package blog.biz.domain.dto;

import blog.biz.domain.Category;
import blog.common.base.entity.BaseEntity;
import blog.common.validate.AddGroup;
import blog.common.validate.EditGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;
import jakarta.validation.constraints.*;

/**
 * 文章分类业务对象 biz_category
 *
 * @author leejie
 * @date 2025-11-14
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class CategoryDTO extends BaseEntity {

    /**
     * 分类名
     */
    @NotBlank(message = "分类名不能为空", groups = { AddGroup.class, EditGroup.class })
    private String categoryName;


}
