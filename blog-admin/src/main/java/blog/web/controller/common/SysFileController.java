package blog.web.controller.common;

import java.util.List;

import blog.biz.domain.dto.SysFileDTO;
import blog.biz.domain.dto.UploadFileDTO;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;
import jakarta.servlet.http.HttpServletResponse;
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
import blog.biz.domain.vo.SysFileVO;
import blog.biz.service.ISysFileService;
import blog.common.base.resp.TableDataInfo;
import org.springframework.web.multipart.MultipartFile;

/**
 * 文件信息
 *
 * @author leejie
 * @date 2025-12-23
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/biz/file")
public class SysFileController extends BaseController {

    private final ISysFileService sysFileService;

    /**
     * 查询文件信息列表
     */
    @PreAuthorize("@ss.hasPermi('biz:file:list')")
    @GetMapping("/list")
    public TableDataInfo<SysFileVO> list(SysFileDTO dto, PageQuery pageQuery) {
        return sysFileService.queryPageList(dto, pageQuery);
    }

    /**
     * 导出文件信息列表
     */
    @PreAuthorize("@ss.hasPermi('biz:file:export')")
    @Log(title = "文件信息", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(SysFileDTO dto, HttpServletResponse response) {
        List<SysFileVO> list = sysFileService.queryList(dto);
        ExcelUtil<SysFileVO> util = new ExcelUtil<>(SysFileVO.class);
        util.exportExcel(response, list, "文件信息");
    }

    /**
     * 获取文件信息详细信息
     *
     * @param id 主键
     */
    @PreAuthorize("@ss.hasPermi('biz:file:query')")
    @GetMapping("/{id}")
    public R<SysFileVO> getInfo(@NotNull(message = "主键不能为空")
                                @PathVariable Long id) {
        return R.ok(sysFileService.queryById(id));
    }

    /**
     * 新增文件信息
     */
    @PreAuthorize("@ss.hasPermi('biz:file:add')")
    @Log(title = "文件信息", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping()
    public R<Void> add(@Validated(AddGroup.class) @RequestBody SysFileDTO dto) {
        return R.ok(sysFileService.insertByDTO(dto));
    }

    /**
     * 修改文件信息
     */
    @PreAuthorize("@ss.hasPermi('biz:file:edit')")
    @Log(title = "文件信息", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping()
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody SysFileDTO dto) {
        return R.ok(sysFileService.updateByDTO(dto));
    }

    /**
     * 删除文件信息
     *
     * @param ids 主键串
     */
    @PreAuthorize("@ss.hasPermi('biz:file:remove')")
    @Log(title = "文件信息", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public R<Void> remove(@NotEmpty(message = "主键不能为空")
                          @PathVariable Long[] ids) {
        return R.ok(sysFileService.deleteWithValidByIds(List.of(ids), true));
    }

    @PostMapping("/uploadFile")
    @Log(title = "上传文件", businessType = BusinessType.INSERT)
    public R<SysFileVO> uploadFile(@NotNull(message = "文件不能为空") @RequestParam("file") MultipartFile file,
                                   @NotBlank(message = "业务类型不能为空") @RequestParam String bizType,
                                   @NotBlank(message = "业务ID不能为空") @RequestParam String bizId) {
        UploadFileDTO dto = UploadFileDTO.builder()
                .bizType(bizType)
                .bizId(bizId)
                .build();
        return R.ok(sysFileService.uploadFile(file, dto));
    }

}