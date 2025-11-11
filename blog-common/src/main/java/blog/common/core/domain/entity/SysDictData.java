package blog.common.core.domain.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Data;
import lombok.EqualsAndHashCode;
import blog.common.annotation.Excel;
import blog.common.annotation.Excel.ColumnType;
import blog.common.core.domain.BaseEntity;
import org.apache.ibatis.type.Alias;

/**
 * 字典数据表 sys_dict_data
 *
 * @author leejie
 */
@EqualsAndHashCode(callSuper = true)
@Data
@Alias("SysDictData")
public class SysDictData extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /**
     * 字典编码
     */
    @TableId(value = "dict_code")
    @Excel(name = "字典编码", cellType = ColumnType.NUMERIC)
    private Long dictCode;

    /**
     * 字典排序
     */
    @TableField(value = "dict_sort")
    @Excel(name = "字典排序", cellType = ColumnType.NUMERIC)
    private Long dictSort;

    /**
     * 字典标签
     */
    @NotBlank(message = "字典标签不能为空")
    @Size(min = 0, max = 100, message = "字典标签长度不能超过100个字符")
    @Excel(name = "字典标签")
    @TableField(value = "dict_label")
    private String dictLabel;

    /**
     * 字典键值
     */
    @NotBlank(message = "字典键值不能为空")
    @Size(min = 0, max = 100, message = "字典键值长度不能超过100个字符")
    @Excel(name = "字典键值")
    @TableField(value = "dict_value")
    private String dictValue;

    /**
     * 字典类型
     */
    @Excel(name = "字典类型")
    @TableField(value = "dict_type")
    private String dictType;

    /**
     * 样式属性（其他样式扩展）
     */
    @Size(min = 0, max = 100, message = "样式属性长度不能超过100个字符")
    @TableField(value = "css_class")
    private String cssClass;

    /**
     * 表格字典样式
     */
    @TableField(value = "list_class")
    private String listClass;

    /**
     * 是否默认（Y是 N否）
     */
    @Excel(name = "是否默认", readConverterExp = "Y=是,N=否")
    @TableField(value = "is_default")
    private String isDefault;

    /**
     * 状态（0正常 1停用）
     */
    @Excel(name = "状态", readConverterExp = "0=正常,1=停用")
    @TableField(value = "status")
    private String status;


}
