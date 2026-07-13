package controller;

import dao.DashboardDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;
import model.Auth;

/**
 *
 * @author Huynh Nhu Y
 */
@WebServlet(name = "DashboardServlet", urlPatterns = {"/admin/dashboard/dashboard", "/admin/dashboard/dashboard/*"})
public class DashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 1. KIỂM TRA BẢO MẬT: Chỉ cho phép Admin đã đăng nhập truy cập
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/Auth?view=login");
            return;
        }

        Auth user = (Auth) session.getAttribute("user");
        if (user.getRoleId() != 1) { // Giả sử RoleId = 1 là Admin
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền truy cập!");
            return;
        }

        /// 2. PHÂN TÍCH ĐƯỜNG DẪN (URL ROUTING) BẰNG IF - ELSE IF
        DashboardDAO dashboardDAO = new DashboardDAO();
        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/")) {
            // Nhánh 1: Trang thống kê tổng quan (/admin/dashboard)
            int pendingOrders = dashboardDAO.getTotalPendingOrders();
            double totalRevenue = dashboardDAO.getTotalRevenue();
            int totalCustomers = dashboardDAO.getTotalCustomers();

            // Gửi dữ liệu sang trang dashboard.jsp
            request.setAttribute("pendingOrders", pendingOrders);
            request.setAttribute("totalRevenue", totalRevenue);
            request.setAttribute("totalCustomers", totalCustomers);

            request.getRequestDispatcher("/WEB-INF/admin/dashboard/dashboard.jsp")
                    .forward(request, response);

        } else if (pathInfo.equals("/revenue")) {
            // Nhánh 2: Thống kê doanh thu theo tháng/năm (/admin/dashboard/revenue)
            String yearParam = request.getParameter("year");
            int year = 2026; // Năm mặc định nếu người dùng chưa chọn bộ lọc

            if (yearParam != null && !yearParam.isEmpty()) {
                try {
                    year = Integer.parseInt(yearParam);
                } catch (NumberFormatException e) {
                    year = 2026;
                }
            }

            // Lấy danh sách doanh thu theo từng tháng từ database
            List<Map<String, Object>> revenueList = dashboardDAO.getRevenueByYear(year);

            // Gửi dữ liệu và năm đang lọc sang trang revenue.jsp
            request.setAttribute("revenueList", revenueList);
            request.setAttribute("selectedYear", year);

            request.getRequestDispatcher("/WEB-INF/admin/dashboard/revenue.jsp")
                    .forward(request, response);

        } else if (pathInfo.equals("/top-products")) {
            // Nhánh 3: Bảng xếp hạng sản phẩm bán chạy (/admin/dashboard/top-products)
            // Lấy Top 10 sản phẩm có số lượng [Sold] cao nhất
            List<Map<String, Object>> topProducts = dashboardDAO.getTopSellingProducts(10);

            // Gửi danh sách ranking sang trang top-products.jsp
            request.setAttribute("topProducts", topProducts);

            request.getRequestDispatcher("/WEB-INF/admin/dashboard/top-products.jsp")
                    .forward(request, response);
        } else {
            // Nếu người dùng gõ đường dẫn lạ (Ví dụ: /admin/dashboard/abc) -> Báo lỗi 404
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }
}
