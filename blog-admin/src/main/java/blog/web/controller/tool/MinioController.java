package blog.web.controller.tool;


import blog.common.annotation.Anonymous;
import blog.common.utils.minio.MinioUtil;
import io.swagger.v3.oas.annotations.Operation;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;

@RequestMapping("/minio")
@RestController
public class MinioController {

    private final MinioUtil minioUtil;

    public MinioController(MinioUtil minioUtil) {
        this.minioUtil = minioUtil;
    }

    @PostMapping("/upload")
    @Operation(summary = "上传文件")
    public String upload(@RequestParam("file") MultipartFile file) throws Exception {
        return minioUtil.upload(file, "user", "1001");
    }


    @Anonymous
    @GetMapping("/download")
    @Operation(summary = "下载文件")
    public void download(@RequestParam String fileName,
                         HttpServletResponse response) throws Exception {

        InputStream inputStream = minioUtil.download(fileName);

        String[] split = fileName.split("/");
        String downloadFileName = split[split.length - 1];

        response.setContentType("application/octet-stream");
        response.setHeader("Content-Disposition",
                "attachment;filename=" + downloadFileName);

        inputStream.transferTo(response.getOutputStream());
    }


    @Anonymous
    @GetMapping("/getFileUrl")
    @Operation(summary = "获取文件url")
    public String getFileUrl(@RequestParam String fileName) throws Exception {
        return minioUtil.getFileUrl(fileName, 600);
    }
}
