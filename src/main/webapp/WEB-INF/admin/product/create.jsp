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

    /* Vùng drag and drop tải ảnh lên */
    .drag-drop-zone{
        border: 2px dashed #cbd5e1;
        border-radius: 8px;
        min-height: 220px;
        display: flex;
        justify-content: center;
        align-items: center;
        background: #f8fafc;
        cursor: pointer;
        transition: .2s;
        overflow: hidden;
    }

    .drag-drop-zone:hover{
        border-color:#4f46e5;
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

    /* Accordion tùy biến cho phần thông tin mở rộng */
    .accordion-mirai {
        border: 1px solid #f1f5f9;
        border-radius: 12px;
        background: #fff;
        box-shadow: 0 1px 3px rgba(0,0,0,0.03);
    }

    .accordion-mirai .accordion-button {
        font-size: 1.10rem;
        font-weight: 600;
        color: #334155;
        padding: 0.8rem 1.2rem;
        box-shadow: none;
        background-color: transparent;
    }

    .accordion-mirai .accordion-button:not(.collapsed) {
        color: #334155;
        border-bottom: 1px solid #f1f5f9;
    }

    <%--
    #uploadContent{
        width:100%;
        height:100%;
    }
    --%>

    #uploadContent{
        width:100%;
        display:flex;
        justify-content:center;
        align-items:center;
    }

    <%--
        #uploadContent img{
            border-radius:6px;
            width:100%;
            height:100%;
            object-fit:contain;
            display:block;
        }
    --%>

    #uploadContent img{
        max-width:100%;
        max-height:320px;
        width:auto;
        height:auto;
        object-fit:contain;
        display:block;
        border-radius:6px;
    }

    .preview-logo{
        border: 1px solid #e2e8f0;
        border-radius: 8px;
        background: #fff;
    }

    .preview-logo img{
        width: 100%;
        height: auto;
        display: block;
        border-radius: 6px;
    }

</style>

