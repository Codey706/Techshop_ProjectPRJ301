<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="java.util.Locale"%>
<%@page import="model.Vouchers"%>
<%@page import="model.Vouchers"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>

<jsp:include page="/WEB-INF/include/header.jsp" />
<jsp:include page="/WEB-INF/include/navbar.jsp" />

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
        <li class="breadcrumb-item"><a href="<%= request.getContextPath()%>/home">Trang ch?</a></li>
        <li class="breadcrumb-item"><a href="<%= request.getContextPath()%>/cart">Gi? hàng</a></li>
        <li class="breadcrumb-item active">Mã gi?m giá</li>
    </ol>
</nav>

<h4 class="fw-bold mb-1">?? Mã gi?m giá</h4>
<p class="text-muted mb-4">Ch?n ho?c nh?p mã ?? ???c gi?m giá cho ??n hàng c?a b?n.</p>

<!-- Thông tin ??n hi?n t?i -->
<div class="alert alert-info d-flex justify-content-between align-items-center">
    <span>
        T?ng gi? hàng: <strong class="text-danger"><%= nf.format(subtotal)%>?</strong>
    </span>
    <% if (appliedVoucher != null) { %>
    <span>
        ?ang áp d?ng:
        <span class="badge bg-success fs-6"><%= appliedVoucher.getCode()%></span>
        <form method="post" action="<%= request.getContextPath()%>/voucher/remove" class="d-inline ms-2">
            <button type="submit" class="btn btn-sm btn-outline-danger">H?y</button>
        </form>
    </span>
    <% } %>
</div>

<!-- Nh?p mã th? công -->
<div class="card shadow-sm mb-4">
    <div class="card-body">
        <h6 class="fw-semibold mb-3">Nh?p mã th? công</h6>
        <form method="post"
              action="<%= request.getContextPath()%>/voucher/apply"
              class="d-flex gap-2">
            <input type="text" name="voucherCode" class="form-control"
                   placeholder="Nh?p mã gi?m giá (VD: SALE20)..."
                   style="max-width:300px;"
                   value="<%= appliedVoucher != null ? appliedVoucher.getCode() : ""%>">
            <button type="submit" class="btn btn-primary">Áp d?ng</button>
        </form>
    </div>
</div>

<!-- Danh sách voucher -->
<h6 class="fw-semibold mb-3">Voucher có s?n</h6>

<% if (vouchers == null || vouchers.isEmpty()) { %>
<div class="text-center py-5 text-muted">
    <p style="font-size:3rem;">??</p>
    <p>Hi?n không có voucher nào kh? d?ng.</p>
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

                <!-- Ph?n tr?m gi?m -->
                <div class="d-flex justify-content-between align-items-start mb-2">
                    <span style="font-size:2.2rem;font-weight:800;color:#dc3545;">
                        ?<%= v.getDiscountPercent().stripTrailingZeros().toPlainString()%>%
                    </span>
                    <% if (isApplied) { %>
                    <span class="badge bg-success">? ?ang dùng</span>
                    <% } else if (!eligible) { %>
                    <span class="badge bg-secondary">Ch?a ?? ?i?u ki?n</span>
                    <% } %>
                </div>

                <!-- Mã voucher -->
                <div class="fw-bold text-primary fs-5 mb-2">
                    <code class="bg-light px-2 py-1 rounded"><%= v.getCode()%></code>
                </div>

                <!-- ?i?u ki?n -->
                <ul class="list-unstyled text-muted small mb-3">
                    <li>? ??n t?i thi?u:
                        <strong class="text-dark"><%= nf.format(v.getMinimumOrder())%>?</strong>
                    </li>
                    <li>? Còn l?i: <strong class="text-dark"><%= remaining%></strong> l??t</li>
                    <li>? H?t h?n: <strong class="text-dark"><%= expireStr%></strong></li>
                </ul>

                <!-- C?nh báo ch?a ?? ?i?u ki?n -->
                <% if (!eligible && !isApplied) {
                    BigDecimal need = v.getMinimumOrder().subtract(subtotal);
                %>
                <p class="text-warning small mb-2">
                    ? C?n thêm <strong><%= nf.format(need)%>?</strong> ?? dùng mã này
                </p>
                <% } %>

                <!-- Nút hành ??ng -->
                <% if (isApplied) { %>
                <form method="post" action="<%= request.getContextPath()%>/voucher/remove">
                    <button type="submit" class="btn btn-outline-danger btn-sm w-100">
                        H?y áp d?ng
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
                    Ch?a ?? ?i?u ki?n
                </button>
                <% } %>

            </div>
        </div>
    </div>
    <% } %>
</div>

<% } %>

<!-- Nút quay l?i gi? hàng -->
<div class="mt-4">
    <a href="<%= request.getContextPath()%>/cart" class="btn btn-outline-secondary">
        ? Quay l?i gi? hàng
    </a>
</div>

<%@include file="/WEB-INF/include/footer.jsp"%>
