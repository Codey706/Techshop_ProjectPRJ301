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
public class Payment {

    private Integer paymentId;
    private Integer orderId;
    private String paymentMethod;
    private BigDecimal amount;
    private String currency;
    private String transactionCode;
    private String gatewayTransactionId;
    private String bankCode;
    private String gatewayResponseCode;
    private String paymentUrl;
    private String callbackData;
    private String secureHash;
    private Timestamp paidDate;
    private Timestamp expiredTime;
    private Integer status;

    public Payment() {
    }

    public Payment(Integer paymentId, Integer orderId, String paymentMethod,
            BigDecimal amount, String currency, String transactionCode,
            String gatewayTransactionId, String bankCode,
            String gatewayResponseCode, String paymentUrl,
            String callbackData, String secureHash,
            Timestamp paidDate, Timestamp expiredTime,
            Integer status) {

        this.paymentId = paymentId;
        this.orderId = orderId;
        this.paymentMethod = paymentMethod;
        this.amount = amount;
        this.currency = currency;
        this.transactionCode = transactionCode;
        this.gatewayTransactionId = gatewayTransactionId;
        this.bankCode = bankCode;
        this.gatewayResponseCode = gatewayResponseCode;
        this.paymentUrl = paymentUrl;
        this.callbackData = callbackData;
        this.secureHash = secureHash;
        this.paidDate = paidDate;
        this.expiredTime = expiredTime;
        this.status = status;
    }

    public Integer getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(Integer paymentId) {
        this.paymentId = paymentId;
    }

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public String getCurrency() {
        return currency;
    }

    public void setCurrency(String currency) {
        this.currency = currency;
    }

    public String getTransactionCode() {
        return transactionCode;
    }

    public void setTransactionCode(String transactionCode) {
        this.transactionCode = transactionCode;
    }

    public String getGatewayTransactionId() {
        return gatewayTransactionId;
    }

    public void setGatewayTransactionId(String gatewayTransactionId) {
        this.gatewayTransactionId = gatewayTransactionId;
    }

    public String getBankCode() {
        return bankCode;
    }

    public void setBankCode(String bankCode) {
        this.bankCode = bankCode;
    }

    public String getGatewayResponseCode() {
        return gatewayResponseCode;
    }

    public void setGatewayResponseCode(String gatewayResponseCode) {
        this.gatewayResponseCode = gatewayResponseCode;
    }

    public String getPaymentUrl() {
        return paymentUrl;
    }

    public void setPaymentUrl(String paymentUrl) {
        this.paymentUrl = paymentUrl;
    }

    public String getCallbackData() {
        return callbackData;
    }

    public void setCallbackData(String callbackData) {
        this.callbackData = callbackData;
    }

    public String getSecureHash() {
        return secureHash;
    }

    public void setSecureHash(String secureHash) {
        this.secureHash = secureHash;
    }

    public Timestamp getPaidDate() {
        return paidDate;
    }

    public void setPaidDate(Timestamp paidDate) {
        this.paidDate = paidDate;
    }

    public Timestamp getExpiredTime() {
        return expiredTime;
    }

    public void setExpiredTime(Timestamp expiredTime) {
        this.expiredTime = expiredTime;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

}
