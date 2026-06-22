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
public class Orders {
    private Integer OrderId;
    private Integer UserId;
    private Integer VoucherId;
    private Integer ProviderId;
    private Integer AddressId;
    private Timestamp OrderDate;
    private Timestamp UpdatedAt;
    private BigDecimal Subtotal;
    private BigDecimal ShippingFee;
    private BigDecimal DiscountAmount;
    private BigDecimal TotalAmount;
    private String ReceiverName;
    private String Phone;
    private String ShippingAddress;
    private String Note;
    private Integer Status;
    private Integer PaymentStatus;

    public Orders() {
    }

    public Orders(Integer OrderId, Integer UserId, Integer VoucherId, Integer ProviderId, Integer AddressId, Timestamp OrderDate, Timestamp UpdatedAt, BigDecimal Subtotal, BigDecimal ShippingFee, BigDecimal DiscountAmount, BigDecimal TotalAmount, String ReceiverName, String Phone, String ShippingAddress, String Note, Integer Status, Integer PaymentStatus) {
        this.OrderId = OrderId;
        this.UserId = UserId;
        this.VoucherId = VoucherId;
        this.ProviderId = ProviderId;
        this.AddressId = AddressId;
        this.OrderDate = OrderDate;
        this.UpdatedAt = UpdatedAt;
        this.Subtotal = Subtotal;
        this.ShippingFee = ShippingFee;
        this.DiscountAmount = DiscountAmount;
        this.TotalAmount = TotalAmount;
        this.ReceiverName = ReceiverName;
        this.Phone = Phone;
        this.ShippingAddress = ShippingAddress;
        this.Note = Note;
        this.Status = Status;
        this.PaymentStatus = PaymentStatus;
    }

    public Integer getOrderId() {
        return OrderId;
    }

    public Integer getUserId() {
        return UserId;
    }

    public Integer getVoucherId() {
        return VoucherId;
    }

    public Integer getProviderId() {
        return ProviderId;
    }

    public Integer getAddressId() {
        return AddressId;
    }

    public Timestamp getOrderDate() {
        return OrderDate;
    }

    public Timestamp getUpdatedAt() {
        return UpdatedAt;
    }

    public BigDecimal getSubtotal() {
        return Subtotal;
    }

    public BigDecimal getShippingFee() {
        return ShippingFee;
    }

    public BigDecimal getDiscountAmount() {
        return DiscountAmount;
    }

    public BigDecimal getTotalAmount() {
        return TotalAmount;
    }

    public String getReceiverName() {
        return ReceiverName;
    }

    public String getPhone() {
        return Phone;
    }

    public String getShippingAddress() {
        return ShippingAddress;
    }

    public String getNote() {
        return Note;
    }

    public Integer getStatus() {
        return Status;
    }

    public Integer getPaymentStatus() {
        return PaymentStatus;
    }

    public void setOrderId(Integer OrderId) {
        this.OrderId = OrderId;
    }

    public void setUserId(Integer UserId) {
        this.UserId = UserId;
    }

    public void setVoucherId(Integer VoucherId) {
        this.VoucherId = VoucherId;
    }

    public void setProviderId(Integer ProviderId) {
        this.ProviderId = ProviderId;
    }

    public void setAddressId(Integer AddressId) {
        this.AddressId = AddressId;
    }

    public void setOrderDate(Timestamp OrderDate) {
        this.OrderDate = OrderDate;
    }

    public void setUpdatedAt(Timestamp UpdatedAt) {
        this.UpdatedAt = UpdatedAt;
    }

    public void setSubtotal(BigDecimal Subtotal) {
        this.Subtotal = Subtotal;
    }

    public void setShippingFee(BigDecimal ShippingFee) {
        this.ShippingFee = ShippingFee;
    }

    public void setDiscountAmount(BigDecimal DiscountAmount) {
        this.DiscountAmount = DiscountAmount;
    }

    public void setTotalAmount(BigDecimal TotalAmount) {
        this.TotalAmount = TotalAmount;
    }

    public void setReceiverName(String ReceiverName) {
        this.ReceiverName = ReceiverName;
    }

    public void setPhone(String Phone) {
        this.Phone = Phone;
    }

    public void setShippingAddress(String ShippingAddress) {
        this.ShippingAddress = ShippingAddress;
    }

    public void setNote(String Note) {
        this.Note = Note;
    }

    public void setStatus(Integer Status) {
        this.Status = Status;
    }

    public void setPaymentStatus(Integer PaymentStatus) {
        this.PaymentStatus = PaymentStatus;
    }
    
}
