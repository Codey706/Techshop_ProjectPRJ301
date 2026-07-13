<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!-- ==================== STORE NAVBAR ==================== -->
<nav class="navbar bg-white sticky-top border-bottom py-2">
    <div class="container-fluid px-3">
        <div class="store-navbar w-100 d-flex align-items-center gap-3">

            <!-- Danh mục -->
            <button class="btn border-0 category-button flex-shrink-0" type="button"
                    data-bs-toggle="offcanvas" data-bs-target="#categoryMenu" aria-controls="categoryMenu">
                <i class="fa-solid fa-bars fs-3 d-block"></i>
                <small>Danh mục</small>
            </button>

            <div class="vr d-none d-sm-block"></div>

            <!-- Logo -->
            <a class="navbar-brand d-flex align-items-center gap-2 me-0 flex-shrink-0"
               href="${pageContext.request.contextPath}/home">
                <img src="${pageContext.request.contextPath}/assets/images/logo.png"
                     alt="Mirai Store" class="store-logo">
                <span class="brand-name"><strong>Mirai</strong> Store</span>
            </a>

            <!-- Thanh tìm kiếm -->
            <form action="${pageContext.request.contextPath}/product/search" method="GET"
                  class="store-search d-none d-md-flex flex-grow-1 mx-lg-4">
                <div class="input-group">
                    <span class="input-group-text bg-white border-end-0">
                        <i class="fa-solid fa-magnifying-glass"></i>
                    </span>
                    <input type="text" class="form-control border-start-0 border-end-0"
                           id="search-input" name="keyword" value="${param.keyword}"
                           placeholder="Tìm kiếm máy tính, phụ kiện, thiết bị...">
                    <button class="btn btn-primary px-4" type="submit">Tìm kiếm</button>
                </div>
            </form>

            <!-- Chức năng bên phải -->
            <div class="d-flex align-items-center gap-2 gap-lg-3 ms-auto flex-shrink-0">
                <c:choose>
                    <c:when test="${sessionScope.user != null
                                    && sessionScope.user.roleId == 1}">

                            <a href="${pageContext.request.contextPath}/admin/dashboard/dashboard"
                               class="navbar-action dashboard-action text-decoration-none">

                                <span class="action-icon-box">
                                    <i class="fa-solid fa-chart-line"></i>
                                </span>

                                <span class="action-label d-none d-xl-inline">
                                    Dashboard
                                </span>
                            </a>
                    </c:when>

                    <c:otherwise>
                        <c:choose>
                            <c:when test="${sessionScope.user != null}">
                                <a href="${pageContext.request.contextPath}/cart"
                                   class="navbar-action text-decoration-none d-flex align-items-center gap-2">
                                    <img src="${pageContext.request.contextPath}/assets/images/cart-icon.png"
                                         alt="Giỏ hàng" class="cart-image">
                                    <span class="d-none d-lg-inline">Giỏ hàng</span>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="#" onclick="requireLoginForCart(event)"
                                   class="navbar-action text-decoration-none d-flex align-items-center gap-2">
                                    <img src="${pageContext.request.contextPath}/assets/images/cart-icon.png"
                                         alt="Giỏ hàng" class="cart-image">
                                    <span class="d-none d-lg-inline">Giỏ hàng</span>
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </c:otherwise>
                </c:choose>

                <div class="vr"></div>

                <c:choose>
                    <c:when test="${sessionScope.user != null}">
                        <div class="dropdown">
                            <button class="btn border-0 dropdown-toggle d-flex align-items-center gap-2"
                                    data-bs-toggle="dropdown" type="button">
                                <img src="${pageContext.request.contextPath}/assets/images/login_icon.png"
                                     alt="Tài khoản" class="account-image">
                                <span class="fw-semibold d-none d-sm-inline">${sessionScope.user.username}</span>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end shadow border-0">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile">Hồ sơ</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/order">Đơn hàng</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/Auth?view=logout">Đăng xuất</a></li>
                            </ul>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/Auth?view=login"
                           class="navbar-action text-decoration-none d-flex align-items-center gap-2">
                            <img src="${pageContext.request.contextPath}/assets/images/login_icon.png"
                                 alt="Đăng nhập" class="account-image">
                            <span class="d-none d-sm-inline">Đăng nhập</span>
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Thanh tìm kiếm trên màn hình nhỏ -->
        <form action="${pageContext.request.contextPath}/product/search" method="GET"
              class="d-flex d-md-none w-100 mt-2">
            <div class="input-group">
                <input type="text" class="form-control" name="keyword" placeholder="Tìm kiếm sản phẩm...">
                <button class="btn btn-primary" type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
            </div>
        </form>
    </div>
