<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<%@include file="/WEB-INF/include/header.jsp"%>
<%@include file="/WEB-INF/include/navbar.jsp"%>

<style>
    /* Shopee Orange */
    .btn-shopee {
        background-color: #EE4D2D;
        color: white;
        border: 1px solid #EE4D2D;
    }

    .btn-shopee:hover {
        background-color: #d73211;
        border-color: #d73211;
        color: white;
    }

    .btn-outline-shopee {
        color: #EE4D2D;
        border: 1px solid #EE4D2D;
        background: white;
    }

    .btn-outline-shopee:hover {
        background: #EE4D2D;
        color: white;
    }

    .text-shopee {
        color: #EE4D2D !important;
    }

    .bg-shopee {
        background-color: #EE4D2D !important;
        color: white;
    }

    .nav-tabs .nav-link{
        color: #198754;
        font-size: .88rem;
        padding: .38rem .85rem;
    }

    .nav-tabs .nav-link:hover{
        color: #198754;
        border-color: #198754 #198754 #dee2e6;
    }

    .nav-tabs .nav-link.active{
        background-color: #198754;
        border-color: #198754 #198754 #fff;
        color: #fff;
        font-weight: 600;
    }

    .card{
        border: none;
        border-radius:12px;
        transition:.2s;
    }

    .card:hover{
        transform:translateY(-2px);
        box-shadow:0 .5rem 1rem rgba(0,0,0,.15)!important;
    }

    .page-item.active .page-link{
        background-color: var(--bs-secondary);
        border-color: var(--bs-secondary);
        color: #fff;
    }

    .page-link{
        color: var(--bs-secondary);
    }

    .page-link:hover{
        background-color: var(--bs-secondary);
        border-color: var(--bs-secondary);
        color: #fff;
    }

    .order-card{
        position: relative;
        overflow: hidden;
    }

    .order-card-logo{
        position: absolute;
        right: 10px;
        bottom: 40px;
        pointer-events: none;
        opacity: .95;
    }

    .order-card-logo img{
        width: 130px;
        height: auto;
    }

    .btn-info{
        color: #fff !important;
    }

    .btn-info:hover{
        color: #fff !important;
    }

    .search-icon{
        width: 40px;      /* chỉnh 32, 36, 40... */
        height: 37px;
        object-fit: contain;
        transform: scale(1.25);
    }

    .input-group-text{
        overflow: visible;
    }

</style>

