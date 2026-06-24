/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author HP
 */
public class Categories {
    private Integer CategoryId;
    private String CategoryName;
    private String ImageURL;
    private String Desciption;
    private Boolean Deleted;

    public Categories() {
    }

    public Categories(Integer CategoryId, String CategoryName, String ImageURL, String Desciption, Boolean Deleted) {
        this.CategoryId = CategoryId;
        this.CategoryName = CategoryName;
        this.ImageURL = ImageURL;
        this.Desciption = Desciption;
        this.Deleted = Deleted;
    }

    public Integer getCategoryId() {
        return CategoryId;
    }

    public String getCategoryName() {
        return CategoryName;
    }

    public String getImageURL() {
        return ImageURL;
    }

    public String getDesciption() {
        return Desciption;
    }

    public Boolean isDeleted() {
        return Deleted;
    }

    public void setCategoryId(Integer CategoryId) {
        this.CategoryId = CategoryId;
    }

    public void setCategoryName(String CategoryName) {
        this.CategoryName = CategoryName;
    }

    public void setImageURL(String ImageURL) {
        this.ImageURL = ImageURL;
    }

    public void setDesciption(String Desciption) {
        this.Desciption = Desciption;
    }

    public void setDeleted(Boolean Deleted) {
        this.Deleted = Deleted;
    }
    
}
