package blog.common.config.minio;

import io.minio.MinioClient;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Slf4j
@Configuration
public class MinioConfig {

    @Autowired
    private MinioProperties properties;

    @Bean
    public MinioClient minioClient() {
        var client = MinioClient.builder()
                .endpoint(properties.getEndpoint())
                .credentials(properties.getAccessKey(), properties.getSecretKey())
                .build();
        // 真正验证连接
        try {
            client.listBuckets();  // 调用API验证连接和认证
            log.info("~~~~minio 服务连接成功~~~~");
        } catch (Exception e) {
            log.error("~~~~minio 服务连接失败: {}~~~~", e.getMessage());
        }
        return client;
    }
}

