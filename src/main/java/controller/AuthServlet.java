package controller;

import dao.AuthDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.UUID;
import model.Auth;

/**
 *
 * @author Huynh Nhu Y
 */
@WebServlet(name = "AuthServlet", urlPatterns = {"/Auth"})
public class AuthServlet extends HttpServlet {

    // =========================================================
    // HANDLE GET REQUEST
    // Hiển thị trang Login, Register và xử lý Logout
    // =========================================================
    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String view = request.getParameter("view");

        // =====================================================
        // 1. SHOW LOGIN PAGE
        // =====================================================
        if (view == null || "login".equals(view)) {

            request.getRequestDispatcher(
                    "/WEB-INF/Auth/login.jsp"
            ).forward(request, response);
        } // =====================================================
        // 2. SHOW REGISTER PAGE
        // =====================================================
        else if ("register".equals(view)) {

            request.getRequestDispatcher(
                    "/WEB-INF/Auth/register.jsp"
            ).forward(request, response);
        } // =====================================================
        // 3. LOGOUT
        // =====================================================
        else if ("logout".equals(view)) {

            // -------------------------------------------------
            // 3.1. Lấy session hiện tại
            // -------------------------------------------------
            HttpSession session = request.getSession(false);

            if (session != null) {

                Auth user = (Auth) session.getAttribute("user");

                /*
                 * Xóa remember-me token trong database.
                 */
                if (user != null) {

                    AuthDAO authDAO = new AuthDAO();

                    authDAO.updateRememberMeToken(
                            user.getUserId(),
                            null
                    );
                }

                // Hủy toàn bộ session
                session.invalidate();
            }

            // -------------------------------------------------
            // 3.2. Xóa Remember Me Cookie
            // -------------------------------------------------
            Cookie rememberCookie = new Cookie(
                    "rememberMe",
                    ""
            );

            rememberCookie.setMaxAge(0);
            rememberCookie.setHttpOnly(true);

            String contextPath = request.getContextPath();

            if (contextPath == null || contextPath.isEmpty()) {
                rememberCookie.setPath("/");
            } else {
                rememberCookie.setPath(contextPath);
            }

            response.addCookie(rememberCookie);

            // -------------------------------------------------
            // 3.3. Chuyển về trang đăng nhập
            // -------------------------------------------------
            response.sendRedirect(
                    request.getContextPath()
                    + "/Auth?view=login"
            );
        } // =====================================================
        // 4. INVALID VIEW
        // =====================================================
        else {

            response.sendRedirect(
                    request.getContextPath()
                    + "/Auth?view=login"
            );
        }
    }

    // =========================================================
    // HANDLE POST REQUEST
    // Xử lý Login và Register
    // =========================================================
    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        // =====================================================
        // LOGIN
        // =====================================================
        if ("login".equals(action)) {

            // -------------------------------------------------
            // 1. GET DATA FROM LOGIN FORM
            // -------------------------------------------------
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            boolean remember
                    = request.getParameter("remember") != null;

            /*
             * Tránh NullPointerException nếu parameter không tồn tại.
             */
            username = username == null
                    ? ""
                    : username.trim();

            password = password == null
                    ? ""
                    : password.trim();

            /*
             * Giữ lại username khi đăng nhập sai.
             * Không giữ lại password.
             */
            request.setAttribute("oldUsername", username);

            // -------------------------------------------------
            // 2. VALIDATE LOGIN INPUT
            // -------------------------------------------------
            if (username.isEmpty() || password.isEmpty()) {

                request.setAttribute(
                        "error",
                        "Please enter username and password."
                );

                request.getRequestDispatcher(
                        "/WEB-INF/Auth/login.jsp"
                ).forward(request, response);

                return;
            }

            // Giới hạn độ dài username
            if (username.length() > 50) {

                request.setAttribute(
                        "error",
                        "Username is invalid."
                );

                request.getRequestDispatcher(
                        "/WEB-INF/Auth/login.jsp"
                ).forward(request, response);

                return;
            }

            // -------------------------------------------------
            // 3. AUTHENTICATE USER
            // -------------------------------------------------
            AuthDAO authDAO = new AuthDAO();

            Auth user = authDAO.login(
                    username,
                    password
            );

            /*
             * Nếu DAO trả về null:
             * - Username không tồn tại
             * - Password không đúng
             * - Tài khoản đã bị vô hiệu hóa
             */
            if (user == null) {

                request.setAttribute(
                        "error",
                        "Invalid username or password."
                );

                request.getRequestDispatcher(
                        "/WEB-INF/Auth/login.jsp"
                ).forward(request, response);

                return;
            }

            // -------------------------------------------------
            // 4. CREATE SESSION
            // -------------------------------------------------

            /*
             * Hủy session cũ trước khi tạo session đăng nhập mới.
             */
            HttpSession oldSession
                    = request.getSession(false);

            if (oldSession != null) {
                oldSession.invalidate();
            }

            HttpSession session
                    = request.getSession(true);

            /*
             * Lưu object user để JSP và các Servlet khác sử dụng.
             */
            session.setAttribute("user", user);

            /*
             * Lưu riêng userId để tương thích với Cart,
             * Order, Voucher và các chức năng khác.
             */
            session.setAttribute(
                    "userId",
                    user.getUserId()
            );

            /*
             * Lưu roleId để kiểm tra quyền truy cập.
             */
            session.setAttribute(
                    "roleId",
                    user.getRoleId()
            );

            /*
             * Session hết hạn sau 30 phút không hoạt động.
             */
            session.setMaxInactiveInterval(30 * 60);

            // -------------------------------------------------
            // 5. HANDLE REMEMBER ME
            // -------------------------------------------------
            if (remember) {

                /*
                 * Tạo token ngẫu nhiên.
                 */
                String token
                        = UUID.randomUUID().toString();

                /*
                 * Lưu token vào database theo UserId.
                 */
                authDAO.updateRememberMeToken(
                        user.getUserId(),
                        token
                );

                /*
                 * Lưu token trong cookie trình duyệt.
                 */
                Cookie rememberCookie = new Cookie(
                        "rememberMe",
                        token
                );

                // Cookie tồn tại trong 7 ngày
                rememberCookie.setMaxAge(
                        7 * 24 * 60 * 60
                );

                // JavaScript phía client không đọc được cookie
                rememberCookie.setHttpOnly(true);

                String contextPath
                        = request.getContextPath();

                if (contextPath == null
                        || contextPath.isEmpty()) {

                    rememberCookie.setPath("/");

                } else {

                    rememberCookie.setPath(contextPath);
                }

                response.addCookie(rememberCookie);

            } else {

                /*
                 * Nếu không chọn Remember Me thì xóa token cũ.
                 */
                authDAO.updateRememberMeToken(
                        user.getUserId(),
                        null
                );

                Cookie rememberCookie = new Cookie(
                        "rememberMe",
                        ""
                );

                rememberCookie.setMaxAge(0);
                rememberCookie.setHttpOnly(true);

                String contextPath
                        = request.getContextPath();

                if (contextPath == null
                        || contextPath.isEmpty()) {

                    rememberCookie.setPath("/");

                } else {

                    rememberCookie.setPath(contextPath);
                }

                response.addCookie(rememberCookie);
            }

            // -------------------------------------------------
            // 6. REDIRECT BY ROLE
            // -------------------------------------------------

            /*
             * RoleId = 1: Admin
             * RoleId = 2: Customer
             */
            if (user.getRoleId() == 1) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/admin/dashboard"
                );

            } else {

                response.sendRedirect(
                        request.getContextPath()
                        + "/home"
                );
            }
        } // =====================================================
        // REGISTER
        // =====================================================
        else if ("register".equals(action)) {

            // -------------------------------------------------
            // 1. GET DATA FROM REGISTER FORM
            // -------------------------------------------------
            String username
                    = request.getParameter("username");

            String email
                    = request.getParameter("email");

            String password
                    = request.getParameter("password");

            String confirmPassword
                    = request.getParameter("confirmPassword");

            /*
             * Tránh NullPointerException.
             */
            username = username == null
                    ? ""
                    : username.trim();

            email = email == null
                    ? ""
                    : email.trim();

            password = password == null
                    ? ""
                    : password.trim();

            confirmPassword = confirmPassword == null
                    ? ""
                    : confirmPassword.trim();

            /*
             * Giữ lại username và email khi đăng ký lỗi.
             */
            request.setAttribute(
                    "oldUsername",
                    username
            );

            request.setAttribute(
                    "oldEmail",
                    email
            );

            // -------------------------------------------------
            // 2. VALIDATE EMPTY INPUT
            // -------------------------------------------------
            if (username.isEmpty()
                    || email.isEmpty()
                    || password.isEmpty()
                    || confirmPassword.isEmpty()) {

                request.setAttribute(
                        "error",
                        "Please fill in all fields."
                );

                request.getRequestDispatcher(
                        "/WEB-INF/Auth/register.jsp"
                ).forward(request, response);

                return;
            }

            // -------------------------------------------------
            // 3. VALIDATE USERNAME
            // -------------------------------------------------
            if (username.length() < 4
                    || username.length() > 30) {

                request.setAttribute(
                        "error",
                        "Username must be between 4 and 30 characters."
                );

                request.getRequestDispatcher(
                        "/WEB-INF/Auth/register.jsp"
                ).forward(request, response);

                return;
            }

            /*
             * Username chỉ cho phép chữ, số và dấu gạch dưới.
             */
            if (!username.matches("[A-Za-z0-9_]+")) {

                request.setAttribute(
                        "error",
                        "Username can only contain letters, "
                        + "numbers and underscores."
                );

                request.getRequestDispatcher(
                        "/WEB-INF/Auth/register.jsp"
                ).forward(request, response);

                return;
            }

            // -------------------------------------------------
            // 4. VALIDATE EMAIL
            // -------------------------------------------------
            if (email.length() > 100
                    || !email.matches(
                            "^[A-Za-z0-9+_.-]+"
                            + "@[A-Za-z0-9.-]+"
                            + "\\.[A-Za-z]{2,}$"
                    )) {

                request.setAttribute(
                        "error",
                        "Please enter a valid email address."
                );

                request.getRequestDispatcher(
                        "/WEB-INF/Auth/register.jsp"
                ).forward(request, response);

                return;
            }

            // -------------------------------------------------
            // 5. VALIDATE PASSWORD
            // -------------------------------------------------
            if (password.length() < 6
                    || password.length() > 50) {

                request.setAttribute(
                        "error",
                        "Password must be between 6 and 50 characters."
                );

                request.getRequestDispatcher(
                        "/WEB-INF/Auth/register.jsp"
                ).forward(request, response);

                return;
            }

            // -------------------------------------------------
            // 6. CHECK CONFIRM PASSWORD
            // -------------------------------------------------
            if (!password.equals(confirmPassword)) {

                request.setAttribute(
                        "error",
                        "Passwords do not match."
                );

                request.getRequestDispatcher(
                        "/WEB-INF/Auth/register.jsp"
                ).forward(request, response);

                return;
            }

            // -------------------------------------------------
            // 7. CHECK EXISTING USERNAME AND EMAIL
            // -------------------------------------------------
            AuthDAO authDAO = new AuthDAO();

            if (authDAO.checkUsernameExist(username)) {

                request.setAttribute(
                        "error",
                        "Username already exists."
                );

                request.getRequestDispatcher(
                        "/WEB-INF/Auth/register.jsp"
                ).forward(request, response);

                return;
            }

            if (authDAO.checkEmailExist(email)) {

                request.setAttribute(
                        "error",
                        "Email address already registered."
                );

                request.getRequestDispatcher(
                        "/WEB-INF/Auth/register.jsp"
                ).forward(request, response);

                return;
            }

            // -------------------------------------------------
            // 8. CREATE NEW CUSTOMER ACCOUNT
            // -------------------------------------------------
            Auth newUser = new Auth();

            newUser.setUsername(username);
            newUser.setPassword(password);
            newUser.setEmail(email);

            /*
             * Form hiện tại không có FullName,
             * nên tạm dùng Username làm FullName.
             */
            newUser.setFullName(username);

            /*
             * Người đăng ký từ website luôn là Customer.
             * Không lấy RoleId từ form để tránh tự tạo Admin.
             */
            newUser.setRoleId(2);

            /*
             * Tài khoản được kích hoạt mặc định.
             */
            newUser.setStatus(true);

            boolean registerSuccess
                    = authDAO.register(newUser);

            // -------------------------------------------------
            // 9. HANDLE REGISTER RESULT
            // -------------------------------------------------
            if (registerSuccess) {

                /*
                 * Đăng ký thành công thì chuyển sang Login.
                 */
                request.setAttribute(
                        "success",
                        "Registration successful! Please login."
                );

                request.getRequestDispatcher(
                        "/WEB-INF/Auth/login.jsp"
                ).forward(request, response);

            } else {

                /*
                 * Có lỗi khi insert vào database.
                 */
                request.setAttribute(
                        "error",
                        "Registration failed. Please try again."
                );

                request.getRequestDispatcher(
                        "/WEB-INF/Auth/register.jsp"
                ).forward(request, response);
            }
        } // =====================================================
        // INVALID ACTION
        // =====================================================
        else {

            response.sendRedirect(
                    request.getContextPath()
                    + "/Auth?view=login"
            );
        }
    }
}
