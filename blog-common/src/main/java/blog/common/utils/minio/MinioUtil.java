package blog.common.utils.minio;

import io.minio.*;
import io.minio.http.Method;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.UUID;

@Component
public class MinioUtil {

    private final MinioClient minioClient;

    @Value("${minio.bucket-name}")
    private String bucketName;

    public MinioUtil(MinioClient minioClient) {
        this.minioClient = minioClient;
    }

    /* ================= Bucket 相关 ================= */

    /**
     * Bucket 是否存在
     */
    public boolean bucketExists() throws Exception {
        return minioClient.bucketExists(
                BucketExistsArgs.builder()
                        .bucket(bucketName)
                        .build()
        );
    }

    /**
     * 不存在则创建 Bucket
     */
    public void createBucketIfNotExists() throws Exception {
        if (!bucketExists()) {
            minioClient.makeBucket(
                    MakeBucketArgs.builder()
                            .bucket(bucketName)
                            .build()
            );
        }
    }

    /* ================= 上传 ================= */

    /**
     * 上传文件（按业务类型 + 业务ID）
     *
     * @param file    文件
     * @param bizType 业务类型，如 user、order、contract
     * @param bizId   业务ID，如用户ID、订单ID
     */
    public String upload(MultipartFile file, String bizType, String bizId) throws Exception {
        createBucketIfNotExists();

        String objectName = buildObjectName(file.getOriginalFilename(), bizType, bizId);

        minioClient.putObject(
                PutObjectArgs.builder()
                        .bucket(bucketName)
                        .object(objectName)
                        .stream(file.getInputStream(), file.getSize(), -1)
                        .contentType(file.getContentType())
                        .build()
        );

        return objectName;
    }

    /* ================= 下载 ================= */

    /**
     * 下载文件
     */
    public InputStream download(String objectName) throws Exception {
        return minioClient.getObject(
                GetObjectArgs.builder()
                        .bucket(bucketName)
                        .object(objectName)
                        .build()
        );
    }

    /* ================= 删除 ================= */

    /**
     * 删除文件
     */
    public void delete(String objectName) throws Exception {
        minioClient.removeObject(
                RemoveObjectArgs.builder()
                        .bucket(bucketName)
                        .object(objectName)
                        .build()
        );
    }

    /* ================= 文件访问 ================= */

    /**
     * 获取文件访问 URL（带有效期）
     *
     * @param expireSeconds 过期时间（秒）
     */
    public String getFileUrl(String objectName, int expireSeconds) throws Exception {
        return minioClient.getPresignedObjectUrl(
                GetPresignedObjectUrlArgs.builder()
                        .bucket(bucketName)
                        .object(objectName)
                        .method(Method.GET)
                        .expiry(expireSeconds)
                        .build()
        );
    }

    /* ================= 工具方法 ================= */

    /**
     * 构建对象存储路径
     */
    private String buildObjectName(String originalFilename, String bizType, String bizId) {
        String date = LocalDate.now().format(DateTimeFormatter.BASIC_ISO_DATE);
        String suffix = "";

        if (originalFilename != null && originalFilename.contains(".")) {
            suffix = originalFilename.substring(originalFilename.lastIndexOf("."));
        }

        return String.format("%s/%s/%s/%s%s",
                bizType,
                bizId,
                date,
                UUID.randomUUID().toString().replace("-", ""),
                suffix
        );
    }
}

