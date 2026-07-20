<%-- 
    Document   : detail
    Created on : Jun 22, 2026, 12:15:53 PM
    Author     : HP
--%>

<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>

<%@include file="/WEB-INF/include/header.jsp"%>
<%@include file="/WEB-INF/include/navbar.jsp"%>

<style>

    body{
        background:#f5f5f5;
    }

    .page-title{
        font-weight:600;
    }

    .status-card{
        background:#fff;
        border-radius:12px;
        box-shadow:0 3px 12px rgba(0,0,0,.08);
        overflow:hidden;
    }

    .status-header{
        background:#198754;
        color:#fff;
        padding:10px 18px;
    }

    .status-header h5{
        margin:0;
        font-size:18px;
        font-weight:600;
    }

    .status-body{
        padding:8px 25px;
    }

    .preview-card{
        background:#fff;
        border-radius:12px;
        padding:18px;
        border:1px solid #e9ecef;
        box-shadow:0 4px 15px rgba(0,0,0,.08);
        height:100%;
    }

    .status-box{
        border:2px solid #e9ecef;
        border-radius:10px;
        padding:10px 14px;
        cursor:pointer;
        transition:.25s;
        background:#fff;
    }

    .status-box + .status-box{
        margin-top:10px;
    }

    .status-box .form-check{
        display:flex;
        align-items:center;
        justify-content:space-between;
        margin:0;
        padding:0;
    }

    .status-box .form-check-input{
        width:15px;
        height:15px;
        margin:0;
        transform:none;
        cursor:pointer;
    }

    .status-left{
        display:flex;
        align-items:center;
    }

    .status-icon{
        width:38px;
        height:38px;
        border-radius:50%;
        display:flex;
        justify-content:center;
        align-items:center;
        margin-right:12px;
        color:#fff;
        font-size:16px;
        flex-shrink:0;
    }

    .status-box label{
        margin-bottom:0;
    }

    .status-box .fw-semibold{
        font-size:14px;
        line-height:1.2;
        margin-bottom:6px;
    }

    .status-box small{
        display:block;
        font-size:11px;
        line-height:1.4;
    }

    .status-preview{
        margin-top:20px;
        padding-top:16px;
        border-top:1px dashed #dee2e6;
        text-align:center;
    }


    .info-item{
        margin-bottom:15px;
    }

    .info-item label{
        display:block;
        font-size:13px;
        color:#6c757d;
        margin-bottom:2px;
    }

    .info-item span{
        font-weight:600;
        font-size:15px;
    }

    .timeline{
        display:flex;
        justify-content:space-between;
        align-items:flex-start;
        position:relative;
        margin:5px 10px;
    }

    .timeline::before{
        content:"";
        position:absolute;
        top:20px;
        left:55px;
        right:55px;
        height:3px;
        background:#dee2e6;
        z-index:0;
    }

    .timeline-item{
        flex:1;
        text-align:center;
        position:relative;
        z-index:2;
    }

    .timeline-icon{
        width:40px;
        height:40px;
        border-radius:50%;
        background:#ced4da;
        color:#fff;
        display:flex;
        justify-content:center;
        align-items:center;
        margin:0 auto 8px;
        font-size:17px;
    }

    .timeline-item.active .timeline-icon{
        background:#198754;
    }

    .timeline-item.cancel .timeline-icon{
        background:#dc3545;
    }

    .timeline-content h6{
        font-size:14px;
        margin-bottom:2px;
        font-weight:600;
    }

    .timeline-content small{
        font-size:11px;
        color:#6c757d;
        line-height:1.2;
    }

    .timeline-item::after{
        display:none;
    }

    .btn-save{
        background:#198754;
        color:#fff;
        border:none;
        min-width:150px;
    }

    .btn-save:hover{
        background:#157347;
        color:#fff;
    }

    .status-box:hover{
        transform: translateY(-2px);
        border-color:#198754;
        box-shadow:0 6px 16px rgba(25,135,84,.12);
    }

    .status-box.active{
        border-color:#198754;
        background:#eefaf3;
        box-shadow:0 6px 18px rgba(25,135,84,.18);
    }

    .col-lg-5 .card{
        height:100%;
    }

    .bg-shopee{
        background:#ee4d2d !important;
        color:#fff !important;
    }

    .text-shopee{
        color:#ee4d2d !important;
    }

    .text-end{
        padding-bottom:5px;
    }

    .status-box .form-check-input{
        width:15px;
        height:15px;
        cursor:pointer;
        border:2px solid #adb5bd;
    }

    .status-box .form-check-input:checked{
        background-color:#198754;
        border-color:#198754;
    }
