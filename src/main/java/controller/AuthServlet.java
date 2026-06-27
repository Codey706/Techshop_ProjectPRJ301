package controller;

import dao.AuthDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Auth;

/**
 *
 * @author Huynh Nhu Y
 */
@WebServlet(name = "AuthServlet", urlPatterns = {"/Auth"})
public class AuthServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String view = request.getParameter("view");

        // ================= LOGIN =================
        if (view == null || view.equals("login")) {

            // Nếu đã có Session thì không cần đăng nhập nữa
            HttpSession session = request.getSession(false);

            if (session != null && session.getAttribute("user") != null) {

                Auth user = (Auth) session.getAttribute("user");

                if (user.getRoleId() == 1) {
                    response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                } else {
                    response.sendRedirect(request.getContextPath() + "/home");
                }
                return;
            }

            // Kiểm tra Cookie Remember Me
            Cookie[] cookies = request.getCookies();

            if (cookies != null) {

                AuthDAO dao = new AuthDAO();

                for (Cookie cookie : cookies) {

                    if ("rememberMe".equals(cookie.getName())) {

                        Auth user = dao.loginWithToken(cookie.getValue());

                        if (user != null) {

                            HttpSession newSession = request.getSession();
                            newSession.setAttribute("user", user);

                            if (user.getRoleId() == 1) {
                                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                            } else {
                                response.sendRedirect(request.getContextPath() + "/home");
                            }
                            return;
                        }
                    }
                }
            }

            request.getRequestDispatcher("/WEB-INF/Auth/login.jsp")
                    .forward(request, response);

        } // ================= REGISTER =================
        else if ("register".equals(view)) {

            request.getRequestDispatcher("/WEB-INF/Auth/register.jsp")
                    .forward(request, response);

        } // ================= LOGOUT =================
        else if ("logout".equals(view)) {

            HttpSession session = request.getSession(false);

            if (session != null) {

                Auth user = (Auth) session.getAttribute("user");

                if (user != null) {

                    AuthDAO dao = new AuthDAO();

                    // Xóa token trong Database
                    dao.updateRememberMeToken(user.getUserId(), null);
                }

                session.invalidate();
            }

            // Xóa Cookie Remember Me
            Cookie cookie = new Cookie("rememberMe", "");
            cookie.setMaxAge(0);
            cookie.setPath("/");
            response.addCookie(cookie);

            response.sendRedirect(request.getContextPath() + "/Auth?view=login");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        // ================= LOGIN =================
        if ("login".equals(action)) {

            String username = request.getParameter("username");
            String password = request.getParameter("password");
            boolean remember = request.getParameter("remember") != null;

            AuthDAO dao = new AuthDAO();

            Auth user = dao.login(username, password);

            if (user != null) {

                // Tạo Session
                HttpSession session = request.getSession();
                session.setAttribute("user", user);

                // Remember Me
                if (remember) {

                    String token = java.util.UUID.randomUUID().toString();

                    dao.updateRememberMeToken(user.getUserId(), token);

                    Cookie cookie = new Cookie("rememberMe", token);
                    cookie.setMaxAge(60 * 60 * 24 * 7); // 7 ngày
                    cookie.setPath("/");
                    response.addCookie(cookie);

                } else {

                    dao.updateRememberMeToken(user.getUserId(), null);

                    Cookie cookie = new Cookie("rememberMe", "");
                    cookie.setMaxAge(0);
                    cookie.setPath("/");
                    response.addCookie(cookie);
                }

                // Redirect theo Role
                if (user.getRoleId() == 1) {
                    response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                } else {
                    response.sendRedirect(request.getContextPath() + "/home");
                }

            } else {

                request.setAttribute("error", "Invalid username or password.");

                request.getRequestDispatcher("/WEB-INF/Auth/login.jsp")
                        .forward(request, response);
            }
        } // ================= REGISTER =================
        else if ("register".equals(action)) {

            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirmPassword");

            AuthDAO dao = new AuthDAO();

            // Kiểm tra Password
            if (!password.equals(confirmPassword)) {

                request.setAttribute("error", "Passwords do not match.");

                request.getRequestDispatcher("/WEB-INF/Auth/register.jsp")
                        .forward(request, response);
                return;
            }

            // Kiểm tra Username
            if (dao.checkUsernameExist(username)) {

                request.setAttribute("error", "Username already exists.");

                request.getRequestDispatcher("/WEB-INF/Auth/register.jsp")
                        .forward(request, response);
                return;
            }

            // Kiểm tra Email
            if (dao.checkEmailExist(email)) {

                request.setAttribute("error", "Email address already registered.");

                request.getRequestDispatcher("/WEB-INF/Auth/register.jsp")
                        .forward(request, response);
                return;
            }

            // Tạo Account
            Auth newAccount = new Auth();

            newAccount.setUsername(username);
            newAccount.setPassword(password);
            newAccount.setEmail(email);

            // Mặc định
            newAccount.setFullName(username);
            newAccount.setRoleId(2);
            newAccount.setStatus(true);

            boolean success = dao.register(newAccount);

            if (success) {

                request.setAttribute("success",
                        "Registration successful! Please login.");

                request.getRequestDispatcher("/WEB-INF/Auth/login.jsp")
                        .forward(request, response);

            } else {

                request.setAttribute("error",
                        "Registration failed. Please try again.");

                request.getRequestDispatcher("/WEB-INF/Auth/register.jsp")
                        .forward(request, response);
            }

        }
    }
}
