<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="/WEB-INF/jsp/layout/header.jsp" />

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<div class="container mt-5">
    <div class="card shadow-lg rounded-4 border-0">
        <div class="card-header bg-primary text-white rounded-top-4">
            <h4 class="mb-0">
                ${drink != null ? "Cập nhật đồ uống" : "Thêm đồ uống"}
            </h4>
        </div>

        <div class="card-body p-4">

            <form method="post" enctype="multipart/form-data"
                  action="${pageContext.request.contextPath}/admin/drink/${drink != null ? 'edit' : 'create'}">

                <input type="hidden" name="id" value="${drink.id}"/>

                <!-- Name -->
                <div class="mb-3">
                    <label class="form-label">Tên</label>
                    <input type="text" name="name" class="form-control"
                           value="${drink.name}" required>
                </div>

                <!-- Price -->
                <div class="mb-3">
                    <label class="form-label">Giá</label>
                    <input type="number" name="price" class="form-control"
                           value="${drink.price}" required>
                </div>

                <!-- Image Upload -->
                <div class="mb-3">
                    <label class="form-label">Hình ảnh</label>
                    <input type="file" name="imageFile" class="form-control" accept="image/*" 
                           ${drink == null ? 'required' : ''}>
                    <small class="text-muted">Chọn file ảnh (JPG, PNG, GIF)</small>
                    
                    <!-- Preview ảnh cũ khi edit -->
                    <c:if test="${drink != null && not empty drink.image}">
                        <div class="mt-2">
                            <label class="form-label">Ảnh hiện tại:</label>
                            <div>
                                <img src="${pageContext.request.contextPath}/assets/uploads/${drink.image}"
                                     style="max-height: 150px; border-radius: 8px;"
                                     alt="${drink.name}">
                                <input type="hidden" name="oldImage" value="${drink.image}">
                            </div>
                        </div>
                    </c:if>
                </div>

                <!-- Description -->
                <div class="mb-3">
                    <label class="form-label">Mô tả</label>
                    <textarea name="description" class="form-control" rows="3">${drink.description}</textarea>
                </div>

                <!-- Category -->
                <div class="mb-3">
                    <label class="form-label">Danh mục</label>
                    <select name="categoryId" class="form-select" required>
                        <option value="">-- Chọn danh mục --</option>
                        <c:forEach var="c" items="${categories}">
                            <option value="${c.id}"
                                ${drink != null && drink.category.id == c.id ? "selected" : ""}>
                                ${c.name}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <!-- Active -->
                <div class="form-check mb-3">
                    <input type="checkbox" name="active" class="form-check-input" value="true"
                        ${drink != null && drink.active ? "checked" : ""}>
                    <label class="form-check-label">Hoạt động</label>
                </div>

                <!-- Buttons -->
                <div class="d-flex justify-content-between">
                    <a href="${pageContext.request.contextPath}/admin/drink/list"
                       class="btn btn-secondary">Quay lại</a>

                    <button type="submit" class="btn btn-success">
                        ${drink != null ? "Cập nhật" : "Thêm mới"}
                    </button>
                </div>

            </form>

        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/jsp/layout/footer.jsp" />