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
import model.Orders;

/**
 *
 * @author HP
 */
public class AdminOrderDAO extends DBContext {

    public List<Orders> getList() {
        List<Orders> list = new ArrayList<>();

        try {
            String sql = "select * from Orders "
                    + "order by OrderId desc";

            PreparedStatement statement = this.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                Integer OrderId = rs.getInt(1);
                Integer UserId = rs.getInt(2);
                Integer VoucherId = rs.getInt(3);
                Integer ProviderId = rs.getInt(4);
                Integer AddressId = rs.getInt(5);
                Timestamp OrderDate = rs.getTimestamp(6);
                Timestamp UpdatedAt = rs.getTimestamp(7);
                BigDecimal Subtotal = rs.getBigDecimal(8);
                BigDecimal ShippingFee = rs.getBigDecimal(9);
                BigDecimal DiscountAmount = rs.getBigDecimal(10);
                BigDecimal TotalAmount = rs.getBigDecimal(11);
                String ReceiverName = rs.getString(12);
                String Phone = rs.getString(13);
                String ShippingAddress = rs.getString(14);
                String Note = rs.getString(15);
                Integer Status = rs.getInt(16);
                Integer PaymentStatus = rs.getInt(17);

                Orders order = new Orders(OrderId, UserId, VoucherId, ProviderId, AddressId, OrderDate, UpdatedAt,
                        Subtotal, ShippingFee, DiscountAmount, TotalAmount, ReceiverName, Phone, ShippingAddress,
                        Note, Status, PaymentStatus);
                list.add(order);
            }
        } catch (SQLException ex) {
            Logger.getLogger(AdminOrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

}
