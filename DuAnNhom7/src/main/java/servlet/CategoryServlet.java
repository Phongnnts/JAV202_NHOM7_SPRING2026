package servlet;

import dao.CategoryDAO;
import entity.Category;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import util.ParamUtil;

import java.io.IOException;
import java.util.List;

@WebServlet({
        "/manager/category/index",
        "/manager/category/create",
        "/manager/category/edit",
        "/manager/category/delete"
})
public class CategoryServlet extends HttpServlet {

    private CategoryDAO categoryDAO = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String uri = req.getRequestURI();

        if (uri.contains("index")) {
            List<Category> list = categoryDAO.findAll();
            req.setAttribute("list", list);
            req.getRequestDispatcher("/WEB-INF/jsp/category/category-list.jsp").forward(req, resp);
        } else if (uri.contains("create")) {
            req.getRequestDispatcher("/WEB-INF/jsp/category/category-form.jsp").forward(req, resp);
        } else if (uri.contains("edit")) {
            int id = ParamUtil.getInt(req, "id");
            Category c = categoryDAO.findById(id);
            req.setAttribute("item", c);
            req.getRequestDispatcher("/WEB-INF/jsp/category/category-form.jsp").forward(req, resp);
        } else if (uri.contains("delete")) {
            int id = ParamUtil.getInt(req, "id");
            categoryDAO.delete(id);
            resp.sendRedirect(req.getContextPath() + "/manager/category/index");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String uri = req.getRequestURI();

        if (uri.contains("create")) {
            Category c = new Category();
            c.setName(ParamUtil.getString(req, "name"));
            c.setDescription(ParamUtil.getString(req, "description"));
            c.setActive(ParamUtil.getBoolean(req, "active"));

            categoryDAO.create(c);
            resp.sendRedirect(req.getContextPath() + "/manager/category/index");
        } else if (uri.contains("edit")) {
            int id = ParamUtil.getInt(req, "id");
            Category c = categoryDAO.findById(id);
            if (c != null) {
                c.setName(ParamUtil.getString(req, "name"));
                c.setDescription(ParamUtil.getString(req, "description"));
                c.setActive(ParamUtil.getBoolean(req, "active"));
                categoryDAO.update(c);
            }
            resp.sendRedirect(req.getContextPath() + "/manager/category/index");
        }
    }
}