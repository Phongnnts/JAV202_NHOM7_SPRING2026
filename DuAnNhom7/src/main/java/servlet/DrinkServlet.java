package servlet;

import dao.CategoryDAO;
import dao.DrinkDAO;
import entity.Category;
import entity.Drink;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import util.ParamUtil;

import java.io.File;
import java.io.IOException;
import java.util.List;

@WebServlet({
        "/admin/drink/list",
        "/admin/drink/create",
        "/admin/drink/edit",
        "/admin/drink/delete"
})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
        maxFileSize = 1024 * 1024 * 10,       // 10MB
        maxRequestSize = 1024 * 1024 * 50     // 50MB
)
public class DrinkServlet extends HttpServlet {

    private DrinkDAO drinkDAO = new DrinkDAO();
    private CategoryDAO categoryDAO = new CategoryDAO();

    private static final String UPLOAD_DIR = "assets/uploads";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String uri = req.getRequestURI();

        if (uri.contains("list")) {
            // Lấy tham số phân trang và lọc
            int page = ParamUtil.getInt(req, "page", 1);
            int limit = 5; // Số item mỗi trang
            int offset = (page - 1) * limit;
            // Đếm tổng & active
            long totalDrinks = drinkDAO.countAll();
            long activeDrinks = drinkDAO.countActive();
            System.out.println("TOTAL = " + totalDrinks);
            System.out.println("ACTIVE = " + activeDrinks);
            req.setAttribute("totalDrinks", totalDrinks);
            req.setAttribute("activeDrinks", activeDrinks);

            Integer categoryId = ParamUtil.getInt(req, "categoryId");
            String keyword = ParamUtil.getString(req, "keyword");

            // Lấy danh sách categories để hiển thị trong dropdown
            List<Category> categories = categoryDAO.findAll();
            req.setAttribute("categories", categories);

            // Lấy danh sách drinks theo filter
            List<Drink> drinks = drinkDAO.findByFilters(categoryId, keyword, offset, limit);
            req.setAttribute("drinks", drinks);

            // Lấy tổng số trang
            long totalRecords = drinkDAO.countByFilters(categoryId, keyword);
            int totalPages = (int) Math.ceil((double) totalRecords / limit);

            req.setAttribute("currentPage", page);
            req.setAttribute("totalPages", totalPages);

            req.getRequestDispatcher("/WEB-INF/jsp/drink/drink-list.jsp").forward(req, resp);

        } else if (uri.contains("create")) {
            // Hiển thị form tạo mới
            List<Category> categories = categoryDAO.findAll();
            req.setAttribute("categories", categories);
            req.getRequestDispatcher("/WEB-INF/jsp/drink/drink-form.jsp").forward(req, resp);

        } else if (uri.contains("edit")) {
            // Hiển thị form chỉnh sửa
            int id = ParamUtil.getInt(req, "id");
            Drink drink = drinkDAO.findById(id);
            if (drink != null) {
                List<Category> categories = categoryDAO.findAll();
                req.setAttribute("drink", drink);
                req.setAttribute("categories", categories);
                req.getRequestDispatcher("/WEB-INF/jsp/drink/drink-form.jsp").forward(req, resp);
            } else {
                resp.sendRedirect(req.getContextPath() + "/admin/drink/list");
            }

        } else if (uri.contains("delete")) {
            try {
                int id = ParamUtil.getInt(req, "id");
                System.out.println("=== DELETE DRINK ===");
                System.out.println("ID: " + id);

                Drink drink = drinkDAO.findById(id);

                if (drink != null) {
                    System.out.println("Drink name: " + drink.getName());
                    System.out.println("Drink image: " + drink.getImage());

                    // Xóa file ảnh
                    if (drink.getImage() != null && !drink.getImage().isEmpty()) {
                        String uploadPath = getServletContext().getRealPath("") + File.separator + "assets/uploads";
                        File imageFile = new File(uploadPath + File.separator + drink.getImage());

                        if (imageFile.exists()) {
                            boolean deleted = imageFile.delete();
                            System.out.println("Image deleted: " + deleted);
                        } else {
                            System.out.println("Image file not found at: " + imageFile.getAbsolutePath());
                        }
                    }

                    // Xóa trong database
                    drinkDAO.delete(id);
                    System.out.println("Deleted drink from database successfully!");

                    // Set success message
                    req.getSession().setAttribute("successMessage", "Đã xóa đồ uống: " + drink.getName());

                } else {
                    System.out.println("Drink not found!");
                    req.getSession().setAttribute("errorMessage", "Không tìm thấy đồ uống cần xóa!");
                }

            } catch (Exception e) {
                e.printStackTrace();
                req.getSession().setAttribute("errorMessage", "Lỗi khi xóa: " + e.getMessage());
            }

            resp.sendRedirect(req.getContextPath() + "/admin/drink/list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String uri = req.getRequestURI();

        if (uri.contains("create")) {
            // Tạo mới drink
            Drink drink = new Drink();
            drink.setName(ParamUtil.getString(req, "name"));
            drink.setPrice(ParamUtil.getInt(req, "price", 0));
            drink.setDescription(ParamUtil.getString(req, "description"));
            drink.setActive(ParamUtil.getBoolean(req, "active"));

            int categoryId = ParamUtil.getInt(req, "categoryId");
            Category category = categoryDAO.findById(categoryId);
            if (category != null) {
                drink.setCategory(category);
            }

            // Xử lý upload ảnh
            Part filePart = req.getPart("imageFile");
            String fileName = uploadImage(filePart, req);
            drink.setImage(fileName);

            drinkDAO.create(drink);
            resp.sendRedirect(req.getContextPath() + "/admin/drink/list");

        } else if (uri.contains("edit")) {
            // Cập nhật drink
            int id = ParamUtil.getInt(req, "id");
            Drink drink = drinkDAO.findById(id);

            if (drink != null) {
                drink.setName(ParamUtil.getString(req, "name"));
                drink.setPrice(ParamUtil.getInt(req, "price", 0));
                drink.setDescription(ParamUtil.getString(req, "description"));
                drink.setActive(ParamUtil.getBoolean(req, "active"));

                int categoryId = ParamUtil.getInt(req, "categoryId");
                Category category = categoryDAO.findById(categoryId);
                if (category != null) {
                    drink.setCategory(category);
                }

                // Xử lý upload ảnh mới
                Part filePart = req.getPart("imageFile");
                if (filePart != null && filePart.getSize() > 0) {
                    // Xóa ảnh cũ
                    String oldImage = drink.getImage();
                    if (oldImage != null && !oldImage.isEmpty()) {
                        deleteImageFile(req, oldImage);
                    }
                    // Upload ảnh mới
                    String fileName = uploadImage(filePart, req);
                    drink.setImage(fileName);
                }

                drinkDAO.update(drink);
            }

            resp.sendRedirect(req.getContextPath() + "/admin/drink/list");
        }
    }

    /**
     * Upload ảnh lên server
     */
    private String uploadImage(Part filePart, HttpServletRequest req) throws IOException {
        if (filePart == null || filePart.getSize() == 0) {
            return null;
        }

        // Tạo tên file duy nhất để tránh trùng
        String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();

        // Lấy đường dẫn thực tế trên server
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;

        // Tạo thư mục nếu chưa tồn tại
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        // Lưu file
        filePart.write(uploadPath + File.separator + fileName);

        System.out.println("Uploaded file: " + fileName + " to " + uploadPath);

        return fileName;
    }

    /**
     * Xóa file ảnh
     */
    private void deleteImageFile(HttpServletRequest req, String fileName) {
        if (fileName == null || fileName.isEmpty()) return;

        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
        File file = new File(uploadPath + File.separator + fileName);

        if (file.exists()) {
            boolean deleted = file.delete();
            if (deleted) {
                System.out.println("Deleted image: " + fileName);
            } else {
                System.out.println("Failed to delete image: " + fileName);
            }
        }
    }
}