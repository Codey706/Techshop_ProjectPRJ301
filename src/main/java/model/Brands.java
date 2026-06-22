/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author HP
 */
public class Brands {
    private Integer BrandId;
    private String BrandName;
    private String Logo;
    private String Country;
    private String Description;
    private Boolean Status;
    private Boolean Deleted;

    public Brands() {
    }

    public Brands(Integer BrandId, String BrandName, String Logo, String Country, String Description, Boolean Status, Boolean Deleted) {
        this.BrandId = BrandId;
        this.BrandName = BrandName;
        this.Logo = Logo;
        this.Country = Country;
        this.Description = Description;
        this.Status = Status;
        this.Deleted = Deleted;
    }

    public Integer getBrandId() {
        return BrandId;
    }

    public String getBrandName() {
        return BrandName;
    }

    public String getLogo() {
        return Logo;
    }

    public String getCountry() {
        return Country;
    }

    public String getDescription() {
        return Description;
    }

    public Boolean isStatus() {
        return Status;
    }

    public Boolean isDeleted() {
        return Deleted;
    }

    public void setBrandId(Integer BrandId) {
        this.BrandId = BrandId;
    }

    public void setBrandName(String BrandName) {
        this.BrandName = BrandName;
    }

    public void setLogo(String Logo) {
        this.Logo = Logo;
    }

    public void setCountry(String Country) {
        this.Country = Country;
    }

    public void setDescription(String Description) {
        this.Description = Description;
    }

    public void setStatus(Boolean Status) {
        this.Status = Status;
    }

    public void setDeleted(Boolean Deleted) {
        this.Deleted = Deleted;
    }
    
}
