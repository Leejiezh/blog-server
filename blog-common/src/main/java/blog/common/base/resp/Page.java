package blog.common.base.resp;

import com.baomidou.mybatisplus.core.metadata.IPage;

import java.io.Serializable;
import java.util.List;

/**
 * 分页数据对象
 *
 * @author leejie
 */
public class Page<T> implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * 列表数据
     */
    private List<T> rows;

    /**
     * 总记录数
     */
    private long total;

    public Page() {
    }

    public Page(List<T> list, long total) {
        this.rows = list;
        this.total = total;
    }

    /**
     * 根据 MyBatis-Plus 分页对象构建
     *
     * @param page 分页对象
     * @return 分页数据
     */
    public static <T> Page<T> build(IPage<T> page) {
        Page<T> rspData = new Page<>();
        rspData.setRows(page.getRecords());
        rspData.setTotal(page.getTotal());
        return rspData;
    }

    /**
     * 根据列表和总数构建
     *
     * @param list  列表数据
     * @param total 总记录数
     * @return 分页数据
     */
    public static <T> Page<T> build(List<T> list, long total) {
        return new Page<>(list, total);
    }

    public List<T> getRows() {
        return rows;
    }

    public void setRows(List<T> rows) {
        this.rows = rows;
    }

    public long getTotal() {
        return total;
    }

    public void setTotal(long total) {
        this.total = total;
    }
}
