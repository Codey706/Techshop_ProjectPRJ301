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
import model.Vouchers;

/**
 *
 * @author HP
 */
public class AdminVoucherDAO extends DBContext {

    public List<Vouchers> getList() {
        List<Vouchers> list = new ArrayList<>();

        try {
            String sql = "select * from Vouchers "
                    + "order by VoucherId desc";

            PreparedStatement statement = this.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                Integer VoucherId = rs.getInt(1);
                String Code = rs.getString(2);
                BigDecimal DiscountPercent = rs.getBigDecimal(3);
                BigDecimal MinimumOrder = rs.getBigDecimal(4);
                Timestamp StartDate = rs.getTimestamp(5);
                Timestamp ExpireDate = rs.getTimestamp(6);
                Integer Quantity = rs.getInt(7);
                Integer UsedQuantity = rs.getInt(8);
                Integer Status = rs.getInt(9);
                Timestamp CreatedDate = rs.getTimestamp(10);

                Vouchers voucher = new Vouchers(VoucherId, Code, DiscountPercent, MinimumOrder,
                        StartDate, ExpireDate, Quantity, UsedQuantity, Status, CreatedDate);
                list.add(voucher);
            }
        } catch (SQLException ex) {
            Logger.getLogger(AdminVoucherDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public void updateVoucherStatus() {
        try {
            String sql = "UPDATE Vouchers "
                    + "SET Status = CASE "
                    + "WHEN CAST(GETDATE() AS DATE) BETWEEN CAST(StartDate AS DATE) "
                    + "AND CAST(ExpireDate AS DATE) "
                    + "THEN 1 "
                    + "ELSE 0 "
                    + "END";

            PreparedStatement statement = this.getConnection().prepareStatement(sql);
            statement.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(AdminVoucherDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public int getTotalPages() {

        int pageSize = 10;

        String sql = "SELECT COUNT(*) FROM Vouchers";

        try {

            PreparedStatement statement = this.getConnection().prepareStatement(sql);

            ResultSet rs = statement.executeQuery();

            if (rs.next()) {

                int totalVouchers = rs.getInt(1);

                int totalPages = totalVouchers / pageSize;

                if (totalVouchers % pageSize != 0) {
                    totalPages++;
                }

                return totalPages;
            }

        } catch (SQLException ex) {
            Logger.getLogger(AdminVoucherDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return 0;
    }

    public List<Vouchers> getVouchersByPage(int page) {

        List<Vouchers> list = new ArrayList<>();

        int pageSize = 10;

        String sql = "SELECT * FROM Vouchers "
                + "ORDER BY VoucherId DESC "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try {

            PreparedStatement statement = this.getConnection().prepareStatement(sql);

            statement.setInt(1, (page - 1) * pageSize);

            statement.setInt(2, pageSize);

            ResultSet rs = statement.executeQuery();

            while (rs.next()) {

                Integer VoucherId = rs.getInt(1);

                String Code = rs.getString(2);

                BigDecimal DiscountPercent = rs.getBigDecimal(3);

                BigDecimal MinimumOrder = rs.getBigDecimal(4);

                Timestamp StartDate = rs.getTimestamp(5);

                Timestamp ExpireDate = rs.getTimestamp(6);

                Integer Quantity = rs.getInt(7);

                Integer UsedQuantity = rs.getInt(8);

                Integer Status = rs.getInt(9);

                Timestamp CreatedDate = rs.getTimestamp(10);

                Vouchers voucher = new Vouchers(VoucherId, Code, DiscountPercent, MinimumOrder, StartDate, ExpireDate, Quantity, UsedQuantity, Status, CreatedDate);

                list.add(voucher);

            }

        } catch (SQLException ex) {

            Logger.getLogger(AdminVoucherDAO.class.getName()).log(Level.SEVERE, null, ex);

        }

        return list;
    }

}
