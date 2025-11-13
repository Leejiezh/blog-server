# 使用基础的 Java 镜像
FROM openjdk:17-jdk-slim

# 设置工作目录
WORKDIR /app

# 将打包好的 JAR 文件复制到容器中
COPY target/blog-admin.jar /app/blog-admin.jar

# 暴露 Spring Boot 应用的端口
EXPOSE 9997

# 运行 Spring Boot 应用
CMD ["java", "-jar", "PMS-1.0-SNAPSHOT.jar"]
