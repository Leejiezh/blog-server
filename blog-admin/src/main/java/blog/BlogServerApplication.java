package blog;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.mybatis.spring.annotation.MapperScan;

/**
 * 启动程序
 *
 * @author leejie
 */
@SpringBootApplication(exclude = {DataSourceAutoConfiguration.class})
@MapperScan("blog.**.mapper")
public class BlogServerApplication {
    public static void main(String[] args) {
         System.setProperty("spring.devtools.restart.enabled", "false");
        SpringApplication.run(BlogServerApplication.class, args);
        System.out.println("~~~~后台项目启动成功~~~~");
    }
}
