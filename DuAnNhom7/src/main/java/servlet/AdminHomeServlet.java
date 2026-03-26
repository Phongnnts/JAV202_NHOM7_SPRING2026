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
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        // Lấy param
        String keyword = req.getParameter("keyword");
        String cidRaw = req.getParameter("categoryId");
        String pageRaw = req.getParameter("page");

        Integer categoryId = null;
        if (cidRaw != null && !cidRaw.isEmpty()) {
            categoryId = Integer.parseInt(cidRaw);
        }

        int page = 1;
        int limit = 8;

        if (pageRaw != null) {
            page = Integer.parseInt(pageRaw);
        }

        int offset = (page - 1) * limit;

        DrinkDAO drinkDAO = new DrinkDAO();

        // 👉 dùng filter đúng
        List<Drink> drinks = drinkDAO.findByFilters(categoryId, keyword, offset, limit);

        long total = drinkDAO.countByFilters(categoryId, keyword);
        int totalPages = (int) Math.ceil((double) total / limit);

        List<Category> categories = new CategoryDAO().findAll();

        // set attribute
        req.setAttribute("drinks", drinks);
        req.setAttribute("categories", categories);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);

        req.getRequestDispatcher("/WEB-INF/jsp/admin/home.jsp").forward(req, resp);
    }
}