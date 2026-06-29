<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/home.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/product-suggestions.css">

<jsp:include page="/WEB-INF/include/header.jsp" />
<jsp:include page="/WEB-INF/include/navbar.jsp" />

<main class="container my-5 flex-grow-1">

    <%-- =========================================
         CAROUSEL BANNER 
         ========================================= --%>
    <div id="bannerCarousel" class="carousel slide mb-5 shadow-sm rounded-4 overflow-hidden" data-bs-ride="carousel" data-bs-interval="4000">
        <div class="carousel-indicators">
            <button type="button" data-bs-target="#bannerCarousel" data-bs-slide-to="0" class="active"></button>
            <button type="button" data-bs-target="#bannerCarousel" data-bs-slide-to="1"></button>
            <button type="button" data-bs-target="#bannerCarousel" data-bs-slide-to="2"></button>
            <button type="button" data-bs-target="#bannerCarousel" data-bs-slide-to="3"></button>
            <button type="button" data-bs-target="#bannerCarousel" data-bs-slide-to="4"></button>
        </div>
        <div class="carousel-inner">
            <div class="carousel-item active">
                <a href="#"><img src="${pageContext.request.contextPath}/assets/images/banner1.jpg" class="d-block w-100" style="max-height: 400px; object-fit: cover;" alt="B1"></a>
            </div>
            <div class="carousel-item">
                <a href="#"><img src="${pageContext.request.contextPath}/assets/images/banner2.jpg" class="d-block w-100" style="max-height: 400px; object-fit: cover;" alt="B2"></a>
            </div>
            <div class="carousel-item">
                <a href="#"><img src="${pageContext.request.contextPath}/assets/images/banner3.jpg" class="d-block w-100" style="max-height: 400px; object-fit: cover;" alt="B3"></a>
            </div>
            <div class="carousel-item">
                <a href="#"><img src="${pageContext.request.contextPath}/assets/images/banner4.jpg" class="d-block w-100" style="max-height: 400px; object-fit: cover;" alt="B4"></a>
            </div>
            <div class="carousel-item">
                <a href="#"><img src="${pageContext.request.contextPath}/assets/images/banner5.jpg" class="d-block w-100" style="max-height: 400px; object-fit: cover;" alt="B5"></a>
            </div>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#bannerCarousel" data-bs-slide="prev"><span class="carousel-control-prev-icon bg-dark bg-opacity-25 rounded-circle p-3"></span></button>
        <button class="carousel-control-next" type="button" data-bs-target="#bannerCarousel" data-bs-slide="next"><span class="carousel-control-next-icon bg-dark bg-opacity-25 rounded-circle p-3"></span></button>
    </div>

    <%-- =========================================
         DANH MỤC NỔI BẬT (Grid Layout)
         ========================================= --%>
    <h5 class="fw-bold mb-4" data-vi="Danh mục nổi bật" data-en="Featured Categories">Danh mục nổi bật</h5>

    <div class="row row-cols-2 row-cols-sm-4 row-cols-md-6 row-cols-lg-8 g-4 mb-5 text-center">
        <div class="col">
            <a href="${pageContext.request.contextPath}/product/search?category=laptop-nhap-khau" class="text-decoration-none text-dark d-flex flex-column align-items-center h-100 category-item">
                <div class="p-2 d-flex align-items-center justify-content-center" style="height: 100px; width: 100px;">
                    <img src="${pageContext.request.contextPath}/assets/images/categories/laptop-nk.png" alt="Laptop" class="img-fluid object-fit-contain" style="max-height: 80px;">
                </div>
                <span class="fw-bold small mt-2 d-block" data-vi="Laptop nhập khẩu" data-en="Imported Laptops">Laptop nhập khẩu</span>
            </a>
        </div>

        <div class="col">
            <a href="${pageContext.request.contextPath}/product/search?category=laptop-chinh-hang" class="text-decoration-none text-dark d-flex flex-column align-items-center h-100 category-item">
                <div class="p-2 d-flex align-items-center justify-content-center" style="height: 100px; width: 100px;">
                    <img src="${pageContext.request.contextPath}/assets/images/categories/laptop-ch.png" alt="Laptop" class="img-fluid object-fit-contain" style="max-height: 80px;">
                </div>
                <span class="fw-bold small mt-2 d-block" data-vi="Laptop chính hãng" data-en="Official Laptops">Laptop chính hãng</span>
            </a>
        </div>

        <div class="col">
            <a href="${pageContext.request.contextPath}/product/search?category=man-hinh-di-dong" class="text-decoration-none text-dark d-flex flex-column align-items-center h-100 category-item">
                <div class="p-2 d-flex align-items-center justify-content-center" style="height: 100px; width: 100px;">
                    <img src="${pageContext.request.contextPath}/assets/images/categories/man-hinh-dd.png" alt="Monitor" class="img-fluid object-fit-contain" style="max-height: 80px;">
                </div>
                <span class="fw-bold small mt-2 d-block" data-vi="Màn hình di động" data-en="Portable Monitors">Màn hình di động</span>
            </a>
        </div>

        <div class="col">
            <a href="${pageContext.request.contextPath}/product/search?category=man-hinh" class="text-decoration-none text-dark d-flex flex-column align-items-center h-100 category-item">
                <div class="p-2 d-flex align-items-center justify-content-center" style="height: 100px; width: 100px;">
                    <img src="${pageContext.request.contextPath}/assets/images/categories/man-hinh.png" alt="Monitor" class="img-fluid object-fit-contain" style="max-height: 80px;">
                </div>
                <span class="fw-bold small mt-2 d-block" data-vi="Màn hình" data-en="Monitors">Màn hình</span>
            </a>
        </div>

        <div class="col">
            <a href="${pageContext.request.contextPath}/product/search?category=ban-phim" class="text-decoration-none text-dark d-flex flex-column align-items-center h-100 category-item">
                <div class="p-2 d-flex align-items-center justify-content-center" style="height: 100px; width: 100px;">
                    <img src="${pageContext.request.contextPath}/assets/images/categories/ban-phim.png" alt="Keyboard" class="img-fluid object-fit-contain" style="max-height: 80px;">
                </div>
                <span class="fw-bold small mt-2 d-block" data-vi="Bàn phím" data-en="Keyboards">Bàn phím</span>
            </a>
        </div>

        <div class="col">
            <a href="${pageContext.request.contextPath}/product/search?category=chuot" class="text-decoration-none text-dark d-flex flex-column align-items-center h-100 category-item">
                <div class="p-2 d-flex align-items-center justify-content-center" style="height: 100px; width: 100px;">
                    <img src="${pageContext.request.contextPath}/assets/images/categories/chuot.png" alt="Mouse" class="img-fluid object-fit-contain" style="max-height: 80px;">
                </div>
                <span class="fw-bold small mt-2 d-block" data-vi="Chuột" data-en="Mice">Chuột</span>
            </a>
        </div>

        <div class="col">
            <a href="${pageContext.request.contextPath}/product/search?category=balo-tui" class="text-decoration-none text-dark d-flex flex-column align-items-center h-100 category-item">
                <div class="p-2 d-flex align-items-center justify-content-center" style="height: 100px; width: 100px;">
                    <img src="${pageContext.request.contextPath}/assets/images/categories/balo.png" alt="Bags" class="img-fluid object-fit-contain" style="max-height: 80px;">
                </div>
                <span class="fw-bold small mt-2 d-block" data-vi="Balo, Túi" data-en="Backpacks & Bags">Balo, Túi</span>
            </a>
        </div>

        <div class="col">
            <a href="${pageContext.request.contextPath}/product/search?category=ghe-cong-thai-hoc" class="text-decoration-none text-dark d-flex flex-column align-items-center h-100 category-item">
                <div class="p-2 d-flex align-items-center justify-content-center" style="height: 100px; width: 100px;">
                    <img src="${pageContext.request.contextPath}/assets/images/categories/ghe.png" alt="Chair" class="img-fluid object-fit-contain" style="max-height: 80px;">
                </div>
                <span class="fw-bold small mt-2 d-block" data-vi="Ghế công thái học" data-en="Ergonomic Chairs">Ghế công thái học</span>
            </a>
        </div>

        <div class="col">
            <a href="${pageContext.request.contextPath}/product/search?category=ban-nang-ha" class="text-decoration-none text-dark d-flex flex-column align-items-center h-100 category-item">
                <div class="p-2 d-flex align-items-center justify-content-center" style="height: 100px; width: 100px;">
                    <img src="${pageContext.request.contextPath}/assets/images/categories/ban.png" alt="Desk" class="img-fluid object-fit-contain" style="max-height: 80px;">
                </div>
                <span class="fw-bold small mt-2 d-block" data-vi="Bàn nâng hạ" data-en="Standing Desks">Bàn nâng hạ</span>
            </a>
        </div>

        <div class="col">
            <a href="${pageContext.request.contextPath}/product/search?category=hoc-tu" class="text-decoration-none text-dark d-flex flex-column align-items-center h-100 category-item">
                <div class="p-2 d-flex align-items-center justify-content-center" style="height: 100px; width: 100px;">
                    <img src="${pageContext.request.contextPath}/assets/images/categories/tu.png" alt="Cabinet" class="img-fluid object-fit-contain" style="max-height: 80px;">
                </div>
                <span class="fw-bold small mt-2 d-block" data-vi="Hộc tủ" data-en="Cabinets">Hộc tủ</span>
            </a>
        </div>

        <div class="col">
            <a href="${pageContext.request.contextPath}/product/search?category=mini-pc" class="text-decoration-none text-dark d-flex flex-column align-items-center h-100 category-item">
                <div class="p-2 d-flex align-items-center justify-content-center" style="height: 100px; width: 100px;">
                    <img src="${pageContext.request.contextPath}/assets/images/categories/mini-pc.png" alt="Mini PC" class="img-fluid object-fit-contain" style="max-height: 80px;">
                </div>
                <span class="fw-bold small mt-2 d-block" data-vi="Mini PC" data-en="Mini PC">Mini PC</span>
            </a>
        </div>

        <div class="col">
            <a href="${pageContext.request.contextPath}/product/search?category=bao-da-op-lung" class="text-decoration-none text-dark d-flex flex-column align-items-center h-100 category-item">
                <div class="p-2 d-flex align-items-center justify-content-center" style="height: 100px; width: 100px;">
                    <img src="${pageContext.request.contextPath}/assets/images/categories/op-lung.png" alt="Case" class="img-fluid object-fit-contain" style="max-height: 80px;">
                </div>
                <span class="fw-bold small mt-2 d-block" data-vi="Bao da ốp lưng" data-en="Cases & Covers">Bao da ốp lưng</span>
            </a>
        </div>

        <div class="col">
            <a href="${pageContext.request.contextPath}/product/search?category=dan-man-hinh" class="text-decoration-none text-dark d-flex flex-column align-items-center h-100 category-item">
                <div class="p-2 d-flex align-items-center justify-content-center" style="height: 100px; width: 100px;">
                    <img src="${pageContext.request.contextPath}/assets/images/categories/dan-mh.png" alt="Screen Protector" class="img-fluid object-fit-contain" style="max-height: 80px;">
                </div>
                <span class="fw-bold small mt-2 d-block" data-vi="Dán màn hình" data-en="Screen Protectors">Dán màn hình</span>
            </a>
        </div>

        <div class="col">
            <a href="${pageContext.request.contextPath}/product/search?category=phu-kien-setup" class="text-decoration-none text-dark d-flex flex-column align-items-center h-100 category-item">
                <div class="p-2 d-flex align-items-center justify-content-center" style="height: 100px; width: 100px;">
                    <img src="${pageContext.request.contextPath}/assets/images/categories/phu-kien.png" alt="Setup" class="img-fluid object-fit-contain" style="max-height: 80px;">
                </div>
                <span class="fw-bold small mt-2 d-block" data-vi="Phụ kiện Setup" data-en="Setup Accessories">Phụ kiện Setup</span>
            </a>
        </div>

        <div class="col">
            <a href="${pageContext.request.contextPath}/product/search?category=merchandise" class="text-decoration-none text-dark d-flex flex-column align-items-center h-100 category-item">
                <div class="p-2 d-flex align-items-center justify-content-center" style="height: 100px; width: 100px;">
                    <img src="${pageContext.request.contextPath}/assets/images/categories/merch.png" alt="Merch" class="img-fluid object-fit-contain" style="max-height: 80px;">
                </div>
                <span class="fw-bold small mt-2 d-block" data-vi="Merchandise" data-en="Merchandise">Merchandise</span>
            </a>
        </div>

        <div class="col">
            <a href="${pageContext.request.contextPath}/product/search?category=phan-mem" class="text-decoration-none text-dark d-flex flex-column align-items-center h-100 category-item">
                <div class="p-2 d-flex align-items-center justify-content-center" style="height: 100px; width: 100px;">
                    <img src="${pageContext.request.contextPath}/assets/images/categories/software.png" alt="Software" class="img-fluid object-fit-contain" style="max-height: 80px;">
                </div>
                <span class="fw-bold small mt-2 d-block" data-vi="Phần mềm" data-en="Software">Phần mềm</span>
            </a>
        </div>

        <div class="col">
            <a href="${pageContext.request.contextPath}/product/search?category=loa-bluetooth" class="text-decoration-none text-dark d-flex flex-column align-items-center h-100 category-item">
                <div class="p-2 d-flex align-items-center justify-content-center" style="height: 100px; width: 100px;">
                    <img src="${pageContext.request.contextPath}/assets/images/categories/loa.png" alt="Speaker" class="img-fluid object-fit-contain" style="max-height: 80px;">
                </div>
                <span class="fw-bold small mt-2 d-block" data-vi="Loa Bluetooth" data-en="Bluetooth Speakers">Loa Bluetooth</span>
            </a>
        </div>

        <div class="col">
            <a href="${pageContext.request.contextPath}/product/search?category=tay-cam-choi-game" class="text-decoration-none text-dark d-flex flex-column align-items-center h-100 category-item">
                <div class="p-2 d-flex align-items-center justify-content-center" style="height: 100px; width: 100px;">
                    <img src="${pageContext.request.contextPath}/assets/images/categories/tay-cam.png" alt="Gamepad" class="img-fluid object-fit-contain" style="max-height: 80px;">
                </div>
                <span class="fw-bold small mt-2 d-block" data-vi="Tay cầm chơi game" data-en="Gamepads">Tay cầm chơi game</span>
            </a>
        </div>
    </div> 

    <%-- SẢN PHẨM BÁN CHẠY --%>
    <h5 class="fw-bold mb-4" data-vi="Sản phẩm bán chạy" data-en="Best Sellers">Sản phẩm bán chạy</h5>
    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-4" id="best-seller-grid">
        <c:forEach var="p" items="${bestSellers}" varStatus="status">
            <%-- Ẩn các sản phẩm từ vị trí thứ 6 trở đi --%>
            <div class="col product-card-item ${status.index >= 6 ? 'product-hidden' : ''}">
                <div class="card h-100 border-0 shadow-sm p-3">
                    <img src="${pageContext.request.contextPath}/assets/images/products/${not empty p.imageUrl ? p.imageUrl : 'default-product.png'}" class="img-fluid" style="height: 200px; object-fit: contain;">
                    <h6 class="fw-bold mt-3">${p.productName}</h6>
                    <span class="fw-bold text-primary"><fmt:formatNumber value="${p.price}" type="number" maxFractionDigits="0"/>đ</span>
                </div>
            </div>
        </c:forEach>
    </div>
    
    <%-- Nút Xem thêm dùng ảnh mascot của bạn --%>
    <div class="text-center my-5">
        <a href="javascript:void(0);" id="load-more-best-seller" class="btn-view-more-wrapper">
            <img src="${pageContext.request.contextPath}/assets/images/view-more-mascot.jpg" 
                 alt="Xem thêm" class="view-more-img" 
                 data-vi="${pageContext.request.contextPath}/assets/images/view-more-mascot.jpg"
                 data-en="${pageContext.request.contextPath}/assets/images/view-more-mascot-en.jpg">
        </a>
    </div>

    <%-- GỢI Ý CHO BẠN --%>
    <h3 class="fw-bold text-center mb-4" data-vi="Gợi ý cho bạn" data-en="Recommended for You">Gợi ý cho bạn</h3>
    <ul class="nav nav-pills justify-content-center mb-4" id="suggestionTabs" role="tablist">
        <c:forEach items="${categoryList}" var="cat" varStatus="status">
            <li class="nav-item">
                <button class="nav-link ${status.first ? 'active' : ''}" data-bs-toggle="tab" data-bs-target="#cat-${cat.categoryId}">${cat.categoryName}</button>
            </li>
        </c:forEach>
    </ul>

    <div class="tab-content">
        <c:forEach items="${categoryList}" var="cat" varStatus="status">
            <div class="tab-pane fade ${status.first ? 'show active' : ''}" id="cat-${cat.categoryId}">
                <div class="row row-cols-1 row-cols-sm-2 row-cols-md-5 g-3 suggestion-grid">
                    <c:forEach items="${productsMap[cat.categoryId]}" var="p" varStatus="pStatus">
                        <div class="col suggestion-item ${pStatus.index >= 5 ? 'product-hidden' : ''}">
                            <div class="card h-100 p-2">
                                <img src="${pageContext.request.contextPath}/assets/images/products/${not empty p.imageUrl ? p.imageUrl : 'default-product.png'}" class="card-img-top">
                                <div class="card-body">
                                    <h6 class="small">${p.productName}</h6>
                                    <p class="text-primary fw-bold"><fmt:formatNumber value="${p.price}" type="number" maxFractionDigits="0"/>đ</p>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <div class="text-center mt-3">
                    <button class="btn btn-sm btn-outline-secondary load-more-suggestion" data-vi="Xem thêm" data-en="Load More">Xem thêm</button>
                </div>
            </div>
        </c:forEach>
    </div>
