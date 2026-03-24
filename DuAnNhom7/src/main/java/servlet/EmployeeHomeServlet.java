package servlet;

import dao.DrinkDAO;
import entity.Drink;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/employee/home")
public class EmployeeHomeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        resp.setCharacterEncoding("UTF-8");
        req.setCharacterEncoding("UTF-8");
        // Chỉ load danh sách sản phẩm
        List<Drink> drinks = new DrinkDAO().findAll();
        req.setAttribute("drinks", drinks);
        req.getRequestDispatcher("/WEB-INF/jsp/employee/home.jsp").forward(req, resp);
    }
}