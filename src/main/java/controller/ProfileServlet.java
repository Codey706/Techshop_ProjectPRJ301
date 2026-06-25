/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.AdminProfileDAO;
import db.DBContext;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.User;

@WebServlet(name = "ProfileServlet", urlPatterns = {"/profile"})
public class ProfileServlet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        User user
                = (User) session.getAttribute("user");

        if (user == null) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/Auth?view=login"
            );

            return;
        }
        AdminProfileDAO dao
                = new AdminProfileDAO();

        User profile
                = dao.getProfile(
                        user.getUserId()
                );

        request.setAttribute(
                "profile",
                profile
        );

        request.getRequestDispatcher(
                "/profile/Profile.jsp"
        )
                .forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name
                = request.getParameter("name");

        String email
                = request.getParameter("email");

        String phone
                = request.getParameter("phone");

        String gender
                = request.getParameter("gender");

        User user
                = (User) request.getSession()
                        .getAttribute("user");

        user.setFullName(name);
        user.setEmail(email);
        user.setPhone(phone);
        user.setGender(gender);

        AdminProfileDAO dao
                = new AdminProfileDAO();

        dao.updateProfile(user);

        response.sendRedirect("profile");
    }

    private void updateProfile(
            HttpServletRequest request,
            HttpServletResponse response
    ) {

        String name
                = request.getParameter("name");

        String phone
                = request.getParameter("phone");

        // gọi DAO update database
    }

    private void changePassword(
            HttpServletRequest request,
            HttpServletResponse response
    ) {

        String oldPass
                = request.getParameter("oldPassword");

        String newPass
                = request.getParameter("newPassword");

        // kiểm tra mật khẩu cũ
        // update password
    }
}
