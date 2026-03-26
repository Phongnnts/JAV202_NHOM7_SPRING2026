<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="/WEB-INF/jsp/layout/header.jsp" />

<div class="container mt-4">
    <div class="card">
        <div class="card-header bg-primary text-white">
            <h4 class="mb-0">Chi tiết đơn hàng #${bill.code}</h4>
        </div>
        <div class="card-body">
            <div class="row mb-4">
                <div class="col-md-6">
                    <h5>Thông tin khách hàng</h5>
                    <p><strong>Họ tên:</strong> ${bill.user.fullName}</p>
                    <p><strong>Email:</strong> ${bill.user.email}</p>
                    <p><strong>SĐT:</strong> ${bill.user.phone}</p>
                </div>
                <div class="col-md-6">
                    <h5>Thông tin đơn hàng</h5>
                    <p><strong>Mã đơn:</strong> ${bill.code}</p>
                    <p><strong>Ngày đặt:</strong> <fmt:formatDate value="${bill.createdAt}" pattern="dd/MM/yyyy HH:mm"/></p>
                    <p><strong>Trạng thái:</strong> ${bill.status.displayName}</p>
                </div>
            </div>

            <h5>Chi tiết sản phẩm</h5>
            <table class="table table-bordered">
                <thead class="table-dark">
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
                            <td>${detail.price} VND</td>
                            <td>${detail.price * detail.quantity} VND</td>
                        </tr>
                    </c:forEach>
                </tbody>
                <tfoot>
                    <tr class="table-info">
                        <td colspan="3" class="text-end fw-bold">Tổng cộng:</td>
                        <td class="fw-bold text-danger">${bill.total} VND</td>
                    </tr>
                </tfoot>
            </table>

            <a href="${pageContext.request.contextPath}/manager/orders" class="btn btn-secondary">Quay lại</a>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/jsp/layout/footer.jsp" />