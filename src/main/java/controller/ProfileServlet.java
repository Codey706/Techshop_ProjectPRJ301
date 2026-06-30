/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.AdminProfileDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Auth;
import model.User;

@WebServlet(name = "ProfileServlet", urlPatterns = {
    "/profile",
    "/profile/update",
    "/profile/change-password"
})
public class ProfileServlet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null) {
            response.sendRedirect(
                    request.getContextPath() + "/Auth?view=login"
            );
            return;
        }

        Auth auth = (Auth) session.getAttribute("user");

        if (auth == null) {

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
                        auth.getUserId()
                );

        request.setAttribute(
                "profile",
                profile
        );

        request.getRequestDispatcher(
                "/WEB-INF/profile/profile.jsp"
        )
                .forward(request, response);
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String path
                = request.getServletPath();

        if (path.equals("/profile/update")) {

            updateProfile(
                    request,
                    response
            );

        } else if (path.equals("/profile/change-password")) {

            changePassword(
                    request,
                    response
            );

        }

    }

    private void updateProfile(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        HttpSession session
                = request.getSession();

        Auth auth = (Auth) session.getAttribute("user");

        if (auth == null) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/Auth?view=login"
            );

            return;
        }

        String name
                = request.getParameter("name");

        String email
                = request.getParameter("email");

        String phone
                = request.getParameter("phone");

        String gender
                = request.getParameter("gender");

        User user = new User();

        user.setUserId(
                auth.getUserId()
        );

        user.setFullName(name);

        user.setEmail(email);

        user.setPhone(phone);

        user.setGender(gender);

        AdminProfileDAO dao
                = new AdminProfileDAO();

        dao.updateProfile(user);

// cập nhật lại thông tin trong session
        auth.setFullName(name);
        auth.setEmail(email);

        session.setAttribute(
                "user",
                auth
        );

        response.sendRedirect(
                request.getContextPath() + "/profile"
        );

    }

    private void changePassword(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        HttpSession session
                = request.getSession();

        Auth auth = (Auth) session.getAttribute("user");

        if (auth == null) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/Auth?view=login"
            );

            return;

        }

        String oldPass
                = request.getParameter("oldPassword");

        String newPass
                = request.getParameter("newPassword");

        AdminProfileDAO dao
                = new AdminProfileDAO();

        boolean check
                = dao.checkOldPassword(
                        auth.getUserId(),
                        oldPass
                );

        if (check) {
            session.setAttribute(
                    "message",
                    "Change password successfully"
            );

            dao.changePassword(
                    auth.getUserId(),
                    newPass
            );

            response.sendRedirect(
                    request.getContextPath() + "/profile"
            );
        } else {

            session.setAttribute(
                    "error",
                    "Old password incorrect"
            );

            response.sendRedirect(
                    request.getContextPath() + "/profile"
            );

        }

    }

}
