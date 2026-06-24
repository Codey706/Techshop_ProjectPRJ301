<%@page import="model.CartItem"%>
<%@page import="model.Vouchers"%>
<%@page import="java.util.List"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setAttribute("pageTitle", "Giỏ hàng");
%>
<%@include file="/WEB-INF/include/header.jsp"%>

<%
    List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");
    BigDecimal subtotal      = (BigDecimal) request.getAttribute("subtotal");
    BigDecimal discountAmount= (BigDecimal) request.getAttribute("discountAmount");
    BigDecimal total         = (BigDecimal) request.getAttribute("total");
    Vouchers appliedVoucher  = (Vouchers)   request.getAttribute("appliedVoucher");

    if (subtotal       == null) subtotal        = BigDecimal.ZERO;
    if (discountAmount == null) discountAmount   = BigDecimal.ZERO;
    if (total          == null) total            = BigDecimal.ZERO;

    // Lấy thông báo từ session (nếu có)
    String voucherError   = (String) session.getAttribute("voucherError");
    String voucherSuccess = (String) session.getAttribute("voucherSuccess");
    session.removeAttribute("voucherError");
    session.removeAttribute("voucherSuccess");

    // Format tiền VND
    NumberFormat nf = NumberFormat.getIntegerInstance(new Locale("vi", "VN"));
%>

<!-- Toast thông báo -->
<% if (voucherError != null) { %>
<div class="alert alert-danger alert-dismissible fade show" role="alert">
    ⚠️ <%= voucherError %>
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
</div>
<% } %>
<% if (voucherSuccess != null) { %>
<div class="alert alert-success alert-dismissible fade show" role="alert">
    ✅ <%= voucherSuccess %>
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
</div>
<% } %>

<div class="d-flex align-items-center gap-2 mb-4">
    <h3 class="fw-bold mb-0">🛒 Giỏ hàng của bạn</h3>
    <span class="badge bg-primary fs-6"><%= cartItems != null ? cartItems.size() : 0 %> sản phẩm</span>
</div>

