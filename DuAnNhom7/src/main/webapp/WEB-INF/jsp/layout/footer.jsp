<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page isELIgnored="false" %>
<footer class="text-dark pt-5 pb-4 mt-5" style="
    background-color: rgba(255, 255, 255, 0.8);
    backdrop-filter: blur(8px);
">
    <div class="container">
        <div class="row">
            <!-- Cột thương hiệu -->
            <div class="col-md-4 mb-4">
                <h5 class="text-success mb-3"><i class="fas fa-leaf"></i> Poly Cafe</h5>
                <p class="text-dark-50">Một ly nước ngon giúp bạn khỏe mạnh và tràn đầy năng lượng.</p>
                <div class="mt-3">
                    <a href="#" class="text-dark me-3"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" class="text-dark me-3"><i class="fab fa-twitter"></i></a>
                    <a href="#" class="text-dark me-3"><i class="fab fa-instagram"></i></a>
                    <a href="#" class="text-dark"><i class="fab fa-youtube"></i></a>
                </div>
            </div>

            <!-- Liên kết nhanh -->
            <div class="col-md-2 mb-4">
                <h6 class="text-uppercase mb-3">Liên kết nhanh</h6>
                <ul class="list-unstyled">
                    <li><a href="${pageContext.request.contextPath}/home" class="text-dark-50 text-decoration-none">Trang chủ</a></li>
                    <li><a href="${pageContext.request.contextPath}/home?category=all" class="text-dark-50 text-decoration-none">Sản phẩm</a></li>
                    <li><a href="#" class="text-dark-50 text-decoration-none">Giới thiệu</a></li>
                    <li><a href="#" class="text-dark-50 text-decoration-none">Liên hệ</a></li>
                </ul>
            </div>

            <!-- Chăm sóc khách hàng -->
            <div class="col-md-3 mb-4">
                <h6 class="text-uppercase mb-3">Chăm sóc khách hàng</h6>
                <ul class="list-unstyled">
                    <li><a href="#" class="text-dark-50 text-decoration-none">Câu hỏi thường gặp</a></li>
                    <li><a href="#" class="text-dark-50 text-decoration-none">Vận chuyển & Đổi trả</a></li>
                    <li><a href="#" class="text-dark-50 text-decoration-none">Chính sách bảo mật</a></li>
                    <li><a href="#" class="text-dark-50 text-decoration-none">Điều khoản & Điều kiện</a></li>
                </ul>
            </div>

            <!-- Thông tin liên hệ -->
            <div class="col-md-3 mb-4">
                <h6 class="text-uppercase mb-3">Liên hệ</h6>
                <ul class="list-unstyled text-dark-50">
                    <li><i class="fas fa-map-marker-alt me-2"></i> 123 Đường Cafe, Quận 1, TP.HCM</li>
                    <li><i class="fas fa-phone me-2"></i> 0909 123 456</li>
                    <li><i class="fas fa-envelope me-2"></i> poly@edu.fpt.vn</li>
                </ul>
            </div>
        </div>

        <hr class="bg-secondary mt-3">
        <div class="row">
            <div class="col text-center text-dark-50">
                <small>&copy; 2026 Poly Cafe. Bảo lưu mọi quyền.</small>
            </div>
        </div>
    </div>
</footer>