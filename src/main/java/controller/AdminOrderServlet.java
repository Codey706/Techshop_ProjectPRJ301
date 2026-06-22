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
@WebServlet(name = "AdminOrderServlet", urlPatterns = {"/admin/order"})
public class AdminOrderServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String view = request.getParameter("view");

        if (view == null || view.equals("list")) {
            request.getRequestDispatcher("/WEB-INF/admin/order/list.jsp").forward(request, response);
        } else if (view.equals("detail")) {
            request.getRequestDispatcher("/WEB-INF/admin/order/detail.jsp").forward(request, response);
        } else if (view.equals("update-status")) {
            request.getRequestDispatcher("/WEB-INF/admin/order/update-status.jsp").forward(request, response);
        } else {

        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

}
