package blog.biz.domain;

import blog.common.base.entity.BaseEntity;
import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serial;

/**
 * 文章分类对象 biz_category
 *
 * @author leejie
 * @date 2025-11-14
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("biz_category")
public class Category extends BaseEntity {

    /**
     * 分类id
     */
    @TableId(value = "id")
    private Long id;

    /**
     * 分类名
     */
    private String categoryName;

    /**
     * 删除标志
     */
    @TableLogic
    private int isDelete;
}
