package servlet;

import dao.DrinkDAO;
import dao.CategoryDAO;
import entity.Drink;
import entity.Category;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import util.ParamUtil;

import java.io.IOException;
import java.util.List;

@WebServlet({
        "/manager/drink/index",
        "/manager/drink/create",
        "/manager/drink/edit",
        "/manager/drink/delete"
})
public class DrinkServlet extends HttpServlet {

    private DrinkDAO drinkDAO = new DrinkDAO();
    private CategoryDAO categoryDAO = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String uri = req.getRequestURI();

        if (uri.contains("index")) {
            List<Drink> list = drinkDAO.findAll();
            req.setAttribute("drinks", list);
            req.getRequestDispatcher("/WEB-INF/jsp/drink/drink-list.jsp").forward(req, resp);
        } else if (uri.contains("create")) {
            List<Category> categories = categoryDAO.findAll();
            req.setAttribute("categories", categories);
            req.getRequestDispatcher("/WEB-INF/jsp/drink/drink-form.jsp").forward(req, resp);
        } else if (uri.contains("edit")) {
            int id = ParamUtil.getInt(req, "id");
            Drink d = drinkDAO.findById(id);
            req.setAttribute("drink", d);
            List<Category> categories = categoryDAO.findAll();
            req.setAttribute("categories", categories);
            req.getRequestDispatcher("/WEB-INF/jsp/drink/drink-form.jsp").forward(req, resp);
        } else if (uri.contains("delete")) {
            int id = ParamUtil.getInt(req, "id");
            drinkDAO.delete(id);
            resp.sendRedirect(req.getContextPath() + "/manager/drink/index");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String uri = req.getRequestURI();

        if (uri.contains("create") || uri.contains("edit")) {
            int id = ParamUtil.getInt(req, "id");
            String name = ParamUtil.getString(req, "name");
            double price = ParamUtil.getInt(req, "price");
            int categoryId = ParamUtil.getInt(req, "categoryId");
            String image = ParamUtil.getString(req, "image"); // upload xử lý riêng

            Drink d;
            if (id > 0) {
                d = drinkDAO.findById(id);
                if (d == null) {
                    resp.sendRedirect(req.getContextPath() + "/manager/drink/index");
                    return;
                }
            } else {
                d = new Drink();
            }

            d.setName(name);
            d.setPrice((int) price);
            d.setCategory(categoryDAO.findById(categoryId));
            if (image != null && !image.isEmpty()) {
                d.setImage(image);
            }

            if (id > 0) {
                drinkDAO.update(d);
            } else {
                drinkDAO.create(d);
            }

            resp.sendRedirect(req.getContextPath() + "/manager/drink/index");
        }
    }
}