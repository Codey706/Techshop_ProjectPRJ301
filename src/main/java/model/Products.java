package model;

import java.sql.Timestamp;
import java.util.List;
import java.util.logging.Logger;

/**
 * Class đối tượng Products tương thích với Cơ sở dữ liệu và giao diện hệ thống.
 * Đã cấu trúc lại Getter/Setter chuẩn CamelCase để dễ gọi từ file JSP/Servlet.
 */
public class Products {

    private Integer productId;
    private Integer categoryId;
    private Integer brandId;
    private String baseSKU;
    private String productName;
    private String slug;
    private Integer views;
    private Integer sold;
    private Boolean isFeatured;
    private Boolean isNew;
    private Boolean deleted;
    private Integer status;
    private String description;
    private Double price;       // Bổ sung để hiển thị giá tiền lên home.jsp
    private String imageUrl;    // Bổ sung để hiển thị hình ảnh đại diện lên home.jsp
    private Integer createdBy;
    private Timestamp publishedAt;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // Các thuộc tính liên kết đối tượng (Object quan hệ)
    private Categories category;
    private Brands brand;
    private ProductImages productImg;
    private List<ProductVariants> variants;

    // 1. Constructor không tham số
    public Products() {
    }

    // 2. Constructor đầy đủ tham số
    public Products(Integer productId, Integer categoryId, Integer brandId, String baseSKU, String productName, String slug, Integer views, Integer sold, Boolean isFeatured, Boolean isNew, Boolean deleted, Integer status, String description, Double price, String imageUrl, Integer createdBy, Timestamp publishedAt, Timestamp createdAt, Timestamp updatedAt, Categories category, Brands brand, ProductImages productImg, List<ProductVariants> variants) {    
        this.productId = productId;
        this.categoryId = categoryId;
        this.brandId = brandId;
        this.baseSKU = baseSKU;
        this.productName = productName;
        this.slug = slug;
        this.views = views;
        this.sold = sold;
        this.isFeatured = isFeatured;
        this.isNew = isNew;
        this.deleted = deleted;
        this.status = status;
        this.description = description;
        this.price = price;
        this.imageUrl = imageUrl;
        this.createdBy = createdBy;
        this.publishedAt = publishedAt;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.category = category;
        this.brand = brand;
        this.productImg = productImg;
        this.variants = variants;
    }

    // ==========================================
    // GETTERS & SETTERS (Chuẩn camelCase)
    // ==========================================
    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    public Integer getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Integer categoryId) {
        this.categoryId = categoryId;
    }

    public Integer getBrandId() {
        return brandId;
    }

    public void setBrandId(Integer brandId) {
        this.brandId = brandId;
    }

    public String getBaseSKU() {
        return baseSKU;
    }

    public void setBaseSKU(String baseSKU) {
        this.baseSKU = baseSKU;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getSlug() {
        return slug;
    }

    public void setSlug(String slug) {
        this.slug = slug;
    }

    public Integer getViews() {
        return views;
    }

    public void setViews(Integer views) {
        this.views = views;
    }

    public Integer getSold() {
        return sold;
    }

    public void setSold(Integer sold) {
        this.sold = sold;
    }

    public Boolean getIsFeatured() {
        return isFeatured;
    }

    public void setIsFeatured(Boolean isFeatured) {
        this.isFeatured = isFeatured;
    }

    public Boolean getIsNew() {
        return isNew;
    }

    public void setIsNew(Boolean isNew) {
        this.isNew = isNew;
    }

    public Boolean getDeleted() {
        return deleted;
    }

    public void setDeleted(Boolean deleted) {
        this.deleted = deleted;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public Integer getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(Integer createdBy) {
        this.createdBy = createdBy;
    }

    public Timestamp getPublishedAt() {
        return publishedAt;
    }

    public void setPublishedAt(Timestamp publishedAt) {
        this.publishedAt = publishedAt;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    public Categories getCategory() {
        return category;
    }

    public void setCategory(Categories category) {
        this.category = category;
    }

    public Brands getBrand() {
        return brand;
    }

    public void setBrand(Brands brand) {
        this.brand = brand;
    }

    public ProductImages getProductImg() {
        return productImg;
    }

    public void setProductImg(ProductImages productImg) {
        this.productImg = productImg;
    }

    public List<ProductVariants> getVariants() {
        return variants;
    }

    public void setVariants(List<ProductVariants> variants) {
        this.variants = variants;
    }

}
