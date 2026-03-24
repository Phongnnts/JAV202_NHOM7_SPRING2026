<%@ page import="java.util.*, entity.Category, jakarta.persistence.*, util.JPAUtil" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
    EntityManager em = JPAUtil.getEntityManager();
    EntityTransaction tx = em.getTransaction();

    String action = request.getParameter("action");

    try {

        // ================= INSERT =================
        if ("insert".equals(action)) {
            tx.begin();
            Category c = new Category();
            c.setName("Trà sữa JSP");
            c.setActive(true);
            em.persist(c);
            tx.commit();
        }

        // ================= UPDATE =================
        if ("update".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            tx.begin();
            Category c = em.find(Category.class, id);
            if (c != null) {
                c.setName("Updated JSP");
                em.merge(c);
            }
            tx.commit();
        }

        // ================= DELETE =================
        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            tx.begin();
            Category c = em.find(Category.class, id);
            if (c != null) {
                em.remove(c);
            }
            tx.commit();
        }

    } catch (Exception e) {
        if (tx.isActive()) tx.rollback();
        e.printStackTrace();
    }

    // ================= LOAD DATA =================
    List<Category> list = em.createQuery("FROM Category", Category.class).getResultList();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Test Category CRUD</title>
    <style>
        body { font-family: Arial; margin: 30px; }
        table { border-collapse: collapse; width: 60%; }
        th, td { border: 1px solid #ccc; padding: 8px; text-align: center; }
        th { background: #f2f2f2; }
        a { text-decoration: none; margin: 0 5px; }
        .btn { padding: 5px 10px; background: #007bff; color: white; border-radius: 5px; }
        .delete { background: red; }
    </style>
</head>
<body>

<h2>📌 Danh sách Category</h2>

<a href="?action=insert" class="btn">➕ Thêm mới</a>

<br><br>

<table>
    <tr>
        <th>ID</th>
        <th>Tên</th>
        <th>Trạng thái</th>
        <th>Hành động</th>
    </tr>

    <%
        for (Category c : list) {
    %>
    <tr>
        <td><%= c.getId() %></td>
        <td><%= c.getName() %></td>
        <td><%= c.isActive() ? "Hoạt động" : "Ngừng" %></td>
        <td>
            <a href="?action=update&id=<%=c.getId()%>" class="btn">✏ Update</a>
            <a href="?action=delete&id=<%=c.getId()%>" class="btn delete"
               onclick="return confirm('Xóa?')">🗑 Delete</a>
        </td>
    </tr>
    <%
        }
    %>
</table>

</body>
</html>

<%
    em.close();
%>