</style>

<div class="container mt-4 mb-5" style="max-width:1100px;">

    <div class="d-flex justify-content-between align-items-center mb-4">

        <h2 class="page-title">
            <i class="bi bi-pencil-square text-secondary me-2"></i>
            Update Order Status
        </h2>

        <a href="${pageContext.request.contextPath}/admin/order"
           class="btn btn-outline-success btn-sm">

            <i class="bi bi-arrow-return-left me-1"></i>
            Back

        </a>

    </div>

    <form action="${pageContext.request.contextPath}/admin/order?action=updateStatus"
          method="post">

        <input type="hidden"
               name="orderId"
               value="${order.orderId}">

        <div class="status-card">

            <div class="status-header mb-3">

                <h5>
                    <i class="bi bi-truck me-2"></i>
                    Order Status Management
                </h5>

            </div>

            <div class="status-body">

                <div class="row g-4 align-items-stretch">

                    <!-- LEFT -->
                    <div class="col-lg-7">

                        <!-- Order Information sẽ viết tiếp -->

                        <div class="card shadow-sm mb-4 order-info-card">

                            <div class="card-header bg-white">
                                <h5 class="mb-0 fw-bold">
                                    <i class="bi bi-info-circle text-primary me-2"></i>
                                    Order Information
                                </h5>
                            </div>

                            <div class="card-body">

                                <div class="row">

                                    <div class="col-md-6">

                                        <p>
                                            <i class="bi bi-box-seam text-danger me-2"></i>
                                            <b>Order ID:</b>
                                            ${order.orderId}
                                        </p>

                                        <p>
                                            <i class="bi bi-person-circle text-secondary me-2"></i>
                                            <b>Customer:</b>
                                            ${order.user.fullName}
                                        </p>

                                        <p>
                                            <i class="bi bi-person-check text-info me-2"></i>
                                            <b>Receiver:</b>
                                            ${order.receiverName}
                                        </p>

                                        <p>
                                            <i class="bi bi-telephone text-success me-2"></i>
                                            <b>Phone:</b>
                                            ${order.phone}
                                        </p>

                                        <div class="d-flex mb-3 align-items-start">

                                            <i class="bi bi-calendar-event text-danger me-2 mt-1"></i>

                                            <div>

                                                <b>Order Date:</b>

                                                <span class="ms-1">
                                                    ${order.orderDate}
                                                </span>

                                            </div>

                                        </div>

                                    </div>

                                    <div class="col-md-6">

                                        <div class="d-flex mb-3 align-items-start">

                                            <i class="bi bi-geo-alt-fill text-danger me-2 mt-1"></i>

                                            <div>

                                                <b>Address:</b>

                                                <span class="ms-1">

                                                    ${order.address.street},
                                                    ${order.address.ward},
                                                    ${order.address.district},
                                                    ${order.address.province}

                                                </span>

                                            </div>

                                        </div>

                                        <div class="d-flex mb-3 align-items-start">

                                            <i class="bi bi-truck text-primary me-2 mt-1"></i>

                                            <div>

                                                <b>Shipping Provider:</b>

                                                <span class="ms-1">
                                                    ${order.provider.providerName}
                                                </span>

                                            </div>

                                        </div>

                                        <p>

                                            <i class="bi bi-ticket-perforated text-warning me-2"></i>

                                            <b>Voucher:</b>

                                            <c:choose>

                                                <c:when test="${order.voucher!=null}">
                                                    ${order.voucher.code}
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

                                                <c:when test="${order.paymentStatus==1}">
                                                    <span class="badge bg-success">
                                                        Paid
                                                    </span>
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

                            </div>

                        </div>


                        <div class="card shadow-sm mt-3">

                            <div class="card-header bg-white">

                                <h5 class="mb-0 fw-bold">
                                    <i class="bi bi-diagram-3 text-success me-2"></i>
                                    Order Timeline
                                </h5>

                            </div>

                            <div class="card-body">

                                <div class="timeline">

                                    <div class="timeline-item ${order.status>=0?'active':''}">
                                        <div class="timeline-icon">
                                            <i class="bi bi-clock-history"></i>
                                        </div>

                                        <div class="timeline-content">
                                            <h6>Pending</h6>
                                            <small>Awaiting seller confirmation</small>
                                        </div>
                                    </div>

                                    <div class="timeline-item ${order.status>=1?'active':''}">
                                        <div class="timeline-icon">
                                            <i class="bi bi-check-circle"></i>
                                        </div>

                                        <div class="timeline-content">
                                            <h6>Confirmed</h6>
                                            <small>Ready for shipment</small>
                                        </div>
                                    </div>

                                    <div class="timeline-item ${order.status>=2?'active':''}">
                                        <div class="timeline-icon">
                                            <i class="bi bi-truck"></i>
                                        </div>

                                        <div class="timeline-content">
                                            <h6>Shipping</h6>
                                            <small>Estimated delivery in progress</small>
                                        </div>
                                    </div>

                                    <div class="timeline-item ${order.status>=3?'active':''}">
                                        <div class="timeline-icon">
                                            <i class="bi bi-bag-check"></i>
                                        </div>

                                        <div class="timeline-content">
                                            <h6>Completed</h6>
                                            <small>Delivered successfully</small>
                                        </div>
                                    </div>

                                    <c:if test="${order.status==4}">

                                        <div class="timeline-item cancel">

                                            <div class="timeline-icon">
                                                <i class="bi bi-x-circle"></i>
                                            </div>

                                            <div class="timeline-content">
                                                <h6>Cancelled</h6>
                                                <small>Order was cancelled</small>
                                            </div>

                                        </div>

                                    </c:if>

                                </div>

                            </div>

                        </div>

                    </div>

                    <!-- RIGHT -->
                    <div class="col-lg-5 d-flex">

                        <div class="card shadow-sm w-100 h-100">

                            <div class="card-header bg-white">
                                <h5 class="mb-0 fw-bold">
                                    <i class="bi bi-arrow-repeat text-success me-2"></i>
                                    Update Status
                                </h5>
                            </div>

                            <div class="card-body d-flex flex-column">

                                <div class="status-box active" id="boxPending">

                                    <div class="form-check">

                                        <div class="status-left">

                                            <div class="status-icon bg-info">
                                                <i class="bi bi-clock-history"></i>
                                            </div>

                                            <label class="form-check-label" for="pending">

                                                <div class="fw-semibold text-info">
                                                    Pending
                                                </div>

                                                <small class="text-muted">
                                                    Waiting for confirmation
                                                </small>

                                            </label>

                                        </div>

                                        <input class="form-check-input"
                                               type="radio"
                                               name="status"
                                               id="pending"
                                               value="0"
                                               ${order.status==0?'checked':''}>

                                    </div>

                                </div>

                                <div class="status-box" id="boxConfirmed">

                                    <div class="form-check">

                                        <div class="status-left">

                                            <div class="status-icon bg-primary">
                                                <i class="bi bi-check-circle"></i>
                                            </div>

                                            <label class="form-check-label" for="confirmed">

                                                <div class="fw-semibold text-primary">
                                                    Confirmed
                                                </div>

                                                <small class="text-muted">
                                                    Order has been confirmed
                                                </small>

                                            </label>

                                        </div>

                                        <input class="form-check-input"
                                               type="radio"
                                               name="status"
                                               id="confirmed"
                                               value="1"
                                               ${order.status==1?'checked':''}>

                                    </div>

                                </div>

                                <div class="status-box" id="boxShipping">

                                    <div class="form-check">

                                        <div class="status-left">

                                            <div class="status-icon bg-shopee">
                                                <i class="bi bi-truck"></i>
                                            </div>

                                            <label class="form-check-label" for="shipping">

                                                <div class="fw-semibold text-shopee">
                                                    Shipping
                                                </div>

                                                <small class="text-muted">
                                                    Package is on delivery
                                                </small>

                                            </label>

                                        </div>

                                        <input class="form-check-input"
                                               type="radio"
                                               name="status"
                                               id="shipping"
                                               value="2"
                                               ${order.status==2?'checked':''}>

                                    </div>

                                </div>

                                <div class="status-box" id="boxCompleted">

                                    <div class="form-check">

                                        <div class="status-left">

                                            <div class="status-icon bg-success">
                                                <i class="bi bi-bag-check"></i>
                                            </div>

                                            <label class="form-check-label" for="completed">

                                                <div class="fw-semibold text-success">
                                                    Completed
                                                </div>

                                                <small class="text-muted">
                                                    Customer received the order
                                                </small>

                                            </label>

                                        </div>

                                        <input class="form-check-input"
                                               type="radio"
                                               name="status"
                                               id="completed"
                                               value="3"
                                               ${order.status==3?'checked':''}>

                                    </div>

                                </div>

                                <div class="status-box" id="boxCancelled">

                                    <div class="form-check">

                                        <div class="status-left">

                                            <div class="status-icon bg-danger">
                                                <i class="bi bi-x-circle"></i>
                                            </div>

                                            <label class="form-check-label" for="cancelled">

                                                <div class="fw-semibold text-danger">
                                                    Cancelled
                                                </div>

                                                <small class="text-muted">
                                                    Order has been cancelled
                                                </small>

                                            </label>

                                        </div>

                                        <input class="form-check-input"
                                               type="radio"
                                               name="status"
                                               id="cancelled"
                                               value="4"
                                               ${order.status==4?'checked':''}>

                                    </div>

                                </div>

                                <div class="status-preview mt-auto">
                                    <h6 class="mb-3">Current Preview</h6>
                                    <span class="badge" id="statusBadge">Pending</span>
                                </div>

                            </div>
                        </div>

                    </div>

                </div>

                <hr class="my-3">

                <div class="text-end">

                    <a href="${pageContext.request.contextPath}/admin/order"
                       class="btn btn-primary btn-sm me-3">

                        <i class="bi bi-arrow-return-left me-1"></i>
                        Cancel

                    </a>

                    <button class="btn btn-save btn-sm"
                            type="submit">

                        <i class="bi bi-check-circle-fill me-1"></i>
                        Save Changes

                    </button>

                </div>

            </div>

        </div>

    </form>

