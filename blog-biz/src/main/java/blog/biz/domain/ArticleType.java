package blog.biz.domain;

import blog.common.base.entity.BaseEntity;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serial;

/**
 * 文章类型对象 biz_article_type
 *
 * @author leejie
 * @date 2026-04-22
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("biz_article_type")
public class ArticleType extends BaseEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 类型ID
     */
    @TableId(value = "id")
    private Long id;

    /**
     * 类型名称
     */
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

    /**
     * 删除标志
     */
    @TableLogic
    private Integer isDelete;
}
