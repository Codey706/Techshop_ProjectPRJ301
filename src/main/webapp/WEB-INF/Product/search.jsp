<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="/WEB-INF/include/header.jsp" />
<jsp:include page="/WEB-INF/include/navbar.jsp" />

<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/search.css">

<c:if test="${empty searchList}">
    <jsp:useBean id="mockList" class="java.util.ArrayList" scope="request"/>

    <jsp:useBean id="p1" class="java.util.HashMap" scope="request"/>
    <c:set target="${p1}" property="productId" value="1"/>
    <c:set target="${p1}" property="productName" value="Laptop Asus Vivobook 14 X1404VA-NK124W"/>
    <c:set target="${p1}" property="baseSKU" value="ASUS-VIVO-14"/>
    <c:set target="${p1}" property="image" value="banner1.jpg"/> 
    <c:set target="${p1}" property="price" value="14990000"/>
    <c:set var="added1" value="${mockList.add(p1)}"/>

    <jsp:useBean id="p2" class="java.util.HashMap" scope="request"/>
    <c:set target="${p2}" property="productId" value="2"/>
    <c:set target="${p2}" property="productName" value="Tai nghe không dây Sony WH-1000XM5"/>
    <c:set target="${p2}" property="baseSKU" value="SONY-XM5"/>
    <c:set target="${p2}" property="image" value="banner2.jpg"/> 
    <c:set target="${p2}" property="price" value="6490000"/>
    <c:set var="added2" value="${mockList.add(p2)}"/>

    <c:set var="searchList" value="${mockList}" scope="request"/>
    <c:set var="keyword" value="Laptop" scope="request"/> </c:if>
    <main class="container my-5 flex-grow-1 search-main-container">
        <span class="fw-bold fs-6 text-danger">


            <div class="row g-4">
            <%-- TRƯỜNG HỢP 1: TÌM THẤY SẢN PHẨM --%>
            <c:if test="${not empty searchList}">
                <c:forEach items="${searchList}" var="p">
                    <div class="col-12 col-sm-6 col-md-4 col-lg-3">
                        <div class="card h-100 border-0 shadow-sm d-flex flex-column justify-content-between overflow-hidden bg-white product-card">
                            <a href="${pageContext.request.contextPath}/product/detail?id=${p.productId}" class="text-decoration-none">
                                <div class="p-3">
                                    <div class="bg-light rounded-3 d-flex align-items-center justify-content-center product-img-wrapper">
                                        <c:choose>
                                            <c:when test="${not empty p.image}">
                                                <img src="${pageContext.request.contextPath}/assets/images/${p.image}" class="img-fluid h-100 object-fit-contain" alt="${p.productName}">
                                            </c:when>
                                            <c:otherwise>
                                                <i class="fa-solid fa-laptop fs-1 opacity-25" style="color: #0056b3;"></i>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <h6 class="fw-bold text-dark mt-3 mb-1 product-title">
                                        ${p.productName}
                                    </h6>
                                    <p class="text-muted small mb-0">SKU: ${p.baseSKU}</p>
                                </div>
                            </a>

                            <div class="card-footer bg-white border-0 d-flex align-items-center justify-content-between p-3">
                                <span class="fw-bold fs-6 text-danger">
                                    <fmt:formatNumber value="${p.price}" type="number" maxFractionDigits="0"/>đ
                                </span>

                                <button class="btn btn-sm btn-success px-3 fw-bold" data-vi="Mua ngay" data-en="Buy now">Mua ngay</button>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:if>

            <%-- TRƯỜNG HỢP 2: KHÔNG TÌM THẤY SẢN PHẨM --%>
            <c:if test="${empty searchList}">
                <div class="col-12 text-center py-5">
                    <div class="fs-1 text-muted mb-3"><i class="fa-solid fa-magnifying-glass-minus"></i></div>

                    <c:choose>
                        <c:when test="${sessionScope.lang == 'en'}">
                            <h5 class="fw-bold text-secondary">Sorry, no matching products found!</h5>
                            <p class="text-muted small">Please try searching with another keyword.</p>
                            <a href="${pageContext.request.contextPath}/home" class="btn text-white px-4 mt-2 btn-search-back text-decoration-none">Back to home</a>
                        </c:when>
                        <c:otherwise>
                            <h5 class="fw-bold text-secondary">Rất tiếc, không tìm thấy sản phẩm phù hợp!</h5>
                            <p class="text-muted small">Hãy thử tìm kiếm lại với từ khóa khác xem sao nhé.</p>
                            <a href="${pageContext.request.contextPath}/home" class="btn text-white px-4 mt-2 btn-search-back text-decoration-none">Quay lại trang chủ</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:if>
        </div>
</main>

<jsp:include page="/WEB-INF/include/footer.jsp" />