</div>

<script>

    const radios = document.querySelectorAll("input[name='status']");
    const boxes = document.querySelectorAll(".status-box");
    const badge = document.getElementById("statusBadge");

    function updateStatus() {

        boxes.forEach(box => box.classList.remove("active"));

        radios.forEach(r => {

            if (r.checked) {

                r.closest(".status-box").classList.add("active");

                switch (r.value) {

                    case "0":
                        badge.className = "badge bg-info";
                        badge.innerHTML = "Pending";
                        break;

                    case "1":
                        badge.className = "badge bg-primary";
                        badge.innerHTML = "Confirmed";
                        break;

                    case "2":
                        badge.className = "badge bg-shopee";
                        badge.innerHTML = "Shipping";
                        break;

                    case "3":
                        badge.className = "badge bg-success";
                        badge.innerHTML = "Completed";
                        break;

                    case "4":
                        badge.className = "badge bg-danger";
                        badge.innerHTML = "Cancelled";
                        break;

                }

            }

        });

    }

    radios.forEach(r => r.addEventListener("change", updateStatus));

    updateStatus();

    boxes.forEach(box => {
        box.addEventListener("click", function () {
            const radio = this.querySelector("input[type='radio']");
            radio.checked = true;
            updateStatus();
        });
    });

</script>

<%@include file="/WEB-INF/include/footer.jsp"%>
