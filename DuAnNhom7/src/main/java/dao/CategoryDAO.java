package dao;

import entity.Category;

public class CategoryDAO extends BaseDAO<Category> {

    public CategoryDAO() {
        super(Category.class);
    }

    // Không cần viết lại CRUD vì đã có trong BaseDAO
}