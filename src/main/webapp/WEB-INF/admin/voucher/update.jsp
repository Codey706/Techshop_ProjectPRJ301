<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<%@include file="/WEB-INF/include/header.jsp"%>
<%@include file="/WEB-INF/include/navbar.jsp"%>

<link rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<style>

    body{
        background:#f5f5f5;
    }

    .page-title{
        font-weight:600;
    }

    .voucher-card{
        background:#fff;
        border-radius:12px;
        box-shadow:0 3px 12px rgba(0,0,0,.08);
        overflow:hidden;
    }

    .voucher-header{
        background:#ee4d2d;
        color:#fff;
        padding:8px 16px;
    }

    .voucher-header h5{
        margin:0;
        font-size:18px;
        font-weight:600;
    }

    .voucher-body{
        padding:22px;
    }

    .form-label{
        font-size:14px;
        font-weight:600;
        margin-bottom:6px;
    }

    .form-control,
    .form-select{
        height:42px;
        border-radius:8px;
        font-size:14px;
    }

    .form-control:focus,
    .form-select:focus{
        border-color:#ee4d2d;
        box-shadow:0 0 0 .2rem rgba(238,77,45,.15);
    }

    .preview-card{
        background:#fafafa;
        border:1px dashed #ddd;
        border-radius:10px;
        padding:18px;
        position:relative;
        overflow:hidden;

        display:flex;
        flex-direction:column;
        height:100%;
    }


    #codePreview{
        font-weight:600;
        margin-top:10px;
        margin-bottom:10px;
    }

    .btn{
        border-radius:8px;
    }

    .status-box{
        border:1px solid #e2e8f0;
        border-radius:8px;
        padding:.85rem 1rem;
        cursor:pointer;
        transition:all .2s ease;
    }

    .status-box.active-green{
        border-color:#10b981;
        background:rgba(16,185,129,.04);
    }

    .voucher{
        display:flex;
        min-height:165px;
        background:#fff;
        border-radius:12px;
        overflow:hidden;
        box-shadow:0 2px 8px rgba(0,0,0,.12);
    }

    .voucher-left{
        width:100px;
        background:#ee4d2d;
        color:#fff;
        display:flex;
        justify-content:center;
        align-items:center;
        position:relative;
    }

    .voucher-left::before{
        content:"";
        position:absolute;
        left:-5px;
        top:0;
        width:10px;
        height:100%;
        background:
            radial-gradient(circle,#fafafa 5px,transparent 5.2px);
        background-size:10px 14px;
        background-repeat:repeat-y;
    }

    .voucher-left>div{
        display:flex;
        flex-direction:column;
        align-items:center;
    }

    .voucher-left i{
        font-size:46px;
    }

    .voucher-left h6{
        margin-top:8px;
        letter-spacing:2px;
        font-size:15px;
        color:#fff;
    }

    .voucher-right{
        flex:1;
        padding:16px;
    }

    .discount{
        font-size:24px;
        color:#ee4d2d;
        font-weight:bold;
    }

    .bottom-banner{
        margin-top:10px;
        display:flex;
        justify-content:space-between;
        align-items:flex-end;
        gap:12px;
    }

    .banner-image{
        width:min(260px,65%);
        height:auto;
        object-fit:contain;
        flex-shrink:1;
    }

    .info-image{
        width:min(130px,28%);
        height:auto;
        object-fit:contain;
        margin-bottom:-30px;
        flex-shrink:1;
    }

    @media (max-width: 992px){

        .banner-image{
            width:min(220px,60%);
        }

        .info-image{
            width:min(100px,25%);
            margin-bottom:-15px;
        }

    }

    @media (max-width: 768px){

        .banner-image{
            width:min(180px,55%);
        }

        .info-image{
            width:min(80px,22%);
            margin-bottom:-8px;
        }

    }


</style>

<div class="container mt-4 mb-5" style="max-width:1100px;">

    <div class="d-flex justify-content-between align-items-center mb-4">

        <h2 class="page-title">
            <i class="bi bi-pencil-square text-secondary me-2"></i>
            Edit Voucher
        </h2>

        <a href="${pageContext.request.contextPath}/admin/voucher"
           class="btn btn-outline-info btn-sm">
            <i class="bi bi-arrow-return-left me-1"></i>
            Back
        </a>

    </div>

    <form action="${pageContext.request.contextPath}/admin/voucher?action=edit"
          method="post">

        <input type="hidden"
               name="voucherId"
               value="${voucher.voucherId}">

        <div class="voucher-card">

            <div class="voucher-header">

                <h5>
                    <i class="bi bi-ticket-detailed-fill me-2"></i>
                    Voucher Information
                </h5>

            </div>

            <div class="voucher-body">

                <div class="row g-4 align-items-stretch">

                    <!-- LEFT -->

                    <div class="col-lg-7">

                        <div class="preview-card">

                            <h6 class="fw-bold mb-3">
                                <i class="bi bi-info-circle-fill me-2"></i>
                                Voucher Information
                            </h6>

                            <div class="mb-3">

                                <label class="form-label">
                                    Voucher Code
                                </label>

                                <input
                                    type="text"
                                    name="code"
                                    class="form-control"
                                    value="${voucher.code}"
                                    required>

                            </div>

                            <div class="row">

                                <div class="col-md-6 mb-3">

                                    <label class="form-label">
                                        Discount (%)
                                    </label>

                                    <input
                                        type="number"
                                        id="discount"
                                        name="discountPercent"
                                        class="form-control"
                                        value="${voucher.discountPercent}"
                                        min="1"
                                        max="100"
                                        required>

                                </div>

                                <div class="col-md-6 mb-3">

                                    <label class="form-label">
                                        Quantity
                                    </label>

                                    <input
                                        type="number"
                                        name="quantity"
                                        class="form-control"
                                        value="${voucher.quantity}"
                                        min="1"
                                        required>

                                </div>

                            </div>

                            <div class="mb-3">

                                <label class="form-label">
                                    Minimum Order (VNĐ)
                                </label>

                                <input
                                    type="number"
                                    name="minimumOrder"
                                    class="form-control"
                                    value="${voucher.minimumOrder}"
                                    min="0"
                                    required>

                            </div>

                            <div class="row">

                                <div class="col-md-6 mb-3">

                                    <label class="form-label">
                                        Start Date
                                    </label>

                                    <fmt:formatDate value="${voucher.startDate}"
                                                    pattern="yyyy-MM-dd"
                                                    var="startDate"/>

                                    <input
                                        type="date"
                                        name="startDate"
                                        class="form-control"
                                        value="${startDate}"
                                        required>

                                </div>

                                <div class="col-md-6 mb-3">

                                    <label class="form-label">
                                        Expire Date
                                    </label>

                                    <fmt:formatDate value="${voucher.expireDate}"
                                                    pattern="yyyy-MM-dd"
                                                    var="expireDate"/>

                                    <input
                                        type="date"
                                        name="expireDate"
                                        class="form-control"
                                        value="${expireDate}"
                                        required>

                                </div>

                            </div>

                            <div class="bottom-banner">
                                <img src="${pageContext.request.contextPath}/assets/images/banner2.jpg"
                                     class="banner-image"
                                     alt="Banner">

                                <img src="${pageContext.request.contextPath}/assets/images/view-more-mascot.jpg"
                                     class="info-image"
                                     alt="Mascot">
                            </div>

                        </div>

                    </div>

                    <!-- RIGHT -->

                    <div class="col-lg-5">

                        <div class="preview-card">

                            <h6 class="fw-bold mb-3">
                                <i class="bi bi-eye-fill me-2"></i>
                                Live Preview
                            </h6>

                            <div class="voucher">

                                <div class="voucher-left">

                                    <div>

                                        <i class="bi bi-ticket-perforated-fill"></i>

                                        <h6>VOUCHER</h6>

                                    </div>

                                </div>

                                <div class="voucher-right">

                                    <h5 id="codePreview">
                                        ${voucher.code}
                                    </h5>

                                    <div class="discount">

                                        Discount <span id="discountPreview">${voucher.discountPercent}</span>%

                                    </div>

                                    <div class="small text-muted">

                                        Minimum Order
                                        <span id="minimumPreview">
                                            <fmt:formatNumber value="${voucher.minimumOrder}" pattern="#,##0"/>
                                        </span> VNĐ

                                    </div>

                                    <div class="small mt-1">

                                        Remaining
                                        <b id="quantityPreview">${voucher.quantity}</b>

                                    </div>

                                    <div class="small text-secondary mt-1">

                                        <i class="bi bi-clock-history me-1"></i>

                                        <span id="startPreview">
                                            <fmt:formatDate value="${voucher.startDate}" pattern="dd/MM/yyyy"/>
                                        </span>

                                        -

                                        <span id="expirePreview">
                                            <fmt:formatDate value="${voucher.expireDate}" pattern="dd/MM/yyyy"/>
                                        </span>

                                    </div>

                                    <div class="mt-3">

                                        <span id="statusPreview"
                                              class="badge ${voucher.status == 1 ? 'bg-success' : 'bg-secondary'}">

                                            ${voucher.status == 1 ? 'Active' : 'Inactive'}

                                        </span>

                                    </div>

                                </div>

                            </div>

                            <h6 class="fw-bold mb-3 mt-5">
                                <i class="bi bi-toggle-on me-2"></i>
                                Voucher Status
                            </h6>

                            <div class="d-flex flex-column gap-3">

                                <div class="status-box d-flex align-items-start"
                                     id="boxActive">
                        

                                    <input class="form-check-input mt-1 me-3"
                                           type="radio"
                                           name="status"
                                           id="statusActive"
                                           value="1"
                                           <c:if test="${voucher.status == 1}">checked</c:if>
                                               style="border-color:#10b981;background-color:#10b981;">

                                           <label for="statusActive"
                                                  class="w-100 cursor-pointer">

                                               <span class="d-block fw-bold text-success small">
                                                   Active
                                               </span>

                                               <span class="text-muted d-block"
                                                     style="font-size:.75rem;margin-top:1px;">

                                                   Voucher is available for customers

                                               </span>

                                           </label>

                                    </div>

                                    <div class="status-box d-flex align-items-start"
                                         id="boxInactive">

                                        <input class="form-check-input mt-1 me-3"
                                               type="radio"
                                               name="status"
                                               id="statusInactive"
                                               value="0"
                                        <c:if test="${voucher.status == 0}">checked</c:if>
                                            style="border-color:#6c757d;background-color:#6c757d;">

                                        <label for="statusInactive"
                                               class="w-100 cursor-pointer">

                                            <span class="d-block fw-semibold text-dark small">
                                                Inactive
                                            </span>

                                            <span class="text-muted d-block"
                                                  style="font-size:.75rem;margin-top:1px;">

                                                Voucher is hidden and cannot be used

                                            </span>

                                        </label>

                                    </div>

                                </div>

                            </div>

                        </div>

                    </div>

                    <hr class="my-4">

                    <div class="text-end">

                        <a href="${pageContext.request.contextPath}/admin/voucher"
                       class="btn btn-primary btn-sm me-4">

                        <i class="bi bi-arrow-return-left me-1"></i>
                        Cancel

                    </a>

                    <button type="submit"
                            class="btn btn-success btn-sm">

                        <i class="bi bi-check-circle-fill me-1"></i>
                        Edit Voucher

                    </button>

                </div>

            </div>

        </div>

    </form>

</div>

<script>

    const codeInput = document.querySelector("input[name='code']");
    const discountInput = document.getElementById("discount");
    const quantityInput = document.querySelector("input[name='quantity']");
    const minimumInput = document.querySelector("input[name='minimumOrder']");
    const startInput = document.querySelector("input[name='startDate']");
    const expireInput = document.querySelector("input[name='expireDate']");

    codeInput.addEventListener("input", function () {

       document.getElementById("codePreview").textContent = this.value;

    });

    discountInput.addEventListener("input", function () {

        document.getElementById("discountPreview").textContent = this.value;

    });

    quantityInput.addEventListener("input", function () {

        document.getElementById("quantityPreview").textContent = this.value;

    });

    minimumInput.addEventListener("input", function () {

       document.getElementById("minimumPreview").textContent =
        Number(this.value).toLocaleString("vi-VN");

    });

    startInput.addEventListener("change", function () {

        if (this.value !== "") {

           document.getElementById("startPreview").textContent =
        this.value.split("-").reverse().join("/");

        }

    });

    expireInput.addEventListener("change", function () {

        if (this.value !== "") {

            document.getElementById("expirePreview").textContent =
        this.value.split("-").reverse().join("/");

        }

    });

    const radioActive = document.getElementById("statusActive");
    const radioInactive = document.getElementById("statusInactive");

    const boxActive = document.getElementById("boxActive");
    const boxInactive = document.getElementById("boxInactive");

    const statusPreview = document.getElementById("statusPreview");

    function updateStatusUI() {

        if (radioActive.checked) {

            boxActive.classList.add("active-green");
            boxInactive.classList.remove("active-green");

            statusPreview.className = "badge bg-success";
            statusPreview.textContent = "Active";

        } else {

            boxInactive.classList.add("active-green");
            boxActive.classList.remove("active-green");

            statusPreview.className = "badge bg-secondary";
            statusPreview.textContent = "Inactive";

        }

    }

    radioActive.addEventListener("change", updateStatusUI);
    radioInactive.addEventListener("change", updateStatusUI);

    updateStatusUI();
</script>

<%@include file="/WEB-INF/include/footer.jsp"%>