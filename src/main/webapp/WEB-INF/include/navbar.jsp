<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<nav class="navbar navbar-expand-lg navbar-light bg-white border-bottom sticky-top shadow-sm py-2">
    <div class="container d-flex align-items-center justify-content-between">

        <%-- Hiển thị logo --%>
        <a class="navbar-brand fw-bold text-primary d-flex align-items-center gap-2"
           href="${pageContext.request.contextPath}/home"
           style="color: #0056b3 !important;">
            <img src="${pageContext.request.contextPath}/assets/images/logo.png"
                 alt="Mirai Logo"
                 style="height: 40px; width: auto; border-radius: 100%;">
            <span>
                Mirai
                <span class="text-secondary fw-normal fs-5">Store</span>
            </span>
        </a>

        <%-- Thanh tìm kiếm --%>
        <div class="flex-grow-1 mx-4 d-none d-md-block" style="max-width: 450px;">
            <form action="${pageContext.request.contextPath}/product/search" method="GET" class="dropdown" id="searchDropdownContainer">
                <div class="position-relative" data-bs-toggle="dropdown" aria-expanded="false" style="cursor: pointer;">
                    <input type="text" class="form-control bg-light border-0 ps-5 py-2 text-sm" 
                           id="search-input"
                           name="keyword"
                           value="${param.keyword}"
                           data-vi="Tìm kiếm máy tính, phụ kiện..." 
                           data-en="Search laptops, accessories..." 
                           placeholder="Tìm kiếm máy tính, phụ kiện...">

                    <%-- Icon tìm kiếm--%>
                    <div class="position-absolute top-50 start-0 translate-middle-y ms-2">
                        <img src="${pageContext.request.contextPath}/assets/images/search-icon.png" 
                             alt="Search" 
                             style="width: 22px; height: 22px; object-fit: contain;">
                    </div>
                </div>

                <div class="dropdown-menu search-dropdown-menu w-100 p-4 border-0 shadow-lg mt-2 rounded-4" aria-labelledby="search-input">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h6 class="fw-bold mb-0 text-dark" data-vi="Khuyến mãi nổi bật" data-en="Hot Promotions">Khuyến mãi nổi bật</h6>
                        <button type="button" class="btn btn-sm btn-light fw-bold text-muted px-3 rounded-pill border-0" id="btn-close-search" style="font-size: 13px;">
                            <span data-vi="Đóng" data-en="Close">Đóng</span>
                        </button>
                    </div>

                    <ul class="list-unstyled mb-0 d-flex flex-column gap-1">
                        <li>
                            <a href="${pageContext.request.contextPath}/product/search?keyword=Âm%20thanh" class="d-flex align-items-center gap-3 text-decoration-none text-dark p-2 search-item">
                                <div class="d-flex align-items-center justify-content-center bg-primary bg-opacity-10 text-primary rounded-circle" style="width: 32px; height: 32px;">
                                    <i class="fa-solid fa-gift fs-6"></i>
                                </div>
                                <span class="fw-semibold text-uppercase text-muted" style="letter-spacing: 0.5px; font-size: 13px;"
                                      data-vi="Âm thanh đỉnh cao" 
                                      data-en="Premium Audio">
                                    Âm thanh đỉnh cao
                                </span>
                            </a>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/product/search?keyword=Máy%20chơi%20game" class="d-flex align-items-center gap-3 text-decoration-none text-dark p-2 search-item">
                                <div class="d-flex align-items-center justify-content-center bg-primary bg-opacity-10 text-primary rounded-circle" style="width: 32px; height: 32px;">
                                    <i class="fa-solid fa-gift fs-6"></i>
                                </div>
                                <span class="fw-semibold text-uppercase text-muted" style="letter-spacing: 0.5px; font-size: 13px;"
                                      data-vi="Máy chơi game" 
                                      data-en="Gaming Consoles">
                                    Máy chơi game
                                </span>
                            </a>
                        </li>
                    </ul>
                </div>
            </form>
        </div>

        <%-- Khối chức năng góc phải --%>
        <div class="d-flex align-items-center gap-4">

            <%-- Nút chuyển đổi ngôn ngữ --%>
            <div class="btn-group" role="group" aria-label="Basic mixed styles example">
                <button type="button" id="btn-vi" onclick="switchLanguage('vi')" class="btn btn-danger btn-sm fw-bold px-2.5">VN</button>
                <button type="button" id="btn-en" onclick="switchLanguage('en')" class="btn btn-success btn-sm fw-bold px-2.5">ENG</button>
            </div>

            <%-- Icon giỏ hàng trên Navbar --%>
            <a href="${pageContext.request.contextPath}/cart" class="text-dark position-relative text-decoration-none d-inline-flex align-items-center justify-content-center me-3">
                <div style="width: 28px; height: 28px; display: flex; align-items: center; justify-content: center;">
                    <img src="${pageContext.request.contextPath}/assets/images/cart-icon.png" 
                         alt="Cart" 
                         style="width: 100%; height: 100%; object-fit: contain;">
                </div>
                <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill" 
                      style="font-size: 9px; background-color: #0056b3 !important; padding: 3px 6px;">0</span>
            </a>

            <%-- Nút đăng nhập trên Navbar --%>
            <c:choose>

                <%-- Đã đăng nhập --%>
                <c:when test="${sessionScope.user != null}">

                    <div class="dropdown">

                        <a class="btn text-white px-3 py-2 d-inline-flex align-items-center gap-2 dropdown-toggle"
                           href="#"
                           role="button"
                           data-bs-toggle="dropdown"
                           aria-expanded="false"
                           style="background-color:#0056b3;
                           border-radius:8px;
                           font-size:14px;
                           font-weight:600;">

                            <!-- Avatar mặc định -->
                            <img src="${pageContext.request.contextPath}/assets/images/login_icon.png"
                                 alt="Avatar"
                                 style="width:28px;
                                 height:28px;
                                 border-radius:50%;
                                 object-fit:cover;">

                            <!-- Tên người dùng -->
                            <span>${sessionScope.user.fullName}</span>

                        </a>

                        <ul class="dropdown-menu dropdown-menu-end shadow">

                            <li class="dropdown-header fw-bold">
                                ${sessionScope.user.username}
                            </li>

                            <li><hr class="dropdown-divider"></li>

                            <li>
                                <a class="dropdown-item" href="#">
                                    <i class="bi bi-person me-2"></i>
                                    My Profile
                                </a>
                            </li>

                            <li>
                                <a class="dropdown-item" href="#">
                                    <i class="bi bi-bag me-2"></i>
                                    My Orders
                                </a>
                            </li>

                            <li><hr class="dropdown-divider"></li>

                            <li>
                                <a class="dropdown-item text-danger"
                                   href="${pageContext.request.contextPath}/Auth?view=logout">

                                    <i class="bi bi-box-arrow-right me-2"></i>
                                    Logout

                                </a>
                            </li>

                        </ul>

                    </div>

                </c:when>

                <%-- Chưa đăng nhập --%>
                <c:otherwise>

                    <a href="${pageContext.request.contextPath}/Auth?view=login"
                       class="btn text-white px-3 py-2 d-inline-flex align-items-center gap-2"
                       style="background-color:#0056b3;
                       border-radius:8px;
                       text-decoration:none;
                       font-size:14px;
                       font-weight:600;">

                        <div style="width:18px;height:18px;display:flex;align-items:center;justify-content:center;">
                            <img src="${pageContext.request.contextPath}/assets/images/login_icon.png"
                                 alt="Login"
                                 style="width:100%;height:100%;object-fit:contain;">
                        </div>

                        <span>Đăng nhập</span>

                    </a>

                </c:otherwise>

            </c:choose>
        </div>
    </div>
</nav>