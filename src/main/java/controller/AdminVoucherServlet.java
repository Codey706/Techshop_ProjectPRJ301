/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.AdminVoucherDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import model.Vouchers;

/**
 *
 * @author PC
 */
@WebServlet(name = "AdminVoucherServlet", urlPatterns = {"/admin/voucher"})
public class AdminVoucherServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String view = request.getParameter("view");

        if (view == null || view.equals("list")) {
            AdminVoucherDAO dao = new AdminVoucherDAO();

            dao.updateVoucherStatus();

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

            List<Vouchers> vouchers = dao.getVouchersByPage(page);

            int totalPages = dao.getTotalPages();

            List<Integer> newVoucherIds = new ArrayList<>();

            Timestamp now = new Timestamp(System.currentTimeMillis());

            for (Vouchers v : vouchers) {

                if (v.getCreatedDate() != null) {

                    long diff = now.getTime() - v.getCreatedDate().getTime();

                    long days = diff / (1000 * 60 * 60 * 24);

                    if (days >= 0 && days <= 7) {
                        newVoucherIds.add(v.getVoucherId());
                    }
                }
            }

            request.setAttribute("vouchers", vouchers);

            request.setAttribute("newVoucherIds", newVoucherIds);

            request.setAttribute("currentPage", page);

            request.setAttribute("totalPages", totalPages);

            request.getRequestDispatcher("/WEB-INF/admin/voucher/list.jsp").forward(request, response);
        } else if (view.equals("create")) {
            request.getRequestDispatcher("/WEB-INF/admin/voucher/create.jsp").forward(request, response);
        } else if (view.equals("edit")) {

            int id = Integer.parseInt(request.getParameter("id"));

            AdminVoucherDAO dao = new AdminVoucherDAO();

            Vouchers voucher = dao.getVoucherById(id);

            request.setAttribute("voucher", voucher);

            request.getRequestDispatcher("/WEB-INF/admin/voucher/update.jsp").forward(request, response);
        } else if (view.equals("delete")) {

            int id = Integer.parseInt(request.getParameter("id"));

            AdminVoucherDAO dao = new AdminVoucherDAO();

            Vouchers voucher = dao.getVoucherById(id);

            request.setAttribute("voucher", voucher);

            request.getRequestDispatcher("/WEB-INF/admin/voucher/delete.jsp").forward(request, response);
        } else {

        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("create".equals(action)) {

            String code = request.getParameter("code");

            BigDecimal discountPercent = new BigDecimal(
                    request.getParameter("discountPercent"));

            BigDecimal minimumOrder = new BigDecimal(
                    request.getParameter("minimumOrder"));

            Timestamp startDate = Timestamp.valueOf(
                    request.getParameter("startDate") + " 00:00:00");

            Timestamp expireDate = Timestamp.valueOf(
                    request.getParameter("expireDate") + " 23:59:59");

            int quantity = Integer.parseInt(
                    request.getParameter("quantity"));

            int status = Integer.parseInt(
                    request.getParameter("status"));

            Vouchers voucher = new Vouchers();

            voucher.setCode(code);
            voucher.setDiscountPercent(discountPercent);
            voucher.setMinimumOrder(minimumOrder);
            voucher.setStartDate(startDate);
            voucher.setExpireDate(expireDate);
            voucher.setQuantity(quantity);

            // Voucher mới tạo chưa được sử dụng
            voucher.setUsedQuantity(0);

            voucher.setStatus(status);

            AdminVoucherDAO dao = new AdminVoucherDAO();

            int result = dao.insertVoucher(voucher);

            if (result > 0) {
                
                 request.getSession().setAttribute("success", "Create voucher successfully!");

                response.sendRedirect(request.getContextPath() + "/admin/voucher");

            } else {

                request.setAttribute("error", "Create voucher failed!");

                request.getRequestDispatcher("/WEB-INF/admin/voucher/create.jsp")
                        .forward(request, response);
            }
        } else if ("edit".equals(action)) {

            int voucherId = Integer.parseInt(request.getParameter("voucherId"));

            String code = request.getParameter("code");

            BigDecimal discountPercent
                    = new BigDecimal(request.getParameter("discountPercent"));

            BigDecimal minimumOrder
                    = new BigDecimal(request.getParameter("minimumOrder"));

            Timestamp startDate
                    = Timestamp.valueOf(request.getParameter("startDate") + " 00:00:00");

            Timestamp expireDate
                    = Timestamp.valueOf(request.getParameter("expireDate") + " 23:59:59");

            int quantity
                    = Integer.parseInt(request.getParameter("quantity"));

            int status
                    = Integer.parseInt(request.getParameter("status"));

            Vouchers voucher = new Vouchers();

            voucher.setVoucherId(voucherId);
            voucher.setCode(code);
            voucher.setDiscountPercent(discountPercent);
            voucher.setMinimumOrder(minimumOrder);
            voucher.setStartDate(startDate);
            voucher.setExpireDate(expireDate);
            voucher.setQuantity(quantity);
            voucher.setStatus(status);

            AdminVoucherDAO dao = new AdminVoucherDAO();

            int result = dao.updateVoucher(voucher);

            if (result > 0) {
                
                 request.getSession().setAttribute("success", "Update voucher successfully!");

                response.sendRedirect(request.getContextPath() + "/admin/voucher");

            } else {

                request.setAttribute("voucher", voucher);
                request.setAttribute("error", "Update voucher failed!");

                request.getRequestDispatcher("/WEB-INF/admin/voucher/update.jsp")
                        .forward(request, response);

            }

        } else if ("delete".equals(action)) {

            int voucherId = Integer.parseInt(request.getParameter("voucherId"));

            AdminVoucherDAO dao = new AdminVoucherDAO();

            int result = dao.deleteVoucher(voucherId);

            if (result > 0) {

                request.getSession().setAttribute("success", "Delete voucher successfully!");
                
                response.sendRedirect(request.getContextPath() + "/admin/voucher");

            } else {

                Vouchers voucher = dao.getVoucherById(voucherId);

                request.setAttribute("voucher", voucher);
                request.setAttribute("error", "Delete voucher failed!");

                request.getRequestDispatcher("/WEB-INF/admin/voucher/delete.jsp")
                        .forward(request, response);

            }

        }

    }

}
