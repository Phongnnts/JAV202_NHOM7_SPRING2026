<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page isELIgnored="false" %>
<jsp:include page="/WEB-INF/jsp/layout/header.jsp" />

<div class="container mt-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>Quản lý thức uống</h2>
        <a href="${pageContext.request.contextPath}/manager/drink/create" class="btn btn-success">
            <i class="fas fa-plus"></i> Thêm mới
        </a>
    </div>

    <!-- Search & Filter -->
    <div class="row mb-3">
        <div class="col-md-6">
            <form action="${pageContext.request.contextPath}/manager/drink/index" method="get" class="d-flex">
                <input type="text" name="keyword" class="form-control me-2" placeholder="Tên thức uống..." value="${param.keyword}">
                <button type="submit" class="btn btn-primary"><i class="fas fa-search"></i> Tìm</button>
            </form>
        </div>
        <div class="col-md-6">
            <form action="${pageContext.request.contextPath}/manager/drink/index" method="get" class="d-flex">
                <select name="categoryId" class="form-select me-2">
                    <option value="">-- Tất cả danh mục --</option>
                    <c:forEach var="cat" items="${categories}">
                        <option value="${cat.id}" ${param.categoryId == cat.id ? 'selected' : ''}>${cat.name}</option>
                    </c:forEach>
                </select>
                <button type="submit" class="btn btn-secondary">Lọc</button>
            </form>
        </div>
    </div>

    <div class="table-responsive">
        <table class="table table-bordered table-hover align-middle">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Hình ảnh</th>
                    <th>Tên</th>
                    <th>Giá</th>
                    <th>Danh mục</th>
                    <th>Trạng thái</th>
                    <th>Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="d" items="${drinks}">
                    <tr>
                        <td>${d.id}</td>
                        <td><img src="${pageContext.request.contextPath}/assets/uploads/${d.image}" width="60" height="60" style="object-fit: cover;"></td>
                        <td>${d.name}</td>
                        <td>${d.price} VND</td>
                        <td>${d.category.name}</td>
                        <td>
                            <c:choose>
                                <c:when test="${d.active}">
                                    <span class="badge bg-success">Hoạt động</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-secondary">Ngừng</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <a href="${pageContext.request.contextPath}/manager/drink/edit?id=${d.id}" class="btn btn-sm btn-primary"><i class="fas fa-edit"></i> Sửa</a>
                            <a href="${pageContext.request.contextPath}/manager/drink/delete?id=${d.id}" class="btn btn-sm btn-danger" onclick="return confirm('Bạn có chắc muốn xóa ${d.name}?');"><i class="fas fa-trash-alt"></i> Xóa</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- Pagination (similar to home page) -->
</div>

<jsp:include page="/WEB-INF/jsp/layout/footer.jsp" />