</main>

<jsp:include page="/WEB-INF/include/footer.jsp" />

<script>
    document.addEventListener("DOMContentLoaded", function () {
        // 1. LOGIC ĐA NGÔN NGỮ
        let lang = new URLSearchParams(window.location.search).get('lang') || 'vi';
        document.querySelectorAll('[data-vi][data-en]').forEach(el => {
            if (el.classList.contains('view-more-img')) {
                el.src = el.getAttribute('data-' + lang);
            } else {
                el.textContent = el.getAttribute('data-' + lang);
            }
        });

        // 2. LOGIC "XEM THÊM" BÁN CHẠY (Dùng mascot)
        const loadMoreBestSeller = document.getElementById("load-more-best-seller");
        loadMoreBestSeller.addEventListener("click", function() {
            document.querySelectorAll(".product-card-item.product-hidden").forEach(item => {
                item.classList.remove("product-hidden");
            });
            this.style.display = "none";
        });

        // 3. LOGIC "XEM THÊM" GỢI Ý (Dùng button)
        document.querySelectorAll(".load-more-suggestion").forEach(btn => {
            btn.addEventListener("click", function() {
                const pane = this.closest('.tab-pane');
                pane.querySelectorAll(".suggestion-item.product-hidden").forEach(item => {
                    item.classList.remove("product-hidden");
                });
                this.style.display = "none";
            });
        });
    });
</script>