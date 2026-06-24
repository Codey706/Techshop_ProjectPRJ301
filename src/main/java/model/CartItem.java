/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.math.BigDecimal;

/**
 *
 * @author TRUC MAI
 */
public class CartItem {

    private Integer cartItemId;
    private Integer cartId;
    private Integer variantId;
    private Integer quantity;

    // Thông tin join tu ProductVariants + Products (de hien thi UI)
    private String productName;
    private String variantName;
    private String variantSKU;
    private String imageUrl;
    private BigDecimal price;
    private BigDecimal originalPrice;
    private Integer stock;

    public CartItem() {
    }

    public CartItem(Integer cartItemId, Integer cartId, Integer variantId, Integer quantity,
            String productName, String variantName, String variantSKU,
            String imageUrl, BigDecimal price, BigDecimal originalPrice, Integer stock) {
        this.cartItemId = cartItemId;
        this.cartId = cartId;
        this.variantId = variantId;
        this.quantity = quantity;
        this.productName = productName;
        this.variantName = variantName;
        this.variantSKU = variantSKU;
        this.imageUrl = imageUrl;
        this.price = price;
        this.originalPrice = originalPrice;
        this.stock = stock;
    }

    public Integer getCartItemId() {
        return cartItemId;
    }

    public Integer getCartId() {
        return cartId;
    }

    public Integer getVariantId() {
        return variantId;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public String getProductName() {
        return productName;
    }

    public String getVariantName() {
        return variantName;
    }

    public String getVariantSKU() {
        return variantSKU;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public BigDecimal getOriginalPrice() {
        return originalPrice;
    }

    public Integer getStock() {
        return stock;
    }

    /**
     * Tong tien:  price * quantity
     */
    public BigDecimal getLineTotal() {
        if (price == null || quantity == null) {
            return BigDecimal.ZERO;
        }
        return price.multiply(new BigDecimal(quantity));
    }

    // ---- Setters ----
    public void setCartItemId(Integer cartItemId) {
        this.cartItemId = cartItemId;
    }

    public void setCartId(Integer cartId) {
        this.cartId = cartId;
    }

    public void setVariantId(Integer variantId) {
        this.variantId = variantId;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public void setVariantName(String variantName) {
        this.variantName = variantName;
    }

    public void setVariantSKU(String variantSKU) {
        this.variantSKU = variantSKU;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public void setOriginalPrice(BigDecimal originalPrice) {
        this.originalPrice = originalPrice;
    }

    public void setStock(Integer stock) {
        this.stock = stock;
    }
}
