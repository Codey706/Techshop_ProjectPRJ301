package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Products; // Sử dụng đúng class đối tượng Products của bạn
import db.DBContext; 

public class ProductDAO {

    // Hàm lấy danh sách sản phẩm nổi bật hiển thị lên trang chủ
    public List<Products> getFeaturedProducts() {
        List<Products> list = new ArrayList<>();
        
        // Lấy top 4 sản phẩm nổi bật và chưa bị xóa (Deleted = 0 hoặc false)
        String query = "SELECT TOP 4 * FROM Products WHERE IsFeatured = 1 AND Deleted = 0 ORDER BY ProductId DESC"; 
        
        try {
            Connection conn = new DBContext().getConnection(); 
            PreparedStatement ps = conn.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                list.add(new Products(
                        rs.getInt("ProductId"),
                        rs.getInt("CategoryId"),
                        rs.getInt("BrandId"),
                        rs.getString("BaseSKU"),
                        rs.getString("ProductName"),
                        rs.getString("Slug"),
                        rs.getInt("Views"),
                        rs.getInt("Sold"),
                        rs.getBoolean("IsFeatured"),
                        rs.getBoolean("IsNew"),
                        rs.getBoolean("Deleted"),
                        rs.getInt("Status"),
                        rs.getString("Description"),
                        rs.getInt("CreatedBy"),
                        rs.getTimestamp("PublishedAt"),
                        rs.getTimestamp("CreatedAt"),
                        rs.getTimestamp("UpdatedAt")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}