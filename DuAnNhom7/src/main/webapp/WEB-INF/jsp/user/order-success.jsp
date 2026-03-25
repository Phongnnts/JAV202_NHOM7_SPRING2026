<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đặt hàng thành công - Coffee Shop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .navbar {
            background-color: #5d4037 !important;
        }
        .navbar-brand, .nav-link {
            color: white !important;
        }
        .success-card {
            text-align: center;
            padding: 40px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 15px;
            margin-top: 50px;
        }
        .success-icon {
            font-size: 80px;
            margin-bottom: 20px;
        }
        .order-info {
            background: white;
            color: #333;
            border-radius: 10px;
            padding: 20px;
            margin-top: 30px;
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

    <div class="container">
        <div class="success-card">
            <div class="success-icon">✅</div>
            <h1>ĐẶT HÀNG THÀNH CÔNG!</h1>
            <p>Cảm ơn bạn đã đặt hàng. Chúng tôi sẽ xử lý đơn hàng của bạn sớm nhất có thể.</p>

            <div class="order-info">
                <h4>Thông tin đơn hàng</h4>
                <p><strong>Mã đơn hàng:</strong> ${bill.code}</p>
                <p><strong>Ngày đặt:</strong> <fmt:formatDate value="${bill.createdAt}" pattern="dd/MM/yyyy HH:mm"/></p>
                <p><strong>Tổng tiền:</strong> <span style="color: #e67e22; font-size: 1.5rem;">${bill.total} VNĐ</span></p>
                <p><strong>Trạng thái:</strong> ${bill.status}</p>
                <hr>
                <a href="${pageContext.request.contextPath}/home" class="btn btn-primary">Tiếp tục mua sắm</a>
                <a href="${pageContext.request.contextPath}/my-orders" class="btn btn-success">Xem đơn hàng</a>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>