<%-- 
    Document   : create
    Created on : Jun 22, 2026, 12:07:25 PM
    Author     : HP
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<%@include file="/WEB-INF/include/header.jsp"%>
<%@include file="/WEB-INF/include/navbar.jsp"%>


<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">

<style>
    body {
        font-family: 'Inter', sans-serif;
        background-color: #f8fafc; /* Màu nền xám nhạt đồng bộ hệ thống */
    }

    .page-wrapper {
        padding: 2rem 1.5rem;
    }

    /* Bo góc và đổ bóng nhẹ siêu mảnh của card */
    .card-mirai {
        border: 1px solid #f1f5f9;
        border-radius: 12px;
        box-shadow: 0 1px 3px rgba(0,0,0,0.03);
        background-color: #ffffff;
        margin-bottom: 1.5rem;
    }

    .form-label-mirai {
        font-size: 0.85rem;
        font-weight: 600;
        color: #334155;
        margin-bottom: 0.5rem;
    }

    .form-control-mirai, .form-select-mirai {
        border: 1px solid #cbd5e1;
        border-radius: 6px;
        padding: 0.55rem 0.75rem;
        font-size: 0.875rem;
        color: #334155;
    }

    .form-control-mirai::placeholder {
        color: #94a3b8;
    }

    .form-control-mirai:focus, .form-select-mirai:focus {
        border-color: #4f46e5;
        box-shadow: 0 0 0 1px #4f46e5;
        background-color: #fff;
    }

    /* Variant Card */
    .variant-card {
        border: 1px solid #f1f5f9;
        border-radius: 12px;
        background: #ffffff;
        padding: 1.25rem;
        margin-bottom: 1.25rem;
        box-shadow: 0 1px 3px rgba(0,0,0,0.03);
    }

    .variant-title {
        font-size: 1rem;
        font-weight: 700;
        color: #334155;
        margin-bottom: 1rem;
    }

    .variant-label {
        font-size: 1rem;
        font-weight: 600;
        color: #334155;
        margin-bottom: 0.5rem;
    }

    .variant-input {
        border: 1px solid #cbd5e1;
        border-radius: 6px;
        padding: 0.55rem 0.75rem;
        font-size: 0.875rem;
        color: #334155;
    }

    .variant-input:focus {
        border-color: #4f46e5;
        box-shadow: 0 0 0 1px #4f46e5;
    }

    .variant-select {
        border: 1px solid #cbd5e1;
        border-radius: 6px;
        padding: 0.55rem 0.75rem;
        font-size:0.875rem;
        color:#334155;
    }

    /* Thước đo đếm độ dài ký tự góc dưới input */
    .char-counter {
        font-size: 0.7rem;
        color: #94a3b8;
        text-align: right;
        margin-top: 0.25rem;
    }

    /* Style block trạng thái active */
    .status-box {
        border: 1px solid #e2e8f0;
        border-radius: 8px;
        padding: 0.85rem 1rem;
        cursor: pointer;
        transition: all 0.2s ease;
    }

    .status-box.active-green {
        border-color: #10b981;
        background-color: rgba(16, 185, 129, 0.04);
    }

    /* Thanh toolbar tùy biến của bộ soạn thảo mô tả */
    .editor-container {
        border: 1px solid #cbd5e1;
        border-radius: 6px;
        overflow: hidden;
    }

    .editor-toolbar {
        background-color: #f8fafc;
        border-bottom: 1px solid #cbd5e1;
        padding: 0.5rem 0.75rem;
        display: flex;
        align-items: center;
        gap: 0.25rem;
        flex-wrap: wrap;
    }

    .editor-toolbar button {
        background: none;
        border: none;
        padding: 0.25rem 0.5rem;
        color: #475569;
        font-size: 0.85rem;
        border-radius: 4px;
    }

    .editor-toolbar button:hover {
        background-color: #e2e8f0;
    }


</style>

