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

        if (view == null || view.equals("login")) {
            request.getRequestDispatcher("/WEB-INF/Auth/login.jsp")
                    .forward(request, response);

        } else if (view.equals("register")) {
            request.getRequestDispatcher("/WEB-INF/Auth/register.jsp")
                    .forward(request, response);

        } else if (view.equals("logout")) {
            HttpSession session = request.getSession(false);

            if (session != null) {
                session.invalidate();
            }

            response.sendRedirect(request.getContextPath() + "/Auth?view=login");
        } else if (view.equals("logout")) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                // Lấy thông tin user hiện tại để xóa token trong DB trước khi hủy session
                Auth user = (Auth) session.getAttribute("user");
                if (user != null) {
                    AuthDAO dao = new AuthDAO();
                    dao.updateRememberMeToken(user.getUserId(), null); // Xóa token trong database
                }
                session.invalidate(); // Hủy session
            }

            // Xóa cookie "rememberMe" lưu trên trình duyệt của người dùng
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if (cookie.getName().equals("rememberMe")) {
                        cookie.setValue("");
                        cookie.setMaxAge(0); // Set thời gian sống bằng 0 để trình duyệt xóa ngay lập tức
                        cookie.setPath(request.getContextPath());
                        response.addCookie(cookie);
                        break;
                    }
                }
            }

            // 3. Chuyển hướng người dùng về lại trang đăng nhập kèm thông báo
            response.sendRedirect(request.getContextPath() + "/Auth?view=login");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action.equals("login")) {

            String username = request.getParameter("username");
            String password = request.getParameter("password");

            AuthDAO dao = new AuthDAO();

            Auth user = dao.login(username, password);

            if (user != null) {

                // KHI ĐĂNG NHẬP THÀNH CÔNG:
                HttpSession session = request.getSession();
                session.setAttribute("user", user);

                // Kiểm tra quyền của tài khoản vừa đăng nhập để điều hướng thông minh
                if (user.getRoleId() == 1) {
                    // Nếu là Admin (RoleId = 1), nhảy thẳng vào trang quản trị Dashboard
                    response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                } else {
                    // Nếu là khách hàng bình thường, đẩy về trang chủ mua sắm
                    response.sendRedirect(request.getContextPath() + "/");
                }

            } else {
                request.setAttribute("error", "Invalid username or password.");

                request.getRequestDispatcher("/WEB-INF/Auth/login.jsp")
                        .forward(request, response);
            }
        } else if (action.equals("register")) {

            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirmPassword");

            AuthDAO dao = new AuthDAO();

            // 1. Kiểm tra mật khẩu khớp nhau
            if (!password.equals(confirmPassword)) {
                request.setAttribute("error", "Passwords do not match.");
                request.getRequestDispatcher("/WEB-INF/Auth/register.jsp").forward(request, response);
                return;
            }

            // 2. Kiểm tra tên tài khoản trùng lặp
            if (dao.checkUsernameExist(username)) {
                request.setAttribute("error", "Username already exists.");
                request.getRequestDispatcher("/WEB-INF/Auth/register.jsp").forward(request, response);
                return;
            }

            // 3. Kiểm tra Email trùng lặp
            if (dao.checkEmailExist(email)) {
                request.setAttribute("error", "Email address already registered.");
                request.getRequestDispatcher("/WEB-INF/Auth/register.jsp").forward(request, response);
                return;
            }

            // 2. Kiểm tra tài khoản đã tồn tại chưa (Giả định AuthDAO có hàm checkExist hoặc register trả về boolean/int)
            // Bạn có thể tùy biến logic check tùy thuộc vào cấu trúc database của bạn
            Auth newAccount = new Auth();
            newAccount.setUsername(username);
            newAccount.setEmail(email);
            newAccount.setPassword(password);

            boolean isRegistered = dao.register(newAccount);

            if (isRegistered) {
                request.setAttribute("success", "Registration successful! Please login.");
                request.getRequestDispatcher("/WEB-INF/Auth/login.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Registration failed. Please try again.");
                request.getRequestDispatcher("/WEB-INF/Auth/register.jsp").forward(request, response);
            }
        }
    }
}
