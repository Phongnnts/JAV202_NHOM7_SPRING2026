<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/WEB-INF/jsp/layout/header.jsp" />

<div class="container mt-4">

    <h2 class="mb-4">Quản lý sản phẩm</h2>

    <!-- BUTTON CREATE -->
    <div class="mb-3">
        <a href="${pageContext.request.contextPath}/admin/drink/create"
           class="btn btn-success">
            + Thêm sản phẩm
        </a>
    </div>

    <!-- SEARCH -->
    <form method="get" action="${pageContext.request.contextPath}/admin/drink/list"
          class="row g-3 mb-4">

        <div class="col-md-4">
            <input type="text" name="keyword" class="form-control"
                   placeholder="Tìm sản phẩm..." value="${param.keyword}">
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
        <tr>
            <th>ID</th>
            <th>Hình</th>
            <th>Tên</th>
            <th>Giá</th>
            <th>Danh mục</th>
            <th>Hành động</th>
        </tr>
        </thead>

        <tbody>
        <c:forEach var="d" items="${drinks}">
            <tr>
                <td>${d.id}</td>

                <!-- IMAGE -->
                <td>
                    <img src="${pageContext.request.contextPath}/assets/uploads/${d.image}"
                         width="80" height="80" style="object-fit:cover;">
                </td>

                <td>${d.name}</td>
                <td>${d.price} VND</td>
                <td>${d.category.name}</td>

                <td>
                    <a href="${pageContext.request.contextPath}/admin/drink/edit?id=${d.id}"
                       class="btn btn-warning btn-sm">Edit</a>

                    <a href="${pageContext.request.contextPath}/admin/drink/delete?id=${d.id}"
                       class="btn btn-danger btn-sm"
                       onclick="return confirm('Xóa sản phẩm?')">
                        Delete
                    </a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <!-- PAGINATION -->
    <c:if test="${totalPages > 1}">
        <nav>
            <ul class="pagination justify-content-center">
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                        <a class="page-link"
                           href="?page=${i}&keyword=${param.keyword}&categoryId=${param.categoryId}">
                            ${i}
                        </a>
                    </li>
                </c:forEach>
            </ul>
        </nav>
    </c:if>

</div>

<jsp:include page="/WEB-INF/jsp/layout/footer.jsp" />