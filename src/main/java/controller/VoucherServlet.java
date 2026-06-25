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
import model.CartItem;

@WebServlet(name = "VoucherServlet", urlPatterns = {"/voucher"})
public class VoucherServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/cart");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer userId = 1; // test tạm
        session.setAttribute("userId", userId);

        String action = request.getParameter("action");

        if (action == null || action.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        try {
            if ("apply".equals(action)) {
                String code = request.getParameter("code");

                if (code == null || code.trim().isEmpty()) {
                    session.setAttribute("voucherError", "Vui lòng nhập mã giảm giá.");
                    session.removeAttribute("voucherSuccess");
                    response.sendRedirect(request.getContextPath() + "/cart");
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
