<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang chủ - Coffee Shop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .drink-card {
            margin-bottom: 20px;
            transition: transform 0.2s;
            cursor: pointer;
        }
        .drink-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        .drink-img {
            height: 200px;
            object-fit: cover;
        }
        .price {
            color: #e67e22;
            font-size: 1.2rem;
            font-weight: bold;
        }
        .navbar {
            background-color: #5d4037 !important;
        }
        .navbar-brand, .nav-link {
            color: white !important;
        }
        .cart-badge {
            position: relative;
        }
        .cart-count {
            position: absolute;
            top: -8px;
            right: -8px;
            background-color: red;
            color: white;
            border-radius: 50%;
            padding: 2px 6px;
            font-size: 12px;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/home">☕ Coffee Shop</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/home">Trang chủ</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/my-orders">Đơn hàng của tôi</a>
                    </li>
                </ul>
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link cart-badge" href="${pageContext.request.contextPath}/cart/view">
                            🛒 Giỏ hàng
                        </a>
                    </li>
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
        <div class="row">
            <div class="col-md-3">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0">📁 Danh mục</h5>
                    </div>
                    <div class="list-group list-group-flush">
                        <a href="${pageContext.request.contextPath}/home"
                           class="list-group-item list-group-item-action ${empty selectedCategory ? 'active' : ''}">
                            📌 Tất cả
                        </a>
                        <c:forEach var="cat" items="${categories}">
                            <c:if test="${cat.active}">
                                <a href="${pageContext.request.contextPath}/home?categoryId=${cat.id}"
                                   class="list-group-item list-group-item-action ${selectedCategory eq cat.id ? 'active' : ''}">
                                    ${cat.name}
                                </a>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>
            </div>

            <div class="col-md-9">
                <div class="row mb-3">
                    <div class="col">
                        <form method="get" action="${pageContext.request.contextPath}/home" class="d-flex">
                            <c:if test="${not empty selectedCategory}">
                                <input type="hidden" name="categoryId" value="${selectedCategory}">
                            </c:if>
                            <input type="text" name="keyword" class="form-control me-2" placeholder="🔍 Tìm kiếm đồ uống..." value="${keyword}">
                            <button type="submit" class="btn btn-primary">Tìm</button>
                        </form>
                    </div>
                </div>

                <div class="row">
                    <c:forEach var="drink" items="${drinks}">
                        <div class="col-md-4 col-sm-6">
                            <div class="card drink-card">
                                <img src="${pageContext.request.contextPath}/images/${drink.image}"
                                     class="card-img-top drink-img"
                                     alt="${drink.name}"
                                     onerror="this.src='${pageContext.request.contextPath}/images/default.jpg'">
                                <div class="card-body">
                                    <h5 class="card-title">${drink.name}</h5>
                                    <p class="card-text text-muted small">${drink.description}</p>
                                    <p class="price">${drink.price} VNĐ</p>
                                    <form action="${pageContext.request.contextPath}/cart/add" method="post">
                                        <input type="hidden" name="id" value="${drink.id}">
                                        <div class="input-group">
                                            <input type="number" name="quantity" value="1" min="1" class="form-control" style="width: 70px;">
                                            <button type="submit" class="btn btn-primary">➕ Thêm vào giỏ</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <c:if test="${totalPages > 1}">
                    <nav>
                        <ul class="pagination justify-content-center">
                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                <a class="page-link" href="${pageContext.request.contextPath}/home?page=${currentPage-1}&categoryId=${selectedCategory}&keyword=${keyword}">« Trước</a>
                            </li>
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                    <a class="page-link" href="${pageContext.request.contextPath}/home?page=${i}&categoryId=${selectedCategory}&keyword=${keyword}">${i}</a>
                                </li>
                            </c:forEach>
                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                <a class="page-link" href="${pageContext.request.contextPath}/home?page=${currentPage+1}&categoryId=${selectedCategory}&keyword=${keyword}">Sau »</a>
                            </li>
                        </ul>
                    </nav>
                </c:if>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>