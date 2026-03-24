package util;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class JPAUtil {

    private static final EntityManagerFactory emf;

    static {
        try {
            emf = Persistence.createEntityManagerFactory("duAnJavaPU");
        } catch (Exception e) {
            throw new RuntimeException("Error creating EntityManagerFactory", e);
        }
    }

    // Lấy EntityManager
    public static EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    // Đóng toàn bộ (ít dùng, chỉ khi shutdown app)
    public static void close() {
        if (emf != null && emf.isOpen()) {
            emf.close();
        }
    }
}