<div class="page-wrapper">

    <div class="container-fluid px-2">

        <div class="d-flex justify-content-between align-items-start mb-4">

            <div>

                <h3 class="fw-bold text-dark mb-1" style="letter-spacing: -0.025em;">
                    Update Product
                </h3>

                <span class="text-muted small" style="font-size: 1rem">
                    Update the information below to modify the product
                </span>

            </div>

            <div class="d-flex flex-column align-items-end mt-3">

                <a href="${pageContext.request.contextPath}/admin/product"
                   class="btn btn-success btn-sm shadow-sm">
                    <i class="bi bi-arrow-left me-1"></i> Back to Product List
                </a>

            </div>

        </div>

        <form action="${pageContext.request.contextPath}/admin/product?action=update" method="POST" enctype="multipart/form-data">

            <input type="hidden" name="productId" value="${product.productId}">

            <div class="row g-4 align-items-stretch">

                <div class="col-lg-8">

                    <div class="card card-mirai p-4">

                        <div class="d-flex align-items-center mb-4">

                            <div class="rounded-circle d-flex align-items-center justify-content-center me-2" style="width: 26px; height: 26px; bg-color: #eeeffe; background: #eeeffe;">

                                <i class="bi bi-file-earmark-text-fill" style="color: #4f46e5; font-size: 1.10rem;"></i>

                            </div>

                            <h5 class="mb-0 fw-bold text-dark" style="font-size: 1.10rem;">Basic Information</h5>

                        </div>

                        <div class="mb-4">

                            <label class="form-label-mirai" style="font-size: 1rem;">Product Name <span class="text-danger">*</span></label>

                            <input type="text" id="prodNameInput" name="productName" value="${product.productName}" maxlength="150" class="form-control form-control-mirai shadow-sm" placeholder="Enter product name" required>

                            <div class="char-counter"><span id="nameCount">0</span> / 150</div>

                        </div>

                        <c:forEach var="v" items="${product.variants}" varStatus="st">

                            <div class="variant-card">

                                <div class="d-flex align-items-center justify-content-between mb-3">

                                    <h6 class="variant-title mb-0">

                                        <i class="bi bi-box2-heart-fill text-danger me-2"></i>

                                        Variant ${st.index + 1}

                                    </h6>

                                    <span class="badge bg-light text-success border">
                                        #${v.variantId}
                                    </span>

                                </div>

                                <input type="hidden"
                                       name="variantId"
                                       value="${v.variantId}">


                                <div class="row g-3">

                                    <div class="col-md-6">
                                        <label class="variant-label">
                                            SKU
                                        </label>

                                        <input type="text"
                                               class="form-control variant-input shadow-sm"
                                               name="variantSKU"
                                               value="${v.variantSKU}">
                                    </div>


                                    <div class="col-md-6">
                                        <label class="variant-label">
                                            Variant Name
                                        </label>

                                        <input type="text"
                                               class="form-control variant-input shadow-sm"
                                               name="variantName"
                                               value="${v.variantName}">
                                    </div>


                                    <div class="col-md-4">

                                        <label class="variant-label">
                                            Original Price
                                        </label>

                                        <input type="number"
                                               class="form-control variant-input shadow-sm"
                                               name="originalPrice"
                                               value="${v.originalPrice}">
                                    </div>


                                    <div class="col-md-4">

                                        <label class="variant-label">
                                            Price
                                        </label>

                                        <input type="number"
                                               class="form-control variant-input shadow-sm"
                                               name="price"
                                               value="${v.price}">
                                    </div>


                                    <div class="col-md-4">

                                        <label class="variant-label">
                                            Discount (%)
                                        </label>

                                        <div class="input-group shadow-sm">

                                            <input type="number"
                                                   class="form-control variant-input border-end-0"
                                                   name="discountPercent"
                                                   value="${v.discountPercent}">

                                            <span class="input-group-text bg-white border-start-0">
                                                %
                                            </span>

                                        </div>

                                    </div>


                                    <div class="col-md-6">

                                        <label class="variant-label">
                                            Stock
                                        </label>

                                        <input type="number"
                                               class="form-control variant-input shadow-sm"
                                               name="stock"
                                               value="${v.stock}">
                                    </div>


                                    <div class="col-md-6">

                                        <label class="variant-label">
                                            Status
                                        </label>

                                        <select class="form-select variant-select shadow-sm"
                                                name="variantStatus">

                                            <option value="Active"
                                                    ${v.status=="Active"?"selected":""}>
                                                Active
                                            </option>

                                            <option value="Inactive"
                                                    ${v.status=="Inactive"?"selected":""}>
                                                Inactive
                                            </option>

                                        </select>

                                    </div>

                                    <div class="col-md-12">

                                        <label class="variant-label">Variant Image</label>

                                        <!-- Hàng chứa 2 ảnh -->
                                        <div class="row g-3 mb-3">

                                            <div class="col-4">

                                                <img id="preview${st.index}"
                                                     src="${pageContext.request.contextPath}/assets/images/products/${v.imageUrl}"
                                                     class="img-fluid rounded shadow-sm"
                                                     style="
                                                     width:100%;
                                                     height:180px;
                                                     object-fit:contain;
                                                     background:#fff;
                                                     border:1px solid #e2e8f0;">

                                            </div>

                                            <div class="col-8">

                                                <img src="${pageContext.request.contextPath}/assets/images/banner5.jpg"
                                                     class="img-fluid rounded shadow-sm"
                                                     style="
                                                     width:100%;
                                                     height:180px;
                                                     object-fit:cover;
                                                     border:1px solid #e2e8f0;">

                                            </div>

                                        </div>

                                        <input type="hidden"
                                               name="oldImageUrl"
                                               value="${v.imageUrl}">

                                        <input type="file"
                                               name="variantImage"
                                               class="form-control variant-input shadow-sm"
                                               accept="image/jpeg,image/png,image/webp"
                                               onchange="previewVariantImage(this, 'preview${st.index}')">

                                    </div>


                                </div>
                            </div>


                        </c:forEach>

                        <div class="row mb-4">

                            <div class="col-md-6">

                                <label class="form-label-mirai" style="font-size: 1rem;">Category <span class="text-danger">*</span></label>

                                <select name="categoryId" class="form-select form-select-mirai text-muted shadow-sm" required>

                                    <c:forEach var="cat" items="${categories}">

                                        <option value="${cat.categoryId}" ${cat.categoryId==product.categoryId ? 'selected' : ''}>

                                            ${cat.categoryName}

                                        </option>

                                    </c:forEach>

                                </select>

                            </div>

                            <div class="col-md-6">

                                <label class="form-label-mirai" style="font-size: 1rem;">Brand <span class="text-danger">*</span></label>

                                <select name="brandId" class="form-select form-select-mirai text-muted shadow-sm" required>

                                    <c:forEach var="b" items="${brands}">

                                        <option value="${b.brandId}" ${b.brandId==product.brandId ? 'selected' : ''}>

                                            ${b.brandName}

                                        </option>

                                    </c:forEach>

                                </select>

                            </div>

                        </div>

                        <div class="mb-2">
                            <label class="form-label-mirai" style="font-size: 1rem;">Description</label>
                            <div class="editor-container shadow-sm">
                                <div class="editor-toolbar">
                                    <select class="form-select form-select-sm border-0 bg-transparent py-0 text-muted" style="width: auto; font-size: 0.85rem; font-weight: 500;">
                                        <option>Paragraph</option>
                                    </select>
                                    <div class="vr mx-1" style="height: 14px; color: #cbd5e1;"></div>
                                    <button type="button" class="fw-bold">B</button>
                                    <button type="button" class="fst-italic">I</button>
                                    <button type="button" class="text-decoration-underline">U</button>
                                    <div class="vr mx-1" style="height: 14px; color: #cbd5e1;"></div>
                                    <button type="button"><i class="bi bi-list-ul"></i></button>
                                    <button type="button"><i class="bi bi-list-ol"></i></button>
                                    <button type="button"><i class="bi bi-text-left"></i></button>
                                    <button type="button"><i class="bi bi-link-45deg"></i></button>
                                    <button type="button"><i class="bi bi-image"></i></button>

                                </div>

                                <textarea
                                    id="descInput"
                                    name="description"
                                    class="form-control border-0 py-3 px-3"
                                    rows="5"
                                    maxlength="2000"
                                    placeholder="Write product description..."
                                    style="resize:none;font-size:0.875rem;">${product.description}</textarea>

                            </div>

                            <div class="char-counter"><span id="descCount">0</span> / 2000</div>

                        </div>    

                    </div>



                </div>

                <div class="col-lg-4 d-flex flex-column">

                    <div class="card card-mirai p-4 mb-4">

                        <div class="d-flex align-items-center mb-3">
                            <div class="rounded-circle d-flex align-items-center justify-content-center me-2"
                                 style="width:26px;height:26px;background:#eef2ff;">
                                <i class="bi bi-image-fill"
                                   style="color:#4f46e5;"></i>
                            </div>

                            <h5 class="mb-0 fw-bold"
                                style="font-size:1.1rem;">
                                Product Thumbnail
                            </h5>
                        </div>

                        <img id="productPreview"
                             src="${pageContext.request.contextPath}/assets/images/products/${product.variants[0].imageUrl}"
                             class="img-fluid rounded border mb-3"
                             style="height:260px;object-fit:contain;background:#fff;">

                        <input type="hidden"
                               name="oldProductImage"
                               value="${product.imageUrl}">

                        <input type="file"
                               name="productImage"
                               class="form-control variant-input shadow-sm"
                               accept="image/*"
                               onchange="previewVariantImage(this, 'productPreview')">

                    </div>

                    <div class="card card-mirai p-4">
                        <div class="d-flex align-items-center mb-4">
                            <div class="rounded-circle d-flex align-items-center justify-content-center me-2" style="width: 26px; height: 26px; background: #e6f4ea;">
                                <i class="bi bi-tag-fill" style="color: #137333; font-size: 1.10rem;"></i>
                            </div>
                            <h5 class="mb-0 fw-bold text-dark" style="font-size: 1.10rem;">Product Status</h5>
                        </div>

                        <div class="d-flex flex-column gap-3">

                            <div class="status-box d-flex align-items-start" id="boxActive">

                                <input class="form-check-input mt-1 me-3" type="radio" name="status" id="statusActive" value="1" ${product.status==1?'checked':''} style="border-color:#10b981;background-color:#10b981;">

                                <label for="statusActive" class="w-100 cursor-pointer">

                                    <span class="d-block fw-bold text-success small">Active</span>

                                    <span class="text-muted d-block" style="font-size: 0.75rem; margin-top: 1px;">Product is visible on the store</span>

                                </label>

                            </div>

                            <div class="status-box d-flex align-items-start" id="boxInactive">

                                <input class="form-check-input mt-1 me-3" type="radio" name="status" id="statusInactive" value="0" ${product.status==0?'checked':''} style="border-color:#6c757d;background-color:#6c757d;">

                                <label for="statusInactive" class="w-100 cursor-pointer">

                                    <span class="d-block fw-semibold text-dark small">Inactive</span>

                                    <span class="text-muted d-block" style="font-size: 0.75rem; margin-top: 1px;">Product is hidden from the store</span>

                                </label>

                            </div>

                        </div>

                    </div>

                    <img
                        src="${pageContext.request.contextPath}/assets/images/banner2.jpg"
                        class="img-fluid rounded shadow-sm"
                        style="
                        width:100%;
                        object-fit:cover;
                        border:1px solid #e2e8f0;">

                    <img
                        src="${pageContext.request.contextPath}/assets/images/banner4.jpg"
                        class="img-fluid rounded shadow-sm mt-4"
                        style="
                        width:100%;
                        object-fit:cover;
                        border:1px solid #e2e8f0;">

                </div>
            </div>
                    
                        <div class="row">
    <div class="col-12">
        <div class="d-flex justify-content-between align-items-center bg-white py-2 px-3 border rounded-3 shadow-sm">

           
            <a href="${pageContext.request.contextPath}/admin/product"
               class="btn btn-danger btn-sm">
                <i class="bi bi-x-lg me-1"></i> Cancel
            </a>

          
            <div class="d-flex gap-3">

                <button type="submit"
                        name="saveMode"
                        value="draft"
                        class="btn btn-secondary btn-sm">
                    <i class="bi bi-floppy me-1"></i> Save as Draft
                </button>

                <button type="submit"
                        name="saveMode"
                        value="publish"
                        class="btn btn-success btn-sm">
                    <i class="bi bi-floppy-fill me-1"></i> Save Product
                </button>

            </div>

        </div>
    </div>
