<%-- 
    Document   : list (voucher)
    Author     : Nguyễn Trúc Mai
    Servlet    : GET /voucher
--%>

<%@page import="model.Vouchers"%>
<%@page import="java.util.List"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setAttribute("pageTitle", "Voucher giảm giá");
%>
<%@include file="/WEB-INF/include/header.jsp"%>

<%
    List<Vouchers> vouchers     = (List<Vouchers>) request.getAttribute("vouchers");
    BigDecimal subtotal         = (BigDecimal) request.getAttribute("subtotal");
    Vouchers appliedVoucher     = (Vouchers)   request.getAttribute("appliedVoucher");

    if (subtotal == null) subtotal = BigDecimal.ZERO;

    NumberFormat nf         = NumberFormat.getIntegerInstance(new Locale("vi", "VN"));
    SimpleDateFormat sdf    = new SimpleDateFormat("dd/MM/yyyy");
%>

<!-- Breadcrumb -->
<nav aria-label="breadcrumb" class="mb-3">
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="<%= request.getContextPath()%>/home">Trang chủ</a></li>
        <li class="breadcrumb-item"><a href="<%= request.getContextPath()%>/cart">Giỏ hàng</a></li>
        <li class="breadcrumb-item active">Mã giảm giá</li>
    </ol>
</nav>

<h4 class="fw-bold mb-1">🎟️ Mã giảm giá</h4>
<p class="text-muted mb-4">Chọn hoặc nhập mã để được giảm giá cho đơn hàng của bạn.</p>

<!-- Thông tin đơn hiện tại -->
<div class="alert alert-info d-flex justify-content-between align-items-center">
    <span>
        Tổng giỏ hàng: <strong class="text-danger"><%= nf.format(subtotal)%>đ</strong>
    </span>
    <% if (appliedVoucher != null) { %>
    <span>
        Đang áp dụng:
        <span class="badge bg-success fs-6"><%= appliedVoucher.getCode()%></span>
        <form method="post" action="<%= request.getContextPath()%>/voucher/remove" class="d-inline ms-2">
            <button type="submit" class="btn btn-sm btn-outline-danger">Hủy</button>
        </form>
    </span>
    <% } %>
</div>

<!-- Nhập mã thủ công -->
<div class="card shadow-sm mb-4">
    <div class="card-body">
        <h6 class="fw-semibold mb-3">Nhập mã thủ công</h6>
        <form method="post"
              action="<%= request.getContextPath()%>/voucher/apply"
              class="d-flex gap-2">
            <input type="text" name="voucherCode" class="form-control"
                   placeholder="Nhập mã giảm giá (VD: SALE20)..."
                   style="max-width:300px;"
                   value="<%= appliedVoucher != null ? appliedVoucher.getCode() : ""%>">
            <button type="submit" class="btn btn-primary">Áp dụng</button>
        </form>
    </div>
</div>

<!-- Danh sách voucher -->
<h6 class="fw-semibold mb-3">Voucher có sẵn</h6>

<% if (vouchers == null || vouchers.isEmpty()) { %>
<div class="text-center py-5 text-muted">
    <p style="font-size:3rem;">🎟️</p>
    <p>Hiện không có voucher nào khả dụng.</p>
</div>

<% } else { %>

<div class="row g-3">
    <%
        for (Vouchers v : vouchers) {
            boolean eligible  = subtotal.compareTo(v.getMinimumOrder()) >= 0;
            boolean isApplied = appliedVoucher != null
                             && appliedVoucher.getVoucherId().equals(v.getVoucherId());
            int remaining     = v.getQuantity() - v.getUsedQuantity();
            String expireStr  = v.getExpireDate() != null ? sdf.format(v.getExpireDate()) : "N/A";
            String cardClass  = isApplied ? "border-success bg-success bg-opacity-10"
                                          : (eligible ? "border-primary" : "border-secondary opacity-75");
    %>
    <div class="col-md-6 col-lg-4">
        <div class="card h-100 shadow-sm border-2 <%= cardClass %>">
            <div class="card-body">

                <!-- Phần trăm giảm -->
                <div class="d-flex justify-content-between align-items-start mb-2">
                    <span style="font-size:2.2rem;font-weight:800;color:#dc3545;">
                        −<%= v.getDiscountPercent().stripTrailingZeros().toPlainString()%>%
                    </span>
                    <% if (isApplied) { %>
                    <span class="badge bg-success">✓ Đang dùng</span>
                    <% } else if (!eligible) { %>
                    <span class="badge bg-secondary">Chưa đủ điều kiện</span>
                    <% } %>
                </div>

                <!-- Mã voucher -->
                <div class="fw-bold text-primary fs-5 mb-2">
                    <code class="bg-light px-2 py-1 rounded"><%= v.getCode()%></code>
                </div>

                <!-- Điều kiện -->
                <ul class="list-unstyled text-muted small mb-3">
                    <li>✦ Đơn tối thiểu:
                        <strong class="text-dark"><%= nf.format(v.getMinimumOrder())%>đ</strong>
                    </li>
                    <li>✦ Còn lại: <strong class="text-dark"><%= remaining%></strong> lượt</li>
                    <li>✦ Hết hạn: <strong class="text-dark"><%= expireStr%></strong></li>
                </ul>

                <!-- Cảnh báo chưa đủ điều kiện -->
                <% if (!eligible && !isApplied) {
                    BigDecimal need = v.getMinimumOrder().subtract(subtotal);
                %>
                <p class="text-warning small mb-2">
                    ⚠ Cần thêm <strong><%= nf.format(need)%>đ</strong> để dùng mã này
                </p>
                <% } %>

                <!-- Nút hành động -->
                <% if (isApplied) { %>
                <form method="post" action="<%= request.getContextPath()%>/voucher/remove">
                    <button type="submit" class="btn btn-outline-danger btn-sm w-100">
                        Hủy áp dụng
                    </button>
                </form>
                <% } else if (eligible) { %>
                <form method="post" action="<%= request.getContextPath()%>/voucher/apply">
                    <input type="hidden" name="voucherCode" value="<%= v.getCode()%>">
                    <button type="submit" class="btn btn-primary btn-sm w-100">
                        Dùng ngay
                    </button>
                </form>
                <% } else { %>
                <button class="btn btn-secondary btn-sm w-100" disabled>
                    Chưa đủ điều kiện
                </button>
                <% } %>

            </div>
        </div>
    </div>
    <% } %>
</div>

<% } %>

<!-- Nút quay lại giỏ hàng -->
<div class="mt-4">
    <a href="<%= request.getContextPath()%>/cart" class="btn btn-outline-secondary">
        ← Quay lại giỏ hàng
    </a>
</div>

<%@include file="/WEB-INF/include/footer.jsp"%>
