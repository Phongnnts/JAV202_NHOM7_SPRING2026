package util;

import jakarta.servlet.http.HttpServletRequest;

public class ParamUtil {

    public static String getString(HttpServletRequest request, String name) {
        String value = request.getParameter(name);
        return value != null ? value.trim() : "";
    }

    public static int getInt(HttpServletRequest request, String name) {
        try {
            return Integer.parseInt(request.getParameter(name));
        } catch (Exception e) {
            return 0;
        }
    }

    public static boolean getBoolean(HttpServletRequest request, String name) {
        String value = request.getParameter(name);
        return value != null && (value.equals("true") || value.equals("on") || value.equals("1"));
    }
}