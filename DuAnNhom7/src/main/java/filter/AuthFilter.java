package filter;

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

        // Các đường dẫn được phép truy cập không cần login
        if (uri.contains("login") || uri.contains("logout") || uri.contains("css") || uri.contains("js")) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session = request.getSession(false);

        // Chưa login
        if (session == null || !AuthUtil.isLogin(session)) {
            response.sendRedirect(contextPath + "/auth/login");
            return;
        }

        // Phân quyền
        if (uri.contains("/admin") && !AuthUtil.isAdmin(session)) {
            response.sendRedirect(contextPath + "/admin/home");
            return;
        }

        if (uri.contains("/employee") && AuthUtil.isAdmin(session)) {
            response.sendRedirect(contextPath + "/admin/home");
            return;
        }

        chain.doFilter(request, response);
    }
}