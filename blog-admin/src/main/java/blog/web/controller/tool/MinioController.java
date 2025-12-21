package blog.web.controller.tool;


import blog.common.utils.minio.MinioUtil;
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
    public String upload(@RequestParam("file") MultipartFile file) throws Exception {
        return minioUtil.upload(file, "user", "1001");
    }


    @GetMapping("/download")
    public void download(@RequestParam String fileName,
                         HttpServletResponse response) throws Exception {

        InputStream inputStream = minioUtil.download(fileName);

        response.setContentType("application/octet-stream");
        response.setHeader("Content-Disposition",
                "attachment;filename=" + fileName);

        inputStream.transferTo(response.getOutputStream());
    }
}
