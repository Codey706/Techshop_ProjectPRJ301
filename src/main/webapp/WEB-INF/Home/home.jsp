<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/include/header.jsp" />
<jsp:include page="/WEB-INF/include/navbar.jsp" />

<main class="container my-5 flex-grow-1">
      <%-- Hiển thị banner --%>
    <div id="bannerCarousel" class="carousel slide mb-5 shadow-sm rounded-4 overflow-hidden" data-bs-ride="carousel" data-bs-interval="4000">
        <div class="carousel-indicators">
            <button type="button" data-bs-target="#bannerCarousel" data-bs-slide-to="0" class="active"></button>
            <button type="button" data-bs-target="#bannerCarousel" data-bs-slide-to="1"></button>
            <button type="button" data-bs-target="#bannerCarousel" data-bs-slide-to="2"></button>
            <button type="button" data-bs-target="#bannerCarousel" data-bs-slide-to="3"></button>
            <button type="button" data-bs-target="#bannerCarousel" data-bs-slide-to="4"></button>
        </div>
        <div class="carousel-inner">
            <div class="carousel-item active"><a href="#"><img src="${pageContext.request.contextPath}/assets/images/banner1.jpg" class="d-block w-100" style="max-height: 400px; object-fit: cover;" alt="B1"></a></div>
            <div class="carousel-item"><a href="#"><img src="${pageContext.request.contextPath}/assets/images/banner2.jpg" class="d-block w-100" style="max-height: 400px; object-fit: cover;" alt="B2"></a></div>
            <div class="carousel-item"><a href="#"><img src="${pageContext.request.contextPath}/assets/images/banner3.jpg" class="d-block w-100" style="max-height: 400px; object-fit: cover;" alt="B3"></a></div>
            <div class="carousel-item"><a href="#"><img src="${pageContext.request.contextPath}/assets/images/banner4.jpg" class="d-block w-100" style="max-height: 400px; object-fit: cover;" alt="B4"></a></div>
            <div class="carousel-item"><a href="#"><img src="${pageContext.request.contextPath}/assets/images/banner5.jpg" class="d-block w-100" style="max-height: 400px; object-fit: cover;" alt="B5"></a></div>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#bannerCarousel" data-bs-slide="prev"><span class="carousel-control-prev-icon bg-dark bg-opacity-25 rounded-circle p-3"></span></button>
        <button class="carousel-control-next" type="button" data-bs-target="#bannerCarousel" data-bs-slide="next"><span class="carousel-control-next-icon bg-dark bg-opacity-25 rounded-circle p-3"></span></button>
    </div>

    <h5 class="fw-bold mb-4">Sản phẩm nổi bật</h5>
    <div class="row g-4">
        
        <%-- Sử dụng c:forEach để lặp qua danh sách sản phẩm nổi bật --%>
        <c:forEach items="${featuredProducts}" var="p">
            <div class="col-12 col-sm-6 col-md-4 col-lg-3">
                <div class="card h-100 border-0 shadow-sm d-flex flex-column justify-content-between overflow-hidden">
                    <div class="p-3">
                        <div class="bg-light rounded-3 d-flex align-items-center justify-content-center" style="height: 160px;">
                            <%-- Hiển thị ảnh động từ database, nếu không có ảnh thì dùng icon mặc định --%>
                            <c:choose>
                                <c:when Bird="${not empty p.image}">
                                    <img src="${pageContext.request.contextPath}/assets/images/${p.image}" class="img-fluid h-100 object-fit-contain" alt="${p.productName}">
                                </c:when>
                                <c:otherwise>
                                    <i class="fa-solid fa-laptop fs-1 opacity-50" style="color: #0056b3;"></i>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        
                        <%-- Hiển thị tên sản phẩm và SKU/Mô tả ngắn --%>
                        <h6 class="fw-bold text-dark mt-3 mb-1 text-truncate-2" style="font-size: 14px; height: 38px; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;">
                            ${p.productName}
                        </h6>
                        <p class="text-muted small mb-0">SKU: ${p.baseSKU}</p>
                    </div>
                    
                    <div class="card-footer bg-light border-0 d-flex align-items-center justify-content-between p-3">
                        <%-- Định dạng giá tiền động bằng thẻ fmt:formatNumber --%>
                        <span class="fw-bold fs-6" style="color: #0056b3;">
                            <%-- Giá giả định --%>
                            <fmt:formatNumber value="24990000" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                        </span>
                        
                        <%-- Nút dẫn sang trang chi tiết sản phẩm dựa theo ProductId --%>
                        <a href="${pageContext.request.contextPath}/product/detail?id=${p.productId}" class="btn btn-sm text-white px-3" style="background-color: #0056b3;">
                            Mua ngay
                        </a>
                    </div>
                </div>
            </div>
        </c:forEach>
        
        <%-- Trường hợp Database trống, không có sản phẩm nào được đánh dấu IsFeatured = 1 --%>
        <c:if test="${empty featuredProducts}">
            <div class="col-12 text-center py-5">
                <p class="text-muted">Chưa có sản phẩm nổi bật nào được hiển thị.</p>
            </div>
        </c:if>
        
    </div>
  <%-- SP bán chạy, chưa code (demo) --%>
    <h5 class="fw-bold mb-4">Sản phẩm bán chạy</h5>
    <div class="row g-4">
        <div class="col-12 col-sm-6 col-md-3">
            <div class="card h-100 border-0 shadow-sm d-flex flex-column justify-content-between overflow-hidden">
                <div class="p-3">
                    <div class="bg-light rounded-3 d-flex align-items-center justify-content-center" style="height: 160px;"><i class="fa-solid fa-laptop fs-1 opacity-50" style="color: #0056b3;"></i></div>
                    <h6 class="fw-bold text-dark mt-3 mb-1 text-truncate-2" style="font-size: 14px;">Laptop Asus Zenbook 14 OLED</h6>
                    <p class="text-muted small mb-0">Core Ultra 7 / 16GB / 512GB</p>
                </div>
                <div class="card-footer bg-light border-0 d-flex align-items-center justify-content-between p-3">
                    <span class="fw-bold fs-6" style="color: #0056b3;">24.990.000đ</span>
                    <button class="btn btn-sm text-white px-3" style="background-color: #0056b3;">Mua ngay</button>
                </div>
            </div>
        </div>
    </div>
</main>

<jsp:include page="/WEB-INF/include/footer.jsp" />