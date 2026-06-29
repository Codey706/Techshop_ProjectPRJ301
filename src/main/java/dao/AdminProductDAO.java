package dao;

import db.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Brands;
import model.Categories;
import model.ProductImages;
import model.Products;

public class AdminProductDAO extends DBContext {

    public List<Products> getList() {
        List<Products> list = new ArrayList<>();
        
        // SỬA SQL: Lấy Price và ImageUrl từ ProductVariants (v) thay vì từ p.Price không tồn tại.
        // Sử dụng subquery hoặc GROUP BY/MIN/MAX để tránh trùng lặp nếu một sản phẩm có nhiều biến thể.
        // Ở đây lấy biến thể đầu tiên (MIN VariantId) để đại diện cho sản phẩm.
        String sql = "SELECT p.ProductId, p.ProductName, p.BaseSKU, "
                + "c.CategoryName, b.BrandName, p.[Status], p.Sold, p.[Views], "
                + "v.Price, v.ImageUrl "
                + "FROM Products p "
                + "JOIN Categories c ON p.CategoryId = c.CategoryId "
                + "JOIN Brands b ON p.BrandId = b.BrandId "
                + "LEFT JOIN ProductVariants v ON v.VariantId = ("
                + "    SELECT MIN(VariantId) FROM ProductVariants WHERE ProductId = p.ProductId"
                + ") "
                + "ORDER BY p.ProductId DESC";

        try (Connection conn = this.getConnection();
             PreparedStatement statement = conn.prepareStatement(sql);
             ResultSet rs = statement.executeQuery()) {

            while (rs.next()) {
                Integer productId = rs.getInt("ProductId");
                String productName = rs.getString("ProductName");
                String baseSKU = rs.getString("BaseSKU");
                String categoryName = rs.getString("CategoryName");
                String brandName = rs.getString("BrandName");
                Integer status = rs.getInt("Status");
                Integer sold = rs.getInt("Sold");
                Integer views = rs.getInt("Views");
                
                // Lấy đúng dữ liệu từ bảng Variants đã được mapping
                String imageUrl = rs.getString("ImageUrl");
                Double price = rs.getDouble("Price"); 

                // Khởi tạo các Object liên kết
                ProductImages productImg = new ProductImages(null, null, imageUrl, null, null, null, null, null);
                Brands brand = new Brands(null, brandName, null, null, null, null, null);
                Categories category = new Categories(null, categoryName, null, null, null);

                // Khởi tạo đối tượng Products khớp cấu trúc Model linh hoạt của bạn
                Products product = new Products(
                        productId,      // productId
                        null,           // categoryId
                        null,           // brandId
                        baseSKU,        // baseSKU
                        productName,    // productName
                        null,           // slug
                        views,          // views
                        sold,           // sold
                        null,           // isFeatured
                        null,           // isNew
                        null,           // deleted
                        status,         // status
                        null,           // description
                        price,          // price (Nhận dữ liệu từ Variant)
                        imageUrl,       // imageUrl (Nhận dữ liệu từ Variant)
                        null,           // createdBy
                        null,           // publishedAt
                        null,           // createdAt
                        null,           // updatedAt
                        category,       // category object
                        brand,          // brand object
                        productImg      // productImg object
                );
                
                list.add(product);
            }

        } catch (SQLException ex) {
            Logger.getLogger(AdminProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
}