package servlet;

import dao.CategoryDAO;
import dao.DrinkDAO;
import entity.Category;
import entity.Drink;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/home")
public class AdminHomeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        resp.setCharacterEncoding("UTF-8");
        req.setCharacterEncoding("UTF-8");
        // Load danh sách sản phẩm & danh mục
        List<Drink> drinks = new DrinkDAO().findAll();
        List<Category> categories = new CategoryDAO().findAll();
        req.setAttribute("drinks", drinks);
        req.setAttribute("categories", categories);
        req.getRequestDispatcher("/WEB-INF/jsp/admin/home.jsp").forward(req, resp);
    }
}