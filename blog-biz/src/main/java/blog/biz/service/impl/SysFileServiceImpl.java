package blog.biz.service.impl;

import blog.biz.domain.dto.UploadFileDTO;
import blog.common.base.service.impl.BaseServiceImpl;
import blog.common.utils.StringUtils;
import blog.common.utils.minio.MinioUtils;
import cn.hutool.core.bean.BeanUtil;
import blog.common.base.resp.TableDataInfo;
import blog.common.base.req.PageQuery;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.date.LocalDateTimeUtil;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import blog.biz.domain.dto.SysFileDTO;
import blog.biz.domain.vo.SysFileVO;
import blog.biz.domain.SysFile;
import blog.biz.mapper.SysFileMapper;
import blog.biz.service.ISysFileService;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;
import java.util.Collection;

/**
 * 文件信息Service业务层处理
 *
 * @author leejie
 * @date 2025-12-23
 */
@Slf4j
@RequiredArgsConstructor
@Service
public class SysFileServiceImpl extends BaseServiceImpl<SysFileMapper, SysFile> implements ISysFileService {

    private final SysFileMapper baseMapper;
    private final MinioUtils minioUtils;

    /**
     * 查询文件信息
     *
     * @param id 主键
     * @return 文件信息
     */
    @Override
    public SysFileVO queryById(Long id){
        return baseMapper.selectVoById(id);
    }

    /**
     * 分页查询文件信息列表
     *
     * @param dto        查询条件
     * @param pageQuery 分页参数
     * @return 文件信息分页列表
     */
    @Override
    public TableDataInfo<SysFileVO> queryPageList(SysFileDTO dto, PageQuery pageQuery) {
        LambdaQueryWrapper<SysFile> lqw = buildQueryWrapper(dto);
        Page<SysFileVO> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    /**
     * 查询符合条件的文件信息列表
     *
     * @param dto 查询条件
     * @return 文件信息列表
     */
    @Override
    public List<SysFileVO> queryList(SysFileDTO dto) {
        LambdaQueryWrapper<SysFile> lqw = buildQueryWrapper(dto);
        return baseMapper.selectVoList(lqw);
    }

    private LambdaQueryWrapper<SysFile> buildQueryWrapper(SysFileDTO dto) {
        Map<String, Object> params = dto.getParams();
        LambdaQueryWrapper<SysFile> lqw = Wrappers.lambdaQuery();
        lqw.orderByAsc(SysFile::getId);
        lqw.like(StringUtils.isNotBlank(dto.getFileName()), SysFile::getFileName, dto.getFileName());
        lqw.eq(StringUtils.isNotBlank(dto.getFileSuffix()), SysFile::getFileSuffix, dto.getFileSuffix());
        lqw.eq(StringUtils.isNotBlank(dto.getContentType()), SysFile::getContentType, dto.getContentType());
        lqw.eq(dto.getFileSize() != null, SysFile::getFileSize, dto.getFileSize());
        lqw.like(StringUtils.isNotBlank(dto.getBucketName()), SysFile::getBucketName, dto.getBucketName());
        lqw.like(StringUtils.isNotBlank(dto.getObjectName()), SysFile::getObjectName, dto.getObjectName());
        lqw.eq(StringUtils.isNotBlank(dto.getFileUrl()), SysFile::getFileUrl, dto.getFileUrl());
        lqw.eq(StringUtils.isNotBlank(dto.getBizType()), SysFile::getBizType, dto.getBizType());
        lqw.eq(StringUtils.isNotBlank(dto.getBizId()), SysFile::getBizId, dto.getBizId());
        lqw.eq(dto.getIsPublic() != null, SysFile::getIsPublic, dto.getIsPublic());
        lqw.eq(StringUtils.isNotBlank(dto.getCreateBy()), SysFile::getCreatedBy, dto.getCreateBy());
        lqw.eq(dto.getCreateTime() != null, SysFile::getCreatedTime, dto.getCreateTime());
        return lqw;
    }

    /**
     * 新增文件信息
     *
     * @param dto 文件信息
     * @return 是否新增成功
     */
    @Override
    public Boolean insertByDTO(SysFileDTO dto) {
        SysFile add = BeanUtil.copyProperties(dto, SysFile.class);
        validEntityBeforeSave(add);
        boolean flag = baseMapper.insert(add) > 0;
        if (flag) {
            dto.setId(add.getId());
        }
        return flag;
    }

    /**
     * 修改文件信息
     *
     * @param dto 文件信息
     * @return 是否修改成功
     */
    @Override
    public Boolean updateByDTO(SysFileDTO dto) {
        SysFile update = BeanUtil.copyProperties(dto, SysFile.class);
        validEntityBeforeSave(update);
        return baseMapper.updateById(update) > 0;
    }

    /**
     * 保存前的数据校验
     */
    private void validEntityBeforeSave(SysFile entity){
        //TODO 做一些数据校验,如唯一约束
    }

    /**
     * 校验并批量删除文件信息信息
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

    @Override
    public SysFileVO uploadFile(MultipartFile file, UploadFileDTO dto) {
        try {
            MinioUtils.MinioFileInfo minioFileInfo = minioUtils.uploadFile(file, null, dto.getDir());
            return SysFileVO.builder()
                    .fileName(minioFileInfo.getOriginalFilename())
                    .contentType(minioFileInfo.getContentType())
                    .fileSize(minioFileInfo.getSize())
                    .bucketName(minioFileInfo.getBucket())
                    .objectName(minioFileInfo.getObjectName())
                    .fileUrl(minioFileInfo.getUrl())
                    .createdTime(minioFileInfo.getUploadTime().toLocalDateTime())
                    .build();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
