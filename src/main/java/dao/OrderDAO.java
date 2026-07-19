package dao;

import db.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import model.CartItem;
import model.OrderDetails;
import model.Orders;

public class OrderDAO extends DBContext {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    //==================================================
    // Tạo Order
    //==================================================
    public int createOrder(Orders order, List<CartItem> cartItems) {

        int orderId = -1;

        String sql = "INSERT INTO Orders("
                + "UserId,"
                + "VoucherId,"
                + "ProviderId,"
                + "AddressId,"
                + "OrderDate,"
                + "UpdatedAt,"
                + "Subtotal,"
                + "ShippingFee,"
                + "DiscountAmount,"
                + "TotalAmount,"
                + "ReceiverName,"
                + "Phone,"
                + "ShippingAddress,"
                + "Note,"
                + "Status,"
                + "PaymentStatus)"
                + " OUTPUT INSERTED.OrderId "
                + " VALUES(?,?,?,?,GETDATE(),GETDATE(),?,?,?,?,?,?,?,?,?,?)";

        try {

            conn = getConnection();

            ps = conn.prepareStatement(sql);

            ps.setObject(1, order.getUserId());

            ps.setObject(2, order.getVoucherId());

            ps.setObject(3, order.getProviderId());

            ps.setObject(4, order.getAddressId());

            ps.setBigDecimal(5, order.getSubtotal());

            ps.setBigDecimal(6, order.getShippingFee());

            ps.setBigDecimal(7, order.getDiscountAmount());

            ps.setBigDecimal(8, order.getTotalAmount());

            ps.setString(9, order.getReceiverName());

            ps.setString(10, order.getPhone());

            ps.setString(11, order.getShippingAddress());

            ps.setString(12, order.getNote());

            ps.setInt(13, order.getStatus());

            ps.setInt(14, order.getPaymentStatus());

            rs = ps.executeQuery();

            if (rs.next()) {

                orderId = rs.getInt(1);

                insertOrderDetails(orderId, cartItems);

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return orderId;

    }

    //==================================================
    // Thêm Order Details
    //==================================================
    public void insertOrderDetails(int orderId, List<CartItem> cartItems) {

        String sql = "INSERT INTO OrderDetails("
                + "OrderId,"
                + "VariantId,"
                + "Quantity,"
                + "UnitPrice,"
                + "SnapProductName,"
                + "SnapVariantName,"
                + "SnapVariantSKU,"
                + "SnapImageUrl,"
                + "SnapBrandName)"
                + " VALUES(?,?,?,?,?,?,?,?,?)";

        try {

            conn = getConnection();

            ps = conn.prepareStatement(sql);

            for (CartItem item : cartItems) {

                ps.setInt(1, orderId);

                ps.setInt(2, item.getVariantId());

                ps.setInt(3, item.getQuantity());

                ps.setBigDecimal(4, item.getPrice());

                ps.setString(5, item.getProductName());

                ps.setString(6, item.getVariantName());

                ps.setString(7, item.getVariantSKU());

                ps.setString(8, item.getImageUrl());

                ps.setString(9, "");

                ps.addBatch();

            }

            ps.executeBatch();

        } catch (Exception e) {

            e.printStackTrace();

        }

    }

    //==================================================
    // Lấy Order theo User
    //==================================================
    public List<Orders> getOrdersByUser(int userId) {

        List<Orders> list = new ArrayList<>();

        String sql = "SELECT * FROM Orders "
                + "WHERE UserId=? "
                + "ORDER BY OrderDate DESC";

        try {

            conn = getConnection();

            ps = conn.prepareStatement(sql);

            ps.setInt(1, userId);

            rs = ps.executeQuery();

            while (rs.next()) {

                Orders o = new Orders(
                        rs.getInt("OrderId"),
                        rs.getInt("UserId"),
                        rs.getObject("VoucherId") == null ? null : rs.getInt("VoucherId"),
                        rs.getObject("ProviderId") == null ? null : rs.getInt("ProviderId"),
                        rs.getObject("AddressId") == null ? null : rs.getInt("AddressId"),
                        rs.getTimestamp("OrderDate"),
                        rs.getTimestamp("UpdatedAt"),
                        rs.getBigDecimal("Subtotal"),
                        rs.getBigDecimal("ShippingFee"),
                        rs.getBigDecimal("DiscountAmount"),
                        rs.getBigDecimal("TotalAmount"),
                        rs.getString("ReceiverName"),
                        rs.getString("Phone"),
                        rs.getString("ShippingAddress"),
                        rs.getString("Note"),
                        rs.getInt("Status"),
                        rs.getInt("PaymentStatus"), null, null, null, null, null, null
                );

                list.add(o);

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return list;

    }

    //==================================================
    // Chi tiết đơn hàng
    //==================================================
    public List<OrderDetails> getOrderDetails(int orderId) {

        List<OrderDetails> list = new ArrayList<>();

        String sql = "SELECT * FROM OrderDetails WHERE OrderId=?";

        try {

            conn = getConnection();

            ps = conn.prepareStatement(sql);

            ps.setInt(1, orderId);

            rs = ps.executeQuery();

            while (rs.next()) {

                OrderDetails od = new OrderDetails(
                        rs.getInt("OrderDetailId"),
                        rs.getInt("OrderId"),
                        rs.getInt("VariantId"),
                        rs.getInt("Quantity"),
                        rs.getBigDecimal("UnitPrice"),
                        rs.getString("SnapProductName"),
                        rs.getString("SnapVariantName"),
                        rs.getString("SnapVariantSKU"),
                        rs.getString("SnapImageUrl"),
                        rs.getString("SnapBrandName")
                );

                list.add(od);

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return list;

    }

    //==================================================
    // Hủy đơn
    //==================================================
    public boolean cancelOrder(int orderId) {

        String sql = "UPDATE Orders "
                + "SET Status=4,"
                + "UpdatedAt=GETDATE() "
                + "WHERE OrderId=?";

        try {

            conn = getConnection();

            ps = conn.prepareStatement(sql);

            ps.setInt(1, orderId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();

        }

        return false;

    }
//==================================================
// Lấy 1 Order theo ID
//==================================================

    public Orders getOrderById(int orderId) {

        String sql = "SELECT * FROM Orders WHERE OrderId=?";

        try {

            conn = getConnection();

            ps = conn.prepareStatement(sql);

            ps.setInt(1, orderId);

            rs = ps.executeQuery();

            if (rs.next()) {

                return new Orders(
                        rs.getInt("OrderId"),
                        rs.getInt("UserId"),
                        rs.getObject("VoucherId") == null ? null : rs.getInt("VoucherId"),
                        rs.getObject("ProviderId") == null ? null : rs.getInt("ProviderId"),
                        rs.getObject("AddressId") == null ? null : rs.getInt("AddressId"),
                        rs.getTimestamp("OrderDate"),
                        rs.getTimestamp("UpdatedAt"),
                        rs.getBigDecimal("Subtotal"),
                        rs.getBigDecimal("ShippingFee"),
                        rs.getBigDecimal("DiscountAmount"),
                        rs.getBigDecimal("TotalAmount"),
                        rs.getString("ReceiverName"),
                        rs.getString("Phone"),
                        rs.getString("ShippingAddress"),
                        rs.getString("Note"),
                        rs.getInt("Status"),
                        rs.getInt("PaymentStatus"), null, null, null, null, null, null
                );

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return null;

    }
    //==================================================
// Cập nhật PaymentStatus của Order
//==================================================

    public boolean updatePaymentStatus(int orderId, int paymentStatus) {

        String sql = "UPDATE Orders "
                + "SET PaymentStatus = ?, UpdatedAt = GETDATE() "
                + "WHERE OrderId = ?";

        try {
            conn = getConnection();
            ps = conn.prepareStatement(sql);

            ps.setInt(1, paymentStatus);
            ps.setInt(2, orderId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}
