package controller;

import dao.CartDAO;
import dao.VoucherDAO;
import dao.VoucherDAO.VoucherValidationResult;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import model.Auth;
import model.CartItem;
import model.Vouchers;

@WebServlet(name = "VoucherServlet", urlPatterns = {"/voucher", "/voucher/*"})
public class VoucherServlet extends HttpServlet {

    /**
     * Lấy userId của người dùng đang đăng nhập từ session.
     * Trả về null nếu chưa đăng nhập.
     */
    private Integer getLoggedInUserId(HttpServletRequest request) {
        HttpSession session = request.getSession();
        Auth user = (Auth) session.getAttribute("user");
        if (user == null) {
            return null;
        }
        return user.getUserId();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        Integer userId = getLoggedInUserId(request);
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/Auth?view=login");
            return;
        }

        CartDAO cartDAO = new CartDAO();
        VoucherDAO voucherDAO = new VoucherDAO();

        List<CartItem> cartItems = cartDAO.getCartItems(userId);
        BigDecimal subtotal = cartDAO.calculateSubtotal(cartItems);

        List<Vouchers> vouchers = voucherDAO.getAvailableVouchers();
        Vouchers appliedVoucher = (Vouchers) session.getAttribute("appliedVoucher");

        request.setAttribute("vouchers", vouchers);
        request.setAttribute("subtotal", subtotal);
        request.setAttribute("appliedVoucher", appliedVoucher);

        request.getRequestDispatcher("/WEB-INF/Voucher/Voucher.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        Integer userId = getLoggedInUserId(request);
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/Auth?view=login");
            return;
        }

        // Voucher.jsp gửi request tới /voucher/apply hoặc /voucher/remove
        String pathInfo = request.getPathInfo(); // "/apply", "/remove" hoặc null
        String action = request.getParameter("action");
        if (action == null || action.trim().isEmpty()) {
            if (pathInfo != null && pathInfo.contains("apply")) {
                action = "apply";
            } else if (pathInfo != null && pathInfo.contains("remove")) {
                action = "remove";
            }
        }

        if (action == null || action.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        try {
            if ("apply".equals(action)) {
                // Voucher.jsp gửi tham số tên "voucherCode"
                String code = request.getParameter("voucherCode");
                if (code == null || code.trim().isEmpty()) {
                    code = request.getParameter("code");
                }

                if (code == null || code.trim().isEmpty()) {
                    session.setAttribute("voucherError", "Vui lòng nhập mã giảm giá.");
                    session.removeAttribute("voucherSuccess");
                    response.sendRedirect(request.getContextPath() + "/voucher");
                    return;
                }

                CartDAO cartDAO = new CartDAO();
                VoucherDAO voucherDAO = new VoucherDAO();

                List<CartItem> cartItems = cartDAO.getCartItems(userId);
                BigDecimal subtotal = cartDAO.calculateSubtotal(cartItems);

                VoucherValidationResult result = voucherDAO.validateVoucher(code.trim(), subtotal, userId);

                if (!result.valid) {
                    session.removeAttribute("appliedVoucher");
                    session.removeAttribute("discountAmount");
                    session.setAttribute("voucherError", result.errorMessage);
                    session.removeAttribute("voucherSuccess");
                } else {
                    session.setAttribute("appliedVoucher", result.voucher);
                    session.setAttribute("discountAmount", result.discountAmount);
                    session.setAttribute("voucherSuccess", "Áp dụng voucher thành công.");
                    session.removeAttribute("voucherError");
                }
            } else if ("remove".equals(action)) {
                session.removeAttribute("appliedVoucher");
                session.removeAttribute("discountAmount");
                session.removeAttribute("voucherError");
                session.setAttribute("voucherSuccess", "Đã xóa voucher.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("voucherError", "Có lỗi xảy ra khi xử lý voucher.");
            session.removeAttribute("voucherSuccess");
        }

        response.sendRedirect(request.getContextPath() + "/cart");
    }
}
