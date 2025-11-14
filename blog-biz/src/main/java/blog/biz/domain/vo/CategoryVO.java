package blog.biz.domain.vo;

import blog.common.annotation.Excel;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

@Data
public class CategoryVO implements Serializable {

    /**
     * 分类id
     */
    @JsonSerialize(using = ToStringSerializer.class)
    @Excel(name = "分类id")
    private Long id;

    /**
     * 分类名
     */
    @Excel(name = "分类名")
    private String categoryName;

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

}
