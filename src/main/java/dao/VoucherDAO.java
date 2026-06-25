package dao;


import db.DBContext;
import jakarta.resource.cci.ResultSet;
import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Vouchers;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author TRUC MAI
 */
public class VoucherDAO extends DBContext {

    // -------------------------------------------------------------------------
    // 1. Lấy danh sách voucher đang khả dụng
    // -------------------------------------------------------------------------

    public List<Vouchers> getAvailableVouchers() {
        List<Vouchers> list = new ArrayList<>();
        String sql = "SELECT VoucherId, Code, DiscountPercent, MinimumOrder, "
                   + "       StartDate, ExpireDate, Quantity, UsedQuantity, Status "
                   + "FROM Vouchers "
                   + "WHERE Status = 1 "
                   + "  AND StartDate  <= GETDATE() "
                   + "  AND ExpireDate >= GETDATE() "
                   + "  AND UsedQuantity < Quantity "
                   + "ORDER BY DiscountPercent DESC";
        try {
            PreparedStatement ps = this.getConnection().prepareStatement(sql);
            ResultSet rs = (ResultSet) ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException ex) {
            Logger.getLogger(VoucherDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    // -------------------------------------------------------------------------
    // 2. Tìm voucher theo mã code (không phân biệt hoa/thường)
    // -------------------------------------------------------------------------

    public Vouchers findByCode(String code) {
        String sql = "SELECT VoucherId, Code, DiscountPercent, MinimumOrder, "
                   + "       StartDate, ExpireDate, Quantity, UsedQuantity, Status "
                   + "FROM Vouchers WHERE UPPER(Code) = UPPER(?)";
        try {
            PreparedStatement ps = this.getConnection().prepareStatement(sql);
            ps.setString(1, code.trim());
            ResultSet rs = (ResultSet) ps.executeQuery();
            if (rs.next()) return mapRow(rs);
        } catch (SQLException ex) {
            Logger.getLogger(VoucherDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    // -------------------------------------------------------------------------
    // 3. Kết quả validate voucher
    // -------------------------------------------------------------------------

    public static class VoucherValidationResult {
        public boolean  valid;
        public String   errorMessage;
        public BigDecimal discountAmount;
        public Vouchers voucher;

        public VoucherValidationResult(boolean valid, String errorMessage,
                                       BigDecimal discountAmount, Vouchers voucher) {
            this.valid          = valid;
            this.errorMessage   = errorMessage;
            this.discountAmount = discountAmount;
            this.voucher        = voucher;
        }
    }

    // -------------------------------------------------------------------------
    // 4. Validate toàn bộ điều kiện voucher
    // -------------------------------------------------------------------------

    public VoucherValidationResult validateVoucher(String code, BigDecimal subtotal, int userId) {
        Vouchers v = findByCode(code);

        if (v == null)
            return fail("Mã giảm giá không tồn tại.");

        if (v.getStatus() != 1)
            return fail("Mã giảm giá đã bị vô hiệu hóa.");

        long now = System.currentTimeMillis();
        if (v.getStartDate() != null && v.getStartDate().getTime() > now)
            return fail("Mã giảm giá chưa đến thời gian áp dụng.");
        if (v.getExpireDate() != null && v.getExpireDate().getTime() < now)
            return fail("Mã giảm giá đã hết hạn.");

        if (v.getUsedQuantity() >= v.getQuantity())
            return fail("Mã giảm giá đã hết lượt sử dụng.");

        if (subtotal.compareTo(v.getMinimumOrder()) < 0)
            return fail("Đơn hàng tối thiểu "
                + String.format("%,.0f", v.getMinimumOrder())
                + "đ để áp dụng mã này.");

        if (hasUserUsedVoucher(userId, v.getVoucherId()))
            return fail("Bạn đã sử dụng mã giảm giá này rồi.");

        // Tính tiền giảm
        BigDecimal discount = subtotal
                .multiply(v.getDiscountPercent())
                .divide(new BigDecimal("100"));

        return new VoucherValidationResult(true, null, discount, v);
    }

    // -------------------------------------------------------------------------
    // 5. Kiểm tra user đã dùng voucher này chưa
    // -------------------------------------------------------------------------

    public boolean hasUserUsedVoucher(int userId, int voucherId) {
        String sql = "SELECT 1 FROM UserVoucher WHERE UserId = ? AND VoucherId = ?";
        try {
            PreparedStatement ps = this.getConnection().prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, voucherId);
            ResultSet rs = (ResultSet) ps.executeQuery();
            return rs.next();
        } catch (SQLException ex) {
            Logger.getLogger(VoucherDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    // -------------------------------------------------------------------------
    // 6. Đánh dấu đã dùng voucher (gọi khi tạo Order thành công)
    // -------------------------------------------------------------------------

    public boolean markVoucherUsed(int userId, int voucherId) {
        String sqlUpd = "UPDATE Vouchers SET UsedQuantity = UsedQuantity + 1 WHERE VoucherId = ?";
        String sqlIns = "INSERT INTO UserVoucher (UserId, VoucherId) VALUES (?, ?)";
        try {
            PreparedStatement psU = this.getConnection().prepareStatement(sqlUpd);
            psU.setInt(1, voucherId);
            psU.executeUpdate();

            PreparedStatement psI = this.getConnection().prepareStatement(sqlIns);
            psI.setInt(1, userId);
            psI.setInt(2, voucherId);
            psI.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(VoucherDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    // -------------------------------------------------------------------------
    // Helpers
    // -------------------------------------------------------------------------

    private Vouchers mapRow(ResultSet rs) throws SQLException {
        return new Vouchers(
            rs.getInt("VoucherId"),
            rs.getString("Code"),
            rs.getBigDecimal("DiscountPercent"),
            rs.getBigDecimal("MinimumOrder"),
            rs.getTimestamp("StartDate"),
            rs.getTimestamp("ExpireDate"),
            rs.getInt("Quantity"),
            rs.getInt("UsedQuantity"),
            rs.getInt("Status")
        );
    }

    private VoucherValidationResult fail(String msg) {
        return new VoucherValidationResult(false, msg, BigDecimal.ZERO, null);
    }
}

