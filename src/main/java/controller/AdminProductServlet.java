/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author PC
 */
@WebServlet(name = "AdminProductServlet", urlPatterns = {"/admin/product"})
public class AdminProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String view = request.getParameter("view");

        if (view == null || view.equals("list")) {
            request.getRequestDispatcher("/WEB-INF/admin/product/list.jsp").forward(request, response);
        } else if (view.equals("create")) {
            request.getRequestDispatcher("/WEB-INF/admin/product/create.jsp").forward(request, response);
        } else if (view.equals("edit")) {
            request.getRequestDispatcher("/WEB-INF/admin/product/update.jsp").forward(request, response);
        } else if (view.equals("delete")) {
            request.getRequestDispatcher("/WEB-INF/admin/product/delete.jsp").forward(request, response);
        } else {

        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }
}
