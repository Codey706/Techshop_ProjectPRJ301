package controller;

import dao.OrderDAO;
import dao.PaymentDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Orders;
import model.Payment;

@WebServlet(name = "PaymentServlet", urlPatterns = {"/payment"})
public class PaymentServlet extends HttpServlet {

    PaymentDAO paymentDAO = new PaymentDAO();
    OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {

            case "process":
                processPayment(request, response);
                break;

            case "result":
                showResult(request, response);
                break;

            default:
                showList(request, response);
                break;
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("process".equals(action)) {

            int orderId = Integer.parseInt(request.getParameter("orderId"));

            String method = request.getParameter("paymentMethod");

            Orders order = orderDAO.getOrderById(orderId);

            Payment payment = new Payment();

            payment.setOrderId(orderId);
            payment.setPaymentMethod(method);
            payment.setAmount(order.getTotalAmount());
            payment.setCurrency("VND");

            // 0 = Pending
            payment.setStatus(0);

            paymentDAO.insertPayment(payment);

            // Nếu COD thì coi như thành công luôn
            if ("COD".equalsIgnoreCase(method)) {

                paymentDAO.updatePaymentStatus(orderId, 1);

                orderDAO.updatePaymentStatus(orderId, 1); 

            }

            response.sendRedirect(request.getContextPath()
                    + "/payment?action=result&orderId=" + orderId);

        }

    }

    // ==========================
    // Danh sách thanh toán
    // ==========================
    private void showList(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("payments",
                paymentDAO.getAllPayments());

        request.getRequestDispatcher("/WEB-INF/payment/list.jsp")
                .forward(request, response);

    }

    // ==========================
    // Trang chọn phương thức thanh toán
    // ==========================
    private void processPayment(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        int orderId = Integer.parseInt(request.getParameter("orderId"));

        Orders order = orderDAO.getOrderById(orderId);

        request.setAttribute("order", order);

        request.getRequestDispatcher("/WEB-INF/payment/process.jsp")
                .forward(request, response);

    }

    // ==========================
    // Kết quả thanh toán
    // ==========================
    private void showResult(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        int orderId = Integer.parseInt(request.getParameter("orderId"));

        request.setAttribute("order",
                orderDAO.getOrderById(orderId));

        request.setAttribute("payment",
                paymentDAO.getPaymentByOrderId(orderId));

        request.getRequestDispatcher("/WEB-INF/payment/result.jsp")
                .forward(request, response);

    }

}
