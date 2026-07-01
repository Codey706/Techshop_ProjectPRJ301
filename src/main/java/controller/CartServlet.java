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
        List<CartItem> cartItems = cartDAO.getCartItems(userId);
        BigDecimal subtotal = cartDAO.calculateSubtotal(cartItems);

        Vouchers appliedVoucher = (Vouchers) session.getAttribute("appliedVoucher");
        BigDecimal discountAmount = (BigDecimal) session.getAttribute("discountAmount");
        if (discountAmount == null) discountAmount = BigDecimal.ZERO;

        BigDecimal total = subtotal.subtract(discountAmount);
        if (total.compareTo(BigDecimal.ZERO) < 0) total = BigDecimal.ZERO;

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

        // Nếu không có action nhưng có productId => coi là "add"
        if (action == null || action.trim().isEmpty()) {
            if (request.getParameter("productId") != null) {
                action = "add";
            } else {
                response.sendRedirect(request.getContextPath() + "/cart");
                return;
            }
        }

        try {
            if ("add".equals(action)) {
                int variantId;
                String variantIdParam = request.getParameter("variantId");
                if (variantIdParam != null && !variantIdParam.trim().isEmpty()) {
                    variantId = Integer.parseInt(variantIdParam);
                } else {
                    // Form chỉ gửi productId => tự tra variantId mặc định
                    int productId = Integer.parseInt(request.getParameter("productId"));
                    variantId = cartDAO.getDefaultVariantIdByProductId(productId);
                }

                if (variantId <= 0) {
                    response.sendRedirect(request.getContextPath() + "/cart");
                    return;
                }

                String qtyParam = request.getParameter("quantity");
                int quantity = (qtyParam != null && !qtyParam.trim().isEmpty())
                        ? Integer.parseInt(qtyParam) : 1;
                if (quantity < 1) quantity = 1;

                cartDAO.addToCart(userId, variantId, quantity);
                session.setAttribute("cartCount", cartDAO.countCartItems(userId));

            } else if ("increase".equals(action)) {
                int variantId = Integer.parseInt(request.getParameter("variantId"));
                cartDAO.addToCart(userId, variantId, 1);
                session.setAttribute("cartCount", cartDAO.countCartItems(userId));

            } else if ("decrease".equals(action)) {
                int variantId = Integer.parseInt(request.getParameter("variantId"));
                List<CartItem> items = cartDAO.getCartItems(userId);
                for (CartItem ci : items) {
                    if (ci.getVariantId() == variantId) {
                        int newQty = ci.getQuantity() - 1;
                        if (newQty <= 0) {
                            cartDAO.removeItem(ci.getCartItemId(), userId);
                        } else {
                            cartDAO.updateQuantity(ci.getCartItemId(), newQty, userId);
                        }
                        break;
                    }
                }
                session.removeAttribute("appliedVoucher");
                session.removeAttribute("discountAmount");
                session.setAttribute("cartCount", cartDAO.countCartItems(userId));

            } else if ("update".equals(action)) {
                int cartItemId = Integer.parseInt(request.getParameter("cartItemId"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                if (quantity < 1) {
                    cartDAO.removeItem(cartItemId, userId);
                } else {
                    cartDAO.updateQuantity(cartItemId, quantity, userId);
                }
                session.removeAttribute("appliedVoucher");
                session.removeAttribute("discountAmount");
                session.setAttribute("cartCount", cartDAO.countCartItems(userId));

            } else if ("remove".equals(action)) {
                int cartItemId = Integer.parseInt(request.getParameter("cartItemId"));
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
