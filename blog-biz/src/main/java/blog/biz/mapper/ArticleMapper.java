package blog.biz.mapper;

import blog.biz.domain.Article;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 文章Mapper接口
 * 
 * @author leejie
 * @date 2025-11-07
 */
public interface ArticleMapper extends BaseMapper<Article> {
    /**
     * 查询文章
     * 
     * @param id 文章主键
     * @return 文章
     */
    Article selectArticleById(Long id);

    /**
     * 查询文章列表
     * 
     * @param article 文章
     * @return 文章集合
     */
    Page<Article> selectArticleList(@Param("page") IPage<Article> page, @Param("dto") Article article);

    /**
     * 新增文章
     * 
     * @param article 文章
     * @return 结果
     */
    int insertArticle(Article article);

    /**
     * 修改文章
     * 
     * @param article 文章
     * @return 结果
     */
    int updateArticle(Article article);

    /**
     * 删除文章
     * 
     * @param id 文章主键
     * @return 结果
     */
    int deleteArticleById(Long id);

    /**
     * 批量删除文章
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    int deleteArticleByIds(Long[] ids);
}
