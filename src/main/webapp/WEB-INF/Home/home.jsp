<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/home.css">
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

    <%-- =========================================
         SẢN PHẨM BÁN CHẠY (Grid Layout 12 Items)
         ========================================= --%>
    <h5 class="fw-bold mb-4" style="color: #333;" data-vi="Sản phẩm bán chạy" data-en="Best Sellers">Sản phẩm bán chạy</h5>
    
    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-4" id="best-seller-grid">
        
        <div class="col product-card-item">
            <div class="card h-100 border-0 shadow-sm d-flex flex-column justify-content-between overflow-hidden style-product-card">
                <div class="p-3">
                    <div class="bg-light rounded-3 d-flex align-items-center justify-content-center" style="height: 200px;">
                        <i class="fa-solid fa-headphones fs-1 opacity-50" style="color: #0056b3;"></i>
                    </div>
                    <h6 class="fw-bold text-dark mt-3 mb-1 text-truncate-2" style="font-size: 15px; height: 44px; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;">
                        Tai nghe không dây Sony WH-1000XM5
                    </h6>
                    <p class="text-muted small mb-0">SKU: SONY-XM5</p>
                </div>
                <div class="card-footer bg-light border-0 d-flex align-items-center justify-content-between p-3">
                    <span class="fw-bold fs-5" style="color: #0056b3;">6.490.000đ</span>
                    <a href="${pageContext.request.contextPath}/product/detail?id=1" class="btn btn-sm text-white px-3 py-2 btn-mirai-buy">
                        <span data-vi="Mua ngay" data-en="Buy Now">Mua ngay</span>
                    </a>
                </div>
            </div>
        </div>

        <div class="col product-card-item">
            <div class="card h-100 border-0 shadow-sm d-flex flex-column justify-content-between overflow-hidden style-product-card">
                <div class="p-3">
                    <div class="bg-light rounded-3 d-flex align-items-center justify-content-center" style="height: 200px;">
                        <i class="fa-solid fa-laptop fs-1 opacity-50" style="color: #0056b3;"></i>
                    </div>
                    <h6 class="fw-bold text-dark mt-3 mb-1 text-truncate-2" style="font-size: 15px; height: 44px; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;">
                        Laptop ASUS ROG Strix G16 (2024)
                    </h6>
                    <p class="text-muted small mb-0">SKU: ROG-G16</p>
                </div>
                <div class="card-footer bg-light border-0 d-flex align-items-center justify-content-between p-3">
                    <span class="fw-bold fs-5" style="color: #0056b3;">34.500.000đ</span>
                    <a href="${pageContext.request.contextPath}/product/detail?id=2" class="btn btn-sm text-white px-3 py-2 btn-mirai-buy">
                        <span data-vi="Mua ngay" data-en="Buy Now">Mua ngay</span>
                    </a>
                </div>
            </div>
        </div>

        <div class="col product-card-item">
            <div class="card h-100 border-0 shadow-sm d-flex flex-column justify-content-between overflow-hidden style-product-card">
                <div class="p-3">
                    <div class="bg-light rounded-3 d-flex align-items-center justify-content-center" style="height: 200px;">
                        <i class="fa-solid fa-keyboard fs-1 opacity-50" style="color: #0056b3;"></i>
                    </div>
                    <h6 class="fw-bold text-dark mt-3 mb-1 text-truncate-2" style="font-size: 15px; height: 44px; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;">
                        Bàn phím cơ NuPhy Air75 V2 Low-Profile
                    </h6>
                    <p class="text-muted small mb-0">SKU: NUPHY-A75</p>
                </div>
                <div class="card-footer bg-light border-0 d-flex align-items-center justify-content-between p-3">
                    <span class="fw-bold fs-5" style="color: #0056b3;">2.990.000đ</span>
                    <a href="${pageContext.request.contextPath}/product/detail?id=3" class="btn btn-sm text-white px-3 py-2 btn-mirai-buy">
                        <span data-vi="Mua ngay" data-en="Buy Now">Mua ngay</span>
                    </a>
                </div>
            </div>
        </div>

        <div class="col product-card-item">
            <div class="card h-100 border-0 shadow-sm d-flex flex-column justify-content-between overflow-hidden style-product-card">
                <div class="p-3">
                    <div class="bg-light rounded-3 d-flex align-items-center justify-content-center" style="height: 200px;">
                        <i class="fa-solid fa-mouse fs-1 opacity-50" style="color: #0056b3;"></i>
                    </div>
                    <h6 class="fw-bold text-dark mt-3 mb-1 text-truncate-2" style="font-size: 15px; height: 44px; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;">
                        Chuột không dây Logitech G Pro X Superlight 2
                    </h6>
                    <p class="text-muted small mb-0">SKU: LOGI-SUPER2</p>
                </div>
                <div class="card-footer bg-light border-0 d-flex align-items-center justify-content-between p-3">
                    <span class="fw-bold fs-5" style="color: #0056b3;">3.290.000đ</span>
                    <a href="#" class="btn btn-sm text-white px-3 py-2 btn-mirai-buy">Mua ngay</a>
                </div>
            </div>
        </div>

        <div class="col product-card-item">
            <div class="card h-100 border-0 shadow-sm d-flex flex-column justify-content-between overflow-hidden style-product-card">
                <div class="p-3">
                    <div class="bg-light rounded-3 d-flex align-items-center justify-content-center" style="height: 200px;">
                        <i class="fa-solid fa-tv fs-1 opacity-50" style="color: #0056b3;"></i>
                    </div>
                    <h6 class="fw-bold text-dark mt-3 mb-1 text-truncate-2" style="font-size: 15px; height: 44px; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;">
                        Màn hình LG UltraGear 27GR75Q-B 2K 165Hz
                    </h6>
                    <p class="text-muted small mb-0">SKU: LG-27GR75Q</p>
                </div>
                <div class="card-footer bg-light border-0 d-flex align-items-center justify-content-between p-3">
                    <span class="fw-bold fs-5" style="color: #0056b3;">5.990.000đ</span>
                    <a href="#" class="btn btn-sm text-white px-3 py-2 btn-mirai-buy">Mua ngay</a>
                </div>
            </div>
        </div>

        <div class="col product-card-item">
            <div class="card h-100 border-0 shadow-sm d-flex flex-column justify-content-between overflow-hidden style-product-card">
                <div class="p-3">
                    <div class="bg-light rounded-3 d-flex align-items-center justify-content-center" style="height: 200px;">
                        <i class="fa-solid fa-chair fs-1 opacity-50" style="color: #0056b3;"></i>
                    </div>
                    <h6 class="fw-bold text-dark mt-3 mb-1 text-truncate-2" style="font-size: 15px; height: 44px; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;">
                        Ghế công thái học Sihoo M57 - Bản kê chân
                    </h6>
                    <p class="text-muted small mb-0">SKU: SIHOO-M57</p>
                </div>
                <div class="card-footer bg-light border-0 d-flex align-items-center justify-content-between p-3">
                    <span class="fw-bold fs-5" style="color: #0056b3;">3.650.000đ</span>
                    <a href="#" class="btn btn-sm text-white px-3 py-2 btn-mirai-buy">Mua ngay</a>
                </div>
            </div>
        </div>

        <div class="col product-card-item">
            <div class="card h-100 border-0 shadow-sm d-flex flex-column justify-content-between overflow-hidden style-product-card">
                <div class="p-3">
                    <div class="bg-light rounded-3 d-flex align-items-center justify-content-center" style="height: 200px;">
                        <i class="fa-solid fa-microchip fs-1 opacity-50" style="color: #0056b3;"></i>
                    </div>
                    <h6 class="fw-bold text-dark mt-3 mb-1 text-truncate-2" style="font-size: 15px; height: 44px; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;">
                        Mini PC ASUS PN64 Intel Core i5-13500H
                    </h6>
                    <p class="text-muted small mb-0">SKU: ASUS-PN64</p>
                </div>
                <div class="card-footer bg-light border-0 d-flex align-items-center justify-content-between p-3">
                    <span class="fw-bold fs-5" style="color: #0056b3;">11.200.000đ</span>
                    <a href="#" class="btn btn-sm text-white px-3 py-2 btn-mirai-buy">Mua ngay</a>
                </div>
            </div>
        </div>

        <div class="col product-card-item">
            <div class="card h-100 border-0 shadow-sm d-flex flex-column justify-content-between overflow-hidden style-product-card">
                <div class="p-3">
                    <div class="bg-light rounded-3 d-flex align-items-center justify-content-center" style="height: 200px;">
                        <i class="fa-solid fa-gamepad fs-1 opacity-50" style="color: #0056b3;"></i>
                    </div>
                    <h6 class="fw-bold text-dark mt-3 mb-1 text-truncate-2" style="font-size: 15px; height: 44px; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;">
                        Tay cầm Xbox Wireless Controller Black
                    </h6>
                    <p class="text-muted small mb-0">SKU: XBOX-CARBON</p>
                </div>
                <div class="card-footer bg-light border-0 d-flex align-items-center justify-content-between p-3">
                    <span class="fw-bold fs-5" style="color: #0056b3;">1.450.000đ</span>
                    <a href="#" class="btn btn-sm text-white px-3 py-2 btn-mirai-buy">Mua ngay</a>
                </div>
            </div>
        </div>

        <div class="col product-card-item">
            <div class="card h-100 border-0 shadow-sm d-flex flex-column justify-content-between overflow-hidden style-product-card">
                <div class="p-3">
                    <div class="bg-light rounded-3 d-flex align-items-center justify-content-center" style="height: 200px;">
                        <i class="fa-solid fa-volume-high fs-1 opacity-50" style="color: #0056b3;"></i>
                    </div>
                    <h6 class="fw-bold text-dark mt-3 mb-1 text-truncate-2" style="font-size: 15px; height: 44px; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;">
                        Loa Bluetooth Marshall Emberton II
                    </h6>
                    <p class="text-muted small mb-0">SKU: MAR-EMBER2</p>
                </div>
                <div class="card-footer bg-light border-0 d-flex align-items-center justify-content-between p-3">
                    <span class="fw-bold fs-5" style="color: #0056b3;">3.890.000đ</span>
                    <a href="#" class="btn btn-sm text-white px-3 py-2 btn-mirai-buy">Mua ngay</a>
                </div>
            </div>
        </div>

        <div class="col product-card-item">
            <div class="card h-100 border-0 shadow-sm d-flex flex-column justify-content-between overflow-hidden style-product-card">
                <div class="p-3">
                    <div class="bg-light rounded-3 d-flex align-items-center justify-content-center" style="height: 200px;">
                        <i class="fa-solid fa-bag-shopping fs-1 opacity-50" style="color: #0056b3;"></i>
                    </div>
                    <h6 class="fw-bold text-dark mt-3 mb-1 text-truncate-2" style="font-size: 15px; height: 44px; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;">
                        Balo Laptop Peak Design Everyday 20L
                    </h6>
                    <p class="text-muted small mb-0">SKU: PEAK-ED20L</p>
                </div>
                <div class="card-footer bg-light border-0 d-flex align-items-center justify-content-between p-3">
                    <span class="fw-bold fs-5" style="color: #0056b3;">6.200.000đ</span>
                    <a href="#" class="btn btn-sm text-white px-3 py-2 btn-mirai-buy">Mua ngay</a>
                </div>
            </div>
        </div>

        <div class="col product-card-item">
            <div class="card h-100 border-0 shadow-sm d-flex flex-column justify-content-between overflow-hidden style-product-card">
                <div class="p-3">
                    <div class="bg-light rounded-3 d-flex align-items-center justify-content-center" style="height: 200px;">
                        <i class="fa-solid fa-table fs-1 opacity-50" style="color: #0056b3;"></i>
                    </div>
                    <h6 class="fw-bold text-dark mt-3 mb-1 text-truncate-2" style="font-size: 15px; height: 44px; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;">
                        Bàn nâng hạ thông minh Epione SmartDesk
                    </h6>
                    <p class="text-muted small mb-0">SKU: EPI-SDPRO</p>
                </div>
                <div class="card-footer bg-light border-0 d-flex align-items-center justify-content-between p-3">
                    <span class="fw-bold fs-5" style="color: #0056b3;">8.490.000đ</span>
                    <a href="#" class="btn btn-sm text-white px-3 py-2 btn-mirai-buy">Mua ngay</a>
                </div>
            </div>
        </div>

        <div class="col product-card-item">
            <div class="card h-100 border-0 shadow-sm d-flex flex-column justify-content-between overflow-hidden style-product-card">
                <div class="p-3">
                    <div class="bg-light rounded-3 d-flex align-items-center justify-content-center" style="height: 200px;">
                        <i class="fa-solid fa-compact-disc fs-1 opacity-50" style="color: #0056b3;"></i>
                    </div>
                    <h6 class="fw-bold text-dark mt-3 mb-1 text-truncate-2" style="font-size: 15px; height: 44px; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;">
                        Microsoft Office Home & Business 2024
                    </h6>
                    <p class="text-muted small mb-0">SKU: MS-OFF24</p>
                </div>
                <div class="card-footer bg-light border-0 d-flex align-items-center justify-content-between p-3">
                    <span class="fw-bold fs-5" style="color: #0056b3;">4.250.000đ</span>
                    <a href="#" class="btn btn-sm text-white px-3 py-2 btn-mirai-buy">Mua ngay</a>
                </div>
            </div>
        </div>

    </div>

    <%-- Nút Xem Thêm --%>
    <div class="text-center mt-5 mb-5">
        <button id="load-more-btn" class="btn btn-mirai-more fw-bold px-4 py-2">
            <span data-vi="Xem thêm sản phẩm" data-en="View More Products">Xem thêm sản phẩm</span>
        </button>
    </div>

</main>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const itemsPerPage = 6; // Mặc định hiển thị 6 sản phẩm (2 hàng)
        const products = document.querySelectorAll(".product-card-item");
        const loadMoreBtn = document.getElementById("load-more-btn");

        // Ẩn các sản phẩm từ vị trí index thứ 6 trở đi
        products.forEach((product, index) => {
            if (index >= itemsPerPage) {
                product.style.display = "none";
            }
        });

        // Xử lý click hiện thêm sản phẩm
        loadMoreBtn.addEventListener("click", function () {
            products.forEach(product => {
                product.style.display = "block";
            });
            loadMoreBtn.style.display = "none"; // Ẩn nút đi sau khi bung toàn bộ 12 sản phẩm
        });
    });
</script>

<jsp:include page="/WEB-INF/include/footer.jsp" />