</div>

        </form>

    </div>
</div>

<script>
    // 1. Tự động đổi màu và trạng thái Active viền của Radio Box
    const radioActive = document.getElementById('statusActive');
    const radioInactive = document.getElementById('statusInactive');
    const boxActive = document.getElementById('boxActive');
    const boxInactive = document.getElementById('boxInactive');

    function updateStatusUI() {

        boxActive.classList.remove("active-green");
        boxInactive.classList.remove("active-green");

        if (radioActive.checked) {
            boxActive.classList.add("active-green");
        }

        if (radioInactive.checked) {
            boxInactive.classList.add("active-green");
        }
    }

    radioActive.addEventListener('change', updateStatusUI);
    radioInactive.addEventListener('change', updateStatusUI);

    updateStatusUI();

    // 2. Bộ đếm độ dài ký tự thực tế (Realtime Char Counter)
    const nameInput = document.getElementById('prodNameInput');
    const nameCount = document.getElementById('nameCount');

    nameCount.textContent = nameInput.value.length;

    nameInput.addEventListener('input', () => {
        nameCount.textContent = nameInput.value.length;
    });

    const descInput = document.getElementById('descInput');
    const descCount = document.getElementById('descCount');


    descCount.textContent = descInput.value.length;

    descInput.addEventListener('input', () => {
        descCount.textContent = descInput.value.length;
    });

    function previewVariantImage(input, imgId) {

        if (!input.files || !input.files[0])
            return;

        const reader = new FileReader();

        reader.onload = function (e) {
            document.getElementById(imgId).src = e.target.result;
        };

        reader.readAsDataURL(input.files[0]);
    }
</script>

<%@include file="/WEB-INF/include/footer.jsp"%>