<div class="container mt-4">

    <h2 class="mb-4 fw-semibold">
        <i class="bi bi-receipt-cutoff text-secondary"></i>
        Order Management
    </h2>

    <!-- Tabs -->
    <ul class="nav nav-tabs mb-3">

        <c:url var="allUrl" value="/admin/order">
            <c:if test="${not empty param.keyword}">
                <c:param name="keyword" value="${param.keyword}"/>
            </c:if>
        </c:url>

        <li class="nav-item">
            <a class="nav-link ${empty param.status ? 'active' : ''}"
               href="${allUrl}">
                All
            </a>
        </li>

        <c:url var="pendingUrl" value="/admin/order">
            <c:param name="status" value="0"/>

            <c:if test="${not empty param.keyword}">
                <c:param name="keyword" value="${param.keyword}"/>
            </c:if>
        </c:url>

        <li class="nav-item">
            <a class="nav-link ${param.status=='0' ? 'active' : ''}"
               href="${pendingUrl}">
                Pending
            </a>
        </li>

        <c:url var="confirmedUrl" value="/admin/order">
            <c:param name="status" value="1"/>
            <c:if test="${not empty param.keyword}">
                <c:param name="keyword" value="${param.keyword}"/>
            </c:if>
        </c:url>

        <a class="nav-link ${param.status=='1' ? 'active' : ''}"
           href="${confirmedUrl}">
            Confirmed
        </a>

        <c:url var="shippingUrl" value="/admin/order">
            <c:param name="status" value="2"/>

            <c:if test="${not empty param.keyword}">
                <c:param name="keyword" value="${param.keyword}"/>
            </c:if>
        </c:url>

        <li class="nav-item">
            <a class="nav-link ${param.status=='2' ? 'active' : ''}"
               href="${shippingUrl}">
                Shipping
            </a>
        </li>

        <c:url var="completedUrl" value="/admin/order">
            <c:param name="status" value="3"/>

            <c:if test="${not empty param.keyword}">
                <c:param name="keyword" value="${param.keyword}"/>
            </c:if>
        </c:url>

        <li class="nav-item">
            <a class="nav-link ${param.status=='3' ? 'active' : ''}"
               href="${completedUrl}">
                Completed
            </a>
        </li>

        <c:url var="cancelledUrl" value="/admin/order">
            <c:param name="status" value="4"/>

            <c:if test="${not empty param.keyword}">
                <c:param name="keyword" value="${param.keyword}"/>
            </c:if>
        </c:url>

        <li class="nav-item">
            <a class="nav-link ${param.status=='4' ? 'active' : ''}"
               href="${cancelledUrl}">
                Cancelled
            </a>
        </li>

    </ul>

    <%-- Search --%>
    <div class="col-md-12 mb-4">
        <form method="get" action="${pageContext.request.contextPath}/admin/order">

            <c:if test="${not empty param.status}">
                <input type="hidden"
                       name="status"
                       value="${param.status}">
            </c:if>

            <div class="input-group shadow-sm">

                <span class="input-group-text bg-white border-end-0 p-0">
                    <img src="${pageContext.request.contextPath}/assets/images/search-icon.png"
                         alt="Search"
                         class="search-icon">
                </span>

                <input
                    type="text"
                    name="keyword"
                    class="form-control border-start-0"
                    placeholder="Search Order ID, Customer..."
                    value="${param.keyword}">

                <button class="btn btn-success btn-sm">
                    Search
                </button>

            </div>

        </form>
    </div >

    <c:forEach items="${orders}" var="o">

        <div class="card shadow-sm mb-4 order-card">

            <!-- Header -->
            <div class="card-header bg-white">

                <div class="d-flex justify-content-between align-items-center">

                    <div>

                        <h5 class="mb-1 text-shopee fw-bold">
                            Order #${o.orderId}
                        </h5>

                        Customer:
                        <strong>${o.user.fullName}</strong>

                    </div>

                    <div>

                        <c:choose>

                            <c:when test="${o.status==0}">
                                <span class="badge bg-info">Pending</span>
                            </c:when>

                            <c:when test="${o.status==1}">
                                <span class="badge bg-primary">Confirmed</span>
                            </c:when>

                            <c:when test="${o.status==2}">
                                <span class="badge bg-shopee">Shipping</span>
                            </c:when>

                            <c:when test="${o.status==3}">
                                <span class="badge bg-success">Completed</span>
                            </c:when>

                            <c:otherwise>
                                <span class="badge bg-danger">Cancelled</span>
                            </c:otherwise>

                        </c:choose>

                    </div>

                </div>

            </div>

            <!-- Body -->
            <div class="card-body">

                <div class="row">

                    <div class="col-md-6">

                        <p>
                             <i class="bi bi-person-check text-primary me-2"></i>
                            <b>Receiver:</b>
                            ${o.receiverName}
                        </p>

                        <p>
                            <i class="bi bi-telephone text-success me-2"></i>
                            <b>Phone:</b>
                            ${o.phone}
                        </p>

                        <p>
                            <i class="bi bi-calendar-event text-danger me-2"></i>
                            <b>Order Date:</b>
                            ${o.orderDate}
                        </p>

                        <p>
                            <i class="bi bi-cash-coin text-warning me-2"></i>
                            <b>Total:</b>
                            <span class="text-danger fw-bold fs-5">
                                ${o.totalAmount} VNĐ
                            </span>
                        </p>

                    </div>

                    <div class="col-md-6">

                        <p>
                             <i class="bi bi-geo-alt-fill text-danger me-2"></i>
                            <b>Address:</b><br>

                            ${o.address.street},
                            ${o.address.ward},
                            ${o.address.district},
                            ${o.address.province}
                        </p>

                        <p>
                            <i class="bi bi-truck text-shopee me-2"></i>
                            <b>Shipping Provider:</b>
                            ${o.provider.providerName}
                        </p>

                        <p>
                            <i class="bi bi-ticket-perforated text-warning me-2"></i>
                            <b>Voucher:</b>

                            <c:choose>

                                <c:when test="${o.voucher!=null}">
                                    ${o.voucher.code}
                                </c:when>

                                <c:otherwise>
                                    None
                                </c:otherwise>

                            </c:choose>

                        </p>

                        <p>
 <i class="bi bi-credit-card text-success me-2"></i>
                            <b>Payment:</b>

                            <c:choose>

                                <c:when test="${o.paymentStatus==1}">
                                    <span class="badge bg-success">
                                        Paid</span>
                                </c:when>

                                <c:otherwise>
                                    <span class="badge bg-secondary">
                                        
                                        Unpaid
                                    </span>
                                </c:otherwise>

                            </c:choose>

                        </p>

                    </div>

                </div>

                <div class="order-card-logo">
                    <img src="${pageContext.request.contextPath}/assets/images/view-more.png"
                         alt="Mirai Store">
                </div>

            </div>

            <!-- Footer -->
            <div class="card-footer bg-white">

                <div class="d-flex justify-content-start gap-3">

                    <a href="${pageContext.request.contextPath}/admin/order?view=detail&id=${o.orderId}"
                       class="btn btn-info btn-sm">
                        <i class="bi bi-eye me-1"></i>
                        Detail

                    </a>

                    <a href="${pageContext.request.contextPath}/admin/order?view=update-status&id=${o.orderId}"
                       class="btn btn-success btn-sm">
                        <i class="bi bi-pencil-square me-1"></i>
                        Edit Status
                    </a>

                </div>

            </div>

        </div>

    </c:forEach>

