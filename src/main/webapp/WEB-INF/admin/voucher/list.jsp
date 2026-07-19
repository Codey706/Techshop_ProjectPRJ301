<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<%@include file="/WEB-INF/include/header.jsp"%>
<%@include file="/WEB-INF/include/navbar.jsp"%>

<link rel="stylesheet"href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<style>

    .voucher{
        display:flex;
        min-height:155px;
        background:#fff;
        border-radius:12px;
        overflow:hidden;
        position:relative;
        box-shadow:0 2px 8px rgba(0,0,0,.12);
        transition:.25s;
    }

    .voucher:hover{
        transform:translateY(-3px);
        box-shadow:0 6px 18px rgba(0,0,0,.18);
    }

    .voucher-left{
        width:120px;
        background:#ee4d2d;
        color:#fff;
        position:relative;
        overflow:hidden;
        display:flex;
        justify-content:center;
        align-items:center;
    }

    .voucher-left::before{
        content:"";
        position:absolute;
        left:-5px;
        top:0;
        width:10px;
        height:100%;
        background:
            radial-gradient(circle,
            #f8f9fa 5px,
            transparent 5.2px);
        background-size:10px 14px;
        background-repeat:repeat-y;
    }

    .voucher-left > div{
        width:100%;
        height:100%;
        display:flex;
        flex-direction:column;
        justify-content:center;
        align-items:center;
    }

    .voucher-left i{
        font-size:52px;
        line-height:1;
        margin-bottom:8px;
    }

    .voucher-left h6{
        margin:0;
        line-height:1;
        font-size:16px;
        font-weight:700;
        letter-spacing:2px;
    }

    .voucher-right{
        flex:1;
        padding:18px;

    }

    .discount{
        font-size:24px;
        font-weight:bold;
        color:#ee4d2d;

    }

    .voucher-action{
        display: flex;
        justify-content: center;
        align-items: center;
        margin-top: 12px;
    }

    .voucher-action .btn{
    width: 90px;
    height: 34px;
    padding: 0;
    margin: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: .9rem;
}

    .voucher-ribbon{
        position:absolute;
        right:-30px;
        top:8px;
        transform:rotate(45deg);
        background:#ff5722;
        color:white;
        width:90px;
        text-align:center;
        font-size:11px;
        font-weight:bold;
    }
    
    .page-item.active .page-link{
    background:#6c757d;
    border-color:#6c757d;
    color:#fff;
}

.page-link{
    color:#6c757d;
}

.page-link:hover{
    background:#6c757d;
    border-color:#6c757d;
    color:#fff;
}
</style>

<div class="container mt-4">

    <div class="d-flex justify-content-between align-items-center mb-4">

        <h2 class="mb-3 fw-semibold">
            <i class="bi bi-tag-fill text-secondary me-1"></i>
        Voucher Management
    </h2>


        <a href="${pageContext.request.contextPath}/admin/voucher?view=create"
           class="btn btn-success btn-sm px-3">
            <i class="bi bi-plus-circle-fill me-2"></i>
            Add Voucher
        </a>

    </div>

    <c:choose>

        <c:when test="${not empty vouchers}">

            <div class="row">

                <c:forEach items="${vouchers}" var="v">

                    <div class="col-lg-6 mb-3">

                        <div class="voucher">

                            <div class="voucher-left">

                                <div>

                                    <i class="bi bi-ticket-perforated-fill"></i>

                                    <h6>VOUCHER</h6>

                                </div>

                            </div>

                            <div class="voucher-right">

                                <c:if test="${newVoucherIds != null && newVoucherIds.contains(v.voucherId)}">
                                    <span class="voucher-ribbon">NEW</span>
                                </c:if>

                                <h5>${v.code}</h5>

                                <div class="discount">Giảm ${v.discountPercent}%</div>

                                <div class="small text-muted">Đơn tối thiểu

                                    <fmt:formatNumber value="${v.minimumOrder}" pattern="#,##0"/> VNĐ</div>

                                <div class="small mt-1">Còn lại <b>${v.quantity-v.usedQuantity}</b>/${v.quantity}</div>

                                <div class="small text-secondary mt-1">

                                    <i class="bi bi-clock-history me-1"></i>Có hiệu lực từ:

                                    <fmt:formatDate value="${v.startDate}" pattern="dd/MM/yyyy"/>
                                    -
                                    <fmt:formatDate value="${v.expireDate}" pattern="dd/MM/yyyy"/>

                                </div>

                                <div class="mt-3">

                                    <c:choose>

                                        <c:when test="${v.status==1}">
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

                                </div>

                            </div>
                        </div>



                        <div class="voucher-action">

                            <a href="${pageContext.request.contextPath}/admin/voucher?view=edit&id=${v.voucherId}"
                               class="btn btn-primary me-3 btn-sm px-3">
                                <i class="bi bi-pencil-square me-1"></i> Edit
                            </a>

                            <a href="${pageContext.request.contextPath}/admin/voucher?view=delete&id=${v.voucherId}"
                               class="btn btn-danger btn-sm px-3"
                               onclick="return confirm('Delete voucher?')">
                                <i class="bi bi-trash me-1"></i> Delete
                            </a>

                        </div>

                    </div>

                </c:forEach>

            </c:when>

            <c:otherwise>

                <div class="alert alert-warning">

                    No vouchers found.

                </div>

            </c:otherwise>

        </c:choose>

    </div>



    <nav class="mt-4">

        <ul class="pagination justify-content-center">

            <li class="page-item ${currentPage==1?'disabled':''}">

                <a class="page-link"
                   href="${pageContext.request.contextPath}/admin/voucher?page=${currentPage-1}">
                    Previous
                </a>

            </li>

            <c:forEach begin="1" end="${totalPages}" var="i">

                <li class="page-item ${currentPage==i?'active':''}">

                    <a class="page-link"
                       href="${pageContext.request.contextPath}/admin/voucher?page=${i}">
                        ${i}
                    </a>

                </li>

            </c:forEach>

            <li class="page-item ${currentPage==totalPages?'disabled':''}">

                <a class="page-link"
                   href="${pageContext.request.contextPath}/admin/voucher?page=${currentPage+1}">
                    Next
                </a>

            </li>

        </ul>

    </nav>

    <%@include file="/WEB-INF/include/footer.jsp"%>