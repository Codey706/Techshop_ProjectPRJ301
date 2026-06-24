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

@WebServlet(name = "CartServlet", urlPatterns = {"/cart"})
public class CartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
Integer userId = 1; // test tạm
session.setAttribute("userId", userId);

        CartDAO cartDAO = new CartDAO();

        // lấy danh sách cart item đúng theo CartDAO
        List<CartItem> cartItems = cartDAO.getCartItems(userId);

        // tính subtotal đúng theo CartDAO
        BigDecimal subtotal = cartDAO.calculateSubtotal(cartItems);

        // voucher đang áp dụng
        Vouchers appliedVoucher = (Vouchers) session.getAttribute("appliedVoucher");
        BigDecimal discountAmount = (BigDecimal) session.getAttribute("discountAmount");
        if (discountAmount == null) {
            discountAmount = BigDecimal.ZERO;
        }

        BigDecimal total = subtotal.subtract(discountAmount);
        if (total.compareTo(BigDecimal.ZERO) < 0) {
            total = BigDecimal.ZERO;
        }

        session.setAttribute("cartCount", cartDAO.countCartItems(userId));

        request.setAttribute("cartItems", cartItems);
        request.setAttribute("subtotal", subtotal);
        request.setAttribute("discountAmount", discountAmount);
        request.setAttribute("total", total);
        request.setAttribute("appliedVoucher", appliedVoucher);

        request.getRequestDispatcher("/WEB-INF/Cart/Cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
Integer userId = 1; // test tạm
session.setAttribute("userId", userId);

        CartDAO cartDAO = new CartDAO();
        String action = request.getParameter("action");

        if (action == null || action.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        try {
            if ("add".equals(action)) {
                int variantId = Integer.parseInt(request.getParameter("variantId"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));

                if (quantity < 1) {
                    quantity = 1;
                }

                // đúng tên hàm trong CartDAO
                cartDAO.addToCart(userId, variantId, quantity);
                session.setAttribute("cartCount", cartDAO.countCartItems(userId));
            }

            else if ("update".equals(action)) {
                int cartItemId = Integer.parseInt(request.getParameter("cartItemId"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));

                if (quantity < 1) {
                    // đúng tên hàm trong CartDAO
                    cartDAO.removeItem(cartItemId, userId);
                } else {
                    // đúng tên hàm trong CartDAO
                    cartDAO.updateQuantity(cartItemId, quantity, userId);
                }

                session.removeAttribute("appliedVoucher");
                session.removeAttribute("discountAmount");
                session.setAttribute("cartCount", cartDAO.countCartItems(userId));
            }

            else if ("remove".equals(action)) {
                int cartItemId = Integer.parseInt(request.getParameter("cartItemId"));

                // đúng tên hàm trong CartDAO
                cartDAO.removeItem(cartItemId, userId);

                session.removeAttribute("appliedVoucher");
                session.removeAttribute("discountAmount");
                session.setAttribute("cartCount", cartDAO.countCartItems(userId));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/cart");
    }
}