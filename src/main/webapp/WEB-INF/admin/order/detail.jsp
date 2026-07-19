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
    .text-shopee{
        color:#EE4D2D !important;
    }

    .btn-shopee{
        background:#EE4D2D;
        border:1px solid #EE4D2D;
        color:white;
    }

    .btn-shopee:hover{
        background:#d73211;
        border-color:#d73211;
        color:white;
    }

    .payment-table th,
    .summary-table th{
        width:38%;
        padding:12px 0;
        font-weight:600;
        color:#212529;
        font-size:16px;
    }

    .payment-badge{
        display:inline-block;
        padding:6px 12px;
        border-radius:20px;
        font-size:13px;
        font-weight:600;
    }

    .payment-method{
        background:#e7f8ef;
        color:#198754;
    }

    .payment-bank{
        background:#fff4e5;
        color:#fd7e14;
    }

    .transaction-code{
        display:inline-block;
        background:#e8f3ff;
        color:#0d6efd;
        border:1px solid #b6d4fe;
        padding:6px 12px;
        border-radius:20px;
        font-weight:600;
    }

    .table img{
        width:70px;
        height:70px;
        object-fit:cover;
        border-radius:8px;
    }

    .payment-info{
        position: relative;
    }

    .payment-note{
        position:absolute;
        top:50%;
        right:10px;
        transform:translateY(-45%);
        width:200px;
        text-align:center;

    }


    .payment-shield{

        width:40px;
        height:40px;
        margin:0 auto 8px;
        background:#e7f8ef;
        border-radius:50%;
        display:flex;
        justify-content:center;
        align-items:center;

    }


    .payment-shield i{
        font-size:23px;
        color:#198754;
        display:flex;
        align-items:center;
        justify-content:center;
        width:100%;
        height:100%;
        line-height:1;
        margin:0;
        padding:0;
        transform: translateY(2px);
    }

    .payment-logo{
        width:120px;
        height:auto;
        display:block;
        margin:10px auto 0;

    }

    .payment-note h6{
        font-size: 19px;
        font-weight: 700;
        color: #198754;
        margin-bottom: 4px;
        letter-spacing: .3px;
    }

    .payment-note p{
        font-size: 14px;
        color: #6c757d;
        font-style: italic;
        margin-bottom: 12px;
    }

    .payment-logo{
        width: 150px;
        height: auto;
        display: block;
        margin: 0 auto;
    }

    @media (max-width: 991px){

        .payment-note{
            position: static;
            width:100%;
            margin-bottom:25px;
            text-align:center;
        }

        .payment-logo{
            width:170px;
            margin:15px auto 0;
        }

        .order-info-box{
            position: relative;
            background: #f8f9fa;
            border-radius: 10px;
            padding: 20px;
        }

        .order-logo{
            position: absolute;
            right: 20px;
            bottom: 15px;
            text-align: center;
        }

        .order-logo i{
            font-size: 48px;
            color: #198754;
        }

        .order-logo p{
            margin: 4px 0 0;
            font-size: 13px;
            color: #6c757d;
            font-style: italic;
        }

        .payment-info{
            text-align:left;
        }

    }

    .order-info-card{
        position: relative;
    }

    .order-info-logo{
        position: absolute;
        right: 10px;
        bottom: -10px;
    }

    .order-info-logo img{
        width:150px;
        height:auto;
    }

</style>

