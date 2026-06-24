<%-- 
    Document   : dashboard
    Created on : Jun 24, 2026, 10:45:58 AM
    Author     : Huynh Nhu Y
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Admin Dashboard - Overview</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    </head>
    <body class="bg-light">
        <div class="container-fluid py-4">
            <h2 class="mb-4"><i class="bi bi-speedometer2"></i> Hệ Thống Thống Kê Tổng Quan</h2>
            
            <div class="row g-3 mb-4">
                <div class="col-md-4">
                    <div class="card bg-primary text-white p-3">
                        <h5><i class="bi bi-cart-check"></i> Đơn Hàng Mới</h5>
                        <h3>150 Đơn</h3>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card bg-success text-white p-3">
                        <h5><i class="bi bi-currency-dollar"></i> Doanh Thu Ngày</h5>
                        <h3>25,400,000 đ</h3>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card bg-warning text-dark p-3">
                        <h5><i class="bi bi-people"></i> Khách Hàng Mới</h5>
                        <h3>45 Thành viên</h3>
                    </div>
                </div>
            </div>

            <div class="d-flex gap-2">
                <a href="${pageContext.request.contextPath}/admin/dashboard/revenue" class="btn btn-outline-success">
                    <i class="bi bi-graph-up-arrow"></i> Xem Doanh Thu Chi Tiết
                </a>
                <a href="${pageContext.request.contextPath}/admin/dashboard/top-products" class="btn btn-outline-primary">
                    <i class="bi bi-trophy"></i> Xem Bảng Xếp Hạng Sản Phẩm
                </a>
            </div>
        </div>
    </body>
</html>
