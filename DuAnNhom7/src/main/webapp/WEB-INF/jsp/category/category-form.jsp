<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page isELIgnored="false" %>

<jsp:include page="/WEB-INF/jsp/layout/header.jsp" />

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow-sm p-4">
                <h3 class="card-title text-center mb-4">
                    <c:choose>
                        <c:when test="${not empty item.id}">Cập nhật danh mục</c:when>
                        <c:otherwise>Thêm mới danh mục</c:otherwise>
                    </c:choose>
                </h3>

                <form action="${pageContext.request.contextPath}/manager/category/${not empty item.id ? 'edit' : 'create'}" method="post">
                    <c:if test="${not empty item.id}">
                        <input type="hidden" name="id" value="${item.id}">
                    </c:if>

                    <div class="mb-3">
                        <label for="name" class="form-label">Tên danh mục</label>
                        <input type="text" class="form-control" id="name" name="name" required value="${item.name}">
                    </div>

                    <div class="mb-3">
                        <label for="description" class="form-label">Mô tả</label>
                        <textarea class="form-control" id="description" name="description" rows="3">${item.description}</textarea>
                    </div>

                    <div class="mb-3 form-check">
                        <input type="checkbox" class="form-check-input" id="active" name="active" <c:if test="${item.active}">checked</c:if>>
                        <label class="form-check-label" for="active">Active</label>
                    </div>

                    <div class="d-grid">
                        <button type="submit" class="btn btn-success">
                            <c:choose>
                                <c:when test="${not empty item.id}">Cập nhật</c:when>
                                <c:otherwise>Thêm mới</c:otherwise>
                            </c:choose>
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/jsp/layout/footer.jsp" />