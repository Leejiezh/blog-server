package blog.framework.handler;

import blog.common.base.entity.BaseEntity;
import blog.common.core.domain.model.LoginUser;
import blog.common.exception.ServiceException;
import blog.common.utils.ObjectUtils;
import blog.common.utils.SecurityUtils;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.http.HttpStatus;
import com.baomidou.mybatisplus.core.handlers.MetaObjectHandler;
import org.apache.ibatis.reflection.MetaObject;
import org.springframework.stereotype.Component;

import java.util.Date;

public class EntityMetaObjectHandler implements MetaObjectHandler {

    /**
     * 如果用户不存在默认注入-1代表无用户
     */
    private static final Long DEFAULT_USER_ID = -1L;

    @Override
    public void insertFill(MetaObject metaObject) {
        try {
            if (ObjectUtil.isNotNull(metaObject) && metaObject.getOriginalObject() instanceof BaseEntity baseEntity) {
                // 获取当前时间作为创建时间，如果创建时间不为空，则使用创建时间，否则使用当前时间
                Date current = ObjectUtils.notNull(baseEntity.getCreateTime(), new Date());
                baseEntity.setCreateTime(current);
                // 如果创建人为空，则填充当前登录用户的信息
                if (ObjectUtil.isNull(baseEntity.getCreateBy())) {
                    LoginUser loginUser = SecurityUtils.getLoginUser();
                    if (ObjectUtil.isNotNull(loginUser)) {
                        // 填充创建人ID
                        baseEntity.setCreateById(loginUser.getUserId());
                        // 填充创建人
                        baseEntity.setCreateBy(loginUser.getUsername());
                    } else {
                        // 填充创建人
                        baseEntity.setCreateById(DEFAULT_USER_ID);
                    }
                }
            }else {
                this.strictInsertFill(metaObject, "createBy", String.class, SecurityUtils.getUsername());
                this.strictInsertFill(metaObject, "createById", Long.class, SecurityUtils.getUserId());
                this.strictInsertFill(metaObject, "createTime", java.util.Date.class, new Date());
            }
        } catch (Exception e) {
            throw new ServiceException("自动注入异常 => " + e.getMessage(), HttpStatus.HTTP_UNAUTHORIZED);
        }
    }

    @Override
    public void updateFill(MetaObject metaObject) {
        try {
            if (ObjectUtil.isNotNull(metaObject) && metaObject.getOriginalObject() instanceof BaseEntity baseEntity){
                baseEntity.setUpdateTime(new Date());

                //获取当前登录用户信息
                LoginUser loginUser = SecurityUtils.getLoginUser();
                if (ObjectUtil.isNotNull(loginUser)){
                    baseEntity.setUpdateBy(loginUser.getUsername());
                    baseEntity.setUpdateById(loginUser.getUserId());
                }else {
                    baseEntity.setUpdateById(DEFAULT_USER_ID);
                }
            } else {
                this.strictInsertFill(metaObject, "", String.class, SecurityUtils.getUsername());
                this.strictInsertFill(metaObject, "updatupdateByeById", Long.class, SecurityUtils.getUserId());
                this.strictInsertFill(metaObject, "updateTime", java.util.Date.class, new Date());
            }
        } catch (Exception e) {
            throw new ServiceException("自动注入异常 => " + e.getMessage(), HttpStatus.HTTP_UNAUTHORIZED);
        }
    }
}
