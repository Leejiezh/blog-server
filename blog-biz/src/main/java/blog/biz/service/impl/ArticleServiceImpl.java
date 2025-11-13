package blog.biz.service.impl;

import blog.common.base.req.PageQuery;
import blog.common.base.resp.TableDataInfo;
import blog.common.utils.DateUtils;
import blog.common.base.service.impl.BaseServiceImpl;
import com.baomidou.mybatisplus.core.metadata.IPage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import blog.biz.mapper.ArticleMapper;
import blog.biz.domain.Article;
import blog.biz.service.IArticleService;

/**
 * 文章Service业务层处理
 *
 * @author leejie
 * @date 2025-11-07
 */
@Service
public class ArticleServiceImpl extends BaseServiceImpl<ArticleMapper, Article> implements IArticleService {
    @Autowired
    private ArticleMapper articleMapper;

    /**
     * 查询文章
     *
     * @param id 文章主键
     * @return 文章
     */
    @Override
    public Article selectArticleById(Long id) {
        return articleMapper.selectArticleById(id);
    }

    /**
     * 查询文章列表
     *
     * @param article 文章
     * @return 文章
     */
    @Override
    public TableDataInfo<Article> selectArticleList(Article article, PageQuery pageQuery) {
        IPage<Article> articlePage = articleMapper.selectArticleList(pageQuery.build(), article);
        return TableDataInfo.build(articlePage);
    }

    /**
     * 新增文章
     *
     * @param article 文章
     * @return 结果
     */
    @Override
    public Boolean insertArticle(Article article) {
        article.setUserId(getCurrUserId());
        return save(article);
    }

    /**
     * 修改文章
     *
     * @param article 文章
     * @return 结果
     */
    @Override
    public int updateArticle(Article article) {
        article.setUpdateTime(DateUtils.getNowDate());
        return articleMapper.updateArticle(article);
    }

    /**
     * 批量删除文章
     *
     * @param ids 需要删除的文章主键
     * @return 结果
     */
    @Override
    public int deleteArticleByIds(Long[] ids) {
        return articleMapper.deleteArticleByIds(ids);
    }

    /**
     * 删除文章信息
     *
     * @param id 文章主键
     * @return 结果
     */
    @Override
    public int deleteArticleById(Long id) {
        return articleMapper.deleteArticleById(id);
    }
}
