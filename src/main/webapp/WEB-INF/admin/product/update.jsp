<%-- 
    Document   : update
    Created on : Jun 22, 2026, 12:08:24 PM
    Author     : HP
--%>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/include/header.jsp"%>
<%@include file="/WEB-INF/include/navbar.jsp"%>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<div class="container-fluid py-4">
    <div class="card border border-black border-opacity-10 rounded-3 overflow-hidden shadow-sm mx-auto" style="max-width: 900px; background-color: #ffffff;">

        <div class="card-header bg-white border-bottom border-black border-opacity-10 p-3 d-flex justify-content-between align-items-center position-relative">
            <h1 class="mb-0 mx-auto fw-bold text-dark" style="font-size: 20px;">Edit Product</h1>
            <button type="button" class="btn border-0 p-0 text-muted position-absolute" style="right: 20px; top: 15px; font-size: 18px;" onclick="window.history.back();">
                <i class="fa-solid fa-xmark"></i>
            </button>
        </div>

        <div class="card-body p-4">
            <form action="${pageContext.request.contextPath}/admin/product?view=edit" method="POST" enctype="multipart/form-data">

                <input type="hidden" name="productId" value="${product.id}">

                <div class="row g-4">

                    <div class="col-md-8 col-lg-8">

                        <div class="mb-3">
                            <label class="form-label fw-bold text-dark mb-1" style="font-size: 14px;">Product Name <span class="text-danger">*</span></label>
                            <input type="text" class="form-control rounded-2 border-secondary border-opacity-25 py-2 text-dark" name="productName" value="${product.name}" placeholder="Enter Product Name" required style="font-size: 14px;">
                        </div>

                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label class="form-label fw-bold text-dark mb-1" style="font-size: 14px;">Product Code </label>
                                <input type="text" class="form-control rounded-2 border-secondary border-opacity-25 py-2 text-dark" name="baseSKU" value="${product.baseSKU}" placeholder="Product Code" style="font-size: 14px;">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold text-dark mb-1" style="font-size: 14px;">Publish Date</label>
                                <input type="date" class="form-control rounded-2 border-secondary border-opacity-25 py-2 text-dark" name="publishedAt" value="${product.publishedAt}" style="font-size: 14px;">
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold text-dark mb-1" style="font-size: 14px;">Belongs to the category <span class="text-danger">*</span></label>
                            <div class="d-flex gap-2">
                                <select class="form-select rounded-2 border-secondary border-opacity-25 py-2 text-dark" name="categoryId" required style="font-size: 14px;">
                                    <option value="">-- Choose Category --</option>
                                    <c:forEach var="cat" items="${categories}">
                                        <option value="${cat.id}" ${cat.id == product.categoryId ? 'selected' : ''}>${cat.name}</option>
                                    </c:forEach>
                                </select>
                                <button type="button" class="btn d-flex align-items-center justify-content-center text-white rounded-2 px-3 border-0" style="background-color: #00b65f;">
                                    <i class="fa-solid fa-plus"></i>
                                </button>
                            </div>
                        </div> <div class="mb-3">
                            <label class="form-label fw-bold text-dark mb-1" style="font-size: 14px;">Belongs to the brand <span class="text-danger">*</span></label>
                            <div class="d-flex gap-2">
                                <select class="form-select rounded-2 border-secondary border-opacity-25 py-2 text-dark" name="brandId" required style="font-size: 14px;">
                                    <option value="">-- Choose Brand --</option>
                                    <c:forEach var="br" items="${brands}">
                                        <option value="${br.brandId}" ${br.brandId == product.brandId ? 'selected' : ''}>${br.brandName}</option>
                                    </c:forEach>
                                </select>
                                <button type="button" class="btn d-flex align-items-center justify-content-center text-white rounded-2 px-3 border-0" style="background-color: #00b65f;">
                                    <i class="fa-solid fa-plus"></i>
                                </button>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold text-dark mb-1" style="font-size: 14px;">Status <span class="text-danger">*</span></label>
                            <select class="form-select rounded-2 border-secondary border-opacity-25 py-2 text-dark" name="productStatus" required style="font-size: 14px;">
                                <option value="1" ${product.status == 1 ? 'selected' : ''}>Active</option>
                                <option value="0" ${product.status == 0 ? 'selected' : ''}>Inactive</option>
                            </select>
                        </div>

                        <div class="row mb-3 g-2">
                            <div class="col-6 d-flex align-items-center gap-2">
                                <input type="checkbox" class="form-check-input border-secondary" id="featuredCheck" name="isFeatured" value="1" ${product.isFeatured ? 'checked' : ''} style="width: 17px; height: 17px; cursor: pointer;">
                                <label class="form-check-label text-dark fw-medium" for="featuredCheck" style="font-size: 14px; cursor: pointer;">Featured Product</label>
                            </div>
                            <div class="col-6 d-flex align-items-center gap-2">
                                <input type="checkbox" class="form-check-input border-secondary" id="newCheck" name="isNew" value="1" ${product.isNew ? 'checked' : ''} style="width: 17px; height: 17px; cursor: pointer;">
                                <label class="form-check-label text-dark fw-medium" for="newCheck" style="font-size: 14px; cursor: pointer;">New Arrival</label>
                            </div>
                        </div>

                    </div>

                    <div class="col-md-4 col-lg-4 ps-md-3">
                        <label class="form-label fw-bold text-dark mb-2" style="font-size: 14px;">Product's Image</label>

                        <div class="border rounded d-flex flex-column align-items-center justify-content-center text-center p-2 bg-white mx-auto mx-md-0" 
                             onclick="document.getElementById('mainImageInput').click();" 
                             style="cursor: pointer; width: 100%; max-width: 150px; height: 110px; border-style: dashed !important; border-color: #d9d9d9 !important;">

                            <input type="hidden" name="oldMainImage" value="${product.mainImage}">
                            <input type="file" id="mainImageInput" name="mainImage" accept="image/*" style="display: none;" onchange="previewImage(this);">

                            <div id="uploadContent" style="display: ${not empty product.mainImage ? 'none' : 'block'};">
                                <i class="fa-regular fa-image text-muted mb-1" style="font-size: 22px;"></i>
                                <p class="mb-0 text-secondary" style="font-size: 13px;">Add image</p>
                            </div>

                            <div id="previewContainer" class="w-100 h-100" style="display: ${empty product.mainImage ? 'none' : 'block'};">
                                <img id="imagePreview" 
                                     src="${not empty product.mainImage ? pageContext.request.contextPath.concat('/').concat(product.mainImage) : '#'}" 
                                     class="w-100 h-100 rounded" style="object-fit: contain;">
                            </div>
                        </div>
                    </div>

                </div>

                <div class="d-flex justify-content-end gap-2 border-top border-light mt-5 pt-3">
                    <button type="button" class="btn btn-light border bg-white text-dark rounded-2 px-4 fw-medium" onclick="window.history.back();" style="font-size: 14px; border-color: #d9d9d9 !important;">Close</button>
                    <button type="submit" class="btn text-white rounded-2 px-4 border-0 fw-medium" style="background-color: #00b65f; font-size: 14px;">Update</button>
                </div>

            </form>
        </div>
    </div>
</div>

<script>
    function previewImage(input) {
        if (input.files && input.files[0]) {
            const file = input.files[0];
            const reader = new FileReader();

            reader.onload = function (e) {
                const imagePreview = document.getElementById('imagePreview');
                const previewContainer = document.getElementById('previewContainer');
                const uploadContent = document.getElementById('uploadContent');

                if (imagePreview) {
                    imagePreview.setAttribute('src', e.target.result);
                    previewContainer.style.setProperty('display', 'block', 'important');
                    uploadContent.style.setProperty('display', 'none', 'important');
                }
            };

            reader.readAsDataURL(file);
        }
    }
</script>

<%@include file="/WEB-INF/include/footer.jsp"%>