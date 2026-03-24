<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page isELIgnored="false" %>
<jsp:include page="/WEB-INF/jsp/layout/header.jsp" />

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card shadow-sm p-4">
                <h3 class="card-title text-center mb-4">
                    <c:choose>
                        <c:when test="${not empty drink.id}">Cập nhật thức uống</c:when>
                        <c:otherwise>Thêm mới thức uống</c:otherwise>
                    </c:choose>
                </h3>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger">${error}</div>
                </c:if>

                <form action="${pageContext.request.contextPath}/manager/drink/${not empty drink.id ? 'edit' : 'create'}" method="post" enctype="multipart/form-data">
                    <c:if test="${not empty drink.id}">
                        <input type="hidden" name="id" value="${drink.id}">
                    </c:if>

                    <div class="mb-3">
                        <label for="name" class="form-label">Tên thức uống <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="name" name="name" required value="${drink.name}">
                    </div>

                    <div class="mb-3">
                        <label for="price" class="form-label">Giá <span class="text-danger">*</span></label>
                        <input type="number" class="form-control" id="price" name="price" required min="0" step="1000" value="${drink.price}">
                    </div>

                    <div class="mb-3">
                        <label for="category" class="form-label">Danh mục <span class="text-danger">*</span></label>
                        <select class="form-select" id="category" name="categoryId" required>
                            <c:forEach var="c" items="${categories}">
                                <option value="${c.id}" <c:if test="${drink.category.id == c.id}">selected</c:if>>${c.name}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label for="description" class="form-label">Mô tả</label>
                        <textarea class="form-control" id="description" name="description" rows="3">${drink.description}</textarea>
                    </div>

                    <div class="mb-3">
                        <label for="image" class="form-label">Ảnh</label>
                        <input type="file" class="form-control" id="image" name="image" accept="image/*" onchange="previewImage(event)">
                        <c:if test="${not empty drink.image}">
                            <img id="preview" src="${pageContext.request.contextPath}/assets/uploads/${drink.image}" class="img-thumbnail mt-2" width="150">
                        </c:if>
                        <c:if test="${empty drink.image}">
                            <img id="preview" class="img-thumbnail mt-2" width="150" style="display: none;">
                        </c:if>
                    </div>

                    <div class="mb-3 form-check">
                        <input type="checkbox" class="form-check-input" id="active" name="active" <c:if test="${drink.active}">checked</c:if>>
                        <label class="form-check-label" for="active">Hoạt động</label>
                    </div>

                    <div class="d-grid">
                        <button type="submit" class="btn btn-success">
                            <c:choose>
                                <c:when test="${not empty drink.id}">Cập nhật</c:when>
                                <c:otherwise>Thêm mới</c:otherwise>
                            </c:choose>
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    function previewImage(event) {
        const reader = new FileReader();
        reader.onload = function() {
            const output = document.getElementById('preview');
            output.src = reader.result;
            output.style.display = 'block';
        };
        reader.readAsDataURL(event.target.files[0]);
    }
</script>

<jsp:include page="/WEB-INF/jsp/layout/footer.jsp" />