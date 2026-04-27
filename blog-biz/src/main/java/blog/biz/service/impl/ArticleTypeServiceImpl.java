package blog.biz.service.impl;

import blog.biz.domain.ArticleType;
import blog.biz.mapper.ArticleTypeMapper;
import blog.biz.service.IArticleTypeService;
import blog.common.base.service.impl.BaseServiceImpl;
import blog.common.exception.ServiceException;
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
import org.springframework.transaction.annotation.Transactional;
import blog.biz.domain.dto.ArticleTypeDTO;
import blog.biz.domain.vo.ArticleTypeVO;

import java.util.List;
import java.util.Collection;

/**
 * 文章类型Service业务层处理
 *
 * @author leejie
 * @date 2026-04-22
 */
@Slf4j
@RequiredArgsConstructor
@Service
public class ArticleTypeServiceImpl extends BaseServiceImpl<ArticleTypeMapper, ArticleType> implements IArticleTypeService {

    private final ArticleTypeMapper baseMapper;

    /**
     * 查询文章类型
     *
     * @param id 主键
     * @return 文章类型
     */
    @Override
    public ArticleTypeVO queryById(Long id){
        return baseMapper.selectVoById(id);
    }

    /**
     * 分页查询文章类型列表
     *
     * @param dto        查询条件
     * @param pageQuery 分页参数
     * @return 文章类型分页列表
     */
    @Override
    public TableDataInfo<ArticleTypeVO> queryPageList(ArticleTypeDTO dto, PageQuery pageQuery) {
        LambdaQueryWrapper<ArticleType> lqw = buildQueryWrapper(dto);
        Page<ArticleTypeVO> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    /**
     * 查询符合条件的文章类型列表
     *
     * @param dto 查询条件
     * @return 文章类型列表
     */
    @Override
    public List<ArticleTypeVO> queryList(ArticleTypeDTO dto) {
        LambdaQueryWrapper<ArticleType> lqw = buildQueryWrapper(dto);
        return baseMapper.selectVoList(lqw);
    }

    private LambdaQueryWrapper<ArticleType> buildQueryWrapper(ArticleTypeDTO dto) {
        LambdaQueryWrapper<ArticleType> lqw = Wrappers.lambdaQuery();
        lqw.orderByAsc(ArticleType::getSortOrder);
        lqw.like(StringUtils.isNotBlank(dto.getTypeName()), ArticleType::getTypeName, dto.getTypeName());
        lqw.eq(StringUtils.isNotBlank(dto.getTypeCode()), ArticleType::getTypeCode, dto.getTypeCode());
        lqw.eq(dto.getStatus() != null, ArticleType::getStatus, dto.getStatus());
        return lqw;
    }

    /**
     * 新增文章类型
     *
     * @param dto 文章类型
     * @return 是否新增成功
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean insertByDto(ArticleTypeDTO dto) {
        // 校验 typeCode 唯一性
        if (StringUtils.isNotBlank(dto.getTypeCode())) {
            LambdaQueryWrapper<ArticleType> lqw = Wrappers.lambdaQuery();
            lqw.eq(ArticleType::getTypeCode, dto.getTypeCode());
            Long count = baseMapper.selectCount(lqw);
            if (count > 0) {
                throw new ServiceException("类型编码已存在");
            }
        }
        
        ArticleType add = BeanUtil.copyProperties(dto, ArticleType.class);
        validEntityBeforeSave(add);
        return baseMapper.insert(add) > 0;
    }

    /**
     * 修改文章类型
     *
     * @param dto 文章类型
     * @return 是否修改成功
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean updateByDto(ArticleTypeDTO dto) {
        // 校验 id 存在性
        ArticleType existing = baseMapper.selectById(dto.getId());
        if (existing == null) {
            throw new ServiceException("文章类型不存在");
        }
        
        // 校验 typeCode 唯一性（排除自身）
        if (StringUtils.isNotBlank(dto.getTypeCode()) && !dto.getTypeCode().equals(existing.getTypeCode())) {
            LambdaQueryWrapper<ArticleType> lqw = Wrappers.lambdaQuery();
            lqw.eq(ArticleType::getTypeCode, dto.getTypeCode());
            lqw.ne(ArticleType::getId, dto.getId());
            Long count = baseMapper.selectCount(lqw);
            if (count > 0) {
                throw new ServiceException("类型编码已存在");
            }
        }
        
        ArticleType update = BeanUtil.copyProperties(dto, ArticleType.class);
        validEntityBeforeSave(update);
        return baseMapper.updateById(update) > 0;
    }

    /**
     * 保存前的数据校验
     */
    private void validEntityBeforeSave(ArticleType entity){
        // 设置默认状态
        if (entity.getStatus() == null) {
            entity.setStatus(1);
        }
        // 设置默认排序
        if (entity.getSortOrder() == null) {
            entity.setSortOrder(0);
        }
    }

    /**
     * 校验并批量删除文章类型信息
     *
     * @param ids     待删除的主键集合
     * @param isValid 是否进行有效性校验
     * @return 是否删除成功
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid) {
        if(isValid){
            // 当前设计：不阻止删除，文章保留类型ID
            // 可选择添加日志记录
            log.info("删除文章类型，ID集合: {}", ids);
        }
        return baseMapper.deleteByIds(ids) > 0;
    }
}
