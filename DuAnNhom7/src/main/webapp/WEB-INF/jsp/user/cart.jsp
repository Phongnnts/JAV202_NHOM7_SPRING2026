<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Giỏ hàng - Coffee Shop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .navbar {
            background-color: #5d4037 !important;
        }
        .navbar-brand, .nav-link {
            color: white !important;
        }
        .cart-img {
            width: 50px;
            height: 50px;
            object-fit: cover;
            border-radius: 5px;
        }
        .total-price {
            font-size: 1.5rem;
            color: #e67e22;
            font-weight: bold;
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
                        <a class="nav-link" href="${pageContext.request.contextPath}/cart/view">🛒 Giỏ hàng</a>
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
        <h2>🛒 Giỏ hàng của bạn</h2>

        <c:if test="${param.error != null}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                Có lỗi xảy ra khi đặt hàng. Vui lòng thử lại!
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <c:if test="${empty cartItems}">
            <div class="alert alert-info text-center">
                <h4>🛍️ Giỏ hàng trống</h4>
                <p>Hãy thêm đồ uống vào giỏ hàng để tiếp tục mua sắm!</p>
                <a href="${pageContext.request.contextPath}/home" class="btn btn-primary">Tiếp tục mua sắm</a>
            </div>
        </c:if>

        <c:if test="${not empty cartItems}">
            <div class="table-responsive">
                <table class="table table-bordered">
                    <thead class="table-dark">