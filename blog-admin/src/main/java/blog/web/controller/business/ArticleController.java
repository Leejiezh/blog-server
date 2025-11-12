package blog.web.controller.business;

import java.util.List;

import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import blog.common.annotation.Log;
import blog.common.core.controller.BaseController;
import blog.common.core.domain.Result;
import blog.common.enums.BusinessType;
import blog.biz.domain.Article;
import blog.biz.service.IArticleService;
import blog.common.utils.poi.ExcelUtil;
import blog.common.core.page.TableDataInfo;

/**
 * 文章Controller
 *
 * @author leejie
 * @date 2025-11-07
 */
@RestController
@RequestMapping("/system/article")
public class ArticleController extends BaseController {
    @Autowired
    private IArticleService articleService;

    /**
     * 查询文章列表
     */
    @PreAuthorize("@ss.hasPermi('system:article:list')")
    @GetMapping("/list")
    public TableDataInfo list(Article article) {
        startPage();
        List<Article> list = articleService.selectArticleList(article);
        return getDataTable(list);
    }

    /**
     * 导出文章列表
     */
    @PreAuthorize("@ss.hasPermi('system:article:export')")
    @Log(title = "文章", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, Article article) {
        List<Article> list = articleService.selectArticleList(article);
        ExcelUtil<Article> util = new ExcelUtil<Article>(Article.class);
        util.exportExcel(response, list, "文章数据");
    }

    /**
     * 获取文章详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:article:query')")
    @GetMapping(value = "/{id}")
    public Result getInfo(@PathVariable("id") Long id) {
        return success(articleService.selectArticleById(id));
    }

    /**
     * 新增文章
     */
    @PreAuthorize("@ss.hasPermi('system:article:add')")
    @Log(title = "文章", businessType = BusinessType.INSERT)
    @PostMapping
    public Result add(@RequestBody Article article) {
        return toAjax(articleService.insertArticle(article));
    }

    /**
     * 修改文章
     */
    @PreAuthorize("@ss.hasPermi('system:article:edit')")
    @Log(title = "文章", businessType = BusinessType.UPDATE)
    @PutMapping
    public Result edit(@RequestBody Article article) {
        return toAjax(articleService.updateArticle(article));
    }

    /**
     * 删除文章
     */
    @PreAuthorize("@ss.hasPermi('system:article:remove')")
    @Log(title = "文章", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public Result remove(@PathVariable Long[] ids) {
        return toAjax(articleService.deleteArticleByIds(ids));
    }
}
