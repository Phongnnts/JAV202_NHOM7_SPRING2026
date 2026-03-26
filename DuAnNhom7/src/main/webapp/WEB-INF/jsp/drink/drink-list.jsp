<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/WEB-INF/jsp/layout/header.jsp" />

<div class="container mt-4">

    <h2 class="mb-4">Quản lý đồ uống</h2>

<div class="alert alert-info rounded-4 shadow-sm p-4 border-0"
     style="background: linear-gradient(135deg, #e3f2fd, #f8fbff);">

    <div class="row">
        <div class="col-md-6">
            <p><strong>Tổng Số Đồ Uống:</strong> ${totalDrinks}</p>
            <p><strong>Tổng Số Đồ Uống Còn Bán:</strong>
<span class="badge bg-success">${activeDrinks}</span>

            </p>
             <p><strong>Tổng Số Đồ Uống Đã Hết:</strong>
                            <span class="badge bg-danger">${totalDrinks - activeDrinks}</span>

        </div>

        <div class="col-md-6">
            <p><strong>Tổng Số Loại:</strong> ${categories.size()}</p>
            <p><strong>Page:</strong> ${currentPage} / ${totalPages}</p>
        </div>
    </div>
</div>

    <!-- BUTTON CREATE -->
    <div class="mb-3">
        <a href="${pageContext.request.contextPath}/admin/drink/create"
           class="btn btn-success">
            + Thêm đồ uống
        </a>
    </div>

    <!-- SEARCH FORM -->
    <form method="get" action="${pageContext.request.contextPath}/admin/drink/list"
          class="row g-3 mb-4">
        <div class="col-md-4">
            <input type="text" name="keyword" class="form-control"
                   placeholder="Tìm đồ uống..." value="${param.keyword}">
        </div>
        <div class="col-md-3">
            <select name="categoryId" class="form-select">
                <option value="">Tất cả danh mục</option>
                <c:forEach var="c" items="${categories}">
                    <option value="${c.id}"
                        ${param.categoryId == c.id ? 'selected' : ''}>
                        ${c.name}
                    </option>
                </c:forEach>
            </select>
        </div>
        <div class="col-md-2">
            <button class="btn btn-dark w-100">Lọc</button>
        </div>
    </form>

    <!-- TABLE -->
    <table class="table table-bordered table-hover text-center">
        <thead class="table-dark">
        陀
            <th>ID</th>
            <th>Hình</th>
            <th>Tên</th>
            <th>Giá</th>
            <th>Danh mục</th>
            <th>Trạng thái</th>
            <th>Hành động</th>
        </tr>
        </thead>
        <tbody>
        <c:choose>
            <c:when test="${empty drinks}">
                <tr>
                    <td colspan="7" class="text-center text-danger">
                        <strong>Không có dữ liệu!</strong><br>
                        Vui lòng kiểm tra lại database hoặc thêm mới đồ uống.
                    </td>
                </tr>
            </c:when>
            <c:otherwise>
                <c:forEach var="d" items="${drinks}">
                    <tr>
                        <td>${d.id}</td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty d.image}">
                                    <img src="${pageContext.request.contextPath}/assets/uploads/${d.image}"
                                         width="80" height="80" style="object-fit:cover;">
                                </c:when>
                                <c:otherwise>
                                    <img src="${pageContext.request.contextPath}/assets/images/no-image.png"
                                         width="80" height="80" style="object-fit:cover;">
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>${d.name}</td>
                        <td>${d.price} VND</td>
                        <td>${d.category.name}</td>
                        <td>
                            <c:choose>
                                <c:when test="${d.active}">
                                    <span class="badge bg-success">Kích hoạt</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-danger">Vô hiệu</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/drink/edit?id=${d.id}"
                               class="btn btn-warning btn-sm">Sửa</a>
                            <a href="${pageContext.request.contextPath}/admin/drink/delete?id=${d.id}"
                               class="btn btn-danger btn-sm"
                               onclick="return confirm('Xóa đồ uống này?')">
                                Xóa
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </c:otherwise>
        </c:choose>
        </tbody>
    </table>

    <!-- PAGINATION -->
    <c:if test="${totalPages > 1}">
        <nav>
            <ul class="pagination justify-content-center">
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                        <a class="page-link"
                           href="${pageContext.request.contextPath}/admin/drink/list?page=${i}&keyword=${param.keyword}&categoryId=${param.categoryId}">
                            ${i}
                        </a>
                    </li>
                </c:forEach>
            </ul>
        </nav>
    </c:if>
</div>

<jsp:include page="/WEB-INF/jsp/layout/footer.jsp" />