package blog.common.base.service.impl;

import blog.common.core.domain.entity.SysUser;
import blog.common.base.service.BaseService;
import blog.common.utils.SecurityUtils;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

public class BaseServiceImpl <M extends BaseMapper<T>, T> extends ServiceImpl<M, T> implements BaseService<T> {

    /**
     * 获取当前登录用户信息
     * @return SysUser
     */
    public SysUser getCurrUser(){
        return SecurityUtils.getLoginUser().getUser();
    }


    /**
     * 获取当前登录用户ID
     * @return Long
     */
    public Long getCurrUserId(){
        return SecurityUtils.getUserId();
    }
}
