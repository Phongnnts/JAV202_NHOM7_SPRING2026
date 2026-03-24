<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/WEB-INF/jsp/layout/header.jsp" />

<div class="container mt-5 mb-5">
    <h2 class="text-center mb-4">☕ Danh sách sản phẩm</h2>

    <!-- Search and filter -->
    <div class="row mb-4">
        <div class="col-md-6">
            <form action="${pageContext.request.contextPath}/home" method="get" class="d-flex">
                <input type="text" name="keyword" class="form-control me-2" placeholder="Tìm thức uống..." value="${param.keyword}">
                <button type="submit" class="btn btn-primary"><i class="fas fa-search"></i> Tìm</button>
            </form>
        </div>
        <div class="col-md-6">
            <form action="${pageContext.request.contextPath}/home" method="get" class="d-flex">
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

    <div class="row row-cols-1 row-cols-md-3 row-cols-lg-4 g-4">
        <c:forEach var="d" items="${drinks}">
            <div class="col">
                <div class="card h-100 shadow-sm">
                    <img src="${pageContext.request.contextPath}/assets/uploads/${d.image}" class="card-img-top" alt="${d.name}" style="height: 200px; object-fit: cover;">
                    <div class="card-body d-flex flex-column">
                        <h5 class="card-title">${d.name}</h5>
                        <p class="card-text mb-1"><strong>Giá:</strong> <span class="text-danger fw-bold">${d.price} VND</span></p>
                        <p class="card-text"><strong>Danh mục:</strong> ${d.category.name}</p>
                        <a href="${pageContext.request.contextPath}/home/detail?id=${d.id}" class="btn btn-outline-primary mt-auto">Xem chi tiết</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <!-- Pagination -->
    <c:if test="${totalPages > 1}">
        <nav aria-label="Page navigation" class="mt-4">
            <ul class="pagination justify-content-center">
                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                    <a class="page-link" href="?page=${currentPage-1}&keyword=${param.keyword}&categoryId=${param.categoryId}">Trước</a>
                </li>
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                        <a class="page-link" href="?page=${i}&keyword=${param.keyword}&categoryId=${param.categoryId}">${i}</a>
                    </li>
                </c:forEach>
                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                    <a class="page-link" href="?page=${currentPage+1}&keyword=${param.keyword}&categoryId=${param.categoryId}">Sau</a>
                </li>
            </ul>
        </nav>
    </c:if>
</div>

<jsp:include page="/WEB-INF/jsp/layout/footer.jsp" />