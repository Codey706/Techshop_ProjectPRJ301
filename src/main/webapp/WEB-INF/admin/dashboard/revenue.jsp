<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Mirai Store - Thống kê doanh thu</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin-dashboard.css">
    </head>
    <body>
        <!-- ==================== ADMIN NAVBAR ==================== -->
        <header class="admin-header sticky-top">
            <div class="container-fluid px-3 py-2">
                <div class="admin-navbar d-flex align-items-center gap-3">
                    <a href="${pageContext.request.contextPath}/admin/dashboard"
                       class="admin-brand d-flex align-items-center text-decoration-none flex-shrink-0">
                        <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="Mirai Store">
                        <span><strong>Mirai</strong> Store <span class="d-none d-xl-inline">- Admin</span></span>
                    </a>

                    <form action="${pageContext.request.contextPath}/admin/product" method="get"
                          class="admin-search d-none d-md-flex flex-grow-1">
                        <div class="input-group">
                            <span class="input-group-text bg-white border-end-0"><i class="bi bi-search"></i></span>
                            <input type="text" class="form-control border-start-0" name="keyword"
                                   placeholder="Tìm kiếm sản phẩm trong hệ thống...">
                            <button class="btn btn-primary px-4" type="submit">Tìm kiếm</button>
                        </div>
                    </form>

                    <div class="d-flex align-items-center gap-2 ms-auto flex-shrink-0">
                        <a href="${pageContext.request.contextPath}/home"
                           class="admin-store-link text-decoration-none d-none d-lg-flex align-items-center gap-2">
                            <i class="bi bi-shop fs-4 text-primary"></i><span>Cửa hàng</span>
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
                                <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/Auth?view=logout">
                                        <i class="bi bi-box-arrow-right me-2"></i>Đăng xuất</a></li>
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
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard">
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
                            <a class="nav-link active" href="${pageContext.request.contextPath}/admin/dashboard/revenue">
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
                            <div class="section-label">BÁO CÁO KINH DOANH</div>
                            <h1 class="mb-1"><i class="bi bi-graph-up-arrow me-2"></i>Thống kê doanh thu</h1>
                            <p class="text-secondary mb-0">Theo dõi doanh thu từ các đơn hàng đã hoàn thành theo từng tháng.</p>
                        </div>
                        <a href="${pageContext.request.contextPath}/admin/dashboard/top-products" class="btn btn-outline-primary px-3 py-2">
                            <i class="bi bi-trophy me-2"></i>Top sản phẩm
                        </a>
                    </div>

                    <!-- ==================== FILTER ==================== -->
                    <section class="dashboard-panel report-filter-panel mb-4">
                        <form action="${pageContext.request.contextPath}/admin/dashboard/revenue" method="get"
                              class="row g-3 align-items-end">
                            <div class="col-12 col-md-5 col-xl-3">
                                <label for="year" class="form-label fw-semibold">Năm báo cáo</label>
                                <select id="year" name="year" class="form-select">
                                    <c:forEach begin="2024" end="2026" var="reportYear">
                                        <option value="${reportYear}" ${selectedYear == reportYear ? 'selected' : ''}>${reportYear}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-12 col-md-auto">
                                <button type="submit" class="btn btn-primary px-4">
                                    <i class="bi bi-funnel me-2"></i>Lọc dữ liệu
                                </button>
                            </div>
                            <div class="col-12 col-md ms-md-auto text-md-end">
                                <span class="report-status"><i class="bi bi-check-circle-fill me-2"></i>Dữ liệu đơn hàng hoàn tất</span>
                            </div>
                        </form>
                    </section>

                    <!-- ==================== SUMMARY CARDS ==================== -->
                    <div class="row g-3 mb-4">
                        <div class="col-12 col-md-4">
                            <div class="report-summary-card h-100">
                                <span class="summary-icon bg-primary-subtle text-primary"><i class="bi bi-cash-stack"></i></span>
                                <div><div class="summary-label">Doanh thu năm ${selectedYear}</div>
                                    <div class="summary-value"><fmt:formatNumber value="${yearlyRevenue}" type="number" maxFractionDigits="0"/> đ</div></div>
                            </div>
                        </div>
                        <div class="col-12 col-md-4">
                            <div class="report-summary-card h-100">
                                <span class="summary-icon bg-success-subtle text-success"><i class="bi bi-bag-check"></i></span>
                                <div><div class="summary-label">Đơn hàng hoàn thành</div><div class="summary-value">${completedOrders}</div></div>
                            </div>
                        </div>
                        <div class="col-12 col-md-4">
                            <div class="report-summary-card h-100">
                                <span class="summary-icon bg-warning-subtle text-warning"><i class="bi bi-calendar2-check"></i></span>
                                <div><div class="summary-label">Tháng doanh thu cao nhất</div>
                                    <div class="summary-value"><c:choose><c:when test="${bestMonth > 0}">Tháng ${bestMonth}</c:when><c:otherwise>Chưa có</c:otherwise></c:choose></div></div>
                                    </div>
                                </div>
                            </div>

                            <!-- ==================== REVENUE TABLE ==================== -->
                            <section class="dashboard-panel">
                                <div class="d-flex flex-wrap justify-content-between align-items-center gap-2 mb-3">
                                        <div><div class="section-label">CHI TIẾT THEO THÁNG</div><h2 class="mb-0">Doanh thu năm ${selectedYear}</h2></div>
                            <span class="text-secondary small"><i class="bi bi-info-circle me-1"></i>Chỉ tính đơn hàng trạng thái hoàn thành</span>
                        </div>
                        <div class="table-responsive">
                            <table class="table admin-report-table align-middle mb-0">
                                <thead><tr><th>Tháng</th><th class="text-center">Đơn hoàn thành</th><th class="text-end">Doanh thu</th><th class="text-end">Tỷ trọng</th></tr></thead>
                                <tbody>
                                    <c:forEach items="${revenueList}" var="item">
                                        <tr>
                                            <td><span class="month-badge"><i class="bi bi-calendar3 me-2"></i>Tháng ${item.month}</span></td>
                                            <td class="text-center fw-semibold">${item.totalOrders}</td>
                                            <td class="text-end fw-bold text-success"><fmt:formatNumber value="${item.revenue}" type="number" maxFractionDigits="0"/> đ</td>
                                            <td class="text-end text-secondary"><c:choose><c:when test="${yearlyRevenue > 0}"><fmt:formatNumber value="${item.revenue / yearlyRevenue * 100}" maxFractionDigits="1"/>%</c:when><c:otherwise>0%</c:otherwise></c:choose></td>
                                                </tr>
                                    </c:forEach>
                                    <c:if test="${empty revenueList}">
                                        <tr><td colspan="4" class="text-center py-5"><div class="empty-report-icon"><i class="bi bi-bar-chart-line"></i></div><h5 class="mt-3">Chưa có dữ liệu doanh thu</h5><p class="text-secondary mb-0">Không có đơn hàng hoàn thành trong năm ${selectedYear}.</p></td></tr>
                                                </c:if>
                                </tbody>
                            </table>
                        </div>
                    </section>
                    <footer class="admin-footer mt-4 text-center">
                        &copy; 2026 <a href="${pageContext.request.contextPath}/home">Mirai Store</a> - Trang quản trị
                    </footer>                </main>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
