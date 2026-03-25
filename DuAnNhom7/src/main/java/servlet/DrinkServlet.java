//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by FernFlower decompiler)
//

package servlet;

import dao.CategoryDAO;
import dao.DrinkDAO;
import entity.Category;
import entity.Drink;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import util.ParamUtil;

@WebServlet({"/manager/drink/index", "/manager/drink/create", "/manager/drink/edit", "/manager/drink/delete"})
public class DrinkServlet extends HttpServlet {
    private DrinkDAO drinkDAO = new DrinkDAO();
    private CategoryDAO categoryDAO = new CategoryDAO();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        if (uri.contains("index")) {
            List<Drink> list = this.drinkDAO.findAll();
            req.setAttribute("drinks", list);
            req.getRequestDispatcher("/WEB-INF/jsp/drink/drink-list.jsp").forward(req, resp);
        } else if (uri.contains("create")) {
            List<Category> categories = this.categoryDAO.findAll();
            req.setAttribute("categories", categories);
            req.getRequestDispatcher("/WEB-INF/jsp/drink/drink-form.jsp").forward(req, resp);
        } else if (uri.contains("edit")) {
            int id = ParamUtil.getInt(req, "id");
            Drink d = (Drink)this.drinkDAO.findById(id);
            req.setAttribute("drink", d);
            List<Category> categories = this.categoryDAO.findAll();
            req.setAttribute("categories", categories);
            req.getRequestDispatcher("/WEB-INF/jsp/drink/drink-form.jsp").forward(req, resp);
        } else if (uri.contains("delete")) {
            int id = ParamUtil.getInt(req, "id");
            this.drinkDAO.delete(id);
            resp.sendRedirect(req.getContextPath() + "/manager/drink/index");
        }

    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        if (uri.contains("create") || uri.contains("edit")) {
            int id = ParamUtil.getInt(req, "id");
            String name = ParamUtil.getString(req, "name");
            double price = (double)ParamUtil.getInt(req, "price");
            int categoryId = ParamUtil.getInt(req, "categoryId");
            String image = ParamUtil.getString(req, "image");
            Drink d;
            if (id > 0) {
                d = (Drink)this.drinkDAO.findById(id);
                if (d == null) {
                    resp.sendRedirect(req.getContextPath() + "/manager/drink/index");
                    return;
                }
            } else {
                d = new Drink();
            }

            d.setName(name);
            d.setPrice((int)price);
            d.setCategory((Category)this.categoryDAO.findById(categoryId));
            if (image != null && !image.isEmpty()) {
                d.setImage(image);
            }

            if (id > 0) {
                this.drinkDAO.update(d);
            } else {
                this.drinkDAO.create(d);
            }

            resp.sendRedirect(req.getContextPath() + "/manager/drink/index");
        }

    }
}
