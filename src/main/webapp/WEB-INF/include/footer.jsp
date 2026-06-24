<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/footer.css">
<%-- Lượn sóng --%>
<div class="w-100 overflow-hidden bg-light" style="height: 20px; margin-top: auto;">
    <svg viewBox="0 0 1200 120" preserveAspectRatio="none" style="width: 100%; height: 20px; display: block;">
    <path d="M0,0 C150,90 350,10 500,60 C650,110 850,20 1000,70 C1150,120 1250,30 1400,80 L1400,120 L0,120 Z" style="stroke: none; fill: #0056b3;"></path>
    </svg>
</div>

<%-- Thông tin chân --%>
<footer class="bg-white border-top py-5" style="font-size: 14px;">
    <div class="container">
        <div class="row g-4 justify-content-between">

            <div class="col-12 col-md-3">
                <a class="navbar-brand fw-bold d-flex align-items-center gap-2 mb-3" href="${pageContext.request.contextPath}/home" style="color: #0056b3 !important;">
                    <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="Mirai Logo" style="height: 35px;">
                    <span class="fs-4">Mirai <span class="text-secondary fw-normal fs-5">Store</span></span>
                </a>
                <div class="d-flex gap-2 mt-3">
                    <a href="#" class="btn btn-outline-secondary rounded-circle d-flex align-items-center justify-content-center p-0" style="width: 36px; height: 36px;"><i class="fa-brands fa-facebook-f text-dark"></i></a>
                    <a href="#" class="btn btn-outline-secondary rounded-circle d-flex align-items-center justify-content-center p-0" style="width: 36px; height: 36px;"><i class="fa-brands fa-youtube text-dark"></i></a>
                    <a href="#" class="btn btn-outline-secondary rounded-circle d-flex align-items-center justify-content-center p-0" style="width: 36px; height: 36px;"><i class="fa-brands fa-tiktok text-dark"></i></a>
                    <a href="#" class="btn btn-outline-secondary rounded-circle d-flex align-items-center justify-content-center p-0" style="width: 36px; height: 36px;"><i class="fa-solid fa-paper-plane text-dark"></i></a>
                </div>
            </div>

            <div class="col-12 col-md-4">
                <div class="mb-3">
                    <span class="fw-bold d-block text-secondary small text-uppercase mb-1">Hotline</span>
                    <a href="tel:0349401599" class="fs-5 fw-bold text-decoration-none" style="color: #0056b3;"><i class="fa-solid fa-phone me-2"></i>0349.401.599</a>
                </div>
                <div>
                    <span class="fw-bold d-block text-secondary small text-uppercase mb-1" data-vi="Cửa hàng Cần Thơ" data-en="Can Tho Store">Cửa hàng Cần Thơ</span>
                    <p class="text-dark fw-semibold mb-1">
                        <i class="fa-solid fa-location-dot me-2 text-secondary"></i>
                        <span data-vi="600, Nguyễn Văn Cừ" data-en="600, Nguyen Van Cu St">600, Nguyễn Văn Cừ</span>
                    </p>
                    <a href="#" class="small text-decoration-none" style="color: #0056b3;" data-vi="(Chỉ đường)" data-en="(Get directions)">(Chỉ đường)</a>
                </div>
            </div>

            <div class="col-12 col-sm-6 col-md-2">
                <h6 class="fw-bold text-dark mb-3" data-vi="Thông tin hữu ích" data-en="Useful Info">Thông tin hữu ích</h6>
                <ul class="list-unstyled d-flex flex-column gap-2 small">
                    <li><a href="#" class="text-muted text-decoration-none text-dark-hover" data-vi="Chính sách bảo hành" data-en="Warranty Policy">Chính sách bảo hành</a></li>
                    <li><a href="#" class="text-muted text-decoration-none text-dark-hover" data-vi="Chính sách đổi trả" data-en="Return Policy">Chính sách đổi trả</a></li>
                    <li><a href="#" class="text-muted text-decoration-none text-dark-hover" data-vi="Chính sách vận chuyển" data-en="Shipping Policy">Chính sách vận chuyển</a></li>
                    <li><a href="#" class="text-muted text-decoration-none text-dark-hover" data-vi="Chính sách bảo mật" data-en="Privacy Policy">Chính sách bảo mật</a></li>
                    <li><a href="#" class="text-muted text-decoration-none text-dark-hover" data-vi="Về chúng tôi" data-en="About Us">Về chúng tôi</a></li>
                </ul>
            </div>

            <%-- Feedback --%>
            <div class="col-12 col-sm-6 col-md-3">
                <h6 class="fw-bold text-dark mb-3" data-vi="Phản hồi, góp ý" data-en="Feedback">Phản hồi, góp ý</h6>
                <p class="text-muted small" data-vi="Đội ngũ Kiểm Soát Chất Lượng của chúng tôi sẵn sàng lắng nghe quý khách." data-en="Our Quality Control team is always ready to listen to you.">Đội ngũ Kiểm Soát Chất Lượng của chúng tôi sẵn sàng lắng nghe quý khách.</p>
                <button class="btn w-100 text-white py-2 fw-semibold d-flex align-items-center justify-content-center gap-2" style="background-color: #1a1a1a; border-radius: 20px;">
                    <i class="fa-regular fa-envelope"></i> 
                    <span data-vi="Gửi phản hồi" data-en="Send Feedback">Gửi phản hồi</span>
                </button>
            </div>
        </div>

        <div class="border-top mt-5 pt-4">
            <div class="row align-items-center justify-content-between g-3">
                <div class="col-12 col-md-8 text-muted small">
                    <p class="mb-1 fw-bold text-dark">&copy; Mirai 2026</p>
                    <p class="mb-0" data-vi="Công ty TNHH Công nghệ Tương lai Việt Nam - GPĐKKD: 0107273909 cấp ngày 09/03/2026" data-en="Vietnam Future Technology Co., Ltd - Business License: 0107273909 issued on 09/03/2026">Công ty TNHH Công nghệ Tương lai Việt Nam - GPĐKKD: 0107273909 cấp ngày 09/03/2026</p>
                    <p class="mb-0" data-vi="Địa chỉ: 600 Đường Nguyễn Văn Cừ, Phường An Khánh, Quận Ninh Kiều, TP. Cần Thơ." data-en="Address: 600 Nguyen Van Cu Street, An Khanh Ward, Ninh Kieu District, Can Tho City.">Địa chỉ: 600 Đường Nguyễn Văn Cừ, Phường An Khánh, Quận Ninh Kiều, TP. Cần Thơ.</p>
                </div>            
            </div>
        </div>
        <%-- Nút giỏ hàng nổi--%>
        <a href="${pageContext.request.contextPath}/cart" class="floating-cart shadow-lg d-flex align-items-center justify-content-center text-decoration-none">
            <div class="floating-cart-img-wrap">
                <img src="${pageContext.request.contextPath}/assets/images/cart-icon.png" alt="Cart" class="floating-cart-inner-img">
            </div>

            <%-- Số lượng sản phẩm (badge) --%>
            <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" id="floating-cart-badge">
                0
            </span>
        </a>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
    <%-- Hàm chuyển ngôn ngữ --%>
    function switchLanguage(lang) {
        let currentUrl = new URL(window.location.href);
        currentUrl.searchParams.set('lang', lang);
        window.location.href = currentUrl.toString();
    }

    document.addEventListener("DOMContentLoaded", function () {
    <%-- LẤY NGÔN NGỮ HIỆN TẠI TỪ URL --%>
        let urlParams = new URLSearchParams(window.location.search);
        let lang = urlParams.get('lang') || 'vi'; // Mặc định là 'vi' nếu không có tham số

    <%--TỰ ĐỘNG ĐỔI TEXT TOÀN TRANG DỰA VÀO DATA ATTRIBUTE --%>
        if (lang === 'en') {
            // Tìm tất cả các thẻ có chứa data-en và đổi nội dung thành tiếng Anh
            document.querySelectorAll('[data-en]').forEach(el => {
                if (el.tagName === 'INPUT' || el.tagName === 'TEXTAREA') {
                    el.placeholder = el.getAttribute('data-en');
                } else {
                    el.innerText = el.getAttribute('data-en');
                }
            });
        } else {
            // Tìm tất cả các thẻ có chứa data-vi và đổi nội dung thành tiếng Việt
            document.querySelectorAll('[data-vi]').forEach(el => {
                if (el.tagName === 'INPUT' || el.tagName === 'TEXTAREA') {
                    el.placeholder = el.getAttribute('data-vi');
                } else {
                    el.innerText = el.getAttribute('data-vi');
                }
            });
        }

    <%--Tự động làm sáng nút dựa trên URL --%>
        let btnEn = document.getElementById('btn-en');
        let btnVi = document.getElementById('btn-vi');
        if (btnEn && btnVi) {
            if (lang === 'en') {
                btnEn.classList.remove('text-muted');
                btnVi.classList.add('text-muted');
            } else {
                btnVi.classList.remove('text-muted');
                btnEn.classList.add('text-muted');
            }
        }

    <%-- 4. Xử lý thanh điều khiển ô tìm kiếm--%>
        const searchInput = document.getElementById('search-input');
        if (searchInput && typeof bootstrap !== 'undefined') {
            const dropdownToggle = new bootstrap.Dropdown(searchInput);

            searchInput.addEventListener('focus', () => {
                dropdownToggle.show();
            });

            const btnCloseSearch = document.getElementById('btn-close-search');
            if (btnCloseSearch) {
                btnCloseSearch.addEventListener('click', (e) => {
                    e.preventDefault();
                    e.stopPropagation();
                    dropdownToggle.hide();
                    searchInput.blur();
                });
            }
        }
    });
</script>
</body>
</html>