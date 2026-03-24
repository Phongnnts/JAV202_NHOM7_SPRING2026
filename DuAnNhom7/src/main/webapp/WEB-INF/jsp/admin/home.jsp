<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/WEB-INF/jsp/layout/header.jsp" />

<style>
/* ===== HERO ===== */
.hero-section {
    width: 100%;
    height: 520px;
    background: linear-gradient(to right, rgba(255,255,255,0.85), rgba(255,255,255,0.2)),
    url('https://wallpapercave.com/wp/wp9322407.jpg');
    background-size: cover;
    background-position: center;

    display: flex;
    align-items: center;
}

.hero-content {
    margin-left: 80px;
    max-width: 550px;
}

.hero-title {
    font-size: 52px;
    font-weight: 700;
}

.hero-subtitle {
    margin: 20px 0;
    color: #555;
}

.btn-hero {
    padding: 12px 30px;
    border-radius: 30px;
    background: #000;
    color: #fff;
    text-decoration: none;
    transition: 0.3s;
}

.btn-hero:hover {
    background: #333;
}

/* ===== SEARCH ===== */
.search-box {
    margin-top: -60px;
    background: #fff;
    padding: 20px;
    border-radius: 15px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.08);
}

.search-input {
    border-radius: 30px;
    padding-left: 40px;
}

.search-wrapper {
    position: relative;
}

.search-wrapper i {
    position: absolute;
    left: 15px;
    top: 50%;
    transform: translateY(-50%);
    color: #aaa;
}

.select-modern {
    border-radius: 30px;
}

.btn-filter {
    border-radius: 30px;
    padding: 8px 20px;
}

/* ===== PRODUCT ===== */
.product-card {
    border-radius: 15px;
    overflow: hidden;
    background: #fff;
    transition: 0.3s;
    box-shadow: 0 5px 15px rgba(0,0,0,0.05);
}

.product-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 15px 35px rgba(0,0,0,0.1);
}

.product-img {
    height: 220px;
    object-fit: cover;
}

.product-title {
    font-size: 18px;
    font-weight: 600;
}

.product-price {
    font-weight: bold;
    color: #e74c3c;
}

/* ===== PAGINATION ===== */
.pagination .page-link {
    border-radius: 50px;
    margin: 0 5px;
}

/* ===== MOBILE ===== */
@media (max-width: 768px) {
    .hero-content {
        margin-left: 20px;
    }

    .hero-title {
        font-size: 32px;
    }

    .search-flex {
        flex-direction: column;
        gap: 10px;
    }
}
</style>

<!-- HERO -->
<div class="hero-section">
    <div class="hero-content">
        <h1 class="hero-title">Poly Cafe</h1>
        <p class="hero-subtitle">
            Poly Cafe tin rằng, nụ cười là hương vị ngọt ngào nhất trong mỗi ngày mới. Từ những ly cà phê đậm đà, những tách trà thanh mát, đến từng lời chào thân quen, chúng tôi mong mỗi vị khách khi ghé Nhà đều mang theo một niềm vui nhỏ – để rồi nụ cười ấy lại được lan toả khắp nơi.
        </p>
        <a href="${pageContext.request.contextPath}/home?category=all" class="btn-hero">
            SHOP NOW
        </a>
    </div>
</div>

<!-- SEARCH -->
<div class="container">
    <div class="search-box">
        <form action="${pageContext.request.contextPath}/home" method="get"
              class="d-flex align-items-center gap-3 search-flex">

            <div class="search-wrapper flex-grow-1">
                <i class="fas fa-search"></i>
                <input type="text" name="keyword"
                       class="form-control search-input"
                       placeholder="Tìm thức uống..."
                       value="${param.keyword}">
            </div>

            <select name="categoryId" class="form-select select-modern">
                <option value="">Tất cả danh mục</option>
                <c:forEach var="cat" items="${categories}">
                    <option value="${cat.id}"
                        ${param.categoryId == cat.id ? 'selected' : ''}>
                        ${cat.name}
                    </option>
                </c:forEach>
            </select>

            <button type="submit" class="btn btn-dark btn-filter">
                Lọc
            </button>
        </form>
    </div>
</div>

<!-- PRODUCT -->
<div class="container mt-5">
    <div class="row g-4">
        <c:forEach var="d" items="${drinks}">
            <div class="col-md-6 col-lg-3">
                <div class="product-card">
                    <img src="${pageContext.request.contextPath}/assets/uploads/${d.image}"
                         class="product-img w-100">

                    <div class="p-3">
                        <h5 class="product-title">${d.name}</h5>
                        <small class="text-muted">Danh mục:${d.category.name}</small>
                        <div class="d-flex justify-content-between align-items-center mt-2">
                            <span class="product-price">${d.price} VND</span>
                            <a href="${pageContext.request.contextPath}/home/detail?id=${d.id}"
                               class="btn btn-sm btn-outline-dark">
                                View
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <!-- PAGINATION -->
    <c:if test="${totalPages > 1}">
        <nav class="mt-5">
            <ul class="pagination justify-content-center">
                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                    <a class="page-link"
                       href="?page=${currentPage-1}&keyword=${param.keyword}&categoryId=${param.categoryId}">
                        Trước
                    </a>
                </li>

                <c:forEach begin="1" end="${totalPages}" var="i">
                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                        <a class="page-link"
                           href="?page=${i}&keyword=${param.keyword}&categoryId=${param.categoryId}">
                            ${i}
                        </a>
                    </li>
                </c:forEach>

                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                    <a class="page-link"
                       href="?page=${currentPage+1}&keyword=${param.keyword}&categoryId=${param.categoryId}">
                        Sau
                    </a>
                </li>
            </ul>
        </nav>
    </c:if>
</div>

<jsp:include page="/WEB-INF/jsp/layout/footer.jsp" />