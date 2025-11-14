package blog.biz.service;

import blog.biz.domain.vo.CategoryVO;
import blog.biz.domain.dto.CategoryDTO;
import blog.common.base.resp.TableDataInfo;
import blog.common.base.req.PageQuery;

import java.util.Collection;
import java.util.List;

/**
 * 文章分类Service接口
 *
 * @author leejie
 * @date 2025-11-14
 */
public interface ICategoryService {

    /**
     * 查询文章分类
     *
     * @param id 主键
     * @return 文章分类
     */
    CategoryVO queryById(Long id);

    /**
     * 分页查询文章分类列表
     *
     * @param DTO        查询条件
     * @param pageQuery 分页参数
     * @return 文章分类分页列表
     */
    TableDataInfo<CategoryVO> queryPageList(CategoryDTO DTO, PageQuery pageQuery);

    /**
     * 查询符合条件的文章分类列表
     *
     * @param DTO 查询条件
     * @return 文章分类列表
     */
    List<CategoryVO> queryList(CategoryDTO DTO);

    /**
     * 新增文章分类
     *
     * @param DTO 文章分类
     * @return 是否新增成功
     */
    Boolean insertByDTO(CategoryDTO DTO);

    /**
     * 修改文章分类
     *
     * @param DTO 文章分类
     * @return 是否修改成功
     */
    Boolean updateByDTO(CategoryDTO DTO);

    /**
     * 校验并批量删除文章分类信息
     *
     * @param ids     待删除的主键集合
     * @param isValid 是否进行有效性校验
     * @return 是否删除成功
     */
    Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid);
}
