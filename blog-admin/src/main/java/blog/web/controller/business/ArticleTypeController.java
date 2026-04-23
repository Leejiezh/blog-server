package blog.web.controller.business;

import java.util.Arrays;
import java.util.List;

import blog.biz.domain.dto.ArticleTypeDTO;
import blog.biz.domain.vo.ArticleTypeVO;
import blog.biz.service.IArticleTypeService;
import blog.common.annotation.Log;
import blog.common.annotation.RepeatSubmit;
import blog.common.base.controller.BaseController;
import blog.common.base.req.PageQuery;
import blog.common.base.resp.R;
import blog.common.base.resp.TableDataInfo;
import blog.common.enums.BusinessType;
import blog.common.validate.AddGroup;
import blog.common.validate.EditGroup;
import blog.common.utils.poi.ExcelUtil;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 文章类型管理
 *
 * @author leejie
 * @date 2026-04-22
 */
@Tag(name = "文章类型管理")
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/biz/articleType")
public class ArticleTypeController extends BaseController {

    private final IArticleTypeService articleTypeService;

    /**
     * 查询文章类型列表
     */
    @Operation(summary = "查询文章类型列表")
    @PreAuthorize("@ss.hasPermi('biz:articleType:list')")
    @GetMapping("/list")
    public TableDataInfo<ArticleTypeVO> list(ArticleTypeDTO dto, PageQuery pageQuery) {
        return articleTypeService.queryPageList(dto, pageQuery);
    }

    /**
     * 导出文章类型列表
     */
    @Operation(summary = "导出文章类型列表")
    @PreAuthorize("@ss.hasPermi('biz:articleType:export')")
    @Log(title = "文章类型", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(ArticleTypeDTO dto, HttpServletResponse response) {
        List<ArticleTypeVO> list = articleTypeService.queryList(dto);
        ExcelUtil<ArticleTypeVO> util = new ExcelUtil<>(ArticleTypeVO.class);
        util.exportExcel(response, list, "文章类型");
    }

    /**
     * 获取文章类型详细信息
     */
    @Operation(summary = "获取文章类型详情")
    @PreAuthorize("@ss.hasPermi('biz:articleType:query')")
    @GetMapping("/{id}")
    public R<ArticleTypeVO> getInfo(@NotNull(message = "主键不能为空")
                                     @PathVariable Long id) {
        return R.ok(articleTypeService.queryById(id));
    }

    /**
     * 新增文章类型
     */
    @Operation(summary = "新增文章类型")
    @PreAuthorize("@ss.hasPermi('biz:articleType:add')")
    @Log(title = "文章类型", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping()
    public R<Void> add(@Validated(AddGroup.class) @RequestBody ArticleTypeDTO dto) {
        return R.ok(articleTypeService.insertByDto(dto));
    }

    /**
     * 修改文章类型
     */
    @Operation(summary = "修改文章类型")
    @PreAuthorize("@ss.hasPermi('biz:articleType:edit')")
    @Log(title = "文章类型", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping()
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody ArticleTypeDTO dto) {
        return R.ok(articleTypeService.updateByDto(dto));
    }

    /**
     * 删除文章类型
     */
    @Operation(summary = "删除文章类型")
    @PreAuthorize("@ss.hasPermi('biz:articleType:remove')")
    @Log(title = "文章类型", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public R<Void> remove(@NotEmpty(message = "主键不能为空")
                          @PathVariable Long[] ids) {
        return R.ok(articleTypeService.deleteWithValidByIds(Arrays.asList(ids), true));
    }
}
