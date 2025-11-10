package blog.common.config;

import blog.common.utils.DateUtils;
import blog.common.utils.SecurityUtils;
import com.baomidou.mybatisplus.core.handlers.MetaObjectHandler;
import org.apache.ibatis.reflection.MetaObject;
import org.springframework.stereotype.Component;

import java.util.Date;

@Component
public class EntityMetaObjectHandler implements MetaObjectHandler {

    @Override
    public void insertFill(MetaObject metaObject) {
        this.strictInsertFill(metaObject, "createBy", String.class, SecurityUtils.getUsername());
        this.strictInsertFill(metaObject, "createById", Long.class, SecurityUtils.getUserId());
        this.strictInsertFill(metaObject, "createTime", java.util.Date.class, new Date());
    }

    @Override
    public void updateFill(MetaObject metaObject) {
        this.strictInsertFill(metaObject, "updateBy", String.class, SecurityUtils.getUsername());
        this.strictInsertFill(metaObject, "updateById", Long.class, SecurityUtils.getUserId());
        this.strictInsertFill(metaObject, "updateTime", java.util.Date.class, new Date());
    }
}
