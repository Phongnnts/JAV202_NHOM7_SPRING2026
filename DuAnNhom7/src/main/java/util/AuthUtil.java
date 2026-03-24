package util;

import entity.User;
import jakarta.servlet.http.HttpSession;

public class AuthUtil {

    private static final String USER_KEY = "user";

    // LOGIN: lưu user vào session
    public static void login(HttpSession session, User user) {
        session.setAttribute(USER_KEY, user);
    }

    // LOGOUT: xóa session
    public static void logout(HttpSession session) {
        session.removeAttribute(USER_KEY);
    }

    // Lấy user hiện tại
    public static User getUser(HttpSession session) {
        return (User) session.getAttribute(USER_KEY);
    }

    // Check đã login chưa
    public static boolean isLogin(HttpSession session) {
        return getUser(session) != null;
    }

    // Check admin (role = true)
    public static boolean isAdmin(HttpSession session) {
        User user = getUser(session);
        return user != null && user.isRole();
    }
}