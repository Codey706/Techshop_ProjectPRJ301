/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;

/**
 *
 * @author HP
 */
public class ProductImages {

    private Integer ImageId;
    private Products product;
    private String ImageUrl;
    private String AltText;
    private Integer DisplayOrder;
    private Boolean IsThumbnail;
    private Boolean Deleted;
    private Timestamp CreatedAt;

    public ProductImages() {
    }

    public ProductImages(Integer ImageId, Products product, String ImageUrl, String AltText, Integer DisplayOrder, Boolean IsThumbnail, Boolean Deleted, Timestamp CreatedAt) {
        this.ImageId = ImageId;
        this.product = product;
        this.ImageUrl = ImageUrl;
        this.AltText = AltText;
        this.DisplayOrder = DisplayOrder;
        this.IsThumbnail = IsThumbnail;
        this.Deleted = Deleted;
        this.CreatedAt = CreatedAt;
    }

    public Integer getImageId() {
        return ImageId;
    }

    public Products getProduct() {
        return product;
    }

    public String getImageUrl() {
        return ImageUrl;
    }

    public String getAltText() {
        return AltText;
    }

    public Integer getDisplayOrder() {
        return DisplayOrder;
    }

    public Boolean isThumbnail() {
        return IsThumbnail;
    }

    public Boolean isDeleted() {
        return Deleted;
    }

    public Timestamp getCreatedAt() {
        return CreatedAt;
    }

    public void setImageId(Integer ImageId) {
        this.ImageId = ImageId;
    }

    public void setProduct(Products product) {
        this.product = product;
    }

    public void setImageUrl(String ImageUrl) {
        this.ImageUrl = ImageUrl;
    }

    public void setAltText(String AltText) {
        this.AltText = AltText;
    }

    public void setDisplayOrder(Integer DisplayOrder) {
        this.DisplayOrder = DisplayOrder;
    }

    public void setIsThumbnail(Boolean IsThumbnail) {
        this.IsThumbnail = IsThumbnail;
    }

    public void setDeleted(Boolean Deleted) {
        this.Deleted = Deleted;
    }

    public void setCreatedAt(Timestamp CreatedAt) {
        this.CreatedAt = CreatedAt;
    }
}
