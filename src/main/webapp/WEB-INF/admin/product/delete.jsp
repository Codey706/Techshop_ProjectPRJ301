<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="/WEB-INF/include/header.jsp"%>
<%@include file="/WEB-INF/include/navbar.jsp"%>

<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<style>
    body{
        font-family:'Inter',sans-serif;
        background:#f8fafc;
    }

    .page-wrapper{
        padding:32px 24px;
    }

    .card-mirai{
        border:none;
        border-radius:14px;
        box-shadow:0 2px 12px rgba(15,23,42,.06);
        background:#fff;
    }

    .section-title{
        font-size:1.15rem;
        font-weight:700;
        color:#1e293b;
    }

    .form-label{
        font-weight:600;
        color:#475569;
    }

    .form-control,
    textarea{
        background:#f8fafc;
    }

    .product-image{
        width:100%;
        height:240px;
        object-fit:contain;
        background:#fff;
        border:1px solid #e2e8f0;
        border-radius:12px;
        padding:12px;
    }

    .warning-box{
        border-left:4px solid #dc3545;
        background:#fff5f5;
        border-radius:8px;
        padding:10px 14px;
        color:#842029;
        font-size:.9rem;
        line-height:1.4;
    }

    .info-card{
        border:1px solid #e2e8f0;
        border-radius:12px;
        padding:20px;
        background:#fff;
    }

    .btn-delete{
        min-width:170px;
    }

    .btn-cancel{
        min-width:130px;
    }

    .delete-logo{
        width:34px;
        height:34px;

        display:flex;
        align-items:center;
        justify-content:center;

        border-radius:50%;
        background:#fff1f2;
        border:1px solid #f8d7da;

        color:#dc3545;
        font-size:14px;

        flex-shrink:0;
    }

    .preview-note{
        text-align:center;
        margin-bottom:16px;
    }

    .preview-note small{
        display:block;
        font-size:.9rem;
        line-height:1.4;
        color:#6b7280;
    }

    .preview-note p{
        font-size:.75rem;
        color:#6b7280;
        margin:0;
    }

    .preview-icon{
        width:38px;
        height:38px;

        display:flex;
        align-items:center;
        justify-content:center;

        border-radius:50%;

        background:#fff7ed;
        border:1px solid #fed7aa;

        color:#ea580c;
        font-size:17px;

        flex-shrink:0;
    }

    .preview-text{
        font-size:.9rem;
        line-height:1.4;
        color:#842029;
    }

    .product-card{
        position: relative;
    }

    .product-mascot{
        position: absolute;
        top: 3px;
        right: 18px;

        width: 90px;
        height: auto;

        object-fit: contain;
        filter: drop-shadow(0 6px 12px rgba(0,0,0,.15));
        transition: .25s;
    }

    .product-mascot:hover{
        transform: scale(1.05);
    }
</style>

<div class="page-wrapper">

    <div class="container">

        <div class="d-flex justify-content-between align-items-center mb-4">

            <div>
                <h3 class="fw-bold mb-1">
                    Delete Product
                </h3>

                <p class="text-muted mb-0">
                    Review the information before deleting this product.
                </p>
            </div>

            <a href="${pageContext.request.contextPath}/admin/product"
               class="btn btn-success">
                <i class="bi bi-arrow-left me-1"></i>
                Back to Product List
            </a>

        </div>

        <form action="${pageContext.request.contextPath}/admin/product?action=delete"
              method="post">

            <input type="hidden"
                   name="productId"
                   value="${product.productId}">

            <div class="row g-4 align-items-stretch">

                <!-- LEFT -->
                <div class="col-lg-8">

                    <div class="card card-mirai p-4 h-100 product-card">

                        <img src="${pageContext.request.contextPath}/assets/images/view-more.png"
                             class="product-mascot"
                             alt="Mascot">

                        <div class="d-flex align-items-center mb-4">

                            <div class="rounded-circle bg-danger-subtle d-flex align-items-center justify-content-center me-2"
                                 style="width:34px;height:34px;">

                                <i class="bi bi-trash-fill text-danger"></i>

                            </div>

                            <span class="section-title">
                                Product Information
                            </span>

                        </div>

                        <div class="warning-box mb-4">

                            <div class="d-flex">

                                <i class="bi bi-exclamation-octagon-fill fs-4 me-3"></i>

                                <div>

                                    <div class="fw-bold mb-1">
                                        Permanent Deletion
                                    </div>

                                    <small>
                                        Deleting this product will also remove all related variants and cannot be undone.
                                    </small>

                                </div>

                            </div>

                        </div>

                        <div class="mb-3">
                            <label class="form-label">Product Name</label>
                            <input class="form-control"
                                   value="${product.productName}"
                                   readonly>
                        </div>

                        <div class="row">

                            <div class="col-md-6 mb-3">
                                <label class="form-label">Category</label>
                                <input class="form-control"
                                       value="${product.category.categoryName}"
                                       readonly>
                            </div>

                            <div class="col-md-6 mb-3">
                                <label class="form-label">Brand</label>
                                <input class="form-control"
                                       value="${product.brand.brandName}"
                                       readonly>
                            </div>

                        </div>

                        <div class="mb-4">
                            <label class="form-label">Description</label>

                            <textarea class="form-control"
                                      rows="3"
                                      readonly>${product.description}</textarea>

                        </div>

                    </div>

                </div>

                <!-- RIGHT -->
                <div class="col-lg-4">

                    <div class="card card-mirai p-4 h-100 d-flex flex-column">

                        <div class="d-flex justify-content-between align-items-center mb-2">

                            <div class="d-flex align-items-center">

                                <div class="preview-icon me-2">
                                    <i class="bi bi-box-seam-fill"></i>
                                </div>

                                <span class="section-title">
                                    Product Preview
                                </span>

                            </div>



                        </div>

                        <div class="preview-note">

                            <div class="d-flex align-items-center justify-content-center mb-1">

                                <div class="delete-logo me-2">
                                    <i class="bi bi-trash3-fill"></i>
                                </div>

                                <div class="fw-bold">
                                    Delete Confirmation
                                </div>

                            </div>

                            <div class="text-muted preview-text">
                                Please make sure this is the correct product before deleting.
                            </div>

                        </div>
                        <img class="product-image"
                             src="${pageContext.request.contextPath}/assets/images/products/${product.variants[0].imageUrl}">

                        <hr>

                        <div class="d-flex justify-content-between align-items-center">

                            <a href="${pageContext.request.contextPath}/admin/product"
                               class="btn btn-outline-dark btn-cancel">
                                <i class="bi bi-arrow-left"></i>
                                Cancel
                            </a>

                            <button type="submit"
                                    class="btn btn-danger btn-delete"
                                    onclick="return confirm('Delete this product permanently?');">

                                <i class="bi bi-trash-fill me-1"></i>

                                Delete Product

                            </button>

                        </div>

                    </div>

                </div>

            </div>

        </form>

    </div>

</div>

<%@include file="/WEB-INF/include/footer.jsp"%>