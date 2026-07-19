package dao;

import db.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Brands;
import model.Categories;
import model.ProductImages;
import model.Products;
import model.ProductVariants;

public class AdminProductDAO extends DBContext {

    public List<Products> getList() {
        List<Products> list = new ArrayList<>();

        // SỬA SQL: Lấy Price và ImageUrl từ ProductVariants (v) thay vì từ p.Price không tồn tại.
        // Sử dụng subquery hoặc GROUP BY/MIN/MAX để tránh trùng lặp nếu một sản phẩm có nhiều biến thể.
        // Ở đây lấy biến thể đầu tiên (MIN VariantId) để đại diện cho sản phẩm.
        String sql = "SELECT p.ProductId, p.ProductName, "
                + "v.VariantSKU, v.Price, v.ImageUrl, "
                + "c.CategoryName, b.BrandName, p.[Status], p.Sold, p.[Views] "
                + "FROM Products p "
                + "JOIN Categories c ON p.CategoryId = c.CategoryId "
                + "JOIN Brands b ON p.BrandId = b.BrandId "
                + "LEFT JOIN ProductVariants v ON v.VariantId = ("
                + "    SELECT MIN(VariantId) FROM ProductVariants WHERE ProductId = p.ProductId"
                + ") "
                + "ORDER BY p.ProductId DESC";

        try (Connection conn = this.getConnection(); PreparedStatement statement = conn.prepareStatement(sql); ResultSet rs = statement.executeQuery()) {

            while (rs.next()) {
                Integer productId = rs.getInt("ProductId");
                String productName = rs.getString("ProductName");
                String variantSKU = rs.getString("VariantSKU");
                String categoryName = rs.getString("CategoryName");
                String brandName = rs.getString("BrandName");
                Integer status = rs.getInt("Status");
                Integer sold = rs.getInt("Sold");
                Integer views = rs.getInt("Views");

                // Lấy đúng dữ liệu từ bảng Variants đã được mapping
                String imageUrl = rs.getString("ImageUrl");
                Double price = rs.getDouble("Price");
                ProductVariants productVariant = new ProductVariants(
                        null, // variantId
                        productId, // productId
                        variantSKU, // variantSKU
                        null, // variantName
                        null, // originalPrice
                        price, // price
                        null, // discountPercent
                        null, // stock
                        imageUrl, // imageUrl
                        null // status
                );

                // Khởi tạo các Object liên kết
                ProductImages productImg = new ProductImages(null, null, imageUrl, null, null, null, null, null);
                Brands brand = new Brands(null, brandName, null, null, null, null, null);
                Categories category = new Categories(null, categoryName, null, null, null);

                // Khởi tạo đối tượng Products khớp cấu trúc Model linh hoạt của bạn
                Products product = new Products(
                        productId, // productId
                        null, // categoryId
                        null, // brandId
                        null, // baseSKU
                        productName, // productName
                        null, // slug
                        views, // views
                        sold, // sold
                        null, // isFeatured
                        null, // isNew
                        null, // deleted
                        status, // status
                        null, // description
                        price, // price (Nhận dữ liệu từ Variant)
                        imageUrl, // imageUrl (Nhận dữ liệu từ Variant)
                        null, // createdBy
                        null, // publishedAt
                        null, // createdAt
                        null, // updatedAt
                        category, // category object
                        brand, // brand object
                        productImg, // productImg object
                        null // productVariant object
                );

                list.add(product);
            }

        } catch (SQLException ex) {
            Logger.getLogger(AdminProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<Categories> getCategories() {
        List<Categories> list = new ArrayList<>();

        try {

            String sql = "SELECT CategoryId, CategoryName FROM Categories";

            PreparedStatement statement = this.getConnection().prepareStatement(sql);

            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                Categories category = new Categories(rs.getInt("CategoryId"), rs.getString("CategoryName"), null, null, null);

                list.add(category);
            }

        } catch (SQLException ex) {
            Logger.getLogger(AdminProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return list;
    }

    public List<Brands> getBrands() {
        List<Brands> list = new ArrayList<>();

        try {

            String sql = "SELECT BrandId, BrandName FROM Brands";

            PreparedStatement statement = this.getConnection().prepareStatement(sql);

            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                Brands brand = new Brands(rs.getInt("BrandId"), rs.getString("BrandName"), null, null, null, null, null);

                list.add(brand);
            }

        } catch (SQLException ex) {
            Logger.getLogger(AdminProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return list;
    }

    public int getTotalPages() {

        int pageSize = 12;

        String sql = "SELECT COUNT(*) FROM Products";

        try {
            PreparedStatement statement = this.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                int totalProducts = rs.getInt(1);

                int totalPages = totalProducts / pageSize;
                if (totalProducts % pageSize != 0) {
                    totalPages++;
                }
                return totalPages;
            }

        } catch (SQLException ex) {
            Logger.getLogger(AdminProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public List<Products> getProductsByPage(int page) {

        List<Products> list = new ArrayList<>();

        int pageSize = 12;

        String sql = "SELECT p.ProductId, p.ProductName, "
                + "v.VariantSKU, v.Price, v.ImageUrl, "
                + "c.CategoryName, b.BrandName, p.Status, p.Sold, p.Views "
                + "FROM Products p "
                + "JOIN Categories c ON p.CategoryId = c.CategoryId "
                + "JOIN Brands b ON p.BrandId = b.BrandId "
                + "LEFT JOIN ProductVariants v ON v.VariantId = ("
                + "SELECT MIN(VariantId) FROM ProductVariants WHERE ProductId = p.ProductId) "
                + "ORDER BY p.ProductId DESC "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try {

            PreparedStatement statement = this.getConnection().prepareStatement(sql);

            statement.setInt(1, (page - 1) * pageSize);
            statement.setInt(2, pageSize);

            ResultSet rs = statement.executeQuery();

            while (rs.next()) {

                Integer productId = rs.getInt("ProductId");
                String productName = rs.getString("ProductName");
                String variantSKU = rs.getString("VariantSKU");
                String categoryName = rs.getString("CategoryName");
                String brandName = rs.getString("BrandName");
                Integer status = rs.getInt("Status");
                Integer sold = rs.getInt("Sold");
                Integer views = rs.getInt("Views");
                String imageUrl = rs.getString("ImageUrl");
                Double price = rs.getDouble("Price");

                ProductVariants productVariant = new ProductVariants(null, productId, variantSKU, null, null, price, null, null, imageUrl, null);

                ProductImages productImg = new ProductImages(null, null, imageUrl, null, null, null, null, null);

                Brands brand = new Brands(null, brandName, null, null, null, null, null);

                Categories category = new Categories(null, categoryName, null, null, null);

                List<ProductVariants> variants = new ArrayList<>();
                variants.add(productVariant);

                Products product = new Products(
                        productId,
                        null,
                        null,
                        null,
                        productName,
                        null,
                        views,
                        sold,
                        null,
                        null,
                        null,
                        status,
                        null,
                        price,
                        imageUrl,
                        null,
                        null,
                        null,
                        null,
                        category,
                        brand,
                        productImg,
                        variants
                );

                list.add(product);
            }

        } catch (SQLException ex) {
            Logger.getLogger(AdminProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return list;
    }

    public int createProduct(Products product) {
        try {
            String sql = "INSERT INTO Products "
                    + "(CategoryId, BrandId, BaseSKU, ProductName, Slug, "
                    + "Views, Sold, IsFeatured, IsNew, Deleted, Status, Description, PublishedAt) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement st = this.getConnection().prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            st.setInt(1, product.getCategoryId());
            st.setInt(2, product.getBrandId());
            st.setString(3, product.getBaseSKU());
            st.setString(4, product.getProductName());
            st.setString(5, product.getSlug());

            st.setInt(6, 0);     // Views
            st.setInt(7, 0);     // Sold
            st.setBoolean(8, false); // IsFeatured
            st.setBoolean(9, false); // IsNew
            st.setBoolean(10, false); // Deleted

            st.setInt(11, product.getStatus());
            st.setString(12, product.getDescription());

            Timestamp published = null;

            if (product.getStatus() == 1) {
                published = new Timestamp(System.currentTimeMillis());
                System.out.println("Published = " + published);
                st.setTimestamp(13, published);
            } else {
                st.setNull(13, java.sql.Types.TIMESTAMP);
            }

            st.executeUpdate();

            ResultSet rs = st.getGeneratedKeys();

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException ex) {
            Logger.getLogger(AdminProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return -1;
    }

    public int createVariant(ProductVariants variant) {
        try {
            String sql = "INSERT INTO ProductVariants "
                    + "(ProductId, VariantSKU, VariantName, OriginalPrice, "
                    + "Price, DiscountPercent, Stock, ImageUrl, Status) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement st = this.getConnection().prepareStatement(sql);

            st.setInt(1, variant.getProductId());
            st.setString(2, variant.getVariantSKU());
            st.setString(3, variant.getVariantName());
            st.setDouble(4, variant.getOriginalPrice());
            st.setDouble(5, variant.getPrice());

            if (variant.getDiscountPercent() == null) {
                st.setNull(6, java.sql.Types.INTEGER);
            } else {
                st.setInt(6, variant.getDiscountPercent());
            }

            st.setInt(7, variant.getStock());
            st.setString(8, variant.getImageUrl());
            st.setString(9, variant.getStatus());

            return st.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(AdminProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return 0;
    }

    public Products getProductById(int id) {

        String sql = "SELECT p.*, "
                + "c.CategoryName, "
                + "b.BrandName "
                + "FROM Products p "
                + "JOIN Categories c ON p.CategoryId = c.CategoryId "
                + "JOIN Brands b ON p.BrandId = b.BrandId "
                + "WHERE p.ProductId = ?";

        try {

            PreparedStatement st = getConnection().prepareStatement(sql);

            st.setInt(1, id);

            ResultSet rs = st.executeQuery();

            if (rs.next()) {

                Products product = new Products();

                product.setProductId(rs.getInt("ProductId"));
                product.setCategoryId(rs.getInt("CategoryId"));
                product.setBrandId(rs.getInt("BrandId"));
                product.setBaseSKU(rs.getString("BaseSKU"));
                product.setProductName(rs.getString("ProductName"));
                product.setSlug(rs.getString("Slug"));
                product.setViews(rs.getInt("Views"));
                product.setSold(rs.getInt("Sold"));
                product.setStatus(rs.getInt("Status"));
                product.setDescription(rs.getString("Description"));

                Categories category = new Categories();
                category.setCategoryId(rs.getInt("CategoryId"));
                category.setCategoryName(rs.getString("CategoryName"));

                Brands brand = new Brands();
                brand.setBrandId(rs.getInt("BrandId"));
                brand.setBrandName(rs.getString("BrandName"));

                product.setCategory(category);
                product.setBrand(brand);

                product.setVariants(getVariantsByProductId(product.getProductId()));

                return product;
            }

        } catch (SQLException ex) {
            Logger.getLogger(AdminProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return null;
    }

    public int updateProduct(Products product) {

        String sql = "UPDATE Products "
                + "SET CategoryId=?, "
                + "BrandId=?, "
                + "ProductName=?, "
                + "Description=?, "
                + "Status=? "
                + "WHERE ProductId=?";

        try {

            PreparedStatement st = getConnection().prepareStatement(sql);

            st.setInt(1, product.getCategoryId());
            st.setInt(2, product.getBrandId());
            st.setString(3, product.getProductName());
            st.setString(4, product.getDescription());
            st.setInt(5, product.getStatus());
            st.setInt(6, product.getProductId());

            return st.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(AdminProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return 0;
    }

    public int updateVariant(ProductVariants variant) {

        String sql = "UPDATE ProductVariants SET "
                + "VariantSKU=?,"
                + "VariantName=?,"
                + "OriginalPrice=?,"
                + "Price=?,"
                + "DiscountPercent=?,"
                + "Stock=?,"
                + "ImageUrl=?,"
                + "Status=? "
                + "WHERE VariantId=?";

        try {

            PreparedStatement st = getConnection().prepareStatement(sql);

            st.setString(1, variant.getVariantSKU());
            st.setString(2, variant.getVariantName());
            st.setDouble(3, variant.getOriginalPrice());
            st.setDouble(4, variant.getPrice());

            if (variant.getDiscountPercent() == null) {
                st.setNull(5, java.sql.Types.INTEGER);
            } else {
                st.setInt(5, variant.getDiscountPercent());
            }

            st.setInt(6, variant.getStock());
            st.setString(7, variant.getImageUrl());
            st.setString(8, variant.getStatus());
            st.setInt(9, variant.getVariantId());

            return st.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(AdminProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return 0;
    }

    public List<ProductVariants> getVariantsByProductId(int productId) {

        List<ProductVariants> list = new ArrayList<>();

        String sql = "SELECT * FROM ProductVariants "
                + "WHERE ProductId = ? "
                + "ORDER BY VariantId";

        try {

            PreparedStatement st = getConnection().prepareStatement(sql);

            st.setInt(1, productId);

            ResultSet rs = st.executeQuery();

            while (rs.next()) {

                ProductVariants variant = new ProductVariants();

                variant.setVariantId(rs.getInt("VariantId"));
                variant.setProductId(rs.getInt("ProductId"));
                variant.setVariantSKU(rs.getString("VariantSKU"));
                variant.setVariantName(rs.getString("VariantName"));
                variant.setOriginalPrice(rs.getDouble("OriginalPrice"));
                variant.setPrice(rs.getDouble("Price"));

                if (rs.getObject("DiscountPercent") != null) {
                    variant.setDiscountPercent(rs.getInt("DiscountPercent"));
                }

                variant.setStock(rs.getInt("Stock"));
                variant.setImageUrl(rs.getString("ImageUrl"));
                variant.setStatus(rs.getString("Status"));

                list.add(variant);
            }

        } catch (SQLException ex) {
            Logger.getLogger(AdminProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return list;
    }

    public int deleteProduct(int productId) {

        try {

            String sql = "DELETE FROM Products WHERE ProductId = ?";

            PreparedStatement st = this.getConnection().prepareStatement(sql);

            st.setInt(1, productId);

            return st.executeUpdate();

        } catch (SQLException e) {
            Logger.getLogger(AdminProductDAO.class.getName()).log(Level.SEVERE, null, e);
        }

        return 0;
    }

}
