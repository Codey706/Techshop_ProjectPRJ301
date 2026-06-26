package dao;

import db.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Payment;

public class PaymentDAO extends DBContext {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    //====================================================
    // Tạo Payment mới
    //====================================================
    public boolean insertPayment(Payment payment) {

        String sql = "INSERT INTO Payment("
                + "OrderId,"
                + "PaymentMethod,"
                + "Amount,"
                + "Currency,"
                + "TransactionCode,"
                + "GatewayTransactionId,"
                + "BankCode,"
                + "GatewayResponseCode,"
                + "PaymentUrl,"
                + "CallbackData,"
                + "SecureHash,"
                + "PaidDate,"
                + "ExpiredTime,"
                + "Status)"
                + " VALUES(?,?,?,?,?,?,?,?,?,?,?,GETDATE(),NULL,?)";

        try {

            conn = getConnection();

            ps = conn.prepareStatement(sql);

            ps.setInt(1, payment.getOrderId());

            ps.setString(2, payment.getPaymentMethod());

            ps.setBigDecimal(3, payment.getAmount());

            ps.setString(4, payment.getCurrency());

            ps.setString(5, payment.getTransactionCode());

            ps.setString(6, payment.getGatewayTransactionId());

            ps.setString(7, payment.getBankCode());

            ps.setString(8, payment.getGatewayResponseCode());

            ps.setString(9, payment.getPaymentUrl());

            ps.setString(10, payment.getCallbackData());

            ps.setString(11, payment.getSecureHash());

            ps.setInt(12, payment.getStatus());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();

        }

        return false;

    }

    //====================================================
    // Lấy Payment theo Order
    //====================================================
    public Payment getPaymentByOrderId(int orderId) {

        String sql = "SELECT * FROM Payment WHERE OrderId=?";

        try {

            conn = getConnection();

            ps = conn.prepareStatement(sql);

            ps.setInt(1, orderId);

            rs = ps.executeQuery();

            if (rs.next()) {

                return new Payment(
                        rs.getInt("PaymentId"),
                        rs.getInt("OrderId"),
                        rs.getString("PaymentMethod"),
                        rs.getBigDecimal("Amount"),
                        rs.getString("Currency"),
                        rs.getString("TransactionCode"),
                        rs.getString("GatewayTransactionId"),
                        rs.getString("BankCode"),
                        rs.getString("GatewayResponseCode"),
                        rs.getString("PaymentUrl"),
                        rs.getString("CallbackData"),
                        rs.getString("SecureHash"),
                        rs.getTimestamp("PaidDate"),
                        rs.getTimestamp("ExpiredTime"),
                        rs.getInt("Status")
                );

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return null;

    }

    //====================================================
    // Lấy tất cả Payment
    //====================================================
    public List<Payment> getAllPayments() {

        List<Payment> list = new ArrayList<>();

        String sql = "SELECT * FROM Payment ORDER BY PaymentId DESC";

        try {

            conn = getConnection();

            ps = conn.prepareStatement(sql);

            rs = ps.executeQuery();

            while (rs.next()) {

                Payment p = new Payment(
                        rs.getInt("PaymentId"),
                        rs.getInt("OrderId"),
                        rs.getString("PaymentMethod"),
                        rs.getBigDecimal("Amount"),
                        rs.getString("Currency"),
                        rs.getString("TransactionCode"),
                        rs.getString("GatewayTransactionId"),
                        rs.getString("BankCode"),
                        rs.getString("GatewayResponseCode"),
                        rs.getString("PaymentUrl"),
                        rs.getString("CallbackData"),
                        rs.getString("SecureHash"),
                        rs.getTimestamp("PaidDate"),
                        rs.getTimestamp("ExpiredTime"),
                        rs.getInt("Status")
                );

                list.add(p);

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return list;

    }

    //====================================================
    // Cập nhật trạng thái thanh toán
    //====================================================
    public boolean updatePaymentStatus(int orderId, int status) {

        String sql = "UPDATE Payment SET Status=? WHERE OrderId=?";

        try {

            conn = getConnection();

            ps = conn.prepareStatement(sql);

            ps.setInt(1, status);

            ps.setInt(2, orderId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();

        }

        return false;
    }

}
