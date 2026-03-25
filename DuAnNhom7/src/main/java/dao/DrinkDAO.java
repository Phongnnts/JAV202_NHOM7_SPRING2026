package dao;

import entity.Drink;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
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

    // Add to DrinkDAO.java
    public List<Drink> searchByKeyword(String keyword) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            String jpql = "SELECT d FROM Drink d WHERE LOWER(d.name) LIKE :keyword";
            return em.createQuery(jpql, Drink.class)
                    .setParameter("keyword", "%" + keyword.toLowerCase() + "%")
                    .getResultList();
        } finally {
            em.close();
        }
    }

    public List<Drink> findByFilters(Integer categoryId, String keyword, int offset, int limit) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            StringBuilder jpql = new StringBuilder("SELECT d FROM Drink d WHERE 1=1");
            if (categoryId != null && categoryId > 0) {
                jpql.append(" AND d.category.id = :cid");
            }
            if (keyword != null && !keyword.trim().isEmpty()) {
                jpql.append(" AND LOWER(d.name) LIKE :kw");
            }
            TypedQuery<Drink> query = em.createQuery(jpql.toString(), Drink.class);
            if (categoryId != null && categoryId > 0) {
                query.setParameter("cid", categoryId);
            }
            if (keyword != null && !keyword.trim().isEmpty()) {
                query.setParameter("kw", "%" + keyword.toLowerCase() + "%");
            }
            return query.setFirstResult(offset).setMaxResults(limit).getResultList();
        } finally {
            em.close();
        }
    }

    public long countByFilters(Integer categoryId, String keyword) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            StringBuilder jpql = new StringBuilder("SELECT COUNT(d) FROM Drink d WHERE 1=1");
            if (categoryId != null && categoryId > 0) {
                jpql.append(" AND d.category.id = :cid");
            }
            if (keyword != null && !keyword.trim().isEmpty()) {
                jpql.append(" AND LOWER(d.name) LIKE :kw");
            }
            TypedQuery<Long> query = em.createQuery(jpql.toString(), Long.class);
            if (categoryId != null && categoryId > 0) {
                query.setParameter("cid", categoryId);
            }
            if (keyword != null && !keyword.trim().isEmpty()) {
                query.setParameter("kw", "%" + keyword.toLowerCase() + "%");
            }
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }
}