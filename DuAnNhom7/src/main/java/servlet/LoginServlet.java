package servlet;

import dao.UserDAO;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import util.AuthUtil;
import util.ParamUtil;

import java.io.IOException;

@WebServlet("/auth/login")
public class LoginServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // Trỏ đúng JSP mới
        req.getRequestDispatcher("/WEB-INF/jsp/auth/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String email = ParamUtil.getString(req, "email");
        String password = ParamUtil.getString(req, "password");

        User user = userDAO.findByEmail(email);

        if (user != null && user.getPassword().equals(password)) {

            AuthUtil.login(req.getSession(), user);

            // phân quyền
            if (user.isRole()) {
                resp.sendRedirect(req.getContextPath() + "/admin/home");
            } else {
                resp.sendRedirect(req.getContextPath() + "/employee/home");
            }

        } else {
            req.setAttribute("error", "Email hoặc mật khẩu không đúng");
            req.getRequestDispatcher("/WEB-INF/jsp/auth/login.jsp").forward(req, resp);
        }
    }
}