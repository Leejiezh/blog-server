package blog.web.controller.business;

import java.util.List;

import lombok.RequiredArgsConstructor;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.constraints.*;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.validation.annotation.Validated;
import blog.common.annotation.RepeatSubmit;
import blog.common.annotation.Log;
import blog.common.base.controller.BaseController;
import blog.common.base.req.PageQuery;
import blog.common.base.resp.R;
import blog.common.validate.AddGroup;
import blog.common.validate.EditGroup;
import blog.common.enums.BusinessType;
import blog.common.utils.poi.ExcelUtil;
import blog.biz.domain.vo.CategoryVO;
import blog.biz.domain.dto.CategoryDTO;
import blog.biz.service.ICategoryService;
import blog.common.base.resp.TableDataInfo;

/**
 * 文章分类
 *
 * @author leejie
 * @date 2025-11-14
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/biz/category")
public class CategoryController extends BaseController {

    private final ICategoryService categoryService;

    /**
     * 查询文章分类列表
     */
    @PreAuthorize("@ss.hasPermi('biz:category:list')")
    @GetMapping("/list")
    public TableDataInfo<CategoryVO> list(CategoryDTO dto, PageQuery pageQuery) {
        return categoryService.queryPageList(dto, pageQuery);
    }

    /**
     * 导出文章分类列表
     */
    @PreAuthorize("@ss.hasPermi('biz:category:export')")
    @Log(title = "文章分类", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(CategoryDTO dto, HttpServletResponse response) {
        List<CategoryVO> list = categoryService.queryList(dto);
        ExcelUtil<CategoryVO> util = new ExcelUtil<>(CategoryVO.class);
        util.exportExcel(response, list, "文章分类");
    }

    /**
     * 获取文章分类详细信息
     *
     * @param id 主键
     */
    @PreAuthorize("@ss.hasPermi('biz:category:query')")
    @GetMapping("/{id}")
    public R<CategoryVO> getInfo(@NotNull(message = "主键不能为空")
                                     @PathVariable Long id) {
        return R.ok(categoryService.queryById(id));
    }

    /**
     * 新增文章分类
     */
    @PreAuthorize("@ss.hasPermi('biz:category:add')")
    @Log(title = "文章分类", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping()
    public R<Void> add(@Validated(AddGroup.class) @RequestBody CategoryDTO bo) {
        return R.ok(categoryService.insertByDTO(bo));
    }

    /**
     * 修改文章分类
     */
    @PreAuthorize("@ss.hasPermi('biz:category:edit')")
    @Log(title = "文章分类", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping()
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody CategoryDTO dto) {
        return R.ok(categoryService.updateByDTO(dto));
    }

    /**
     * 删除文章分类
     *
     * @param ids 主键串
     */
    @PreAuthorize("@ss.hasPermi('biz:category:remove')")
    @Log(title = "文章分类", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public R<Void> remove(@NotEmpty(message = "主键不能为空")
                          @PathVariable Long[] ids) {
        return R.ok(categoryService.deleteWithValidByIds(List.of(ids), true));
    }
}
