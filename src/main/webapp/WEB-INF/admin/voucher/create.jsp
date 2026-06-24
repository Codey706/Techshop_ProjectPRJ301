<%-- 
    Document   : create
    Created on : Jun 22, 2026, 12:17:06 PM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Voucher giảm giá - TechShop</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.css">
    <style>
        body { background: #f8f9fa; }
        .voucher-card {
            border: 2px dashed #dee2e6;
            border-radius: 12px;
            transition: border-color .2s;
            position: relative;
            overflow: hidden;
        }
        .voucher-card:hover { border-color: #0d6efd; }
        .voucher-card.applied { border-color: #198754; background: #f0fff4; }
        .voucher-card.disabled-voucher { opacity: 0.55; pointer-events: none; }
        .voucher-badge {
            position: absolute;
            top: 12px; right: -24px;
            background: #0d6efd; color: white;
            padding: 2px 32px;
            font-size: 0.75rem;
            transform: rotate(45deg);
        }
        .voucher-badge.success { background: #198754; }
        .discount-big { font-size: 2rem; font-weight: 800; color: #dc3545; }
        .apply-btn { min-width: 110px; }
    </style>
</head>
<body>

<div class="container py-4">
    <div class="d-flex align-items-center gap-3 mb-4">
        <a href="${pageContext.request.contextPath}/cart" class="btn btn-outline-secondary btn-sm">
            ← Quay lại giỏ hàng
        </a>
        <h4 class="fw-bold mb-0">🎟️ Mã giảm giá khả dụng</h4>
    </div>

    <%-- Thông tin đơn hàng hiện tại --%>
    <div class="alert alert-info mb-4">
        Tổng giỏ hàng của bạn: <strong>
            <fmt:formatNumber value="${subtotal}" type="number" groupingUsed="true"/>đ
        </strong>
        <c:if test="${not empty appliedVoucher}">
            — Đang áp dụng: <span class="badge bg-success">${appliedVoucher.code}</span>
        </c:if>
    </div>

    <%-- Nhập thủ công --%>
    <div class="card shadow-sm mb-4">
        <div class="card-body">
            <h6 class="fw-semibold mb-3">Nhập mã thủ công</h6>
            <form method="post" action="${pageContext.request.contextPath}/voucher/apply"
                  class="d-flex gap-2">
                <input type="text" name="voucherCode" class="form-control"
                       placeholder="Nhập mã giảm giá..." style="max-width:300px;"
                       value="${not empty appliedVoucher ? appliedVoucher.code : ''}">
                <button type="submit" class="btn btn-primary apply-btn">Áp dụng</button>
            </form>
        </div>
    </div>

    <%-- Danh sách voucher --%>
    <c:choose>
        <c:when test="${empty vouchers}">
            <div class="text-center py-5 text-muted">
                <p class="fs-5">Hiện không có voucher nào khả dụng.</p>
            </div>
        </c:when>
        <c:otherwise>
            <div class="row g-3">
                <c:forEach var="v" items="${vouchers}">
                    <%-- Kiểm tra đủ điều kiện đơn tối thiểu --%>
                    <c:set var="eligible" value="${subtotal ge v.minimumOrder}"/>
                    <%-- Kiểm tra đang được áp dụng --%>
                    <c:set var="isApplied" value="${not empty appliedVoucher and appliedVoucher.voucherId eq v.voucherId}"/>

                    <div class="col-md-6 col-lg-4">
                        <div class="voucher-card p-4 h-100 ${isApplied ? 'applied' : ''} ${not eligible ? 'disabled-voucher' : ''}">

                            <%-- Ribbon --%>
                            <c:if test="${isApplied}">
                                <div class="voucher-badge success">Đang dùng</div>
                            </c:if>

                            <%-- Phần trăm giảm --%>
                            <div class="discount-big mb-1">
                                -<fmt:formatNumber value="${v.discountPercent}" maxFractionDigits="0"/>%
                            </div>
                            <div class="fw-semibold text-primary mb-1">${v.code}</div>

                            <ul class="list-unstyled text-muted small mb-3">
                                <li>✦ Đơn tối thiểu:
                                    <strong><fmt:formatNumber value="${v.minimumOrder}" type="number" groupingUsed="true"/>đ</strong>
                                </li>
                                <li>✦ Còn lại: <strong>${v.quantity - v.usedQuantity}</strong> lượt</li>
                                <li>✦ HSD: <strong>
                                    <fmt:formatDate value="${v.expireDate}" pattern="dd/MM/yyyy"/>
                                </strong></li>
                            </ul>

                            <c:if test="${not eligible}">
                                <p class="text-warning small mb-2">
                                    ⚠ Cần thêm
                                    <fmt:formatNumber value="${v.minimumOrder - subtotal}" type="number" groupingUsed="true"/>đ
                                    để dùng mã này
                                </p>
                            </c:if>

                            <%-- Nút áp dụng / hủy --%>
                            <c:choose>
                                <c:when test="${isApplied}">
                                    <form method="post" action="${pageContext.request.contextPath}/voucher/remove">
                                        <button type="submit" class="btn btn-outline-danger btn-sm w-100">
                                            Hủy áp dụng
                                        </button>
                                    </form>
                                </c:when>
                                <c:when test="${eligible}">
                                    <form method="post" action="${pageContext.request.contextPath}/voucher/apply">
                                        <input type="hidden" name="voucherCode" value="${v.code}">
                                        <button type="submit" class="btn btn-primary btn-sm w-100 apply-btn">
                                            Dùng ngay
                                        </button>
                                    </form>
                                </c:when>
                                <c:otherwise>
                                    <button class="btn btn-secondary btn-sm w-100" disabled>
                                        Chưa đủ điều kiện
                                    </button>
                                </c:otherwise>
                            </c:choose>

                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.js"></script>
</body>
</html>