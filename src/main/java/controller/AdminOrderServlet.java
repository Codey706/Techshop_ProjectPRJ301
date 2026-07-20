/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.AdminOrderDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Orders;

/**
 *
 * @author PC
 */
@WebServlet(name = "AdminOrderServlet", urlPatterns = {"/admin/order"})
public class AdminOrderServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String view = request.getParameter("view");

        if (view == null || view.equals("list")) {

            AdminOrderDAO dao = new AdminOrderDAO();

            // Status
            String status = request.getParameter("status");
            Integer st = null;

            if (status != null && !status.isBlank()) {
                st = Integer.parseInt(status);
            }

            // Keyword
            String keyword = request.getParameter("keyword");

            if (keyword != null) {
                keyword = keyword.trim();
            }

            if (keyword != null && keyword.isEmpty()) {

                if (st == null) {
                    response.sendRedirect(request.getContextPath() + "/admin/order");
                } else {
                    response.sendRedirect(request.getContextPath()
                            + "/admin/order?status=" + st);
                }

                return;
            }

            // Page
            String pageParam = request.getParameter("page");

            int page = 1;

            if (pageParam != null && !pageParam.isEmpty()) {

                try {

                    page = Integer.parseInt(pageParam);

                    if (page <= 0) {
                        page = 1;
                    }

                } catch (NumberFormatException e) {
                    page = 1;
                }
            }

            // Lấy dữ liệu
            List<Orders> orders = dao.getOrdersByPage(page, st, keyword);

            request.setAttribute("orders", orders);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", dao.getTotalPages(st, keyword));

            request.getRequestDispatcher("/WEB-INF/admin/order/list.jsp")
                    .forward(request, response);

        } else if (view.equals("detail")) {

            int id = Integer.parseInt(request.getParameter("id"));

            AdminOrderDAO dao = new AdminOrderDAO();

            Orders order = dao.getOrderById(id);

            request.setAttribute("order", order);

            request.getRequestDispatcher("/WEB-INF/admin/order/detail.jsp")
                    .forward(request, response);

        } else if (view.equals("update-status")) {

            int id = Integer.parseInt(request.getParameter("id"));

            AdminOrderDAO dao = new AdminOrderDAO();

            Orders order = dao.getOrderById(id);

            request.setAttribute("order", order);

            request.getRequestDispatcher("/WEB-INF/admin/order/update-status.jsp")
                    .forward(request, response);

        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("create".equals(action)) {

        } else if ("updateStatus".equals(action)) {

            int orderId = Integer.parseInt(request.getParameter("orderId"));

            int status = Integer.parseInt(request.getParameter("status"));

            AdminOrderDAO dao = new AdminOrderDAO();

            int result = dao.updateStatus(orderId, status);

            if (result > 0) {

                request.getSession().setAttribute("success", "Update order status successfully!");

                response.sendRedirect(request.getContextPath()
                        + "/admin/order?view=detail&id=" + orderId);

            } else {

                Orders order = dao.getOrderById(orderId);

                request.setAttribute("order", order);

                request.setAttribute("error", "Update order status failed!");

                request.getRequestDispatcher("/WEB-INF/admin/order/update-status.jsp")
                        .forward(request, response);
            }
        }
    }

}
