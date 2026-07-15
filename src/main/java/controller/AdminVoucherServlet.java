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
            request.getRequestDispatcher("/WEB-INF/admin/voucher/update.jsp").forward(request, response);
        } else if (view.equals("delete")) {
            request.getRequestDispatcher("/WEB-INF/admin/voucher/delete.jsp").forward(request, response);
        } else {

        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

}
