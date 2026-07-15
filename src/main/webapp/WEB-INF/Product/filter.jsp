<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="/WEB-INF/include/header.jsp" />
<jsp:include page="/WEB-INF/include/navbar.jsp" />

<main class="container my-5 flex-grow-1">
    <div class="row g-4">
        
        <div class="col-12 col-lg-3">
            <div class="card border-0 shadow-sm p-4 rounded-4 bg-white">
                <h5 class="fw-bold mb-4 text-dark"><i class="fa-solid fa-sliders me-2 text-primary"></i>Bộ lọc tìm kiếm</h5>
                
                <form action="${pageContext.request.contextPath}/product/filter" method="GET">
                    <div class="mb-4">
                        <label class="fw-bold text-secondary small text-uppercase mb-2" style="letter-spacing: 0.5px;">Thương hiệu</label>
                        <select name="brandId" class="form-select bg-light border-0 py-2.5 text-sm rounded-3" onchange="this.form.submit()">
                            <option value="">Tất cả thương hiệu</option>
                            <option value="1" ${selectedBrand == '1' ? 'selected' : ''}>Asus</option>
                            <option value="2" ${selectedBrand == '2' ? 'selected' : ''}>MSI</option>
                            <option value="3" ${selectedBrand == '3' ? 'selected' : ''}>Apple</option>
                        </select>
                    </div>

                    <div class="mb-4">
                        <label class="fw-bold text-secondary small text-uppercase mb-2" style="letter-spacing: 0.5px;">Mức giá</label>
                        <select name="priceRange" class="form-select bg-light border-0 py-2.5 text-sm rounded-3" onchange="this.form.submit()">
                            <option value="">Tất cả mức giá</option>
                            <option value="under-15m" ${selectedPrice == 'under-15m' ? 'selected' : ''}>Dưới 15 triệu</option>
                            <option value="15m-25m" ${selectedPrice == '15m-25m' ? 'selected' : ''}>15 - 25 triệu</option>
                            <option value="over-25m" ${selectedPrice == 'over-25m' ? 'selected' : ''}>Trên 25 triệu</option>
                        </select>
                    </div>
                    
                    <a href="${pageContext.request.contextPath}/product/filter" class="btn btn-light w-100 text-muted fw-bold btn-sm py-2 rounded-3">
                        Xóa bộ lọc
                    </a>
                </form>
            </div>
        </div>

        <div class="col-12 col-lg-9">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h4 class="fw-bold text-dark mb-0">Sản phẩm phù hợp</h4>
                <span class="text-muted small">Hiển thị ${filterList.size()} sản phẩm</span>
            </div>

            <div class="row g-4">
                <c:forEach items="${filterList}" var="p">
                    <div class="col-12 col-sm-6 col-md-4">
                        <div class="card h-100 border-0 shadow-sm d-flex flex-column justify-content-between overflow-hidden bg-white" style="border-radius: 16px;">
                            <div class="p-3">
                                <div class="bg-light rounded-4 d-flex align-items-center justify-content-center" style="height: 180px;">
                                    <c:choose>
                                        <c:when test="${not empty p.imageUrl}">
                                            <img src="${pageContext.request.contextPath}/assets/images/products/${p.imageUrl}" class="img-fluid h-100 object-fit-contain" alt="${p.productName}">
                                        </c:when>
                                        <c:otherwise>
                                            <i class="fa-solid fa-laptop fs-1 opacity-25" style="color: #0056b3;"></i>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                
                                <h6 class="fw-bold text-dark mt-3 mb-1 text-truncate-2" style="font-size: 14px; height: 38px; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;">
                                    ${p.productName}
                                </h6>
                                <p class="text-muted small mb-0">SKU: ${p.baseSKU}</p>
                            </div>
                            
                            <div class="card-footer bg-white border-0 d-flex align-items-center justify-content-between p-3 pt-0">
                                <span class="fw-bold fs-6" style="color: #0056b3;">
                                    <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                                </span>
                                <a href="${pageContext.request.contextPath}/product/detail?id=${p.productId}" class="btn btn-sm text-white px-3 fw-bold" style="background-color: #0056b3; border-radius: 8px;">
                                    Chi tiết
                                </a>
                            </div>
                        </div>
                    </div>
                </c:forEach>

                <c:if test="${empty filterList}">
                    <div class="col-12 text-center py-5">
                        <p class="text-muted">Không tìm thấy sản phẩm nào khớp với tiêu chí lọc.</p>
                    </div>
                </c:if>
            </div>
        </div>

    </div>
</main>

<jsp:include page="/WEB-INF/include/footer.jsp" />