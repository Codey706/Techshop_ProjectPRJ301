/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import db.DBContext;
import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Addresses;
import model.Brands;
import model.Categories;
import model.OrderDetails;
import model.Orders;
import model.Payment;
import model.ProductVariants;
import model.Products;
import model.ShippingProviders;
import model.User;
import model.Vouchers;

/**
 *
 * @author HP
 */
public class AdminOrderDAO extends DBContext {

    public List<Orders> getList(Integer status, String keyword) {
        List<Orders> list = new ArrayList<>();

        try {

            String sql = "SELECT o.*, "
                    + "u.FullName, "
                    + "a.Street, "
                    + "a.Province, "
                    + "a.District, "
                    + "a.Ward, "
                    + "sp.ProviderName, "
                    + "v.Code "
                    + "FROM Orders o "
                    + "INNER JOIN Users u ON o.UserId = u.UserId "
                    + "INNER JOIN Addresses a ON o.AddressId = a.AddressId "
                    + "INNER JOIN ShippingProviders sp ON o.ProviderId = sp.ProviderId "
                    + "LEFT JOIN Vouchers v ON o.VoucherId = v.VoucherId ";

            boolean hasWhere = false;

            if (status != null) {
                sql += " WHERE o.Status = ? ";
                hasWhere = true;
            }

            if (keyword != null && !keyword.trim().isEmpty()) {

                if (hasWhere) {
                    sql += " AND ";
                } else {
                    sql += " WHERE ";
                }

                sql += "(o.OrderId = TRY_CAST(? AS INT) "
                        + "OR u.FullName LIKE ?) ";
            }

            sql += "ORDER BY o.OrderId DESC";

            PreparedStatement ps = this.getConnection().prepareStatement(sql);

            int index = 1;

            if (status != null) {
                ps.setInt(index++, status);
            }

            if (keyword != null && !keyword.trim().isEmpty()) {
                ps.setString(index++, keyword);
                ps.setString(index++, "%" + keyword + "%");
            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Orders order = new Orders();

                // Orders
                order.setOrderId(rs.getInt("OrderId"));
                order.setUserId(rs.getInt("UserId"));

                if (rs.getObject("VoucherId") != null) {
                    order.setVoucherId(rs.getInt("VoucherId"));
                }

                order.setProviderId(rs.getInt("ProviderId"));
                order.setAddressId(rs.getInt("AddressId"));
                order.setOrderDate(rs.getTimestamp("OrderDate"));
                order.setUpdatedAt(rs.getTimestamp("UpdatedAt"));
                order.setSubtotal(rs.getBigDecimal("Subtotal"));
                order.setShippingFee(rs.getBigDecimal("ShippingFee"));
                order.setDiscountAmount(rs.getBigDecimal("DiscountAmount"));
                order.setTotalAmount(rs.getBigDecimal("TotalAmount"));
                order.setReceiverName(rs.getString("ReceiverName"));
                order.setPhone(rs.getString("Phone"));
                order.setShippingAddress(rs.getString("ShippingAddress"));
                order.setNote(rs.getString("Note"));
                order.setStatus(rs.getInt("Status"));
                order.setPaymentStatus(rs.getInt("PaymentStatus"));

                // User
                User user = new User();
                user.setUserId(rs.getInt("UserId"));
                user.setFullName(rs.getString("FullName"));
                order.setUser(user);

                // Address
                Addresses address = new Addresses();
                address.setAddressId(rs.getInt("AddressId"));
                address.setStreet(rs.getString("Street"));
                address.setWard(rs.getString("Ward"));
                address.setDistrict(rs.getString("District"));
                address.setProvince(rs.getString("Province"));
                order.setAddress(address);

                // Provider
                ShippingProviders provider = new ShippingProviders();
                provider.setProviderId(rs.getInt("ProviderId"));
                provider.setProviderName(rs.getString("ProviderName"));
                order.setProvider(provider);

                // Voucher
                if (rs.getObject("VoucherId") != null) {
                    Vouchers voucher = new Vouchers();
                    voucher.setVoucherId(rs.getInt("VoucherId"));
                    voucher.setCode(rs.getString("Code"));
                    order.setVoucher(voucher);
                }

                list.add(order);
            }

        } catch (SQLException ex) {
            Logger.getLogger(AdminOrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return list;
    }

    public int getTotalPages(Integer status, String keyword) {

        int pageSize = 10;

        String sql = "SELECT COUNT(*) "
                + "FROM Orders o "
                + "INNER JOIN Users u ON o.UserId = u.UserId ";

        boolean hasWhere = false;

        if (status != null) {
            sql += "WHERE o.Status = ? ";
            hasWhere = true;
        }

        if (keyword != null && !keyword.trim().isEmpty()) {

            if (hasWhere) {
                sql += "AND ";
            } else {
                sql += "WHERE ";
            }

            sql += "(o.OrderId = TRY_CAST(? AS INT) "
                    + "OR u.FullName LIKE ?) ";
        }

        try {

            PreparedStatement ps = getConnection().prepareStatement(sql);

            int index = 1;

            if (status != null) {
                ps.setInt(index++, status);
            }

            if (keyword != null && !keyword.trim().isEmpty()) {
                ps.setString(index++, keyword);
                ps.setString(index++, "%" + keyword + "%");
            }

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                int totalOrders = rs.getInt(1);

                int totalPages = totalOrders / pageSize;

                if (totalOrders % pageSize != 0) {
                    totalPages++;
                }

                return totalPages;
            }

        } catch (SQLException ex) {
            Logger.getLogger(AdminOrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return 0;
    }

    public List<Orders> getOrdersByPage(int page, Integer status, String keyword) {

        List<Orders> list = new ArrayList<>();

        int pageSize = 10;

        try {

            String sql = "SELECT o.*, "
                    + "u.FullName, "
                    + "a.Street, "
                    + "a.Province, "
                    + "a.District, "
                    + "a.Ward, "
                    + "sp.ProviderName, "
                    + "v.Code "
                    + "FROM Orders o "
                    + "INNER JOIN Users u ON o.UserId = u.UserId "
                    + "INNER JOIN Addresses a ON o.AddressId = a.AddressId "
                    + "INNER JOIN ShippingProviders sp ON o.ProviderId = sp.ProviderId "
                    + "LEFT JOIN Vouchers v ON o.VoucherId = v.VoucherId ";

            boolean hasWhere = false;

            if (status != null) {
                sql += "WHERE o.Status = ? ";
                hasWhere = true;
            }

            if (keyword != null && !keyword.trim().isEmpty()) {

                if (hasWhere) {
                    sql += "AND ";
                } else {
                    sql += "WHERE ";
                }

                sql += "(o.OrderId = TRY_CAST(? AS INT) "
                        + "OR u.FullName LIKE ?) ";
            }

            sql += "ORDER BY o.OrderId DESC "
                    + "OFFSET ? ROWS "
                    + "FETCH NEXT ? ROWS ONLY";

            PreparedStatement ps = getConnection().prepareStatement(sql);

            int index = 1;

            if (status != null) {
                ps.setInt(index++, status);
            }

            if (keyword != null && !keyword.trim().isEmpty()) {
                ps.setString(index++, keyword);
                ps.setString(index++, "%" + keyword + "%");
            }

            ps.setInt(index++, (page - 1) * pageSize);
            ps.setInt(index, pageSize);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Orders order = new Orders();

                order.setOrderId(rs.getInt("OrderId"));
                order.setUserId(rs.getInt("UserId"));

                if (rs.getObject("VoucherId") != null) {
                    order.setVoucherId(rs.getInt("VoucherId"));
                }

                order.setProviderId(rs.getInt("ProviderId"));
                order.setAddressId(rs.getInt("AddressId"));
                order.setOrderDate(rs.getTimestamp("OrderDate"));
                order.setUpdatedAt(rs.getTimestamp("UpdatedAt"));
                order.setSubtotal(rs.getBigDecimal("Subtotal"));
                order.setShippingFee(rs.getBigDecimal("ShippingFee"));
                order.setDiscountAmount(rs.getBigDecimal("DiscountAmount"));
                order.setTotalAmount(rs.getBigDecimal("TotalAmount"));
                order.setReceiverName(rs.getString("ReceiverName"));
                order.setPhone(rs.getString("Phone"));
                order.setShippingAddress(rs.getString("ShippingAddress"));
                order.setNote(rs.getString("Note"));
                order.setStatus(rs.getInt("Status"));
                order.setPaymentStatus(rs.getInt("PaymentStatus"));

                User user = new User();
                user.setUserId(rs.getInt("UserId"));
                user.setFullName(rs.getString("FullName"));
                order.setUser(user);

                Addresses address = new Addresses();
                address.setAddressId(rs.getInt("AddressId"));
                address.setStreet(rs.getString("Street"));
                address.setWard(rs.getString("Ward"));
                address.setDistrict(rs.getString("District"));
                address.setProvince(rs.getString("Province"));
                order.setAddress(address);

                ShippingProviders provider = new ShippingProviders();
                provider.setProviderId(rs.getInt("ProviderId"));
                provider.setProviderName(rs.getString("ProviderName"));
                order.setProvider(provider);

                if (rs.getObject("VoucherId") != null) {
                    Vouchers voucher = new Vouchers();
                    voucher.setVoucherId(rs.getInt("VoucherId"));
                    voucher.setCode(rs.getString("Code"));
                    order.setVoucher(voucher);
                }

                list.add(order);
            }

        } catch (SQLException ex) {
            Logger.getLogger(AdminOrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return list;
    }

    public Orders getOrderById(int id) {

        Orders order = null;

        try {

            String sql = "SELECT o.*, "
                    + "u.FullName, "
                    + "u.Email, "
                    + "a.Street, "
                    + "a.Ward, "
                    + "a.District, "
                    + "a.Province, "
                    + "sp.ProviderName, "
                    + "v.Code "
                    + "FROM Orders o "
                    + "INNER JOIN Users u ON o.UserId = u.UserId "
                    + "INNER JOIN Addresses a ON o.AddressId = a.AddressId "
                    + "INNER JOIN ShippingProviders sp ON o.ProviderId = sp.ProviderId "
                    + "LEFT JOIN Vouchers v ON o.VoucherId = v.VoucherId "
                    + "WHERE o.OrderId = ?";

            PreparedStatement ps = getConnection().prepareStatement(sql);
            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                order = new Orders();

                order.setOrderId(rs.getInt("OrderId"));
                order.setUserId(rs.getInt("UserId"));

                if (rs.getObject("VoucherId") != null) {
                    order.setVoucherId(rs.getInt("VoucherId"));
                }

                order.setProviderId(rs.getInt("ProviderId"));
                order.setAddressId(rs.getInt("AddressId"));
                order.setOrderDate(rs.getTimestamp("OrderDate"));
                order.setUpdatedAt(rs.getTimestamp("UpdatedAt"));
                order.setSubtotal(rs.getBigDecimal("Subtotal"));
                order.setShippingFee(rs.getBigDecimal("ShippingFee"));
                order.setDiscountAmount(rs.getBigDecimal("DiscountAmount"));
                order.setTotalAmount(rs.getBigDecimal("TotalAmount"));
                order.setReceiverName(rs.getString("ReceiverName"));
                order.setPhone(rs.getString("Phone"));
                order.setShippingAddress(rs.getString("ShippingAddress"));
                order.setNote(rs.getString("Note"));
                order.setStatus(rs.getInt("Status"));
                order.setPaymentStatus(rs.getInt("PaymentStatus"));

                User user = new User();
                user.setUserId(rs.getInt("UserId"));
                user.setFullName(rs.getString("FullName"));
                user.setEmail(rs.getString("Email"));
                order.setUser(user);

                Addresses address = new Addresses();
                address.setAddressId(rs.getInt("AddressId"));
                address.setStreet(rs.getString("Street"));
                address.setWard(rs.getString("Ward"));
                address.setDistrict(rs.getString("District"));
                address.setProvince(rs.getString("Province"));
                order.setAddress(address);

                ShippingProviders provider = new ShippingProviders();
                provider.setProviderId(rs.getInt("ProviderId"));
                provider.setProviderName(rs.getString("ProviderName"));
                order.setProvider(provider);

                if (rs.getObject("VoucherId") != null) {
                    Vouchers voucher = new Vouchers();
                    voucher.setVoucherId(rs.getInt("VoucherId"));
                    voucher.setCode(rs.getString("Code"));
                    order.setVoucher(voucher);
                }
                if (order != null) {
                    order.setOrderDetails(getOrderDetails(order.getOrderId()));
                    order.setPayment(getPaymentByOrderId(order.getOrderId()));
                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(AdminOrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return order;
    }

    public List<OrderDetails> getOrderDetails(int orderId) {

        List<OrderDetails> list = new ArrayList<>();

        try {

            String sql = "SELECT *\n"
                    + "FROM OrderDetails\n"
                    + "WHERE OrderId = ?";

            PreparedStatement ps = getConnection().prepareStatement(sql);
            ps.setInt(1, orderId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                OrderDetails detail = new OrderDetails();

                detail.setOrderDetailId(rs.getInt("OrderDetailId"));
                detail.setOrderId(rs.getInt("OrderId"));
                detail.setVariantId(rs.getInt("VariantId"));
                detail.setQuantity(rs.getInt("Quantity"));
                detail.setUnitPrice(rs.getBigDecimal("UnitPrice"));
                detail.setSnapProductName(rs.getString("SnapProductName"));
                detail.setSnapVariantName(rs.getString("SnapVariantName"));
                detail.setSnapVariantSKU(rs.getString("SnapVariantSKU"));
                detail.setSnapImageUrl(rs.getString("SnapImageUrl"));
                detail.setSnapBrandName(rs.getString("SnapBrandName"));

                list.add(detail);
            }

        } catch (SQLException ex) {
            Logger.getLogger(AdminOrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return list;
    }

    public Payment getPaymentByOrderId(int orderId) {

        Payment payment = null;

        try {

            String sql = "SELECT * FROM Payments WHERE OrderId = ?";

            PreparedStatement ps = getConnection().prepareStatement(sql);
            ps.setInt(1, orderId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                payment = new Payment();

                payment.setPaymentId(rs.getInt("PaymentId"));
                payment.setOrderId(rs.getInt("OrderId"));
                payment.setPaymentMethod(rs.getString("PaymentMethod"));
                payment.setAmount(rs.getBigDecimal("Amount"));
                payment.setCurrency(rs.getString("Currency"));
                payment.setTransactionCode(rs.getString("TransactionCode"));
                payment.setGatewayTransactionId(rs.getString("GatewayTransactionId"));
                payment.setBankCode(rs.getString("BankCode"));
                payment.setGatewayResponseCode(rs.getString("GatewayResponseCode"));
                payment.setPaymentUrl(rs.getString("PaymentUrl"));
                payment.setCallbackData(rs.getString("CallbackData"));
                payment.setSecureHash(rs.getString("SecureHash"));
                payment.setPaidDate(rs.getTimestamp("PaidDate"));
                payment.setExpiredTime(rs.getTimestamp("ExpiredTime"));
                payment.setStatus(rs.getInt("Status"));

            }

        } catch (SQLException ex) {
            Logger.getLogger(AdminOrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return payment;
    }

    public int updateStatus(int orderId, int status) {

        String sql = "UPDATE Orders SET Status = ? WHERE OrderId = ?";

        try {

            PreparedStatement st = this.getConnection().prepareStatement(sql);

            st.setInt(1, status);
            st.setInt(2, orderId);

            return st.executeUpdate();

        } catch (SQLException ex) {

            Logger.getLogger(AdminOrderDAO.class.getName()).log(Level.SEVERE, null, ex);

        }

        return 0;
    }

}
