package util;

import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;

public class FileUtil {

    private static final String UPLOAD_DIR = "uploads";

    // Upload file, trả về tên file đã lưu
    public static String upload(Part part, String realPath) throws IOException {

        if (part == null || part.getSize() == 0) {
            return null;
        }

        // Lấy tên file gốc
        String fileName = part.getSubmittedFileName();

        // Tạo tên file unique (timestamp)
        String newFileName = System.currentTimeMillis() + "_" + fileName;

        // Tạo thư mục uploads nếu chưa có
        File uploadDir = new File(realPath + File.separator + UPLOAD_DIR);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        // Đường dẫn lưu file
        String filePath = uploadDir.getAbsolutePath() + File.separator + newFileName;

        // Lưu file
        part.write(filePath);

        return newFileName;
    }
}