<div class="container mt-4">

    <div class="d-flex justify-content-between align-items-center mb-4">

        <h2 class="fw-semibold">
            <i class="bi bi-bag-check text-secondary"></i>
            Order Detail
        </h2>

        <a href="${pageContext.request.contextPath}/admin/order"
           class="btn btn-success btn-sm fw-semibold px-4">
            <i class="bi bi-arrow-left-circle me-2"></i>
            Back
        </a>

    </div>

    <!-- Order Information -->
    <div class="card shadow-sm mb-4 order-info-card">

        <div class="card-header bg-white">

            <h4 class="mb-0 fw-bold">
                Order Information
            </h4>

        </div>

        <div class="card-body">

            <div class="row">

                <div class="col-md-6">

                    <p>
                        <i class="bi bi-box-seam text-shopee me-2"></i> 
                        <b>Order ID:</b> ${order.orderId}
                    </p>


                    <p>
                        <i class="bi bi-person-circle text-secondary me-2"></i>
                        <b>Customer:</b> ${order.user.fullName}
                    </p>


                    <p>
                        <i class="bi bi-person-check text-info me-2"></i>
                        <b>Receiver:</b> ${order.receiverName}
                    </p>

                    <p>
                        <i class="bi bi-telephone text-success me-2"></i>
                        <b>Phone:</b> ${order.phone}
                    </p>

                    <p>
                        <i class="bi bi-calendar-event text-danger me-2"></i>
                        <b>Order Date:</b> ${order.orderDate}
                    </p>

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
                    <p>
                        <i class="bi bi-truck text-primary me-2"></i>
                        <b>Shipping Provider:</b>
                        ${order.provider.providerName}
                    </p>

                    <p>
                        <i class="bi bi-ticket-perforated text-shopee me-2"></i>
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

        <div class="order-info-logo">
            <img src="${pageContext.request.contextPath}/assets/images/view-more.png"
                 alt="Mirai Store">
        </div>

    </div>

    <!-- Products -->
    <div class="card shadow-sm">

        <div class="card-header bg-white">

            <h4 class="mb-0 fw-bold">
                Products
            </h4>

        </div>

        <div class="card-body">

            <div class="table-responsive">

                <table class="table table-hover align-middle">

                    <thead class="table-light">

                        <tr>

                            <th>Image</th>

                            <th>Product</th>

                            <th>Brand</th>

                            <th>SKU</th>

                            <th>Variant</th>

                            <th>Price</th>

                            <th>Quantity</th>

                        </tr>

                    </thead>

                    <tbody>

                        <c:forEach items="${order.orderDetails}" var="d">

                            <tr>

                                <td>

                                    <img src="${pageContext.request.contextPath}/${d.snapImageUrl}" alt="${d.snapProductName}">

                                </td>

                                <td>

                                    ${d.snapProductName}

                                </td>

                                <td>

                                    ${d.snapBrandName}

                                </td>

                                <td>

                                    ${d.snapVariantSKU}

                                </td>

                                <td>

                                    ${d.snapVariantName}

                                </td>

                                <td>

                                    ${d.unitPrice} VNĐ

                                </td>

                                <td>

                                    ${d.quantity}

                                </td>

                            </tr>

                        </c:forEach>

                    </tbody>

                </table>

            </div>

        </div>

    </div>

    <!-- Payment Information + Order Summary -->
    <div class="card shadow-sm mt-4">

        <div class="card-header bg-white">
            <h4 class="mb-0 fw-bold">Payment & Summary</h4>
        </div>

        <div class="card-body">

            <div class="row">

                <!-- Payment Information -->
                <div class="col-lg-7 border-end pe-lg-4 payment-info">

                    <h5 class="mb-4">
                        <i class="bi bi-credit-card text-primary me-2"></i>
                        Payment Information
                    </h5>


                    <div class="payment-note">

                        <div class="payment-shield">
                            <i class="bi bi-shield-check"></i>
                        </div>


                        <h6 class="mb-1 fw-bold text-success">
                            Payment Verified
                        </h6>


                        <p class="mb-1 text-muted">
                            by Mirai Store
                        </p>


                        <img src="${pageContext.request.contextPath}/assets/images/view-more-mascot.jpg"
                             class="payment-logo"
                             alt="Payment">

                    </div>

                    <c:choose>

                        <c:when test="${order.payment != null}">

                            <table class="table table-borderless payment-table">

                                <tr>
                                    <th>
                                        <i class="bi bi-credit-card-2-front text-success me-2"></i>Method</th>
                                    <td>
                                        <span class="payment-badge payment-method">
                                            <i class="bi bi-wallet2 me-1"></i>
                                            ${order.payment.paymentMethod}
                                        </span>
                                    </td>
                                </tr>

                                <tr>
                                    <th>
                                        <i class="bi bi-clock-history text-primary me-2"></i>
                                        Paid Date
                                    </th>
                                    <td>
                                        <c:choose>
                                            <c:when test="${order.payment.paidDate != null}">
                                                ${order.payment.paidDate}
                                            </c:when>
                                            <c:otherwise>
                                                <span class="payment-badge d-inline-flex justify-content-center align-items-center"
                                                      style="width:170px; background:#f8f9fa; color:#6c757d;">
                                                    -
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>

                                <tr>
                                    <th>
                                        <i class="bi bi-upc-scan text-danger me-2"></i>
                                        Transaction Code
                                    </th>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty order.payment.transactionCode}">
                                                <span class="transaction-code">
                                                    ${order.payment.transactionCode}
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="payment-badge d-inline-flex justify-content-center align-items-center"
                                                      style="width:170px; background:#f8f9fa; color:#6c757d;">
                                                    -
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>

                                <tr>
                                    <th>
                                        <i class="bi bi-bank2 text-warning me-2"></i>
                                        Bank / Wallet
                                    </th>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty order.payment.bankCode}">
                                                <span class="payment-badge payment-bank">
                                                    <i class="bi bi-bank me-1"></i>
                                                    ${order.payment.bankCode}
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="payment-badge d-inline-flex justify-content-center align-items-center"
                                                      style="width:170px; background:#f8f9fa; color:#6c757d;">
                                                    -
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>

                            </table>

                        </c:when>

                        <c:otherwise>

                            <div class="text-center py-5 text-muted">
                                <i class="bi bi-credit-card fs-1 mb-2 d-block"></i>
                                No payment information available.
                            </div>

                        </c:otherwise>

                    </c:choose>

                </div>

                <!-- Order Summary -->
                <div class="col-lg-5 ps-lg-4">

                    <h5 class="mb-4">
                        <i class="bi bi-receipt text-success me-2"></i>
                        Order Summary
                    </h5>

                    <table class="table table-borderless summary-table">

                        <tr>
                            <th>
                                <i class="bi bi-box-seam text-secondary me-2"></i>
                                Subtotal
                            </th>
                            <td class="text-end fw-semibold">
                                ${order.subtotal} VNĐ
                            </td>
                        </tr>

                        <tr>
                            <th>
                                <i class="bi bi-truck text-primary me-2"></i>
                                Shipping Fee
                            </th>
                            <td class="text-end fw-semibold">
                                ${order.shippingFee} VNĐ
                            </td>
                        </tr>

                        <tr>
                            <th>
                                <i class="bi bi-ticket-perforated text-shopee me-2"></i>
                                Discount
                            </th>
                            <td class="text-end fw-semibold text-shopee">
                                - ${order.discountAmount} VNĐ
                            </td>
                        </tr>

                        <tr class="border-top">
                            <td class="fw-bold">
                                <i class="bi bi-cash-stack text-danger me-2"></i>
                                Total Amount
                            </td>
                            <td class="text-end text-danger fw-bold fs-4">
                                ${order.totalAmount} VNĐ
                            </td>
                        </tr>

                    </table>

                </div>

            </div>

        </div>

    </div>

</div>

<%@include file="/WEB-INF/include/footer.jsp"%>