<div class="page-wrapper">
    <div class="container-fluid px-2">

        <div class="d-flex justify-content-between align-items-start mb-4">
            <div>
                <h3 class="fw-bold text-dark mb-1" letter-spacing: -0.025em;">Add New Product</h3>
                <span class="text-muted small" style="font-size: 1rem">Fill in the information below to create a new product</span>
            </div>
            <div class="d-flex flex-column align-items-end mt-3">
                <a href="${pageContext.request.contextPath}/admin/product" class="btn btn-sm border fw-medium px-3 py-2 shadow-sm btn-success mt-2" style="font-size: 0.925rem; border-radius: 6px;">
                    <i class="bi bi-arrow-left me-1" style="font-size: 1rem"></i> Back to Product List
                </a>
            </div>
        </div>

        <form action="${pageContext.request.contextPath}/admin/product?action=store" method="POST" enctype="multipart/form-data">
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
                            <input type="text" id="prodNameInput" name="productName" maxlength="150" class="form-control form-control-mirai shadow-sm" placeholder="Enter product name" required>
                            <div class="char-counter"><span id="nameCount">0</span> / 150</div>
                        </div>

                        <div class="row mb-4">
                            <div class="col-md-6">
                                <label class="form-label-mirai" style="font-size: 1rem;">Price (VNĐ) <span class="text-danger">*</span></label>
                                <div class="input-group shadow-sm">
                                    <span class="input-group-text bg-white text-muted border-end-0">₫</span>
                                    <input type="number" name="price" class="form-control form-control-mirai border-start-0 ps-1" min="0" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label-mirai" style="font-size: 1rem;">Variant SKU <span class="text-danger">*</span></label>
                                <input type="text" name="variantSKU" class="form-control form-control-mirai shadow-sm" placeholder="e.g. HX-HASTE2-WHT" required>
                            </div>
                        </div>

                        <div class="row mb-4">
                            <div class="col-md-6">
                                <label class="form-label-mirai" style="font-size: 1rem;">Category <span class="text-danger">*</span></label>
                                <select name="categoryId" class="form-select form-select-mirai text-muted shadow-sm" required>
                                    <option value="" disabled selected>Select a category</option>
                                    <c:forEach var="cat" items="${categories}">
                                        <option value="${cat.categoryId}">${cat.categoryName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label-mirai" style="font-size: 1rem;">Brand <span class="text-danger">*</span></label>
                                <select name="brandId" class="form-select form-select-mirai text-muted shadow-sm" required>
                                    <option value="" disabled selected>Select a brand</option>
                                    <c:forEach var="b" items="${brands}">
                                        <option value="${b.brandId}">${b.brandName}</option>
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
                                <textarea id="descInput" name="description" class="form-control border-0 py-3 px-3" rows="8" placeholder="Write product description..." maxlength="" style="resize: none; font-size: 0.875rem;"></textarea>
                            </div>
                            <div class="char-counter"><span id="descCount">0</span> / 2000</div>
                        </div>
                    </div>

                    <div class="accordion accordion-mirai mb-4" id="accordionOptional">
                        <div class="accordion-item border-0 bg-transparent">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed d-flex align-items-center" type="button" data-bs-toggle="collapse" data-bs-target="#collapseInfo" aria-expanded="false" aria-controls="collapseInfo">
                                    <div class="rounded-circle d-flex align-items-center justify-content-center me-2" style="width:26px; height: 26px; background: #fef3c7;">
                                        <i class="bi bi-three-dots" style="color: #d97706; font-size: 1.2rem;"></i>
                                    </div>
                                    Additional Information (Optional)
                                </button>
                            </h2>
                            <div id="collapseInfo" class="accordion-collapse collapse" data-bs-parent="#accordionOptional">
                                <div class="accordion-body p-4 border-top" style="border-color: #f1f5f9 !important;">
                                    <div class="row g-3">

                                        <div class="col-md-6">
                                            <label class="form-label-mirai" style="font-size: 1rem;">Stock Quantity</label>
                                            <input type="number" name="stock" class="form-control form-control-mirai" min="0" placeholder="e.g. 25">
                                        </div>

                                        <div class="col-md-6">
                                            <label class="form-label-mirai" style="font-size: 1rem;">Discount Percent (%)</label>

                                            <div class="input-group">
                                                <input type="number" name="discountPercent" class="form-control form-control-mirai border-end-0"
                                                       min="0" max="100" placeholder="e.g. 10">
                                                <span class="input-group-text bg-white border-start-0">%</span>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>

                <div class="col-lg-4 d-flex flex-column">

                    <div class="card card-mirai p-4">
                        <div class="d-flex align-items-center mb-4">
                            <div class="rounded-circle d-flex align-items-center justify-content-center me-2" style="width: 26px; height: 26px; background: #e6f4ea;">
                                <i class="bi bi-tag-fill" style="color: #137333; font-size: 1.10rem;"></i>
                            </div>
                            <h5 class="mb-0 fw-bold text-dark" style="font-size: 1.10rem;">Product Status</h5>
                        </div>

                        <div class="d-flex flex-column gap-3">
                            <div class="status-box active-green d-flex align-items-start" id="boxActive">
                                <input class="form-check-input mt-1 me-3" type="radio" name="status" id="statusActive" value="1" checked style="border-color: #10b981; background-color: #10b981;">
                                <label for="statusActive" class="w-100 cursor-pointer">
                                    <span class="d-block fw-bold text-success small">Active</span>
                                    <span class="text-muted d-block" style="font-size: 0.75rem; margin-top: 1px;">Product is visible on the store</span>
                                </label>
                            </div>

                            <div class="status-box d-flex align-items-start" id="boxInactive">
                                <input class="form-check-input mt-1 me-3" type="radio" name="status" id="statusInactive" value="0" style="border-color: #6c757d; background-color: #6c757d;">
                                <label for="statusInactive" class="w-100 cursor-pointer">
                                    <span class="d-block fw-semibold text-dark small">Inactive</span>
                                    <span class="text-muted d-block" style="font-size: 0.75rem; margin-top: 1px;">Product is hidden from the store</span>
                                </label>
                            </div>
                        </div>
                    </div>

                    <div class="card card-mirai p-4 flex-grow-1">
                        <div class="d-flex align-items-center mb-3">
                            <div class="rounded-circle d-flex align-items-center justify-content-center me-2" style="width: 26px; height: 26px; background: #eeeffe;">
                                <i class="bi bi-image-fill" style="color: #4f46e5; font-size: 1.10rem;"></i>
                            </div>
                            <h5 class="mb-0 fw-bold text-dark" style="font-size: 1.10rem;">Product Image</h5>
                        </div>

                        <div class="drag-drop-zone"  id="dropZone" onclick="document.getElementById('imageFileInput').click();">
                            <input type="file" name="productImage" id="imageFileInput" class="d-none" accept="image/jpeg, image/png, image/webp" onchange="handleImagePreview(this)">
                            <div id="uploadContent" class="d-flex flex-column align-items-center justify-content-center">
                                <i class="bi bi-cloud-arrow-up text-primary mb-2" style="font-size: 2rem; color: #4f46e5 !important;"></i>
                                <p class="mb-1 small fw-medium text-dark">Drag & drop an image here</p>
                                <p class="text-muted my-1 small">or</p>
                                <button type="button" class="btn btn-sm bg-white border px-3 text-dark shadow-sm fw-medium mt-1" style="font-size: 0.8rem; border-color: #cbd5e1;">Choose File</button>
                                <p class="text-muted mt-3 mb-0" style="font-size: 0.7rem;">JPG, PNG or WEBP. Max size 2MB.</p>
                            </div>
                        </div>

                        <%--
                        <div class="border rounded p-3 mt-3 text-center d-flex flex-column align-items-center justify-content-center bg-light/30" id="previewArea" style="min-height: 160px;">
                            <i class="bi bi-bag-dash text-muted mb-2" id="previewIcon" style="font-size: 2rem; color: #cbd5e1 !important;"></i>
                            <span class="text-muted small fw-medium" id="previewStatusText">No image selected</span>
                        </div>
                        --%>
                        <div class="preview-logo mt-4">
                            <img src="${pageContext.request.contextPath}/assets/images/banner2.jpg"
                                 alt="Banner">
                        </div>
                                
                        <div class="preview-logo mt-3 d-none" id="banner2">
    <img src="${pageContext.request.contextPath}/assets/images/banner4.jpg"
         alt="Banner 2">
</div>
                    </div>
                </div>
            </div>

            <div class="row mt-4">
                <div class="col-12">
                    <div class="d-flex justify-content-between align-items-center bg-white py-2 px-3 border rounded-3 shadow-sm">
                        <a href="${pageContext.request.contextPath}/admin/product" class="btn btn-outline-danger">
                            <i class="bi bi-x-lg me-1"></i> Cancel
                        </a>
                        <div class="d-flex gap-3">
                            <button type="submit" name="saveMode" value="draft" class="btn btn-secondary">
                                <i class="bi bi-floppy me-1"></i> Save as Draft
                            </button>
                            <button type="submit" name="saveMode" value="publish" class="btn btn-success">
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
        if (radioActive.checked) {
            boxActive.classList.add('active-green');
            boxInactive.classList.remove('active-green');
        } else if (radioInactive.checked) {
            boxInactive.classList.add('active-green');
            boxActive.classList.remove('active-green');
        }
    }

    radioActive.addEventListener('change', updateStatusUI);
    radioInactive.addEventListener('change', updateStatusUI);

    // 2. Bộ đếm độ dài ký tự thực tế (Realtime Char Counter)
    const nameInput = document.getElementById('prodNameInput');
    const nameCount = document.getElementById('nameCount');
    nameInput.addEventListener('input', () => {
        nameCount.textContent = nameInput.value.length;
    });

    const descInput = document.getElementById('descInput');
    const descCount = document.getElementById('descCount');
    descInput.addEventListener('input', () => {
        descCount.textContent = descInput.value.length;
    });

    function handleImagePreview(input) {
        if (!input.files || !input.files[0])
            return;
        const reader = new FileReader();
        reader.onload = function (e) {
            document.getElementById("uploadContent").innerHTML =
                    '<img src="' + e.target.result + '">';
        };
        reader.readAsDataURL(input.files[0]);
    }
    
    const collapseInfo = document.getElementById("collapseInfo");
const banner2 = document.getElementById("banner2");

collapseInfo.addEventListener("shown.bs.collapse", function () {
    banner2.classList.remove("d-none");
});

collapseInfo.addEventListener("hidden.bs.collapse", function () {
    banner2.classList.add("d-none");
});
    <%--
        // 3. Hiển thị ảnh tức thì lên khung Preview khi bấm chọn file
        function handleImagePreview(input) {
            const previewArea = document.getElementById('previewArea');
            if (input.files && input.files[0]) {
                const fileReader = new FileReader();
                fileReader.onload = function (e) {
                    previewArea.innerHTML = '<img src="' + e.target.result + '" class="img-fluid rounded shadow-sm" style="max-height:140px; object-fit:contain;">';
                };
                fileReader.readAsDataURL(input.files[0]);
            }
        }
    --%>
</script>

<%@include file="/WEB-INF/include/footer.jsp"%>
