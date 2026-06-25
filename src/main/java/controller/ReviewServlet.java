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
@WebServlet(name = "ReviewServlet", urlPatterns = {"/review"})
public class ReviewServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action
                = request.getServletPath();

        switch (action) {

            case "/review/add":

                addReview(request, response);

                break;

            case "/review/edit":

                editReview(request, response);

                break;

            case "/review/delete":

                deleteReview(request, response);

                break;

        }

    }

    private void addReview(
            HttpServletRequest request,
            HttpServletResponse response) {

        int productId = Integer.parseInt(request.getParameter("productId")
        );

        String content = request.getParameter("content");

        int rating = Integer.parseInt(request.getParameter("rating")
        );

// gọi ReviewDAO.insert()
    }

    private void editReview(
            HttpServletRequest request,
            HttpServletResponse response) {

        int reviewId = Integer.parseInt(request.getParameter("reviewId")
        );

        String content = request.getParameter("content");

// update review
    }

    private void deleteReview(
            HttpServletRequest request,
            HttpServletResponse response) {

        int reviewId = Integer.parseInt(request.getParameter("reviewId")
        );

// delete review
    }

}
