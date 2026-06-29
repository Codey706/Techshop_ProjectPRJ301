package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Products;
import db.DBContext;
import java.sql.SQLException;
import model.Categories;

public class ProductDAO {

    // =================================================================
    // BỔ SUNG: CÁC HÀM PHỤC VỤ TRANG CHỦ (HOME) & GỢI Ý CHO BẠN
    // =================================================================
    
    /**
     * Lấy danh sách sản phẩm nổi bật hiển thị lên trang chủ (Mặc định lấy TOP 4)
     */
    public List<Products> getFeaturedProducts() {
        List<Products> list = new ArrayList<>();
        String query = "SELECT TOP 4 * FROM Products WHERE IsFeatured = 1 AND Deleted = 0 ORDER BY ProductId DESC";
        try (Connection conn = new DBContext().getConnection(); 
             PreparedStatement ps = conn.prepareStatement(query); 
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapResultSetToProduct(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Lấy danh sách sản phẩm bán chạy nhất theo số lượng đã bán (Mặc định lấy TOP 12)
     * @return 
     */
    public List<Products> getBestSellers() {
        List<Products> list = new ArrayList<>();
        String query = "SELECT TOP 12 p.*, v.Price, v.ImageUrl "
                + "FROM Products p "
                + "LEFT JOIN ProductVariants v ON p.ProductId = v.ProductId "
                + "WHERE p.Deleted = 0 "
                + "ORDER BY p.Sold DESC";

        try (Connection conn = new DBContext().getConnection()) {
            if (conn == null) {
                return list;
            }
            try (PreparedStatement ps = conn.prepareStatement(query); 
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToProduct(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Lấy danh sách các danh mục hiển thị trên thanh tab gợi ý (Active & Chưa xóa)
     * @return 
     */
    public List<Categories> getSuggestionCategories() {
        List<Categories> list = new ArrayList<>();
        String sql = "SELECT CategoryId, CategoryName FROM Categories WHERE Deleted = 0";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Categories cat = new Categories();
                cat.setCategoryId(rs.getInt("CategoryId"));
                cat.setCategoryName(rs.getString("CategoryName"));
                list.add(cat);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Lấy danh sách sản phẩm mới nhất theo CategoryId (Giới hạn TOP 10 phần tử để tối ưu giao diện)
     * @return 
     */
    public List<Products> getProductsByCategoryId(int categoryId) {
        List<Products> list = new ArrayList<>();
        String sql = "SELECT TOP 10 p.ProductId, p.ProductName, p.BaseSKU, v.Price, v.ImageUrl "
                   + "FROM Products p "
                   + "LEFT JOIN ProductVariants v ON v.VariantId = ("
                   + "    SELECT MIN(VariantId) FROM ProductVariants WHERE ProductId = p.ProductId"
                   + ") "
                   + "WHERE p.CategoryId = ? AND p.Deleted = 0 AND p.Status = 1 "
                   + "ORDER BY p.ProductId DESC";

        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, categoryId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Products p = new Products();
                    p.setProductId(rs.getInt("ProductId"));
                    p.setProductName(rs.getString("ProductName"));
                    p.setBaseSKU(rs.getString("BaseSKU"));
                    p.setPrice(rs.getDouble("Price"));
                    p.setImageUrl(rs.getString("ImageUrl"));
                    list.add(p);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // =================================================================
    // CÁC HÀM XỬ LÝ DỮ LIỆU KHÁC
    // =================================================================
    
    // 1. Hàm lấy danh sách TẤT CẢ sản phẩm
    public List<Products> getAllProducts() {
        List<Products> list = new ArrayList<>();
        String query = "SELECT * FROM Products WHERE Deleted = 0 ORDER BY ProductId DESC";
        try (Connection conn = new DBContext().getConnection(); 
             PreparedStatement ps = conn.prepareStatement(query); 
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapResultSetToProduct(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 2. Hàm TÌM KIẾM sản phẩm theo từ khóa (khớp tên hoặc SKU)
    public List<Products> searchProducts(String keyword) {
        List<Products> list = new ArrayList<>();
        String query = "SELECT * FROM Products WHERE Deleted = 0 AND (ProductName LIKE ? OR BaseSKU LIKE ?) ORDER BY ProductId DESC";
        try (Connection conn = new DBContext().getConnection(); 
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, "%" + keyword + "%");
            ps.setString(2, "%" + keyword + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToProduct(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 3. Hàm LỌC sản phẩm theo Brand và Khoảng giá
    public List<Products> filterProducts(String brandId, String priceRange) {
        List<Products> list = new ArrayList<>();
        StringBuilder query = new StringBuilder("SELECT * FROM Products WHERE Deleted = 0");

        if (brandId != null && !brandId.isEmpty()) {
            query.append(" AND BrandId = ?");
        }

        if (priceRange != null && !priceRange.isEmpty()) {
            if (priceRange.equals("under-15m")) {
                query.append(" AND Price < 15000000");
            } else if (priceRange.equals("15m-25m")) {
                query.append(" AND Price BETWEEN 15000000 AND 25000000");
            } else if (priceRange.equals("over-25m")) {
                query.append(" AND Price > 25000000");
            }
        }
        query.append(" ORDER BY ProductId DESC");

        try (Connection conn = new DBContext().getConnection(); 
             PreparedStatement ps = conn.prepareStatement(query.toString())) {

            int paramIndex = 1;
            if (brandId != null && !brandId.isEmpty()) {
                ps.setInt(paramIndex++, Integer.parseInt(brandId));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToProduct(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 4. Hàm lấy CHI TIẾT 1 sản phẩm theo ID
    public Products getProductById(int id) {
        String query = "SELECT * FROM Products WHERE ProductId = ? AND Deleted = 0";
        try (Connection conn = new DBContext().getConnection(); 
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToProduct(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Hàm bổ trợ ánh xạ dữ liệu tránh lặp code (Helper Method)
     */
    private Products mapResultSetToProduct(ResultSet rs) throws java.sql.SQLException {
        Products p = new Products();
        p.setProductId(rs.getInt("ProductId"));
        p.setCategoryId(rs.getInt("CategoryId"));
        p.setBrandId(rs.getInt("BrandId"));
        p.setBaseSKU(rs.getString("BaseSKU"));
        p.setProductName(rs.getString("ProductName"));
        p.setSlug(rs.getString("Slug"));
        p.setViews(rs.getInt("Views"));
        p.setSold(rs.getInt("Sold"));
        p.setIsFeatured(rs.getBoolean("IsFeatured"));
        p.setIsNew(rs.getBoolean("IsNew"));
        p.setDeleted(rs.getBoolean("Deleted"));
        p.setStatus(rs.getInt("Status"));
        p.setDescription(rs.getString("Description"));
        p.setPrice(rs.getDouble("Price"));
        p.setImageUrl(rs.getString("ImageUrl"));
        p.setCreatedBy(rs.getInt("CreatedBy"));
        p.setPublishedAt(rs.getTimestamp("PublishedAt"));
        p.setCreatedAt(rs.getTimestamp("CreatedAt"));
        p.setUpdatedAt(rs.getTimestamp("UpdatedAt"));
        return p;
    }
}