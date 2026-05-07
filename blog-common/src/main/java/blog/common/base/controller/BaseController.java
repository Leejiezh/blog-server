package blog.common.base.controller;

import java.beans.PropertyEditorSupport;
import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import blog.common.constant.HttpStatus;
import blog.common.base.resp.R;
import blog.common.base.resp.Page;
import blog.common.core.domain.model.LoginUser;
import blog.common.core.page.PageDomain;
import blog.common.core.page.TableSupport;
import blog.common.utils.DateUtils;
import blog.common.utils.PageUtils;
import blog.common.utils.SecurityUtils;
import blog.common.utils.StringUtils;
import blog.common.utils.sql.SqlUtil;

/**
 * web层通用数据处理
 *
 * @author leejie
 */
public class BaseController {
    protected final Logger logger = LoggerFactory.getLogger(this.getClass());

    /**
     * 将前台传递过来的日期格式的字符串，自动转化为Date类型
     */
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        // Date 类型转换
        binder.registerCustomEditor(Date.class, new PropertyEditorSupport() {
            @Override
            public void setAsText(String text) {
                setValue(DateUtils.parseDate(text));
            }
        });
    }

    /**
     * 设置请求分页数据
     */
    protected void startPage() {
        PageUtils.startPage();
    }

    /**
     * 设置请求排序数据
     */
    protected void startOrderBy() {
        PageDomain pageDomain = TableSupport.buildPageRequest();
        if (StringUtils.isNotEmpty(pageDomain.getOrderBy())) {
            String orderBy = SqlUtil.escapeOrderBySql(pageDomain.getOrderBy());
            PageHelper.orderBy(orderBy);
        }
    }

    /**
     * 清理分页的线程变量
     */
    protected void clearPage() {
        PageUtils.clearPage();
    }

    /**
     * 响应请求分页数据
     */
    @SuppressWarnings({"rawtypes", "unchecked"})
    protected R<Page<?>> getDataTable(List<?> list) {
        Page<?> page = Page.build(list, new PageInfo(list).getTotal());
        return R.ok(page);
    }

    /**
     * 返回成功
     */
    public R<Void> success() {
        return R.ok();
    }

    /**
     * 返回失败消息
     */
    public R<Void> error() {
        return R.fail();
    }

    /**
     * 返回成功消息
     */
    public R<Void> success(String message) {
        return R.ok(null, message);
    }

    /**
     * 返回成功消息
     */
    public <T> R<T> success(T data) {
        return R.ok(data);
    }

    /**
     * 返回失败消息
     */
    public R<Void> error(String message) {
        return R.fail(message);
    }

    /**
     * 返回警告消息
     */
    public R<Void> warn(String message) {
        return R.warn(message);
    }

    /**
     * 响应返回结果
     *
     * @param rows 影响行数
     * @return 操作结果
     */
    protected R<Void> toAjax(int rows) {
        return rows > 0 ? R.ok() : R.fail();
    }

    /**
     * 响应返回结果
     *
     * @param result 结果
     * @return 操作结果
     */
    protected R<Void> toAjax(boolean result) {
        return result ? success() : error();
    }

    /**
     * 页面跳转
     */
    public String redirect(String url) {
        return StringUtils.format("redirect:{}", url);
    }

    /**
     * 获取用户缓存信息
     */
    public LoginUser getLoginUser() {
        return SecurityUtils.getLoginUser();
    }

    /**
     * 获取登录用户id
     */
    public Long getUserId() {
        return getLoginUser().getUserId();
    }

    /**
     * 获取登录部门id
     */
    public Long getDeptId() {
        return getLoginUser().getDeptId();
    }

    /**
     * 获取登录用户名
     */
    public String getUsername() {
        return getLoginUser().getUsername();
    }
}