</div>

<nav class="mt-4">
    <ul class="pagination justify-content-center">

        <!-- Previous -->
        <c:url var="previousUrl" value="/admin/order">
            <c:param name="page" value="${currentPage-1}"/>

            <c:if test="${not empty param.status}">
                <c:param name="status" value="${param.status}"/>
            </c:if>

            <c:if test="${not empty param.keyword}">
                <c:param name="keyword" value="${param.keyword}"/>
            </c:if>
        </c:url>

        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
            <a class="page-link" href="${previousUrl}">
                Previous
            </a>
        </li>

        <!-- Number -->
        <c:forEach begin="1" end="${totalPages}" var="i">

            <c:url var="pageUrl" value="/admin/order">
                <c:param name="page" value="${i}"/>

                <c:if test="${not empty param.status}">
                    <c:param name="status" value="${param.status}"/>
                </c:if>

                <c:if test="${not empty param.keyword}">
                    <c:param name="keyword" value="${param.keyword}"/>
                </c:if>
            </c:url>

            <li class="page-item ${currentPage == i ? 'active' : ''}">
                <a class="page-link" href="${pageUrl}">
                    ${i}
                </a>
            </li>

        </c:forEach>

        <!-- Next -->
        <c:url var="nextUrl" value="/admin/order">
            <c:param name="page" value="${currentPage+1}"/>

            <c:if test="${not empty param.status}">
                <c:param name="status" value="${param.status}"/>
            </c:if>

            <c:if test="${not empty param.keyword}">
                <c:param name="keyword" value="${param.keyword}"/>
            </c:if>
        </c:url>

        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
            <a class="page-link" href="${nextUrl}">
                Next
            </a>
        </li>

    </ul>
</nav>

<%@include file="/WEB-INF/include/footer.jsp"%>