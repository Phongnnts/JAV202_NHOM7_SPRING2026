<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page isELIgnored="false" %>
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
    <div class="container">
        <a class="navbar-brand fw-bold text-success" href="${pageContext.request.contextPath}/home">
            <i class="fa fa-coffee"></i> Cafe Poly
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav mx-auto">
                <li class="nav-item dropdown">


                </li>
                <li class="nav-item dropdown">

                    <ul class="dropdown-menu" aria-labelledby="shopDropdown">
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/home">All Products</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <c:forEach var="cat" items="${categories}">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/home?categoryId=${cat.id}">${cat.name}</a></li>
                        </c:forEach>
                    </ul>
                </li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/home">Trang Chủ</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/manager/drink/index">Category</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/manager/category/index">Drink</a></li>
                 <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/manager/category/index">Giỏ hàng</a></li>
                  <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/manager/category/index">Về chúng tôi</a></li>
                   <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/manager/category/index">Liên hệ</a></li>


            </ul>
            <ul class="navbar-nav ms-auto">
                <c:if test="${not empty sessionScope.user}">
                    <li class="nav-item"><a class="nav-link" href="#">Xin Chào đây là role : ${sessionScope.user.fullName}</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/auth/login">Logout</a></li>
                </c:if>
                <c:if test="${empty sessionScope.user}">
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/auth/login">Login</a></li>
                </c:if>
            </ul>
        </div>
    </div>
</nav>