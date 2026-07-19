<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<%@include file="/WEB-INF/include/header.jsp"%>
<%@include file="/WEB-INF/include/navbar.jsp"%>

<link rel="stylesheet"href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<style>
    <%-- Pagination --%>
    .pagination .page-link {
        color: #6c757d;
        border-color: #dee2e6;
    }

    .pagination .page-link:hover {
        color: #fff;
        background-color: #6c757d;
        border-color: #6c757d;
    }

    .pagination .page-item.active .page-link {
        color: #fff;
        background-color: #6c757d;
        border-color: #6c757d;
    }

    .pagination .page-item.disabled .page-link {
        color: #adb5bd;
        background-color: #fff;
        border-color: #dee2e6;
    }

    .action-btn{
        width: 120px;
        height: 36px;
        padding: 0;
        font-size: .9rem;
        display: inline-flex;
        justify-content: center;
        align-items: center;
    }
</style>

<div class="container mt-4">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="fw-semibold mb-0">
            <i class="bi bi-box-seam me-2 text-secondary"></i>
            Product Management
        </h2>

        <a href="${pageContext.request.contextPath}/admin/product?view=create"
           class="btn btn-success action-btn">
            <i class="bi bi-plus-circle-fill me-1"></i>
            Add Product
        </a>
    </div>

    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-4">

        <c:choose>

            <c:when test="${not empty products}">

                <c:forEach var="p" items="${products}">

                    <div class="col">

                        <div class="card h-100 border-0 shadow-sm p-3">

                            <%-- Product Image --%>
                           <img src="${pageContext.request.contextPath}/assets/images/products/${p.imageUrl}"
     class="img-fluid"
     style="height:220px; object-fit:contain;"
     alt="${p.productName}">

                            <%-- Product Name --%>
                            <h5 class="fw-bold mt-3 mb-2">
                                ${p.productName}
                            </h5>

                            <%-- Price --%>
                            <p class="fw-bold text-danger fs-5 mb-2">
                                <fmt:formatNumber value="${p.price}" pattern="#,##0"/> VNĐ
                            </p>

                            <%-- SKU --%>
                            <p class="text-muted mb-2">
                                SKU:
<c:choose>
    <c:when test="${not empty p.variants}">
        ${p.variants[0].variantSKU}
    </c:when>
    <c:otherwise>
        N/A
    </c:otherwise>
</c:choose>
                            </p>

                            <%-- Category --%>
                            <p class="mb-1">
                                <strong>Category:</strong>

                                <c:choose>
                                    <c:when test="${not empty p.category}">
                                        ${p.category.categoryName}
                                    </c:when>
                                    <c:otherwise>
                                        N/A
                                    </c:otherwise>
                                </c:choose>
                            </p>

                            <%-- Brand --%>
                            <p class="mb-1">
                                <strong>Brand:</strong>

                                <c:choose>
                                    <c:when test="${not empty p.brand}">
                                        ${p.brand.brandName}
                                    </c:when>
                                    <c:otherwise>
                                        N/A
                                    </c:otherwise>
                                </c:choose>
                            </p>

                            <%-- Views --%>
                            <p class="mb-1">
                                👁 <strong>Views:</strong> ${p.views}
                            </p>

                            <%-- Sold --%>
                            <p class="mb-3">
                                🛒 <strong>Sold:</strong> ${p.sold}
                            </p>

                            <%-- Status --%>
                            <p class="mb-3">
                                <strong>Status:</strong>

                                <c:choose>
                                    <c:when test="${p.status == 1}">
                                        <span class="badge bg-success">
                                            Active
                                        </span>
                                    </c:when>

                                    <c:otherwise>
                                        <span class="badge bg-secondary">
                                            Inactive
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </p>

                            <%-- Buttons --%>
                            <div class="mt-auto d-flex justify-content-center gap-2">

                                <a href="${pageContext.request.contextPath}/admin/product?view=edit&id=${p.productId}"
                                   class="btn btn-primary action-btn">
                                    <i class="bi bi-pencil-square me-1"></i>
                                    Edit
                                </a>

                                <a href="${pageContext.request.contextPath}/admin/product?view=delete&id=${p.productId}"
                                   class="btn btn-danger action-btn">
                                    <i class="bi bi-trash me-1"></i>
                                    Delete
                                </a>

                            </div>

                        </div>

                    </div>

                </c:forEach>

            </c:when>

            <c:otherwise>

                <div class="col-12">
                    <div class="alert alert-warning text-center">
                        No products found.
                    </div>
                </div>

            </c:otherwise>

        </c:choose>

    </div>

</div>

<nav class="mt-4">
    <ul class="pagination justify-content-center">

        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
            <a class="page-link"
               href="${pageContext.request.contextPath}/admin/product?page=${currentPage - 1}">
                Previous
            </a>
        </li>

        <c:forEach begin="1" end="${totalPages}" var="i">
            <li class="page-item ${currentPage == i ? 'active' : ''}">
                <a class="page-link"
                   href="${pageContext.request.contextPath}/admin/product?page=${i}">
                    ${i}
                </a>
            </li>
        </c:forEach>

        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
            <a class="page-link"
               href="${pageContext.request.contextPath}/admin/product?page=${currentPage + 1}">
                Next
            </a>
        </li>

    </ul>
</nav>

<%@include file="/WEB-INF/include/footer.jsp"%>