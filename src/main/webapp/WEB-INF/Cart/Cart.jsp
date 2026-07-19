<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="model.CartItem" %>
<%@ page import="model.Vouchers" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.text.NumberFormat" %>
<%@include file="/WEB-INF/include/header.jsp" %>
<%
    List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");
    BigDecimal subtotal       = (BigDecimal) request.getAttribute("subtotal");
    BigDecimal discountAmount = (BigDecimal) request.getAttribute("discountAmount");
    BigDecimal total          = (BigDecimal) request.getAttribute("total");
    Vouchers appliedVoucher   = (Vouchers) request.getAttribute("appliedVoucher");

    if (subtotal       == null) subtotal       = BigDecimal.ZERO;
    if (discountAmount == null) discountAmount = BigDecimal.ZERO;
    if (total          == null) total          = BigDecimal.ZERO;

    NumberFormat nf = NumberFormat.getIntegerInstance(new Locale("vi", "VN"));
    int totalQty = 0;
    if (cartItems != null)
        for (CartItem ci : cartItems)
            totalQty += (ci.getQuantity() != null ? ci.getQuantity() : 0);
%>

<%@include file="/WEB-INF/include/navbar.jsp" %>

<style>
    body { background-color: #fff; }

    input[type=checkbox] { accent-color: #1C56B3; width: 18px; height: 18px; cursor: pointer; }

    .shop-card-header { background-color: #3E8FFD; border-bottom: 1px solid #d1c4e9; }

    .badge-variant { background-color: #3E8FFD; color: #F8FAFD; font-weight: 500; }

    .btn-qty { width: 30px; height: 30px; padding: 0; line-height: 1; border-color: #d1c4e9; color: #6c3fc5; }
    .btn-qty:hover { background-color: #ede7f6; border-color: #6c3fc5; }
    .qty-input { width: 42px; text-align: center; border-color: #d1c4e9; }

    .price-original { text-decoration: line-through; color: #9e9e9e; font-size: .82rem; }
    .price-sale     { color: #6c3fc5; font-weight: 600; }
    .line-total     { color: #e53935; font-weight: 700; }

    .voucher-bar { border-top: 1px dashed #d1c4e9; }

    .cart-footer {
        position: sticky; bottom: 0; z-index: 100;
        background: #fff;
        border-top: 2px solid #ede7f6;
        box-shadow: 0 -2px 12px rgba(108,63,197,.12);
    }

    .btn-buy { background: #1C56B3; border: none; font-weight: 600; }
    .btn-buy:hover { opacity: .88; color: #96C9DF; }

    .col-header { background: #f8f9fa; border-radius: 10px; font-size: .85rem; }

    .item-row { border-bottom: 1px solid #f5f5f5; }
    .item-row:last-of-type { border-bottom: none; }
    .item-row:hover { background-color: #96C9DF; }
</style>

<div class="container-lg py-4">

<%-- ── EMPTY ── --%>
<% if (cartItems == null || cartItems.isEmpty()) { %>
<div class="bg-white rounded-3 border text-center py-5">
    <i class="fa-solid fa-cart-xmark fa-4x text-secondary mb-3"></i>
    <p class="fw-semibold fs-5 mb-1">Giỏ hàng của bạn đang trống</p>
    <p class="text-muted mb-4">Hãy thêm sản phẩm vào giỏ hàng nhé!</p>
    <a href="${pageContext.request.contextPath}/home" class="btn btn-buy text-white px-5 py-2">Tiếp tục mua sắm</a>
</div>

<%-- ── HAS ITEMS ── --%>
<% } else { %>

<!-- Column header -->
<div class="col-header d-none d-md-block mb-3 px-3 py-2 rounded-3 border">
    <div class="row align-items-center text-muted">
        <div class="col-1 text-center"><input type="checkbox" id="checkAll" onclick="toggleAll(this)"></div>
        <div class="col-4">Sản phẩm</div>
        <div class="col-2 text-center">Đơn giá</div>
        <div class="col-2 text-center">Số lượng</div>
        <div class="col-2 text-center">Số tiền</div>
        <div class="col-1 text-center">Xóa</div>
    </div>
</div>

<!-- Shop group -->
<div class="card border rounded-3 mb-4 overflow-hidden">
    <div class="shop-card-header px-3 py-2 d-flex align-items-center gap-2">
        <input type="checkbox" onclick="toggleAll(this)">
        <i class="fa-solid fa-store" style="color:#F8FAFD"></i>
        <span class="fw-semibold" style="color:#F8FAFD">MiraiStore</span>
    </div>

    <% for (CartItem item : cartItems) {
        boolean hasDiscount = item.getOriginalPrice() != null
            && item.getOriginalPrice().compareTo(item.getPrice()) > 0;
    %>
    <div class="item-row px-3 py-3">
        <div class="row align-items-center">

            <div class="col-1 text-center">
                <input type="checkbox" class="item-check" value="<%= item.getCartItemId() %>">
            </div>

            <div class="col-md-4 col-8 d-flex align-items-center gap-3">
                <img src="<%= item.getImageUrl() != null ? item.getImageUrl() : "" %>"
                     alt="<%= item.getProductName() %>"
                     class="rounded-2 border"
                     style="width:72px;height:72px;object-fit:cover;flex-shrink:0">
                <div>
                    <div class="fw-semibold small mb-1"><%= item.getProductName() %></div>
                    <span class="badge badge-variant rounded-pill small">
                        <i class="fa-solid fa-tag me-1" style="font-size:.65rem"></i><%= item.getVariantName() %>
                    </span>
                </div>
            </div>

            <div class="col-md-2 col-3 text-center mt-2 mt-md-0">
                <% if (hasDiscount) { %>
                <div class="price-original"><%= nf.format(item.getOriginalPrice()) %>đ</div>
                <% } %>
                <div class="price-sale"><%= nf.format(item.getPrice()) %>đ</div>
            </div>

            <div class="col-md-2 col-12 d-flex justify-content-center mt-2 mt-md-0">
                <div class="input-group" style="width:108px">
                    <form action="${pageContext.request.contextPath}/cart" method="POST" style="display:contents">
                        <input type="hidden" name="action"    value="decrease">
                        <input type="hidden" name="variantId" value="<%= item.getVariantId() %>">
                        <button type="submit" class="btn btn-outline-secondary btn-qty">−</button>
                    </form>
                    <input type="text" class="form-control qty-input" value="<%= item.getQuantity() %>" readonly>
                    <form action="${pageContext.request.contextPath}/cart" method="POST" style="display:contents">
                        <input type="hidden" name="action"    value="increase">
                        <input type="hidden" name="variantId" value="<%= item.getVariantId() %>">
                        <button type="submit" class="btn btn-outline-secondary btn-qty">+</button>
                    </form>
                </div>
            </div>

            <div class="col-md-2 col-6 text-center mt-2 mt-md-0 line-total">
                <%= nf.format(item.getLineTotal()) %>đ
            </div>

            <div class="col-md-1 col-6 text-center mt-2 mt-md-0">
                <form action="${pageContext.request.contextPath}/cart" method="POST">
                    <input type="hidden" name="action"     value="remove">
                    <input type="hidden" name="cartItemId" value="<%= item.getCartItemId() %>">
                    <button type="submit" class="btn btn-link text-danger p-0 small">Xóa</button>
                </form>
            </div>

        </div>
    </div>
    <% } %>

    <div class="voucher-bar px-3 py-2 d-flex align-items-center gap-2 small">
        <i class="fa-solid fa-ticket" style="color:#4fc3f7"></i>
        <span class="text-muted">Voucher của Shop</span>
        <% if (appliedVoucher != null) { %>
            <span class="text-success fw-semibold"><%= appliedVoucher.getCode() %> đã áp dụng</span>
            <a href="${pageContext.request.contextPath}/voucher" class="fw-semibold text-decoration-none ms-2" style="color:#6c3fc5">Đổi voucher khác</a>
        <% } else { %>
            <a href="${pageContext.request.contextPath}/voucher" class="fw-semibold text-decoration-none" style="color:#6c3fc5">Xem thêm voucher</a>
        <% } %>
    </div>
</div>

<% } %>
</div>

<%-- ── Sticky footer ── --%>
<% if (cartItems != null && !cartItems.isEmpty()) { %>
<div class="cart-footer py-3 px-4">
    <div class="d-flex align-items-center justify-content-between flex-wrap gap-3">
        <div class="d-flex align-items-center gap-3">
            <label class="d-flex align-items-center gap-2 text-muted small mb-0" style="cursor:pointer">
                <input type="checkbox" id="footerCheck" onclick="toggleAll(this)">
                Chọn tất cả (<%= cartItems.size() %>)
            </label>
            <form action="${pageContext.request.contextPath}/cart" method="POST"
                  onsubmit="return confirm('Bạn có chắc muốn xóa toàn bộ sản phẩm trong giỏ hàng?');">
                <input type="hidden" name="action" value="clearAll">
                <button type="submit" class="btn btn-link text-danger small text-decoration-none p-0 border-0 align-baseline">Xóa</button>
            </form>
        </div>
        <div class="d-flex align-items-center gap-4">
            <div class="text-end">
                <div class="text-muted small">Tổng cộng (<%= totalQty %> sản phẩm):</div>
                <div class="fw-bold fs-5" style="color:#e53935"><%= nf.format(total) %>đ</div>
                <% if (discountAmount.compareTo(BigDecimal.ZERO) > 0) { %>
                <div class="small" style="color:#6c3fc5">Tiết kiệm <%= nf.format(discountAmount) %>đ</div>
                <% } %>
            </div>
            <a href="${pageContext.request.contextPath}/order">
                <button class="btn btn-buy text-white px-5 py-2 rounded-3">Mua Hàng</button>
            </a>
        </div>
    </div>
</div>
<% } %>

<%@include file="/WEB-INF/include/footer.jsp" %>
<script>
function toggleAll(src) {
    const checked = src.checked;
    document.querySelectorAll('.item-check, #checkAll, #footerCheck')
            .forEach(cb => cb.checked = checked);
}
</script>
