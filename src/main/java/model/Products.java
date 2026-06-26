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
public class Products {
    private Integer ProductId;
    private Integer CategoryId;
    private Integer BrandId;
    private String BaseSKU;
    private String ProductName;
    private String Slug;
    private Integer Views;
    private Integer Sold;
    private Boolean IsFeatured;
    private Boolean IsNew;
    private Boolean Deleted;
    private Integer Status;
    private String Description;
    private Integer CreatedBy;
    private Timestamp PublishedAt;
    private Timestamp CreatedAt;
    private Timestamp UpdatedAt;
    private Categories category;
    private Brands brand;
    private ProductImages ProductImg;

    public Products() {
    }

    public Products(Integer ProductId, Integer CategoryId, Integer BrandId, String BaseSKU, String ProductName, String Slug, Integer Views, Integer Sold, Boolean IsFeatured, Boolean IsNew, Boolean Deleted, Integer Status, String Description, Integer CreatedBy, Timestamp PublishedAt, Timestamp CreatedAt, Timestamp UpdatedAt, Categories category, Brands brand, ProductImages ProductImg) {
        this.ProductId = ProductId;
        this.CategoryId = CategoryId;
        this.BrandId = BrandId;
        this.BaseSKU = BaseSKU;
        this.ProductName = ProductName;
        this.Slug = Slug;
        this.Views = Views;
        this.Sold = Sold;
        this.IsFeatured = IsFeatured;
        this.IsNew = IsNew;
        this.Deleted = Deleted;
        this.Status = Status;
        this.Description = Description;
        this.CreatedBy = CreatedBy;
        this.PublishedAt = PublishedAt;
        this.CreatedAt = CreatedAt;
        this.UpdatedAt = UpdatedAt;
        this.category = category;
        this.brand = brand;
        this.ProductImg = ProductImg;
    }

    public Integer getProductId() {
        return ProductId;
    }

    public Integer getCategoryId() {
        return CategoryId;
    }

    public Integer getBrandId() {
        return BrandId;
    }

    public String getBaseSKU() {
        return BaseSKU;
    }

    public String getProductName() {
        return ProductName;
    }

    public String getSlug() {
        return Slug;
    }

    public Integer getViews() {
        return Views;
    }

    public Integer getSold() {
        return Sold;
    }

    public Boolean isFeatured() {
        return IsFeatured;
    }

    public Boolean isNew() {
        return IsNew;
    }

    public Boolean isDeleted() {
        return Deleted;
    }

    public Integer getStatus() {
        return Status;
    }

    public String getDescription() {
        return Description;
    }

    public Integer getCreatedBy() {
        return CreatedBy;
    }

    public Timestamp getPublishedAt() {
        return PublishedAt;
    }

    public Timestamp getCreatedAt() {
        return CreatedAt;
    }

    public Timestamp getUpdatedAt() {
        return UpdatedAt;
    }

    public Categories getCategory() {
        return category;
    }

    public Brands getBrand() {
        return brand;
    }

    public ProductImages getProductImg() {
        return ProductImg;
    }
    

    public void setProductId(Integer ProductId) {
        this.ProductId = ProductId;
    }

    public void setCategoryId(Integer CategoryId) {
        this.CategoryId = CategoryId;
    }

    public void setBrandId(Integer BrandId) {
        this.BrandId = BrandId;
    }

    public void setBaseSKU(String BaseSKU) {
        this.BaseSKU = BaseSKU;
    }

    public void setProductName(String ProductName) {
        this.ProductName = ProductName;
    }

    public void setSlug(String Slug) {
        this.Slug = Slug;
    }

    public void setViews(Integer Views) {
        this.Views = Views;
    }

    public void setSold(Integer Sold) {
        this.Sold = Sold;
    }

    public void setIsFeatured(Boolean IsFeatured) {
        this.IsFeatured = IsFeatured;
    }

    public void setIsNew(Boolean IsNew) {
        this.IsNew = IsNew;
    }

    public void setDeleted(Boolean Deleted) {
        this.Deleted = Deleted;
    }

    public void setStatus(Integer Status) {
        this.Status = Status;
    }

    public void setDescription(String Description) {
        this.Description = Description;
    }

    public void setCreatedBy(Integer CreatedBy) {
        this.CreatedBy = CreatedBy;
    }

    public void setPublishedAt(Timestamp PublishedAt) {
        this.PublishedAt = PublishedAt;
    }

    public void setCreatedAt(Timestamp CreatedAt) {
        this.CreatedAt = CreatedAt;
    }

    public void setUpdatedAt(Timestamp UpdatedAt) {
        this.UpdatedAt = UpdatedAt;
    }

    public void setCategory(Categories category) {
        this.category = category;
    }

    public void setBrand(Brands brand) {
        this.brand = brand;
    }

    public void setProductImg(ProductImages ProductImg) {
        this.ProductImg = ProductImg;
    }
}