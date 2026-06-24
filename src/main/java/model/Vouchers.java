/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.math.BigDecimal;
import java.sql.Timestamp;

/**
 *
 * @author HP
 */
public class Vouchers {

    private Integer VoucherId;
    private String Code;
    private BigDecimal DiscountPercent;
    private BigDecimal MinimumOrder;
    private Timestamp StartDate;
    private Timestamp ExpireDate;
    private Integer Quantity;
    private Integer UsedQuantity;
    private Integer Status;

    public Vouchers() {
    }

    public Vouchers(Integer VoucherId, String Code, BigDecimal DiscountPercent, BigDecimal MinimumOrder, Timestamp StartDate, Timestamp ExpireDate, Integer Quantity, Integer UsedQuantity, Integer Status) {
        this.VoucherId = VoucherId;
        this.Code = Code;
        this.DiscountPercent = DiscountPercent;
        this.MinimumOrder = MinimumOrder;
        this.StartDate = StartDate;
        this.ExpireDate = ExpireDate;
        this.Quantity = Quantity;
        this.UsedQuantity = UsedQuantity;
        this.Status = Status;
    }

    public Integer getVoucherId() {
        return VoucherId;
    }

    public String getCode() {
        return Code;
    }

    public BigDecimal getDiscountPercent() {
        return DiscountPercent;
    }

    public BigDecimal getMinimumOrder() {
        return MinimumOrder;
    }

    public Timestamp getStartDate() {
        return StartDate;
    }

    public Timestamp getExpireDate() {
        return ExpireDate;
    }

    public Integer getQuantity() {
        return Quantity;
    }

    public Integer getUsedQuantity() {
        return UsedQuantity;
    }

    public Integer getStatus() {
        return Status;
    }

    public void setVoucherId(Integer VoucherId) {
        this.VoucherId = VoucherId;
    }

    public void setCode(String Code) {
        this.Code = Code;
    }

    public void setDiscountPercent(BigDecimal DiscountPercent) {
        this.DiscountPercent = DiscountPercent;
    }

    public void setMinimumOrder(BigDecimal MinimumOrder) {
        this.MinimumOrder = MinimumOrder;
    }

    public void setStartDate(Timestamp StartDate) {
        this.StartDate = StartDate;
    }

    public void setExpireDate(Timestamp ExpireDate) {
        this.ExpireDate = ExpireDate;
    }

    public void setQuantity(Integer Quantity) {
        this.Quantity = Quantity;
    }

    public void setUsedQuantity(Integer UsedQuantity) {
        this.UsedQuantity = UsedQuantity;
    }

    public void setStatus(Integer Status) {
        this.Status = Status;
    }

}
