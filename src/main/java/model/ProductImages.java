package model;

import java.sql.Timestamp;

public class ProductImages {

    private Integer imageId;
    private Integer productId;
    private String imageUrl;
    private String altText;
    private Integer displayOrder;
    private Boolean isThumbnail;
    private Timestamp createdAt;
    private Products product;

    public ProductImages() {
    }

    public ProductImages(Integer imageId, Integer productId, String imageUrl,
            String altText, Integer displayOrder, Boolean isThumbnail,
            Timestamp createdAt, Products product) {
        this.imageId = imageId;
        this.productId = productId;
        this.imageUrl = imageUrl;
        this.altText = altText;
        this.displayOrder = displayOrder;
        this.isThumbnail = isThumbnail;
        this.createdAt = createdAt;
        this.product = product;
    }

    public Integer getImageId() {
        return imageId;
    }

    public void setImageId(Integer imageId) {
        this.imageId = imageId;
    }

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getAltText() {
        return altText;
    }

    public void setAltText(String altText) {
        this.altText = altText;
    }

    public Integer getDisplayOrder() {
        return displayOrder;
    }

    public void setDisplayOrder(Integer displayOrder) {
        this.displayOrder = displayOrder;
    }

    public Boolean getIsThumbnail() {
        return isThumbnail;
    }

    public void setIsThumbnail(Boolean isThumbnail) {
        this.isThumbnail = isThumbnail;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Products getProduct() {
        return product;
    }

    public void setProduct(Products product) {
        this.product = product;
    }

    @Override
    public String toString() {
        return "ProductImages{" +
                "imageId=" + imageId +
                ", productId=" + productId +
                ", imageUrl='" + imageUrl + '\'' +
                ", altText='" + altText + '\'' +
                ", displayOrder=" + displayOrder +
                ", isThumbnail=" + isThumbnail +
                ", createdAt=" + createdAt +
                '}';
    }
}