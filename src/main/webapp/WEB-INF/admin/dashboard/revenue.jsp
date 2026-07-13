<%-- 
    Document   : revenue
    Created on : Jun 24, 2026, 11:27:34 AM
    Author     : Huynh Nhu Y
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Admin Dashboard - Revenue Report</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    </head>
    <body class="bg-light">
        <div class="container-fluid py-4">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2><i class="bi bi-graph-up-arrow text-success"></i> Thống Kê Doanh Thu</h2>
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-secondary btn-sm">
                    <i class="bi bi-arrow-left"></i> Quay lại Overview
                </a>
            </div>

            <div class="card p-3 mb-4">
                <form action="${pageContext.request.contextPath}/admin/dashboard/revenue" method="get" class="row g-2 align-items-center">
                    <div class="col-auto">
                        <label class="col-form-label">Chọn năm báo cáo:</label>
                    </div>
                    <div class="col-auto">
                        <select name="year" class="form-select form-select-sm">
                            <option value="2026" selected>2026</option>
                            <option value="2025">2025</option>
                        </select>
                    </div>
                    <div class="col-auto">
                        <button type="submit" class="btn btn-primary btn-sm">Lọc dữ liệu</button>
                    </div>
                </form>
            </div>

            <div class="card p-3">
                <table class="table table-striped table-hover align-middle">
                    <thead class="table-dark">
                        <tr>
                            <th>Tháng</th>
                            <th>Tổng Đơn Hàng Hoàn Thành</th>
                            <th>Doanh Thu Thu Về</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr><td>Tháng 1</td><td>120</td><td>48,000,000 đ</td></tr>
                        <tr><td>Tháng 2</td><td>95</td><td>39,500,000 đ</td></tr>
                        </tbody>
                </table>
            </div>
        </div>
    </body>
</html>