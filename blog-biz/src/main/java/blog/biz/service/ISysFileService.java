package blog.biz.service;

import blog.biz.domain.SysFile;
import blog.biz.domain.vo.SysFileVO;
import blog.biz.domain.dto.SysFileDTO;
import blog.common.base.resp.TableDataInfo;
import blog.common.base.req.PageQuery;
import blog.common.base.service.BaseService;

import java.util.Collection;
import java.util.List;

/**
 * 文件信息Service接口
 *
 * @author leejie
 * @date 2025-12-23
 */
public interface ISysFileService extends BaseService<SysFile>{

    /**
     * 查询文件信息
     *
     * @param id 主键
     * @return 文件信息
     */
    SysFileVO queryById(Long id);

    /**
     * 分页查询文件信息列表
     *
     * @param DTO        查询条件
     * @param pageQuery 分页参数
     * @return 文件信息分页列表
     */
    TableDataInfo<SysFileVO> queryPageList(SysFileDTO DTO, PageQuery pageQuery);

    /**
     * 查询符合条件的文件信息列表
     *
     * @param DTO 查询条件
     * @return 文件信息列表
     */
    List<SysFileVO> queryList(SysFileDTO DTO);

    /**
     * 新增文件信息
     *
     * @param DTO 文件信息
     * @return 是否新增成功
     */
    Boolean insertByDTO(SysFileDTO DTO);

    /**
     * 修改文件信息
     *
     * @param DTO 文件信息
     * @return 是否修改成功
     */
    Boolean updateByDTO(SysFileDTO DTO);

    /**
     * 校验并批量删除文件信息信息
     *
     * @param ids     待删除的主键集合
     * @param isValid 是否进行有效性校验
     * @return 是否删除成功
     */
    Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid);
}
