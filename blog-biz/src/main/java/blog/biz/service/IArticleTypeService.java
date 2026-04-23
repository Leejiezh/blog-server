package blog.biz.service;

import blog.biz.domain.ArticleType;
import blog.biz.domain.vo.ArticleTypeVO;
import blog.biz.domain.dto.ArticleTypeDTO;
import blog.common.base.resp.TableDataInfo;
import blog.common.base.req.PageQuery;
import blog.common.base.service.BaseService;

import java.util.Collection;
import java.util.List;

/**
 * 文章类型Service接口
 *
 * @author leejie
 * @date 2026-04-22
 */
public interface IArticleTypeService extends BaseService<ArticleType> {

    /**
     * 查询文章类型
     *
     * @param id 主键
     * @return 文章类型
     */
    ArticleTypeVO queryById(Long id);

    /**
     * 分页查询文章类型列表
     *
     * @param dto        查询条件
     * @param pageQuery 分页参数
     * @return 文章类型分页列表
     */
    TableDataInfo<ArticleTypeVO> queryPageList(ArticleTypeDTO dto, PageQuery pageQuery);

    /**
     * 查询符合条件的文章类型列表
     *
     * @param dto 查询条件
     * @return 文章类型列表
     */
    List<ArticleTypeVO> queryList(ArticleTypeDTO dto);

    /**
     * 新增文章类型
     *
     * @param dto 文章类型
     * @return 是否新增成功
     */
    Boolean insertByDto(ArticleTypeDTO dto);

    /**
     * 修改文章类型
     *
     * @param dto 文章类型
     * @return 是否修改成功
     */
    Boolean updateByDto(ArticleTypeDTO dto);

    /**
     * 校验并批量删除文章类型信息
     *
     * @param ids     待删除的主键集合
     * @param isValid 是否进行有效性校验
     * @return 是否删除成功
     */
    Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid);
}
