/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CartDAO;
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
import model.Vouchers;


/**
 *
 * @author PC
 */
@WebServlet(name = "CartServlet", urlPatterns = {"/cart"})
public class CartServlet extends HttpServlet {

   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        // Lấy danh sách sản phẩm trong giỏ
        List<CartItem> cartItems = CartDAO.getCartItems(userId);

        // Tính subtotal
        BigDecimal subtotal = CartDAO.calculateSubtotal(cartItems);

        // Lấy voucher đang áp dụng từ session
        Vouchers appliedVoucher = (Vouchers) session.getAttribute("appliedVoucher");
        BigDecimal discountAmount = (BigDecimal) session.getAttribute("discountAmount");
        if (discountAmount == null) discountAmount = BigDecimal.ZERO;

        // Tổng sau giảm
        BigDecimal total = subtotal.subtract(discountAmount);
        if (total.compareTo(BigDecimal.ZERO) < 0) total = BigDecimal.ZERO;

        // Cập nhật badge số lượng trong session
        session.setAttribute("cartCount", CartDAO.countCartItems(userId));

        // Đẩy dữ liệu ra request
        request.setAttribute("cartItems",      cartItems);
        request.setAttribute("subtotal",       subtotal);
        request.setAttribute("appliedVoucher", appliedVoucher);
        request.setAttribute("discountAmount", discountAmount);
        request.setAttribute("total",          total);

        request.getRequestDispatcher("/WEB-INF/cart/cart.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
      HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        String path = request.getServletPath();
        switch (path) {
            case "/cart/add":
                handleAdd(request, response, session, userId);
                break;
            case "/cart/update":
                handleUpdate(request, response, session, userId);
                break;
            case "/cart/remove":
                handleRemove(request, response, session, userId);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/cart");
        }
    }

    // =========================================================================
    // POST /cart/add - Thêm sản phẩm vào giỏ
    // =========================================================================
    private void handleAdd(HttpServletRequest request, HttpServletResponse response,
                           HttpSession session, int userId) throws IOException {
        String variantIdStr = request.getParameter("variantId");
        String quantityStr  = request.getParameter("quantity");

        if (variantIdStr == null || variantIdStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        try {
            int variantId = Integer.parseInt(variantIdStr.trim());
            int quantity  = 1;
            if (quantityStr != null && !quantityStr.trim().isEmpty()) {
                quantity = Math.max(1, Integer.parseInt(quantityStr.trim()));
            }

            CartDAO.addToCart(userId, variantId, quantity);

            // Cập nhật badge giỏ hàng trong session
            session.setAttribute("cartCount", CartDAO.countCartItems(userId));

        } catch (NumberFormatException e) {
            // tham số không hợp lệ -> bỏ qua
        }

        // Quay về trang trước hoặc về giỏ hàng
        String referer = request.getHeader("Referer");
        if (referer != null && !referer.isEmpty()) {
            response.sendRedirect(referer);
        } else {
            response.sendRedirect(request.getContextPath() + "/cart");
        }
    }

    // =========================================================================
    // POST /cart/update - Cập nhật số lượng
    // =========================================================================
    private void handleUpdate(HttpServletRequest request, HttpServletResponse response,
                              HttpSession session, int userId) throws IOException {
        try {
            int cartItemId = Integer.parseInt(request.getParameter("cartItemId"));
            int quantity   = Integer.parseInt(request.getParameter("quantity"));

            if (quantity < 1) {
                // Số lượng = 0 -> xóa luôn
                CartDAO.removeItem(cartItemId, userId);
            } else {
                CartDAO.updateQuantity(cartItemId, quantity, userId);
            }

            // Khi giỏ thay đổi, xóa voucher session để tránh tính sai
            clearVoucherSession(session);
            session.setAttribute("cartCount", CartDAO.countCartItems(userId));

        } catch (NumberFormatException e) {
            // bỏ qua
        }

        response.sendRedirect(request.getContextPath() + "/cart");
    }

    // =========================================================================
    // POST /cart/remove - Xóa sản phẩm
    // =========================================================================
    private void handleRemove(HttpServletRequest request, HttpServletResponse response,
                              HttpSession session, int userId) throws IOException {
        try {
            int cartItemId = Integer.parseInt(request.getParameter("cartItemId"));
            CartDAO.removeItem(cartItemId, userId);

            // Khi giỏ thay đổi, xóa voucher session
            clearVoucherSession(session);
            session.setAttribute("cartCount", CartDAO.countCartItems(userId));

        } catch (NumberFormatException e) {
            // bỏ qua
        }

        response.sendRedirect(request.getContextPath() + "/cart");
    }

    // =========================================================================
    // Helper: Xóa voucher khỏi session khi giỏ hàng thay đổi
    // =========================================================================
    private void clearVoucherSession(HttpSession session) {
        session.removeAttribute("appliedVoucher");
        session.removeAttribute("discountAmount");
    }
}
