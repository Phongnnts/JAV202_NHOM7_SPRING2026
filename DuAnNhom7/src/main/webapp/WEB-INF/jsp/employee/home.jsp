<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/jsp/layout/header.jsp" />

<!-- Main content -->
<div class="container mt-5 mb-5">
    <h2 class="text-center mb-4">Danh sách sản phẩm</h2>

    <div class="row row-cols-1 row-cols-md-3 row-cols-lg-4 g-4">
        <c:forEach var="d" items="${drinks}">
            <div class="col">
                <div class="card h-100 shadow-sm">
                    <img src="${pageContext.request.contextPath}/assets/uploads/${d.image}"
                         class="card-img-top" alt="${d.name}" style="height:200px; object-fit:cover;">
                    <div class="card-body d-flex flex-column">
                        <h5 class="card-title">${d.name}</h5>
                        <p class="card-text mb-1"><strong>Giá:</strong> ${d.price} VND</p>
                        <p class="card-text mb-3"><strong>Danh mục:</strong> ${d.category.name}</p>
                        <!-- Employee chỉ xem, không sửa/xóa -->
                        <a href="#" class="btn btn-primary mt-auto">Xem chi tiết</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<jsp:include page="/WEB-INF/jsp/layout/footer.jsp" />