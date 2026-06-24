<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="/WEB-INF/include/header.jsp" />
<jsp:include page="/WEB-INF/include/navbar.jsp" />

<main class="container my-5 flex-grow-1" style="min-height: 60vh;">
    <div class="mb-4">
        <h3 class="fw-bold text-dark">Kết quả tìm kiếm cho: <span class="text-secondary">"${not empty keyword ? keyword : '...'}"</span></h3>
    </div>

    <div class="row g-4">
        <c:if test="${not empty searchList}">
            <c:forEach items="${searchList}" var="p">
                <div class="col-12 col-sm-6 col-md-4 col-lg-3">
                    <div class="card h-100 border-0 shadow-sm d-flex flex-column justify-content-between overflow-hidden bg-white" style="border-radius: 12px;">
                        <div class="p-3">
                            <div class="bg-light rounded-3 d-flex align-items-center justify-content-center" style="height: 160px;">
                                <c:choose>
                                    <c:when test="${not empty p.image}">
                                        <img src="${pageContext.request.contextPath}/assets/images/${p.image}" class="img-fluid h-100 object-fit-contain" alt="${p.productName}">
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fa-solid fa-laptop fs-1 opacity-25" style="color: #0056b3;"></i>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <h6 class="fw-bold text-dark mt-3 mb-1 text-truncate" style="font-size: 14px;">
                                ${p.productName}
                            </h6>
                            <p class="text-muted small mb-0">SKU: ${p.baseSKU}</p>
                        </div>
                        <div class="card-footer bg-white border-0 d-flex align-items-center justify-content-between p-3">
                            <span class="fw-bold fs-6" style="color: #0056b3;">
                                <fmt:formatNumber value="24990000" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                            </span>
                            <a href="${pageContext.request.contextPath}/product/detail?id=${p.productId}" class="btn btn-sm text-white px-3 fw-bold" style="background-color: #0056b3; border-radius: 6px;">Chi tiết</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:if>

        <c:if test="${empty searchList}">
            <div class="col-12 text-center py-5">
                <div class="fs-1 text-muted mb-3"><i class="fa-solid fa-magnifying-glass-minus"></i></div>
                <h5 class="fw-bold text-secondary">Rất tiếc, không tìm thấy sản phẩm phù hợp!</h5>
                <p class="text-muted small">Hãy thử tìm kiếm lại với từ khóa khác xem sao nhé.</p>
                <a href="${pageContext.request.contextPath}/home" class="btn text-white px-4 mt-2" style="background-color: #0056b3; border-radius: 20px;">Quay lại trang chủ</a>
            </div>
        </c:if>
    </div>
</main>

<jsp:include page="/WEB-INF/include/footer.jsp" />