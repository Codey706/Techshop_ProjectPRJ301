<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="/WEB-INF/include/header.jsp" />
<jsp:include page="/WEB-INF/include/navbar.jsp" />

<main class="container my-5 flex-grow-1">

    <nav aria-label="breadcrumb" class="mb-4">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home" class="text-decoration-none">Trang chủ</a></li>
            <li class="breadcrumb-item active" aria-current="page">${product.productName}</li>
        </ol>
    </nav>

    <div class="row g-5 mb-5">
        <div class="col-12 col-md-6">
            <div class="bg-light rounded-4 d-flex align-items-center justify-content-center p-4 shadow-sm" style="min-height: 400px;">
                <%-- Hình chữ nhật giả lập ảnh sản phẩm (Placeholder) --%>
                <div class="w-100 d-flex flex-column align-items-center justify-content-center bg-secondary-subtle border rounded-4 text-secondary" style="height: 380px;">
                    <i class="fa-regular fa-image fs-1 mb-2"></i>
                    <span class="fw-semibold" data-vi="Hình ảnh sản phẩm" data-en="Product Image">Hình ảnh sản phẩm</span>
                </div>
                <i class="fa-solid fa-laptop opacity-25" style="font-size: 120px; color: #0056b3;"></i>
            
    </div>
</div>

<div class="col-12 col-md-6 d-flex flex-column justify-content-between">
    <div>
        <span class="badge mb-2 px-3 py-2" style="background-color: #0056b3;">Mã SKU: ${product.baseSKU}</span>
        <h2 class="fw-bold text-dark mb-3">${product.productName}</h2>
        <h3 class="fw-bold mb-4" style="color: #0056b3;">
            <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
        </h3>
        <div class="d-flex gap-4 mb-4 text-muted small">
            <span><i class="fa-solid fa-eye me-1"></i> Lượt xem: <strong>${product.views}</strong></span>
            <span><i class="fa-solid fa-fire me-1"></i> Đã bán: <strong>${product.sold}</strong></span>
        </div>
        <hr>
        <h6 class="fw-bold text-dark mb-2">Thông số cấu hình nổi bật:</h6>
        <div class="p-3 bg-light rounded-3 text-secondary" style="white-space: pre-line;">
            ${product.description}
        </div>
    </div>

    <div class="mt-4 row g-3">
        <div class="col-12 col-sm-6">
            <form action="${pageContext.request.contextPath}/cart" method="POST">
                <input type="hidden" name="productId" value="${product.productId}">
                <button type="submit" class="btn btn-outline-dark w-100 py-2.5 fw-bold" style="border-radius: 8px;">
                    <i class="fa-solid fa-cart-plus me-2"></i>Thêm vào giỏ hàng
                </button>
            </form>
        </div>
        <div class="col-12 col-sm-6">
            <a href="#" class="btn text-white w-100 py-2.5 fw-bold" style="background-color: #0056b3; border-radius: 8px;">Mua ngay</a>
        </div>
    </div>
</div>
</div>

<hr class="my-5">

<h4 class="fw-bold mb-4">Sản phẩm tương tự dành cho bạn</h4>
<div class="row g-4">
    <c:forEach items="${productList}" var="p">
        <div class="col-12 col-sm-6 col-md-4 col-lg-3">
            <div class="card h-100 border-0 shadow-sm d-flex flex-column justify-content-between overflow-hidden">
                <div class="p-3">
                    <div class="bg-light rounded-3 d-flex align-items-center justify-content-center" style="height: 160px;">
                        <c:choose>
                            <c:when test="${not empty p.imageUrl}">
                                <img src="${pageContext.request.contextPath}/assets/images/products/${p.imageUrl}" class="img-fluid h-100 object-fit-contain" alt="${p.productName}">
                            </c:when>
                            <c:otherwise>
                                <i class="fa-solid fa-laptop fs-1 opacity-50" style="color: #0056b3;"></i>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <h6 class="fw-bold text-dark mt-3 mb-1 text-truncate-2" style="font-size: 14px; height: 38px; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;">
                        ${p.productName}
                    </h6>
                    <p class="text-muted small mb-0">SKU: ${p.baseSKU}</p>
                </div>
                <div class="card-footer bg-light border-0 d-flex align-items-center justify-content-between p-3">
                    <span class="fw-bold fs-6" style="color: #0056b3;">
                        <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                    </span>
                    <a href="${pageContext.request.contextPath}/product/detail?id=${p.productId}&page=${currentPage}" class="btn btn-sm text-white px-3" style="background-color: #0056b3;">Xem chi tiết</a>
                </div>
            </div>
        </div>
    </c:forEach>
</div>

<nav class="mt-5">
    <ul class="pagination justify-content-center">
        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
            <a class="page-link" href="${pageContext.request.contextPath}/product/detail?id=${product.productId}&page=${currentPage - 1}">Trước</a>
        </li>
        <c:forEach begin="1" end="${totalPages}" var="i">
            <li class="page-item ${currentPage == i ? 'active' : ''}">
                <a class="page-link" href="${pageContext.request.contextPath}/product/detail?id=${product.productId}&page=${i}">${i}</a>
            </li>
        </c:forEach>
        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
            <a class="page-link" href="${pageContext.request.contextPath}/product/detail?id=${product.productId}&page=${currentPage + 1}">Sau</a>
        </li>
    </ul>
</nav>
</main>

<jsp:include page="/WEB-INF/include/footer.jsp" />