</nav>

<!-- Menu danh mục responsive -->
<div class="offcanvas offcanvas-start" tabindex="-1" id="categoryMenu">
    <div class="offcanvas-header">
        <h5 class="offcanvas-title">Danh mục sản phẩm</h5>
        <button type="button" class="btn-close" data-bs-dismiss="offcanvas"></button>
    </div>
    <div class="offcanvas-body p-0">

        <!-- Xem toàn bộ sản phẩm -->
        <a class="d-flex align-items-center gap-3 px-3 py-3 text-decoration-none text-dark border-bottom category-menu-item"
           href="${pageContext.request.contextPath}/products">
            <i class="fa-solid fa-border-all text-primary"></i>
            <span>Tất cả sản phẩm</span>
        </a>

        <!-- Các loại sản phẩm -->
        <a class="d-flex align-items-center gap-3 px-3 py-3 text-decoration-none text-dark border-bottom category-menu-item"
           href="${pageContext.request.contextPath}/products?category=Laptop">
            <i class="fa-solid fa-laptop text-primary"></i>
            <span>Laptop</span>
        </a>

        <a class="d-flex align-items-center gap-3 px-3 py-3 text-decoration-none text-dark border-bottom category-menu-item"
           href="${pageContext.request.contextPath}/products?category=Desktop">
            <i class="fa-solid fa-computer text-primary"></i>
            <span>Máy tính để bàn</span>
        </a>

        <a class="d-flex align-items-center gap-3 px-3 py-3 text-decoration-none text-dark border-bottom category-menu-item"
           href="${pageContext.request.contextPath}/products?category=Monitor">
            <i class="fa-solid fa-display text-primary"></i>
            <span>Màn hình</span>
        </a>

        <a class="d-flex align-items-center gap-3 px-3 py-3 text-decoration-none text-dark border-bottom category-menu-item"
           href="${pageContext.request.contextPath}/products?category=Keyboard">
            <i class="fa-solid fa-keyboard text-primary"></i>
            <span>Bàn phím</span>
        </a>

        <a class="d-flex align-items-center gap-3 px-3 py-3 text-decoration-none text-dark border-bottom category-menu-item"
           href="${pageContext.request.contextPath}/products?category=Mouse">
            <i class="fa-solid fa-computer-mouse text-primary"></i>
            <span>Chuột</span>
        </a>

        <a class="d-flex align-items-center gap-3 px-3 py-3 text-decoration-none text-dark border-bottom category-menu-item"
           href="${pageContext.request.contextPath}/products?category=Headphone">
            <i class="fa-solid fa-headphones text-primary"></i>
            <span>Tai nghe</span>
        </a>

        <a class="d-flex align-items-center gap-3 px-3 py-3 text-decoration-none text-dark category-menu-item"
           href="${pageContext.request.contextPath}/products?category=Accessory">
            <i class="fa-solid fa-plug text-primary"></i>
            <span>Phụ kiện</span>
        </a>

    </div>
</div>

<script>
    // Người chưa đăng nhập phải đăng nhập trước khi xem giỏ hàng
    function requireLoginForCart(event) {
        event.preventDefault();
        alert("Vui lòng đăng nhập để xem giỏ hàng.");
        window.location.href = "${pageContext.request.contextPath}/Auth?view=login";
    }
</script>
