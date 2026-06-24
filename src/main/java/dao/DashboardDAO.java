package dao;

import db.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Huynh Nhu Y
 */
public class DashboardDAO {

    // =========================================================================
    // PHẦN 1: CÁC HÀM CHO TRANG TỔNG QUAN (/admin/dashboard)
    // =========================================================================
    
    /**
     * Đếm tổng số đơn hàng mới (Trạng thái = 0: Pending)
     */
    public int getTotalPendingOrders() {
        String sql = "SELECT COUNT(*) FROM [dbo].[Orders] WHERE [Status] = 0";
        try {
            DBContext db = new DBContext();
            Connection con = db.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * Tính tổng doanh thu thu được từ các đơn hàng đã hoàn thành (Status = 3: Completed)
     */
    public double getTotalRevenue() {
        String sql = "SELECT SUM([TotalAmount]) FROM [dbo].[Orders] WHERE [Status] = 3";
        try {
            DBContext db = new DBContext();
            Connection con = db.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0.0;
    }

    /**
     * Đếm tổng số thành viên/khách hàng trong hệ thống (RoleId = 2)
     */
    public int getTotalCustomers() {
        String sql = "SELECT COUNT(*) FROM [dbo].[Users] WHERE [RoleId] = 2";
        try {
            DBContext db = new DBContext();
            Connection con = db.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // =========================================================================
    // PHẦN 2: CÁC HÀM CHO TRANG DOANH THU (/admin/dashboard/revenue)
    // =========================================================================
    
    /**
     * Lấy thống kê doanh thu theo từng tháng của một năm cụ thể
     * Trả về danh sách gồm các Map chứa: Tháng, Số lượng đơn, Tổng tiền
     */
    public List<Map<String, Object>> getRevenueByYear(int year) {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT MONTH([OrderDate]) AS [Month], "
                + "COUNT([OrderId]) AS [TotalOrders], "
                + "SUM([TotalAmount]) AS [MonthlyRevenue] "
                + "FROM [dbo].[Orders] "
                + "WHERE YEAR([OrderDate]) = ? AND [Status] = 3 "
                + "GROUP BY MONTH([OrderDate]) "
                + "ORDER BY [Month] ASC";
        try {
            DBContext db = new DBContext();
            Connection con = db.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, year);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("month", rs.getInt("Month"));
                map.put("totalOrders", rs.getInt("TotalOrders"));
                map.put("revenue", rs.getDouble("MonthlyRevenue"));
                list.add(map);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // =========================================================================
    // PHẦN 3: CÁC HÀM CHO TRANG SẢN PHẨM BÁN CHẠY (/admin/dashboard/top-products)
    // =========================================================================
    
    /**
     * Lấy danh sách sản phẩm bán chạy nhất dựa trên trường [Sold] tích lũy trong bảng Products
     * Lấy Top 5 hoặc Top 10 tùy vào giá trị truyền vào limit
     */
    public List<Map<String, Object>> getTopSellingProducts(int limit) {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT TOP (?) [ProductName], [BaseSKU], [Sold] "
                + "FROM [dbo].[Products] "
                + "WHERE [Deleted] = 0 "
                + "ORDER BY [Sold] DESC";
        try {
            DBContext db = new DBContext();
            Connection con = db.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("productName", rs.getNString("ProductName"));
                map.put("baseSku", rs.getString("BaseSKU"));
                map.put("sold", rs.getInt("Sold"));
                list.add(map);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}