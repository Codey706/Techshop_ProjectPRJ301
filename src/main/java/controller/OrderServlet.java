package controller;

import dao.CartDAO;
import dao.OrderDAO;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Auth;
import model.CartItem;
import model.Orders;

@WebServlet(name = "OrderServlet", urlPatterns = {"/order"})
public class OrderServlet extends HttpServlet {

    OrderDAO orderDAO = new OrderDAO();
    CartDAO cartDAO = new CartDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        Auth user = (Auth) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/Auth?view=login");
            return;
        }

        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {

            case "create":
                showCreate(request, response, user);
                break;

            case "detail":
                showDetail(request, response);
                break;

            case "cancel":
                cancelOrder(request, response);
                break;

            default:
                showList(request, response, user);
                break;
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        Auth user = (Auth) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/Auth?view=login");
            return;
        }

        String action = request.getParameter("action");

        if ("create".equals(action)) {

            Orders order = new Orders();

            order.setUserId(user.getUserId());

            order.setReceiverName(request.getParameter("receiverName"));
            order.setPhone(request.getParameter("phone"));
            order.setShippingAddress(request.getParameter("address"));
            order.setNote(request.getParameter("note"));

            List<CartItem> cart = cartDAO.getCartItems(user.getUserId());

            BigDecimal subtotal = cartDAO.calculateSubtotal(cart);

            BigDecimal shipping = new BigDecimal("30000");

            BigDecimal discount = BigDecimal.ZERO;

            BigDecimal total = subtotal.add(shipping).subtract(discount);

            order.setSubtotal(subtotal);
            order.setShippingFee(shipping);
            order.setDiscountAmount(discount);
            order.setTotalAmount(total);

            int orderId = orderDAO.createOrder(order, cart);

            if (orderId > 0) {

                cartDAO.clearCart(user.getUserId());

                response.sendRedirect(request.getContextPath()
                        + "/payment?action=process&orderId=" + orderId);

            } else {

                response.sendRedirect(request.getContextPath()
                        + "/order?action=create");

            }

        }

    }

    // ==========================
    // Hiển thị danh sách đơn hàng
    // ==========================
    private void showList(HttpServletRequest request,
            HttpServletResponse response,
            Auth user)
            throws ServletException, IOException {

        List<Orders> list = orderDAO.getOrdersByUser(user.getUserId());

        request.setAttribute("orders", list);

        request.getRequestDispatcher("/WEB-INF/order/list.jsp")
                .forward(request, response);

    }

    // ==========================
    // Trang xác nhận đặt hàng
    // ==========================
    private void showCreate(HttpServletRequest request,
            HttpServletResponse response,
            Auth user)
            throws ServletException, IOException {

        List<CartItem> cart = cartDAO.getCartItems(user.getUserId());

        BigDecimal subtotal = cartDAO.calculateSubtotal(cart);

        request.setAttribute("cart", cart);
        request.setAttribute("subtotal", subtotal);

        request.getRequestDispatcher("/WEB-INF/order/create.jsp")
                .forward(request, response);

    }

    // ==========================
    // Chi tiết đơn hàng
    // ==========================
    private void showDetail(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        int orderId = Integer.parseInt(request.getParameter("id"));

        request.setAttribute("order",
                orderDAO.getOrderById(orderId));

        request.setAttribute("details",
                orderDAO.getOrderDetails(orderId));

        request.getRequestDispatcher("/WEB-INF/order/detail.jsp")
                .forward(request, response);

    }

    // ==========================
    // Hủy đơn
    // ==========================
    private void cancelOrder(HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        int orderId = Integer.parseInt(request.getParameter("id"));

        orderDAO.cancelOrder(orderId);

        response.sendRedirect(request.getContextPath()
                + "/order");

    }

}