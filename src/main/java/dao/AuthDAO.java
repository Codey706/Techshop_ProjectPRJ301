package dao;

import db.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Auth;

/**
 *
 * @author Huynh Nhu Y
 */
public class AuthDAO {

    public Auth login(String username, String password) {

        String sql = "SELECT * FROM Users "
                + "WHERE Username = ? "
                + "AND Password = ? "
                + "AND Status = 1";

        try {
            DBContext db = new DBContext();
            Connection con = db.getConnection();

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Auth user = new Auth();

                user.setUserId(rs.getInt("UserID"));
                user.setUsername(rs.getString("Username"));
                user.setPassword(rs.getString("Password"));
                user.setFullName(rs.getString("FullName"));
                user.setEmail(rs.getString("Email"));
                user.setRoleId(rs.getInt("RoleID"));
                user.setStatus(rs.getBoolean("Status"));
                user.setRememberMeToken(rs.getString("RememberMeToken"));

                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    /**
     * Cập nhật chuỗi Token ghi nhớ đăng nhập cho người dùng
     *
     * @param userId
     * @param token
     * @return
     */
    public boolean updateRememberMeToken(int userId, String token) {
        String sql = "UPDATE Users SET RememberMeToken = ? WHERE UserID = ?";
        try {
            DBContext db = new DBContext();
            Connection con = db.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, token);
            ps.setInt(2, userId);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Tự động đăng nhập bằng Token (đọc từ Cookie của trình duyệt gửi lên)
     */
    public Auth loginWithToken(String token) {
        String sql = "SELECT * FROM Users WHERE RememberMeToken = ? AND Status = 1";
        try {
            DBContext db = new DBContext();
            Connection con = db.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, token);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Auth user = new Auth();
                user.setUserId(rs.getInt("UserId"));
                user.setRoleId(rs.getInt("RoleId"));
                user.setUsername(rs.getString("Username"));
                user.setFullName(rs.getString("FullName"));
                user.setEmail(rs.getString("Email"));
                user.setStatus(rs.getBoolean("Status"));
                user.setRememberMeToken(rs.getString("RememberMeToken"));
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean checkUsernameExist(String username) {
        String sql = "SELECT * FROM Users WHERE Username = ?";
        try {
            DBContext db = new DBContext();
            Connection con = db.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return true; // Tìm thấy tài khoản trùng tên
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean checkEmailExist(String email) {
        String sql = "SELECT * FROM Users WHERE Email = ?";
        try {
            DBContext db = new DBContext();
            Connection con = db.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return true; // Tìm thấy email đã được sử dụng
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean register(Auth user) {
        // Trước khi chèn, kiểm tra xem tài khoản đã tồn tại chưa
        if (checkUsernameExist(user.getUsername())) {
            return false;
        }

        // Câu lệnh INSERT (Mặc định RoleID = 2 cho Customer/User thường và Status = 1 là Active)
        String sql = "INSERT INTO Users (Username, Password, FullName, Email, RoleID, Status) "
                + "VALUES (?, ?, ?, ?, ?, ?)";

        try {
            DBContext db = new DBContext();
            Connection con = db.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());

            // Nếu form đăng ký chưa truyền FullName và Email, tạm thời gán bằng chính Username hoặc giá trị mặc định
            ps.setString(3, user.getFullName() != null ? user.getFullName() : user.getUsername());
            ps.setString(4, user.getEmail() != null ? user.getEmail() : (user.getUsername() + "@gmail.com"));

            // Gán RoleID: Ví dụ mặc định là 2 (tài khoản người dùng/khách hàng)
            ps.setInt(5, user.getRoleId() != 0 ? user.getRoleId() : 2);

            // Gán Status: Mặc định là 1 (Active) tức là true
            ps.setBoolean(6, true);

            int result = ps.executeUpdate();
            return result > 0; // Trả về true nếu chèn thành công ít nhất 1 dòng

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
