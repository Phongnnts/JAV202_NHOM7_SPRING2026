<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page isELIgnored="false" %>
<jsp:include page="/WEB-INF/jsp/layout/header.jsp" />

<style>
    /* Dark glassmorphism card */
    .glass-card {
        background: rgba(20, 20, 20, 0.7); /* nền tối, mờ 70% */
        backdrop-filter: blur(12px);
        border-radius: 15px;
        border: 1px solid rgba(255, 255, 255, 0.1); /* viền mờ sáng */
        color: #f0f0f0; /* chữ sáng nổi trên nền tối */
    }

    .glass-card .form-control,
    .glass-card .form-select,
    .glass-card textarea {
        background: rgba(50, 50, 50, 0.6); /* input nền tối trong suốt */
        border: 1px solid rgba(255, 255, 255, 0.15);
        color: #f0f0f0;
        backdrop-filter: blur(5px);
    }

    .glass-card .form-control:focus,
    .glass-card .form-select:focus,
    .glass-card textarea:focus {
        box-shadow: 0 0 10px rgba(255, 255, 255, 0.2);
        border-color: rgba(255, 255, 255, 0.3);
    }

    .glass-card .btn-success {
        background: rgba(0, 128, 0, 0.7);
        border: none;
        color: white;
        backdrop-filter: blur(5px);
    }

    .glass-card .btn-success:hover {
        background: rgba(0, 128, 0, 0.9);
    }

    .glass-card .alert {
        background: rgba(255, 0, 0, 0.3);
        color: #ffcccc;
        border: 1px solid rgba(255, 0, 0, 0.2);
    }

    /* Dark glass footer */
    footer.glass-footer {
        background: rgba(30, 30, 30, 0.7);
        backdrop-filter: blur(10px);
        color: #f0f0f0;
    }

    footer.glass-footer a {
        color: #d0d0d0;
    }

    footer.glass-footer a:hover {
        color: #ffffff;
        text-decoration: none;
    }
</style>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card shadow-sm p-4 glass-card">
                <h3 class="card-title text-center mb-4">
                    <c:choose>
                        <c:when test="${not empty drink.id}">Cập nhật thức uống</c:when>
                        <c:otherwise>Thêm mới thức uống</c:otherwise>
                    </c:choose>
                </h3>

                <c:if test="${not empty error}">
                    <div class="alert">${error}</div>
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


<jsp:include page="/WEB-INF/jsp/layout/footer.jsp" />