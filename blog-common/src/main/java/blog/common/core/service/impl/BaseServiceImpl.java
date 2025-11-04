package blog.common.core.service.impl;

import blog.common.core.service.BaseService;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

public class BaseServiceImpl <M extends BaseMapper<T>, T> extends ServiceImpl<M, T> implements BaseService<T> {
}
