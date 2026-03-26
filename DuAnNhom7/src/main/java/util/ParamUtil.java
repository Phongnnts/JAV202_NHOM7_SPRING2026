package util;

import jakarta.servlet.http.HttpServletRequest;

public class ParamUtil {

    // Phương thức gốc - lấy int, nếu lỗi trả về 0
    public static int getInt(HttpServletRequest req, String name) {
        try {
            return Integer.parseInt(req.getParameter(name));
        } catch (NumberFormatException e) {
            return 0;
        }
    }

    // Thêm phương thức mới - lấy int với giá trị mặc định
    public static int getInt(HttpServletRequest req, String name, int defaultValue) {
        try {
            String value = req.getParameter(name);
            if (value == null || value.trim().isEmpty()) {
                return defaultValue;
            }
            return Integer.parseInt(value);
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }

    // Phương thức lấy String
    public static String getString(HttpServletRequest req, String name) {
        String value = req.getParameter(name);
        return value != null ? value.trim() : "";
    }

    // Phương thức lấy boolean
    public static boolean getBoolean(HttpServletRequest req, String name) {
        String value = req.getParameter(name);
        return value != null && (value.equals("true") || value.equals("on") || value.equals("1"));
    }
}