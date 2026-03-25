<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý đồ uống - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .navbar {
            background-color: #5d4037 !important;
        }
        .navbar-brand, .nav-link {
            color: white !important;
        }
        .drink-img {
            width: 50px;
            height: 50px;
            object-fit: cover;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/admin/home">☕ Coffee Shop - Admin</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/home">Trang chủ</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/admin/drink/index">Quản lý đồ uống</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/manager/category/index">Quản lý danh mục</a>
                    </li>
                </ul>
                <ul class="navbar-nav">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown">
                            👤 ${sessionScope.user.fullName}
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">Đăng xuất</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>🍹 Quản lý đồ uống</h2>
            <a href="${pageContext.request.contextPath}/admin/drink/create" class="btn btn-success">➕ Thêm đồ uống mới</a>
        </div>

        <div class="table-responsive">
            <table class="table table-bordered table-hover">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Hình ảnh</th>
                        <th>Tên đồ uống</th>
                        <th>Danh mục</th>
                        <th>Giá</th>
                        <th>Trạng thái</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="drink" items="${drinks}">
                        <tr>
                            <td>${drink.id}</td>
                            <td>
                                <img src="${pageContext.request.contextPath}/images/${drink.image}"
                                     class="drink-img"
                                     onerror="this.src='${pageContext.request.contextPath}/images/default.jpg'">
                            </td>
                            <td>${drink.name}</td>
                            <td>${drink.category.name}</td>
                            <td class="price">${drink.price} VNĐ</td>
                            <td>
                                <c:if test="${drink.active}">
                                    <span class="badge bg-success">Hoạt động</span>
                                </c:if>
                                <c:if test="${not drink.active}">
                                    <span class="badge bg-danger">Ngừng hoạt động</span>
                                </c:if>
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/drink/edit?id=${drink.id}" class="btn btn-warning btn-sm">✏️ Sửa</a>
                                <a href="${pageContext.request.contextPath}/admin/drink/delete?id=${drink.id}"
                                   class="btn btn-danger btn-sm"
                                   onclick="return confirm('Bạn có chắc muốn xóa đồ uống ${drink.name}?')">🗑️ Xóa</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <c:if test="${empty drinks}">
            <div class="alert alert-info text-center">
                <h5>Chưa có đồ uống nào</h5>
                <a href="${pageContext.request.contextPath}/admin/drink/create" class="btn btn-primary">Thêm đồ uống đầu tiên</a>
            </div>
        </c:if>

        <div class="mt-3">
            <a href="${pageContext.request.contextPath}/admin/home" class="btn btn-secondary">← Quay lại trang chủ</a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>