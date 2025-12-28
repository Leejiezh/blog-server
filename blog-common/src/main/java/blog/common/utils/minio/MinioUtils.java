package blog.common.utils.minio;

import io.minio.*;
import io.minio.StatObjectResponse;
import io.minio.http.Method;
import io.minio.messages.DeleteError;
import io.minio.messages.DeleteObject;
import io.minio.messages.Item;
import lombok.Builder;
import lombok.Data;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * MinIO 工具类，封装企业级常用文件操作
 */
@Component
public class MinioUtils {

    private final MinioClient minioClient;

    @Value("${minio.bucket-name}")
    private String bucket;

    public MinioUtils(MinioClient minioClient) {
        this.minioClient = minioClient;
    }

    /**
     * 文件信息 DTO
     */
    @Data
    @Builder
    public static class MinioFileInfo {
        private String bucket;               // 桶名称
        private String originalFilename;     // 原始文件名
        private String objectName;           // MinIO 对象路径
        private String url;                  // 文件访问 URL（临时或永久）
        private Long size;                   // 文件大小（字节）
        private String contentType;          // 文件类型
        private ZonedDateTime uploadTime;    // 上传时间
    }

    // ======================= Bucket 操作 =======================

    /**
     * 判断 Bucket 是否存在
     * @param bucket 桶名称
     * @return true = 存在，false = 不存在
     * @throws Exception MinIO 操作异常
     */
    public boolean bucketExists(String bucket) throws Exception {
        return minioClient.bucketExists(BucketExistsArgs.builder().bucket(bucket).build());
    }

    /**
     * 创建 Bucket，如果已存在则忽略
     * @param bucket 桶名称
     * @throws Exception MinIO 操作异常
     */
    public void makeBucket(String bucket) throws Exception {
        if (!bucketExists(bucket)) {
            minioClient.makeBucket(MakeBucketArgs.builder().bucket(bucket).build());
        }
    }

    // ======================= 文件上传 =======================

    /**
     * 上传 MultipartFile 文件
     * @param file 文件对象
     * @param bucket 桶名称
     * @param dir 文件存储目录（例如 user/1/）
     * @return MinioFileInfo 上传后文件信息
     * @throws Exception 上传异常
     */
    public MinioFileInfo uploadFile(MultipartFile file, String bucket, String dir) throws Exception {
        if (bucket == null){
            bucket = this.bucket;
        }
        makeBucket(bucket);

        String originalFilename = file.getOriginalFilename();
        String suffix = "";
        if (originalFilename != null && originalFilename.contains(".")) {
            suffix = originalFilename.substring(originalFilename.lastIndexOf("."));
        }

        String objectName = dir + "/" + UUID.randomUUID() + suffix;

        try (InputStream inputStream = file.getInputStream()) {
            minioClient.putObject(
                    PutObjectArgs.builder()
                            .bucket(bucket)
                            .object(objectName)
                            .stream(inputStream, file.getSize(), -1)
                            .contentType(file.getContentType())
                            .build()
            );
        }

        return getFileInfo(bucket, objectName, originalFilename);
    }

    /**
     * 上传本地文件
     * @param localFilePath 本地文件路径
     * @param bucket 桶名称
     * @param dir 文件存储目录
     * @return MinioFileInfo 上传后文件信息
     * @throws Exception 上传异常
     */
    public MinioFileInfo uploadFile(String localFilePath, String bucket, String dir) throws Exception {
        makeBucket(bucket);

        File file = new File(localFilePath);
        if (!file.exists() || !file.isFile()) {
            throw new FileNotFoundException("文件不存在：" + localFilePath);
        }

        String originalFilename = file.getName();
        String suffix = "";
        if (originalFilename.contains(".")) {
            suffix = originalFilename.substring(originalFilename.lastIndexOf("."));
        }

        String objectName = dir + "/" + UUID.randomUUID() + suffix;

        minioClient.uploadObject(
                UploadObjectArgs.builder()
                        .bucket(bucket)
                        .object(objectName)
                        .filename(localFilePath)
                        .contentType("application/octet-stream")
                        .build()
        );

        return getFileInfo(bucket, objectName, originalFilename);
    }

    // ======================= 文件信息 =======================

    /**
     * 获取文件信息（大小、类型、上传时间、临时访问 URL）
     * @param bucket 桶名称
     * @param objectName 文件路径（objectName）
     * @param originalFilename 原始文件名，可为空
     * @return MinioFileInfo 文件信息
     * @throws Exception MinIO 操作异常
     */
    public MinioFileInfo getFileInfo(String bucket, String objectName, String originalFilename) throws Exception {
        StatObjectResponse stat = minioClient.statObject(
                StatObjectArgs.builder().bucket(bucket).object(objectName).build()
        );

        String url = minioClient.getPresignedObjectUrl(
                GetPresignedObjectUrlArgs.builder()
                        .method(Method.GET)
                        .bucket(bucket)
                        .object(objectName)
                        .expiry(60 * 60 * 24) // 24小时临时URL
                        .build()
        );

        return MinioFileInfo.builder()
                .bucket(bucket)
                .originalFilename(originalFilename)
                .objectName(objectName)
                .url(url)
                .size(stat.size())
                .contentType(stat.contentType())
                .uploadTime(stat.lastModified().withZoneSameInstant(ZoneId.of("Asia/Shanghai")))
                .build();
    }

