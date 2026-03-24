package test;

import entity.Category;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import util.JPAUtil;

import java.util.List;

public class TestCategoryCRUD {

    public static void main(String[] args) {

        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {

            // =====================
            // 1. INSERT
            // =====================
            tx.begin();
            Category c = new Category();
            c.setName("Trà sữa");
            c.setActive(true);
            em.persist(c);
            tx.commit();
            System.out.println("✔ Insert thành công: " + c.getId());


            // =====================
            // 2. FIND ALL
            // =====================
            List<Category> list = em.createQuery("FROM Category", Category.class)
                    .getResultList();

            System.out.println("\n📌 Danh sách Category:");
            for (Category item : list) {
                System.out.println(item.getId() + " - " + item.getName());
            }


            // =====================
            // 3. FIND BY ID
            // =====================
            Category find = em.find(Category.class, c.getId());
            System.out.println("\n🔍 FindById: " + find.getName());


            // =====================
            // 4. UPDATE
            // =====================
            tx.begin();
            find.setName("Trà sữa updated");
            em.merge(find);
            tx.commit();
            System.out.println("✔ Update thành công");


            // =====================
            // 5. DELETE
            // =====================
            tx.begin();
            Category del = em.find(Category.class, find.getId());
            if (del != null) {
                em.remove(del);
            }
            tx.commit();
            System.out.println("✔ Delete thành công");

        } catch (Exception e) {
            tx.rollback();
            e.printStackTrace();
        } finally {
            em.close();
            JPAUtil.close();
        }
    }
}