<% if (cartItems == null || cartItems.isEmpty()) { %>

<!-- Giỏ hàng trống -->
<div class="text-center py-5">
    <p style="font-size:5rem;">🛒</p>
    <p class="text-muted fs-5">Giỏ hàng của bạn đang trống.</p>
    <a href="<%= request.getContextPath()%>/products" class="btn btn-primary mt-2">
        Tiếp tục mua sắm
    </a>
</div>

<% } else { %>

<div class="row g-4">

    <!-- ==================== CỘT TRÁI: Danh sách sản phẩm + Voucher ==================== -->
    <div class="col-lg-8">

        <!-- Danh sách sản phẩm -->
        <div class="card shadow-sm mb-4">
            <div class="card-body p-0">
                <table class="table table-borderless align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th class="ps-4" style="width:45%">Sản phẩm</th>
                            <th class="text-center">Đơn giá</th>
                            <th class="text-center">Số lượng</th>
                            <th class="text-center">Thành tiền</th>
                            <th style="width:40px"></th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (CartItem item : cartItems) { %>
                        <tr>
                            <!-- Ảnh + Tên -->
                            <td class="ps-4">
                                <div class="d-flex align-items-center gap-3">
                                    <% if (item.getImageUrl() != null && !item.getImageUrl().isEmpty()) { %>
                                    <img src="<%= item.getImageUrl()%>"
                                         alt="<%= item.getProductName()%>"
                                         style="width:65px;height:65px;object-fit:cover;border-radius:8px;">
                                    <% } else { %>
                                    <div style="width:65px;height:65px;border-radius:8px;background:#f0f0f0;
                                                display:flex;align-items:center;justify-content:center;">
                                        <span class="text-muted" style="font-size:1.5rem;">📦</span>
                                    </div>
                                    <% } %>
                                    <div>
                                        <div class="fw-semibold"><%= item.getProductName()%></div>
                                        <small class="text-muted"><%= item.getVariantName()%></small>
                                    </div>
                                </div>
                            </td>

                            <!-- Đơn giá -->
                            <td class="text-center">
                                <span class="text-danger fw-bold">
                                    <%= nf.format(item.getPrice())%>đ
                                </span>
                                <% if (item.getOriginalPrice() != null && item.getOriginalPrice().compareTo(item.getPrice()) > 0) { %>
                                <br>
                                <small class="text-muted text-decoration-line-through">
                                    <%= nf.format(item.getOriginalPrice())%>đ
                                </small>
                                <% } %>
                            </td>

                            <!-- Số lượng -->
                            <td class="text-center">
                                <div class="d-flex align-items-center justify-content-center gap-1">
                                    <!-- Nút giảm -->
                                    <form method="post"
                                          action="<%= request.getContextPath()%>/cart/update"
                                          style="display:inline;">
                                        <input type="hidden" name="cartItemId" value="<%= item.getCartItemId()%>">
                                        <input type="hidden" name="quantity"   value="<%= item.getQuantity() - 1%>">
                                        <button type="submit"
                                                class="btn btn-outline-secondary btn-sm px-2"
                                                <%= item.getQuantity() <= 1 ? "disabled" : "" %>>−</button>
                                    </form>

                                    <!-- Số lượng (form submit onchange) -->
                                    <form method="post"
                                          action="<%= request.getContextPath()%>/cart/update"
                                          id="formQty-<%= item.getCartItemId()%>">
                                        <input type="hidden" name="cartItemId" value="<%= item.getCartItemId()%>">
                                        <input type="number" name="quantity"
                                               value="<%= item.getQuantity()%>"
                                               min="1" max="<%= item.getStock()%>"
                                               style="width:55px;text-align:center;"
                                               class="form-control form-control-sm d-inline"
                                               onchange="document.getElementById('formQty-<%= item.getCartItemId()%>').submit()">
                                    </form>

                                    <!-- Nút tăng -->
                                    <form method="post"
                                          action="<%= request.getContextPath()%>/cart/update"
                                          style="display:inline;">
                                        <input type="hidden" name="cartItemId" value="<%= item.getCartItemId()%>">
                                        <input type="hidden" name="quantity"   value="<%= item.getQuantity() + 1%>">
                                        <button type="submit"
                                                class="btn btn-outline-secondary btn-sm px-2"
                                                <%= item.getQuantity() >= item.getStock() ? "disabled" : "" %>>+</button>
                                    </form>
                                </div>

                                <% if (item.getQuantity() >= item.getStock()) { %>
                                <small class="text-warning d-block mt-1">Đã đạt tối đa</small>
                                <% } %>
                            </td>

                            <!-- Thành tiền -->
                            <td class="text-center fw-bold text-danger">
                                <%= nf.format(item.getLineTotal())%>đ
                            </td>

                            <!-- Xóa -->
                            <td class="pe-3">
                                <form method="post"
                                      action="<%= request.getContextPath()%>/cart/remove"
                                      onsubmit="return confirm('Xóa sản phẩm này khỏi giỏ hàng?')">
                                    <input type="hidden" name="cartItemId" value="<%= item.getCartItemId()%>">
                                    <button type="submit" class="btn btn-link text-danger p-0" title="Xóa">
                                        🗑️
                                    </button>
                                </form>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- ==================== VOUCHER SECTION ==================== -->
        <div class="card shadow-sm">
            <div class="card-body">
                <h6 class="fw-bold mb-3">🎟️ Mã giảm giá</h6>

                <% if (appliedVoucher != null) { %>
                <!-- Đang có voucher được áp dụng -->
                <div class="alert alert-success d-flex justify-content-between align-items-center mb-0">
                    <div>
                        ✅ Đang áp dụng: <strong><%= appliedVoucher.getCode()%></strong>
                        — Giảm <strong><%= appliedVoucher.getDiscountPercent()%>%</strong>
                        <span class="text-muted">(Đơn tối thiểu: <%= nf.format(appliedVoucher.getMinimumOrder())%>đ)</span>
                    </div>
                    <form method="post" action="<%= request.getContextPath()%>/voucher/remove">
                        <button type="submit" class="btn btn-sm btn-outline-danger ms-3">Hủy</button>
                    </form>
                </div>

                <% } else { %>
                <!-- Chưa áp dụng voucher -->
                <form method="post"
                      action="<%= request.getContextPath()%>/voucher/apply"
                      class="d-flex gap-2 flex-wrap">
                    <input type="text" name="voucherCode" class="form-control"
                           placeholder="Nhập mã giảm giá..."
                           style="max-width:260px;" required>
                    <button type="submit" class="btn btn-outline-primary">Áp dụng</button>
                    <a href="<%= request.getContextPath()%>/voucher"
                       class="btn btn-link text-decoration-none px-0">
                        Xem tất cả voucher →
                    </a>
                </form>
                <% } %>
            </div>
        </div>

    </div><!-- end col-lg-8 -->


    <!-- ==================== CỘT PHẢI: Tóm tắt đơn hàng ==================== -->
    <div class="col-lg-4">
        <div class="card shadow-sm" style="position:sticky;top:20px;">
            <div class="card-body">
                <h6 class="fw-bold mb-4">📋 Tóm tắt đơn hàng</h6>

                <div class="d-flex justify-content-between mb-2">
                    <span class="text-muted">Tạm tính</span>
                    <span><%= nf.format(subtotal)%>đ</span>
                </div>

                <% if (discountAmount.compareTo(BigDecimal.ZERO) > 0) { %>
                <div class="d-flex justify-content-between mb-2 text-success">
                    <span>Giảm giá (<%= appliedVoucher != null ? appliedVoucher.getDiscountPercent() : "" %>%)</span>
                    <span>−<%= nf.format(discountAmount)%>đ</span>
                </div>
                <% } %>

                <div class="d-flex justify-content-between mb-2">
                    <span class="text-muted">Phí vận chuyển</span>
                    <span class="text-success small">Tính ở bước tiếp theo</span>
                </div>

                <hr>

                <div class="d-flex justify-content-between fw-bold fs-5 mb-4">
                    <span>Tổng cộng</span>
                    <span class="text-danger"><%= nf.format(total)%>đ</span>
                </div>

                <a href="<%= request.getContextPath()%>/payment"
                   class="btn btn-danger w-100 py-2 fw-semibold mb-2">
                    Thanh toán →
                </a>
                <a href="<%= request.getContextPath()%>/products"
                   class="btn btn-outline-secondary w-100">
                    ← Tiếp tục mua sắm
                </a>
            </div>
        </div>
    </div>

</div><!-- end row -->

<% } %>

<%@include file="/WEB-INF/include/footer.jsp"%>
