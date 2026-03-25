<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đơn hàng của tôi - Coffee Shop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .navbar {
            background-color: #5d4037 !important;
        }
        .navbar-brand, .nav-link {
            color: white !important;
        }
        .order-card {
            margin-bottom: 20px;
            border-left: 4px solid #5d4037;
        }
        .status-processing {
            color: #f39c12;
            font-weight: bold;
        }
        .status-completed {
            color: #27ae60;
            font-weight: bold;
        }
        .status-cancelled {
            color: #e74c3c;
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
                        <a class="nav-link active" href="${pageContext.request.contextPath}/my-orders">Đơn hàng của tôi</a>
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
        <h2>📋 Đơn hàng của tôi</h2>

        <c:if test="${empty bills}">
            <div class="alert alert-info text-center">
                <h4>📦 Bạn chưa có đơn hàng nào</h4>
                <p>Hãy đặt hàng ngay để thưởng thức những ly đồ uống thơm ngon!</p>
                <a href="${pageContext.request.contextPath}/home" class="btn btn-primary">Mua sắm ngay</a>
            </div>
        </c:if>

        <c:if test="${not empty bills}">
            <c:forEach var="bill" items="${bills}">
                <div class="card order-card">
                    <div class="card-header bg-light">
                        <div class="row">
                            <div class="col-md-3">
                                <strong>Mã đơn hàng:</strong> ${bill.code}
                            </div>
                            <div class="col-md-3">
                                <strong>Ngày đặt:</strong> <fmt:formatDate value="${bill.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                            </div>
                            <div class="col-md-3">
                                <strong>Tổng tiền:</strong> <span class="price">${bill.total} VNĐ</span>
                            </div>
                            <div class="col-md-3">
                                <strong>Trạng thái:</strong>
                                <span class="status-${bill.status == 'Chờ xử lý' ? 'processing' : (bill.status == 'Hoàn thành' ? 'completed' : 'cancelled')}">
                                    ${bill.status}
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="card-body">
                        <table class="table table-sm">
                            <thead>
                                <tr>
                                    <th>Sản phẩm</th>
                                    <th>Số lượng</th>
                                    <th>Đơn giá</th>
                                    <th>Thành tiền</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="detail" items="${bill.billDetails}">
                                    <tr>
                                        <td>${detail.drink.name}</td>
                                        <td>${detail.quantity}</td>
                                        <td>${detail.price} VNĐ</td>
                                        <td>${detail.price * detail.quantity} VNĐ</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </c:forEach>
        </c:if>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>