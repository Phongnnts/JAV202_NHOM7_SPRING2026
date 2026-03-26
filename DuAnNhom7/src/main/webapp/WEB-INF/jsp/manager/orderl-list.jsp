<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="/WEB-INF/jsp/layout/header.jsp" />

<div class="container mt-4">
    <h2 class="mb-4">📦 Quản lý đơn hàng</h2>

    <div class="table-responsive">
        <table class="table table-bordered table-hover">
            <thead class="table-dark">
                <tr>
                    <th>Mã đơn</th>
                    <th>Khách hàng</th>
                    <th>Ngày đặt</th>
                    <th>Tổng tiền</th>
                    <th>Trạng thái</th>
                    <th>Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="bill" items="${bills}">
                    <tr>
                        <td>${bill.code}</td>
                        <td>${bill.user.fullName}</td>
                        <td><fmt:formatDate value="${bill.createdAt}" pattern="dd/MM/yyyy HH:mm"/></td>
                        <td>${bill.total} VND</td>
                        <td>
                            <c:choose>
                                <c:when test="${bill.status == 'NEW'}">
                                    <span class="badge bg-warning">Chờ xử lý</span>
                                </c:when>
                                <c:when test="${bill.status == 'CONFIRMED'}">
                                    <span class="badge bg-info">Đã xác nhận</span>
                                </c:when>
                                <c:when test="${bill.status == 'DONE'}">
                                    <span class="badge bg-success">Hoàn thành</span>
                                </c:when>
                            </c:choose>
                        </td>
                        <td>
                            <form action="${pageContext.request.contextPath}/manager/orders/update" method="post" class="d-flex gap-2">
                                <input type="hidden" name="id" value="${bill.id}">
                                <select name="status" class="form-select form-select-sm" style="width: auto;">
                                    <option value="NEW" ${bill.status == 'NEW' ? 'selected' : ''}>Chờ xử lý</option>
                                    <option value="CONFIRMED" ${bill.status == 'CONFIRMED' ? 'selected' : ''}>Đã xác nhận</option>
                                    <option value="DONE" ${bill.status == 'DONE' ? 'selected' : ''}>Hoàn thành</option>
                                </select>
                                <button type="submit" class="btn btn-sm btn-primary">Cập nhật</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<jsp:include page="/WEB-INF/jsp/layout/footer.jsp" />