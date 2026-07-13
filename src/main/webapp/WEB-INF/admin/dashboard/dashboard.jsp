<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Mirai Store - Admin Dashboard</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin-dashboard.css">
    </head>
    <body>

        <!-- ==================== ADMIN NAVBAR ==================== -->
        <header class="admin-header sticky-top">
            <div class="container-fluid px-3 py-2">
                <div class="admin-navbar d-flex align-items-center gap-3">
                    <a href="${pageContext.request.contextPath}/admin/dashboard/dashboard"
                       class="admin-brand d-flex align-items-center text-decoration-none flex-shrink-0">
                        <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="Mirai Store">
                        <span><strong>Mirai</strong> Store <span class="d-none d-xl-inline">- Admin</span></span>
                    </a>

                    <form action="${pageContext.request.contextPath}/admin/dashboard/dashboard"
                          method="get" class="admin-search d-none d-md-flex flex-grow-1">
                        <div class="input-group">
                            <span class="input-group-text bg-white border-end-0"><i class="bi bi-search"></i></span>
                            <input type="text" class="form-control border-start-0"
                                   name="keyword" placeholder="Tìm kiếm đơn hàng, sản phẩm, khách hàng...">
                            <button class="btn btn-primary px-4" type="submit">Tìm kiếm</button>
                        </div>
                    </form>

                    <div class="d-flex align-items-center gap-2 ms-auto flex-shrink-0">
                        <a href="${pageContext.request.contextPath}/home"
                           class="admin-store-link text-decoration-none d-none d-lg-flex align-items-center gap-2">
                            <i class="bi bi-shop fs-4 text-primary"></i>
                            <span>Cửa hàng</span>
                        </a>

                        <div class="vr d-none d-lg-block"></div>

                        <div class="dropdown">
                            <button class="btn border-0 dropdown-toggle d-flex align-items-center gap-2"
                                    data-bs-toggle="dropdown" type="button">
                                <span class="admin-avatar"><i class="bi bi-person-fill"></i></span>
                                <span class="fw-semibold d-none d-sm-inline">
                                    ${not empty sessionScope.user.username ? sessionScope.user.username : 'admin'}
                                </span>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end shadow-sm border-0">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile">Hồ sơ</a></li>
                                <li>
                                    <a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/Auth?view=logout">
                                        <i class="bi bi-box-arrow-right me-2"></i>Đăng xuất
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </header>

        <div class="container-fluid px-3 py-3">
            <div class="row g-3 align-items-stretch">

                <!-- ==================== SIDEBAR ==================== -->
                <aside class="col-12 col-lg-2">
                    <div class="admin-sidebar h-100 d-flex flex-column">
                        <nav class="nav flex-column gap-2">
                            <a class="nav-link active" href="${pageContext.request.contextPath}/admin/dashboard/dashboard">
                                <i class="bi bi-house-door-fill"></i><span>Tổng quan</span>
                            </a>
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/order">
                                <i class="bi bi-bag"></i><span>Đơn hàng</span>
                            </a>
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/product">
                                <i class="bi bi-box-seam"></i><span>Sản phẩm</span>
                            </a>
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/voucher">
                                <i class="bi bi-ticket-perforated"></i><span>Khuyến mãi</span>
                            </a>
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard/dashboard/revenue">
                                <i class="bi bi-bar-chart"></i><span>Báo cáo</span>
                            </a>
                        </nav>

                        <a class="logout-link mt-lg-auto" href="${pageContext.request.contextPath}/Auth?view=logout">
                            <i class="bi bi-box-arrow-right"></i><span>Đăng xuất</span>
                        </a>
                    </div>
                </aside>

                <!-- ==================== MAIN CONTENT ==================== -->
                <main class="col-12 col-lg-10">
                    <div class="dashboard-heading d-flex flex-wrap justify-content-between align-items-center gap-3 mb-4">
                        <div>
                            <div class="section-label">BẢNG ĐIỀU KHIỂN</div>
                            <h1 class="mb-0"><i class="bi bi-speedometer2 me-2"></i>Tổng quan hệ thống</h1>
                        </div>
                        <div class="dropdown">
                            <button class="btn btn-white border dropdown-toggle px-3 py-2" data-bs-toggle="dropdown">
                                <i class="bi bi-calendar3 me-2"></i>7 ngày qua
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <li><button class="dropdown-item" type="button">7 ngày qua</button></li>
                                <li><button class="dropdown-item" type="button">30 ngày qua</button></li>
                                <li><button class="dropdown-item" type="button">Năm nay</button></li>
                            </ul>
                        </div>
                    </div>

                    <!-- ==================== STATISTIC CARDS ==================== -->
                    <div class="row g-3 mb-4">
                        <div class="col-12 col-md-4">
                            <div class="stat-card stat-orders h-100">
                                <div class="stat-icon"><i class="bi bi-cart-check"></i></div>
                                <div>
                                    <div class="stat-title">Đơn hàng chờ xử lý</div>
                                    <div class="stat-value">${pendingOrders}</div>
                                    <div class="stat-note text-primary"><i class="bi bi-arrow-up"></i> Cần kiểm tra và xác nhận</div>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-4">
                            <div class="stat-card stat-revenue h-100">
                                <div class="stat-icon"><i class="bi bi-currency-dollar"></i></div>
                                <div>
                                    <div class="stat-title">Tổng doanh thu</div>
                                    <div class="stat-value">
                                        <fmt:formatNumber value="${totalRevenue}" type="number" maxFractionDigits="0"/> đ
                                    </div>
                                    <div class="stat-note text-success"><i class="bi bi-graph-up-arrow"></i> Dữ liệu từ đơn hàng hoàn tất</div>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-4">
                            <div class="stat-card stat-customers h-100">
                                <div class="stat-icon"><i class="bi bi-people"></i></div>
                                <div>
                                    <div class="stat-title">Tổng khách hàng</div>
                                    <div class="stat-value">${totalCustomers}</div>
                                    <div class="stat-note text-warning"><i class="bi bi-person-check"></i> Tài khoản khách hàng hiện có</div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row g-4 align-items-stretch">
                        <!-- ==================== QUICK ACCESS ==================== -->
                        <div class="col-12 col-xl-7">
                            <section class="dashboard-panel h-100">
                                <div class="section-label">TRUY CẬP NHANH</div>
                                <h2>Quản lý cửa hàng</h2>

                                <a class="quick-link" href="${pageContext.request.contextPath}/admin/order">
                                    <span class="quick-icon"><i class="bi bi-receipt"></i></span>
                                    <span class="flex-grow-1">
                                        <strong>Đơn hàng</strong>
                                        <small>Kiểm tra và cập nhật trạng thái</small>
                                    </span>
                                    <i class="bi bi-arrow-right"></i>
                                </a>

                                <a class="quick-link" href="${pageContext.request.contextPath}/admin/product">
                                    <span class="quick-icon"><i class="bi bi-box-seam"></i></span>
                                    <span class="flex-grow-1">
                                        <strong>Sản phẩm</strong>
                                        <small>Thêm, sửa và quản lý sản phẩm</small>
                                    </span>
                                    <i class="bi bi-arrow-right"></i>
                                </a>

                                <a class="quick-link" href="${pageContext.request.contextPath}/admin/voucher">
                                    <span class="quick-icon"><i class="bi bi-ticket-perforated"></i></span>
                                    <span class="flex-grow-1">
                                        <strong>Khuyến mãi</strong>
                                        <small>Quản lý voucher của cửa hàng</small>
                                    </span>
                                    <i class="bi bi-arrow-right"></i>
                                </a>
                            </section>
                        </div>

                        <!-- ==================== REPORT ==================== -->
                        <div class="col-12 col-xl-5">
                            <section class="dashboard-panel h-100">
                                <div class="section-label">BÁO CÁO</div>
                                <h2>Thống kê chi tiết</h2>

                                <div class="report-graphic mx-auto">
                                    <div class="report-inner"><i class="bi bi-graph-up-arrow"></i></div>
                                </div>

                                <p class="text-secondary text-center">Xem dữ liệu doanh thu và bảng xếp hạng sản phẩm bán chạy.</p>

                                <a class="report-link" href="${pageContext.request.contextPath}/admin/dashboard/dashboard/revenue">
                                    <span><i class="bi bi-bar-chart-line me-3"></i><strong>Doanh thu</strong></span>
                                    <i class="bi bi-chevron-right"></i>
                                </a>
                                <a class="report-link" href="${pageContext.request.contextPath}/admin/dashboard/dashboard/top-products">
                                    <span><i class="bi bi-trophy me-3"></i><strong>Sản phẩm bán chạy</strong></span>
                                    <i class="bi bi-chevron-right"></i>
                                </a>
                            </section>
                        </div>
                    </div>

                    <footer class="admin-footer mt-4 text-center">© 2026 Mirai Store - Trang quản trị</footer>
                </main>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
