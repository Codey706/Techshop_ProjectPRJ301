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
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.CartItem;

/**
 *
 * @author TRUC MAI
 */
public class CartDAO extends DBContext {
    //1.Lay CardId theo UserId(tao moi neu chua co)

    //Tra ve CardId cuar useer. Neu user chua co cart thi tao moi vaf tra ve ID moi.
    public int getOrCreateCartId(int userId) {
        // Thử lấy cart cũ
        String sqlGet = "SELECT CartId FROM Cart WHERE UserId = ?";
        try {
            PreparedStatement ps = this.getConnection().prepareStatement(sqlGet);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("CartId");
            }
        } catch (SQLException ex) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        // Tạo cart mới
        String sqlInsert = "INSERT INTO Cart (UserId) OUTPUT INSERTED.CartId VALUES (?)";
        try {
            PreparedStatement ps = this.getConnection().prepareStatement(sqlInsert);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }

    /**
     * Lay toan bo san pham trong gio hang Join CartItems -> ProductVariants ->
     * Products de lay thong tin hien thi
     */
    public List<CartItem> getCartItems(int userId) {
        List<CartItem> list = new ArrayList<>();
        String sql = "SELECT ci.CartItemId, ci.CartId, ci.VariantId, ci.Quantity, "
                + "       p.ProductName, pv.VariantName, pv.VariantSKU, "
                + "       pv.ImageUrl, pv.Price, pv.OriginalPrice, pv.Stock "
                + "FROM Cart c "
                + "JOIN CartItems ci ON c.CartId = ci.CartId "
                + "JOIN ProductVariants pv ON ci.VariantId = pv.VariantId "
                + "JOIN Products p ON pv.ProductId = p.ProductId "
                + "WHERE c.UserId = ? "
                + "ORDER BY ci.CartItemId DESC";
        try {
            PreparedStatement ps = this.getConnection().prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                CartItem item = new CartItem(
                        rs.getInt("CartItemId"),
                        rs.getInt("CartId"),
                        rs.getInt("VariantId"),
                        rs.getInt("Quantity"),
                        rs.getString("ProductName"),
                        rs.getString("VariantName"),
                        rs.getString("VariantSKU"),
                        rs.getString("ImageUrl"),
                        rs.getBigDecimal("Price"),
                        rs.getBigDecimal("OriginalPrice"),
                        rs.getInt("Stock")
                );
                list.add(item);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    // 3. Thêm sản phẩm vào giỏ hàng
    /**
     * Them san pham vao gio. Neu variant da ton tai thi cong them quantity
     *
     * @return true neu thanh cong
     */
    public boolean addToCart(int userId, int variantId, int quantity) {
        int cartId = getOrCreateCartId(userId);
        if (cartId < 0) {
            return false;
        }

        // Kiem tra da co trong gio chua
        String sqlCheck = "SELECT CartItemId, Quantity FROM CartItems WHERE CartId = ? AND VariantId = ?";
        try {
            PreparedStatement ps = this.getConnection().prepareStatement(sqlCheck);
            ps.setInt(1, cartId);
            ps.setInt(2, variantId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                // Da co => cong them so luong
                int newQty = rs.getInt("Quantity") + quantity;
                String sqlUpdate = "UPDATE CartItems SET Quantity = ? WHERE CartItemId = ?";
                PreparedStatement psUp = this.getConnection().prepareStatement(sqlUpdate);
                psUp.setInt(1, newQty);
                psUp.setInt(2, rs.getInt("CartItemId"));
                psUp.executeUpdate();
            } else {
                // Chua => them moi
                String sqlInsert = "INSERT INTO CartItems (CartId, VariantId, Quantity) VALUES (?, ?, ?)";
                PreparedStatement psIn = this.getConnection().prepareStatement(sqlInsert);
                psIn.setInt(1, cartId);
                psIn.setInt(2, variantId);
                psIn.setInt(3, quantity);
                psIn.executeUpdate();
            }
            // Update
            updateCartTimestamp(cartId);
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    // 4. Cập nhật số lượng sản phẩm
    /**
     * Cap nhat so luong cua 1 san pham
     *
     * @param cartItemId ID của dong CartItem
     * @param quantity So luong moi (>=1)
     * @param userId Dung de kiem tra quyen so huu
     * @return true neu cap nhat thanh cong
     */
    public boolean updateQuantity(int cartItemId, int quantity, int userId) {
        if (quantity < 1) {
            return false;
        }
        // Chỉ update nếu CartItem thuộc về cart của đúng user này
        String sql = "UPDATE ci SET ci.Quantity = ? "
                + "FROM CartItems ci "
                + "JOIN Cart c ON ci.CartId = c.CartId "
                + "WHERE ci.CartItemId = ? AND c.UserId = ?";
        try {
            PreparedStatement ps = this.getConnection().prepareStatement(sql);
            ps.setInt(1, quantity);
            ps.setInt(2, cartItemId);
            ps.setInt(3, userId);
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException ex) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    // 5. Xóa sản phẩm khỏi giỏ hàng
    /**
     * Xoa 1 dong san pham. Kiem tra quyen so huu qua userId
     */
    public boolean removeItem(int cartItemId, int userId) {
        String sql = "DELETE ci FROM CartItems ci "
                + "JOIN Cart c ON ci.CartId = c.CartId "
                + "WHERE ci.CartItemId = ? AND c.UserId = ?";
        try {
            PreparedStatement ps = this.getConnection().prepareStatement(sql);
            ps.setInt(1, cartItemId);
            ps.setInt(2, userId);
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException ex) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    // 6. Tinh tong tien gio hang
    /**
     * Tinh subtotal (tong tien chua ap dung voucher) từ danh sach CartItem.
     */
    public BigDecimal calculateSubtotal(List<CartItem> items) {
        BigDecimal total = BigDecimal.ZERO;
        for (CartItem item : items) {
            total = total.add(item.getLineTotal());
        }
        return total;
    }

    // 7. Dem so san pham trong gio
    public int countCartItems(int userId) {
        String sql = "SELECT ISNULL(SUM(ci.Quantity), 0) "
                + "FROM Cart c JOIN CartItems ci ON c.CartId = ci.CartId "
                + "WHERE c.UserId = ?";
        try {
            PreparedStatement ps = this.getConnection().prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    // 8. Xoa toan bo gio hang sau khi dat hang thanh cong
    public boolean clearCart(int userId) {
        String sql = "DELETE ci FROM CartItems ci "
                + "JOIN Cart c ON ci.CartId = c.CartId "
                + "WHERE c.UserId = ?";
        try {
            PreparedStatement ps = this.getConnection().prepareStatement(sql);
            ps.setInt(1, userId);
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    // Helper

    private void updateCartTimestamp(int cartId) {
        String sql = "UPDATE Cart SET UpdatedAt = GETDATE() WHERE CartId = ?";
        try {
            PreparedStatement ps = this.getConnection().prepareStatement(sql);
            ps.setInt(1, cartId);
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
