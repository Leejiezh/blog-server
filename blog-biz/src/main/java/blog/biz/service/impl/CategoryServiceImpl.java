package blog.biz.service.impl;

import blog.biz.domain.Article;
import blog.biz.mapper.ArticleMapper;
import blog.biz.service.IArticleService;
import blog.common.base.service.impl.BaseServiceImpl;
import blog.common.utils.StringUtils;
import cn.hutool.core.bean.BeanUtil;
import blog.common.base.resp.TableDataInfo;
import blog.common.base.req.PageQuery;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import blog.biz.domain.dto.CategoryDTO;
import blog.biz.domain.vo.CategoryVO;
import blog.biz.domain.Category;
import blog.biz.mapper.CategoryMapper;
import blog.biz.service.ICategoryService;

import java.util.List;
import java.util.Map;
import java.util.Collection;

/**
 * 文章分类Service业务层处理
 *
 * @author leejie
 * @date 2025-11-14
 */
@Slf4j
@RequiredArgsConstructor
@Service
public class CategoryServiceImpl extends BaseServiceImpl<CategoryMapper, Category> implements ICategoryService {

    private final CategoryMapper baseMapper;

    /**
     * 查询文章分类
     *
     * @param id 主键
     * @return 文章分类
     */
    @Override
    public CategoryVO queryById(Long id){
        return baseMapper.selectVoById(id);
    }

    /**
     * 分页查询文章分类列表
     *
     * @param dto        查询条件
     * @param pageQuery 分页参数
     * @return 文章分类分页列表
     */
    @Override
    public TableDataInfo<CategoryVO> queryPageList(CategoryDTO dto, PageQuery pageQuery) {
        LambdaQueryWrapper<Category> lqw = buildQueryWrapper(dto);
        Page<CategoryVO> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    /**
     * 查询符合条件的文章分类列表
     *
     * @param dto 查询条件
     * @return 文章分类列表
     */
    @Override
    public List<CategoryVO> queryList(CategoryDTO dto) {
        LambdaQueryWrapper<Category> lqw = buildQueryWrapper(dto);
        return baseMapper.selectVoList(lqw);
    }

    private LambdaQueryWrapper<Category> buildQueryWrapper(CategoryDTO dto) {
        Map<String, Object> params = dto.getParams();
        LambdaQueryWrapper<Category> lqw = Wrappers.lambdaQuery();
        lqw.orderByAsc(Category::getId);
        lqw.like(StringUtils.isNotBlank(dto.getCategoryName()), Category::getCategoryName, dto.getCategoryName());
        return lqw;
    }

    /**
     * 新增文章分类
     *
     * @param dto 文章分类
     * @return 是否新增成功
     */
    @Override
    public Boolean insertByDTO(CategoryDTO dto) {
        Category add = BeanUtil.copyProperties(dto, Category.class);
        validEntityBeforeSave(add);
        return baseMapper.insert(add) > 0;
    }

    /**
     * 修改文章分类
     *
     * @param dto 文章分类
     * @return 是否修改成功
     */
    @Override
    public Boolean updateByDTO(CategoryDTO dto) {
        Category update = BeanUtil.copyProperties(dto, Category.class);
        validEntityBeforeSave(update);
        return baseMapper.updateById(update) > 0;
    }

    /**
     * 保存前的数据校验
     */
    private void validEntityBeforeSave(Category entity){
        //TODO 做一些数据校验,如唯一约束
    }

    /**
     * 校验并批量删除文章分类信息
     *
     * @param ids     待删除的主键集合
     * @param isValid 是否进行有效性校验
     * @return 是否删除成功
     */
    @Override
    public Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid) {
        if(isValid){
            //TODO 做一些业务上的校验,判断是否需要校验
        }
        return baseMapper.deleteByIds(ids) > 0;
    }
}
