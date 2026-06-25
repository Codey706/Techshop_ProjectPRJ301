<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.CartItem" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="model.Vouchers" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.text.NumberFormat" %>

<%
    List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");
    BigDecimal subtotal = (BigDecimal) request.getAttribute("subtotal");
    BigDecimal discountAmount = (BigDecimal) request.getAttribute("discountAmount");
    BigDecimal total = (BigDecimal) request.getAttribute("total");
    Vouchers appliedVoucher = (Vouchers) request.getAttribute("appliedVoucher");

    if (subtotal == null) subtotal = BigDecimal.ZERO;
    if (discountAmount == null) discountAmount = BigDecimal.ZERO;
    if (total == null) total = BigDecimal.ZERO;

    String voucherError = (String) session.getAttribute("voucherError");
    String voucherSuccess = (String) session.getAttribute("voucherSuccess");
    session.removeAttribute("voucherError");
    session.removeAttribute("voucherSuccess");

    NumberFormat nf = NumberFormat.getIntegerInstance(new Locale("vi", "VN"));
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cart</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container py-4">

    <% if (voucherError != null) { %>
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
        <%= voucherError %>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
    <% } %>

    <% if (voucherSuccess != null) { %>
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        <%= voucherSuccess %>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
    <% } %>

    <div class="d-flex align-items-center gap-2 mb-4">
        <h3 class="fw-bold mb-0">Giỏ hàng của bạn</h3>
        <span class="badge bg-primary fs-6"><%= cartItems != null ? cartItems.size() : 0 %> sản phẩm</span>
    </div>

    <% if (cartItems == null || cartItems.isEmpty()) { %>

    <div class="text-center py-5">
        <p class="text-muted fs-4">Giỏ hàng trống</p>
        <a href="<%= request.getContextPath()%>/home" class="btn btn-primary mt-2">
            Tiếp tục mua sắm
        </a>
    </div>

    <% } else { %>

    <div class="row g-4">

        <div class="col-lg-8">

            <div class="card shadow-sm mb-4">
                <div class="card-body p-0">
                    <table class="table table-borderless align-middle mb-0">
                        <thead class="table-light">
                            <tr>
                                <th class="ps-4" style="width:45%">Sản phẩm</th>
                                <th class="text-center">Đơn giá</th>
                                <th class="text-center">Số lượng</th>
                                <th class="text-center">Thành tiền</th>
                                <th style="width:70px" class="text-center">Xóa</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (CartItem item : cartItems) { %>
                            <tr>
                                <td class="ps-4">
                                    <div class="d-flex align-items-center gap-3">
                                        <% if (item.getImageUrl() != null && !item.getImageUrl().isEmpty()) { %>
                                        <img src="<%= item.getImageUrl()%>"
                                             alt="<%= item.getProductName()%>"
                                             style="width:65px;height:65px;object-fit:cover;border-radius:8px;">
                                        <% } else { %>
                                        <div style="width:65px;height:65px;border-radius:8px;background:#f0f0f0;
                                             display:flex;align-items:center;justify-content:center;">
                                            <span class="text-muted">No image</span>
                                        </div>
                                        <% } %>
                                        <div>
                                            <div class="fw-semibold"><%= item.getProductName()%></div>
                                            <small class="text-muted"><%= item.getVariantName()%></small>
                                        </div>
                                    </div>
                                </td>

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

                                <td class="text-center">
                                    <div class="d-flex align-items-center justify-content-center gap-1">

                                        <form method="post" action="<%= request.getContextPath()%>/cart" style="display:inline;">
                                            <input type="hidden" name="action" value="update">
                                            <input type="hidden" name="cartItemId" value="<%= item.getCartItemId()%>">
                                            <input type="hidden" name="quantity" value="<%= item.getQuantity() - 1%>">
                                            <button type="submit"
                                                    class="btn btn-outline-secondary btn-sm px-2"
                                                    <%= item.getQuantity() <= 1 ? "disabled" : "" %>>-</button>
                                        </form>

                                        <form method="post"
                                              action="<%= request.getContextPath()%>/cart"
                                              id="formQty-<%= item.getCartItemId()%>">
                                            <input type="hidden" name="action" value="update">
                                            <input type="hidden" name="cartItemId" value="<%= item.getCartItemId()%>">
                                            <input type="number" name="quantity"
                                                   value="<%= item.getQuantity()%>"
                                                   min="1" max="<%= item.getStock()%>"
                                                   style="width:55px;text-align:center;"
                                                   class="form-control form-control-sm d-inline"
                                                   onchange="document.getElementById('formQty-<%= item.getCartItemId()%>').submit()">
                                        </form>

                                        <form method="post" action="<%= request.getContextPath()%>/cart" style="display:inline;">
                                            <input type="hidden" name="action" value="update">
                                            <input type="hidden" name="cartItemId" value="<%= item.getCartItemId()%>">
                                            <input type="hidden" name="quantity" value="<%= item.getQuantity() + 1%>">
                                            <button type="submit"
                                                    class="btn btn-outline-secondary btn-sm px-2"
                                                    <%= item.getQuantity() >= item.getStock() ? "disabled" : "" %>>+</button>
                                        </form>
                                    </div>

                                    <% if (item.getQuantity() >= item.getStock()) { %>
                                    <small class="text-warning d-block mt-1">Đã đạt số lượng tối đa</small>
                                    <% } %>
                                </td>

                                <td class="text-center fw-bold text-danger">
                                    <%= nf.format(item.getLineTotal())%>đ
                                </td>

                                <td class="text-center">
                                    <form method="post"
                                          action="<%= request.getContextPath()%>/cart"
                                          onsubmit="return confirm('Xóa sản phẩm này khỏi giỏ hàng?')">
                                        <input type="hidden" name="action" value="remove">
                                        <input type="hidden" name="cartItemId" value="<%= item.getCartItemId()%>">
                                        <button type="submit" class="btn btn-sm btn-outline-danger">
                                            Remove
                                        </button>
                                    </form>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="card shadow-sm">
                <div class="card-body">
                    <h5 class="fw-bold mb-3">Voucher</h5>

                    <% if (appliedVoucher != null) { %>
                    <div class="d-flex justify-content-between align-items-center flex-wrap gap-2 p-3 rounded"
                         style="background:#f8fff8;border:1px solid #d4edda;">
                        <div>
                            <div class="fw-semibold text-success">
                                Đã áp dụng mã: <%= appliedVoucher.getCode()%>
                            </div>
                            <small class="text-muted">
                                Giảm <%= appliedVoucher.getDiscountPercent()%>% cho đơn hàng
                            </small>
                        </div>

                        <form action="<%= request.getContextPath()%>/voucher" method="post" class="m-0">
                            <input type="hidden" name="action" value="remove">
                            <button type="submit" class="btn btn-outline-danger btn-sm">Xóa voucher</button>
                        </form>
                    </div>

                    <% } else { %>
                    <form method="post"
                          action="<%= request.getContextPath()%>/voucher"
                          class="d-flex gap-2 flex-wrap">
                        <input type="hidden" name="action" value="apply">
                        <input type="text" name="code" class="form-control"
                               placeholder="Nhập mã giảm giá"
                               style="max-width:260px;" required>
                        <button type="submit" class="btn btn-outline-primary">Áp dụng</button>
                    </form>
                    <% } %>
                </div>
            </div>

        </div>

        <div class="col-lg-4">
            <div class="card shadow-sm" style="position:sticky;top:20px;">
                <div class="card-body">
                    <h6 class="fw-bold mb-4">Tóm tắt đơn hàng</h6>

                    <div class="d-flex justify-content-between mb-2">
                        <span class="text-muted">Tạm tính</span>
                        <span><%= nf.format(subtotal)%>đ</span>
                    </div>

                    <% if (discountAmount.compareTo(BigDecimal.ZERO) > 0) { %>
                    <div class="d-flex justify-content-between mb-2 text-success">
                        <span>
                            Giảm giá
                            <% if (appliedVoucher != null) { %>
                                (<%= appliedVoucher.getDiscountPercent()%>%)
                            <% } %>
                        </span>
                        <span>-<%= nf.format(discountAmount)%>đ</span>
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
                        Thanh toán
                    </a>
                    <a href="<%= request.getContextPath()%>/home"
                       class="btn btn-outline-secondary w-100">
                        Tiếp tục mua sắm
                    </a>
                </div>
            </div>
        </div>

    </div>

    <% } %>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>