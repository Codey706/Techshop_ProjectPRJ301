/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

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
