package dao;

import entity.Drink;
import jakarta.persistence.EntityManager;
import util.JPAUtil;

import java.util.List;

public class DrinkDAO extends BaseDAO<Drink> {

    public DrinkDAO() {
        super(Drink.class);
    }

    // Tìm theo Category
    public List<Drink> findByCategory(Integer categoryId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                            "SELECT d FROM Drink d WHERE d.category.id = :cid", Drink.class)
                    .setParameter("cid", categoryId)
                    .getResultList();
        } finally {
            em.close();
        }
    }
}