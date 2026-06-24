<%-- 
    Document   : top-products
    Created on : Jun 24, 2026, 11:28:01 AM
    Author     : Huynh Nhu Y
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Admin Dashboard - Top Selling Products</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    </head>
    <body class="bg-light">
        <div class="container-fluid py-4">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2><i class="bi bi-trophy text-warning"></i> Bảng Xếp Hạng Sản Phẩm Bán Chạy</h2>
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-secondary btn-sm">
                    <i class="bi bi-arrow-left"></i> Quay lại Overview
                </a>
            </div>

            <div class="card p-3">
                <table class="table table-hover align-middle">
                    <thead class="table-warning">
                        <tr>
                            <th style="width: 80px;">Hạng</th>
                            <th>Sản Phẩm</th>
                            <th>Mã SKU Gốc</th>
                            <th>Số Lượng Đã Bán (Sold)</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><span class="badge bg-danger fs-6">1</span></td>
                            <td><strong>iPhone 16 Pro Max</strong></td>
                            <td><code>APL-IP16PM-BASE</code></td>
                            <td><span class="text-success fw-bold">1,240 cái</span></td>
                        </tr>
                        <tr>
                            <td><span class="badge bg-warning text-dark fs-6">2</span></td>
                            <td><strong>Bàn phím cơ Logitech G213</strong></td>
                            <td><code>LOG-G213-BASE</code></td>
                            <td><span class="text-success fw-bold">850 cái</span></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>