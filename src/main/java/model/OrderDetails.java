/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.math.BigDecimal;

/**
 *
 * @author HP
 */
public class OrderDetails {
    private Integer OrderDetailId;
    private Integer OrderId;
    private Integer VariantId;
    private Integer Quantity;
    private BigDecimal UnitPrice;
    private String SnapProductName;
    private String SnapVariantName;
    private String SnapVariantSKU;
    private String SnapImageUrl;
    private String SnapBrandName;

    public OrderDetails() {
    }

    public OrderDetails(Integer OrderDetailId, Integer OrderId, Integer VariantId, Integer Quantity, BigDecimal UnitPrice, String SnapProductName, String SnapVariantName, String SnapVariantSKU, String SnapImageUrl, String SnapBrandName) {
        this.OrderDetailId = OrderDetailId;
        this.OrderId = OrderId;
        this.VariantId = VariantId;
        this.Quantity = Quantity;
        this.UnitPrice = UnitPrice;
        this.SnapProductName = SnapProductName;
        this.SnapVariantName = SnapVariantName;
        this.SnapVariantSKU = SnapVariantSKU;
        this.SnapImageUrl = SnapImageUrl;
        this.SnapBrandName = SnapBrandName;
    }

    public Integer getOrderDetailId() {
        return OrderDetailId;
    }

    public Integer getOrderId() {
        return OrderId;
    }

    public Integer getVariantId() {
        return VariantId;
    }

    public Integer getQuantity() {
        return Quantity;
    }

    public BigDecimal getUnitPrice() {
        return UnitPrice;
    }

    public String getSnapProductName() {
        return SnapProductName;
    }

    public String getSnapVariantName() {
        return SnapVariantName;
    }

    public String getSnapVariantSKU() {
        return SnapVariantSKU;
    }

    public String getSnapImageUrl() {
        return SnapImageUrl;
    }

    public String getSnapBrandName() {
        return SnapBrandName;
    }

    public void setOrderDetailId(Integer OrderDetailId) {
        this.OrderDetailId = OrderDetailId;
    }

    public void setOrderId(Integer OrderId) {
        this.OrderId = OrderId;
    }

    public void setVariantId(Integer VariantId) {
        this.VariantId = VariantId;
    }

    public void setQuantity(Integer Quantity) {
        this.Quantity = Quantity;
    }

    public void setUnitPrice(BigDecimal UnitPrice) {
        this.UnitPrice = UnitPrice;
    }

    public void setSnapProductName(String SnapProductName) {
        this.SnapProductName = SnapProductName;
    }

    public void setSnapVariantName(String SnapVariantName) {
        this.SnapVariantName = SnapVariantName;
    }

    public void setSnapVariantSKU(String SnapVariantSKU) {
        this.SnapVariantSKU = SnapVariantSKU;
    }

    public void setSnapImageUrl(String SnapImageUrl) {
        this.SnapImageUrl = SnapImageUrl;
    }

    public void setSnapBrandName(String SnapBrandName) {
        this.SnapBrandName = SnapBrandName;
    }
    
}