    /**
     * 判断文件是否存在
     * @param bucket 桶名称
     * @param objectName 文件路径
     * @return true = 文件存在，false = 文件不存在
     */
    public boolean isFileExist(String bucket, String objectName) {
        try {
            minioClient.statObject(
                    StatObjectArgs.builder().bucket(bucket).object(objectName).build()
            );
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    /**
     * 获取文件 Stat 对象
     * @param bucket 桶名称
     * @param objectName 文件路径
     * @return StatObjectResponse 文件信息对象
     * @throws Exception MinIO 操作异常
     */
    public StatObjectResponse getFileStat(String bucket, String objectName) throws Exception {
        return minioClient.statObject(StatObjectArgs.builder().bucket(bucket).object(objectName).build());
    }

    // ======================= 文件下载 =======================

    /**
     * 获取文件输入流，可用于后端实时下载
     * @param bucket 桶名称
     * @param objectName 文件路径
     * @return InputStream 文件流
     * @throws Exception MinIO 操作异常
     */
    public InputStream getFileStream(String bucket, String objectName) throws Exception {
        return minioClient.getObject(GetObjectArgs.builder().bucket(bucket).object(objectName).build());
    }

    // ======================= 文件删除 =======================

    /**
     * 删除单个文件
     * @param bucket 桶名称
     * @param objectName 文件路径
     * @throws Exception MinIO 操作异常
     */
    public void deleteFile(String bucket, String objectName) throws Exception {
        minioClient.removeObject(RemoveObjectArgs.builder().bucket(bucket).object(objectName).build());
    }

    /**
     * 批量删除文件
     * @param bucket 桶名称
     * @param objectNames 文件路径列表
     * @throws Exception MinIO 操作异常
     */
    public void deleteFiles(String bucket, List<String> objectNames) throws Exception {
        List<DeleteObject> objects = new ArrayList<>();
        for (String objectName : objectNames) {
            objects.add(new DeleteObject(objectName));
        }
        Iterable<Result<DeleteError>> results = minioClient.removeObjects(
                RemoveObjectsArgs.builder().bucket(bucket).objects(objects).build()
        );
        for (Result<DeleteError> result : results) {
            DeleteError error = result.get();
            System.err.println("删除失败: " + error.objectName() + " 原因: " + error.message());
        }
    }

    // ======================= 文件列表 =======================

    /**
     * 列出目录下文件（非递归）
     * @param bucket 桶名称
     * @param prefix 目录前缀
     * @return 文件路径列表
     * @throws Exception MinIO 操作异常
     */
    public List<String> listObjects(String bucket, String prefix) throws Exception {
        return listObjects(bucket, prefix, false);
    }

    /**
     * 列出目录下文件，可选择递归
     * @param bucket 桶名称
     * @param prefix 目录前缀
     * @param recursive true = 递归子目录, false = 只列当前目录
     * @return 文件路径列表
     * @throws Exception MinIO 操作异常
     */
    public List<String> listObjects(String bucket, String prefix, boolean recursive) throws Exception {
        List<String> list = new ArrayList<>();
        Iterable<Result<Item>> results = minioClient.listObjects(
                ListObjectsArgs.builder().bucket(bucket).prefix(prefix).recursive(recursive).build()
        );
        for (Result<Item> itemResult : results) {
            Item item = itemResult.get();
            list.add(item.objectName());
        }
        return list;
    }

    // ======================= URL 生成 =======================

    /**
     * 获取临时访问 URL
     * @param bucket 桶名称
     * @param objectName 文件路径
     * @param expireSeconds 过期时间（秒）
     * @return 临时 URL
     * @throws Exception MinIO 操作异常
     */
    public String getPresignedUrl(String bucket, String objectName, int expireSeconds) throws Exception {
        return minioClient.getPresignedObjectUrl(
                GetPresignedObjectUrlArgs.builder()
                        .method(Method.GET)
                        .bucket(bucket)
                        .object(objectName)
                        .expiry(expireSeconds)
                        .build()
        );
    }

    /**
     * 获取永久访问 URL（前提 Bucket 公共可读）
     * @param bucket 桶名称
     * @param objectName 文件路径
     * @param domain MinIO 域名，例如 http://minio.example.com
     * @return 永久 URL
     */
    public String getPermanentUrl(String bucket, String objectName, String domain) {
        return domain + "/" + bucket + "/" + objectName;
    }

}


