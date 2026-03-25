package filter;

import entity.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import util.AuthUtil;

import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        String uri = request.getRequestURI();
        String contextPath = request.getContextPath();
        String path = uri.substring(contextPath.length());

        // Các đường dẫn công khai (không cần login)
        if (path.startsWith("/auth/login") ||
                path.startsWith("/css") ||
                path.startsWith("/js") ||
                path.startsWith("/images") ||
                path.equals("/logout")) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session = request.getSession(false);

        // Chưa login -> chuyển về login
        if (session == null || !AuthUtil.isLogin(session)) {
            response.sendRedirect(contextPath + "/auth/login");
            return;
        }

        User currentUser = AuthUtil.getUser(session);

        // Admin có thể truy cập mọi nơi
        if (AuthUtil.isAdmin(session)) {
            chain.doFilter(request, response);
            return;
        }

        // User (không phải admin) không được truy cập /admin/*
        if (path.startsWith("/admin/")) {
            response.sendRedirect(contextPath + "/home");
            return;
        }

        // User không được truy cập /manager/*
        if (path.startsWith("/manager/")) {
            response.sendRedirect(contextPath + "/home");
            return;
        }

        chain.doFilter(request, response);
    }
}