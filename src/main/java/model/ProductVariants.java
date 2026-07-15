/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author HP
 */
public class ProductVariants {
    private Integer variantId;
    private Integer productId;
    private String variantSKU;
    private String variantName;
    private Double originalPrice;
    private Double price;
    private Integer discountPercent;
    private Integer stock;
    private String imageUrl;
    private String status;

    public ProductVariants() {
    }

    public ProductVariants(Integer variantId, Integer productId, String variantSKU, String variantName, Double originalPrice, Double price, Integer discountPercent, Integer stock, String imageUrl, String status) {
        this.variantId = variantId;
        this.productId = productId;
        this.variantSKU = variantSKU;
        this.variantName = variantName;
        this.originalPrice = originalPrice;
        this.price = price;
        this.discountPercent = discountPercent;
        this.stock = stock;
        this.imageUrl = imageUrl;
        this.status = status;
    }
    
    public Integer getVariantId() {
        return variantId;
    }

    public void setVariantId(Integer variantId) {
        this.variantId = variantId;
    }

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    public String getVariantSKU() {
        return variantSKU;
    }

    public void setVariantSKU(String variantSKU) {
        this.variantSKU = variantSKU;
    }

    public String getVariantName() {
        return variantName;
    }

    public void setVariantName(String variantName) {
        this.variantName = variantName;
    }

    public Double getOriginalPrice() {
        return originalPrice;
    }

    public void setOriginalPrice(Double originalPrice) {
        this.originalPrice = originalPrice;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Integer getDiscountPercent() {
        return discountPercent;
    }

    public void setDiscountPercent(Integer discountPercent) {
        this.discountPercent = discountPercent;
    }

    public Integer getStock() {
        return stock;
    }

    public void setStock(Integer stock) {
        this.stock = stock;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

}
