package dao;

import db.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Auth;
import org.springframework.security.crypto.bcrypt.BCrypt;

public class AuthDAO {

    // ======================= LOGIN =======================
    public Auth login(String username, String password) {

        String sql = "SELECT * FROM Users WHERE Username = ? AND Status = 1";

        try {
            DBContext db = new DBContext();
            Connection con = db.getConnection();

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, username);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                String dbPassword = rs.getString("Password");
                boolean valid = false;

                // ===== Password đã là BCrypt =====
                if (dbPassword != null && dbPassword.startsWith("$2")) {

                    valid = BCrypt.checkpw(password, dbPassword);

                } // ===== Password cũ (plain text) =====
                else {

                    valid = password.equals(dbPassword);

                    // Đăng nhập đúng -> tự động nâng cấp sang BCrypt
                    if (valid) {

                        String newHash = BCrypt.hashpw(password, BCrypt.gensalt());

                        String updateSql = "UPDATE Users SET Password = ? WHERE UserID = ?";
                        PreparedStatement ups = con.prepareStatement(updateSql);
                        ups.setString(1, newHash);
                        ups.setInt(2, rs.getInt("UserID"));
                        ups.executeUpdate();
                    }
                }

                if (valid) {

                    Auth user = new Auth();

                    user.setUserId(rs.getInt("UserID"));
                    user.setUsername(rs.getString("Username"));
                    user.setFullName(rs.getString("FullName"));
                    user.setEmail(rs.getString("Email"));
                    user.setRoleId(rs.getInt("RoleID"));
                    user.setStatus(rs.getBoolean("Status"));
                    user.setRememberMeToken(rs.getString("RememberMeToken"));

                    return user;
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    // ======================= REMEMBER ME =======================
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

    // ======================= LOGIN WITH TOKEN =======================
    public Auth loginWithToken(String token) {

        String sql = "SELECT * FROM Users "
                + "WHERE RememberMeToken = ? "
                + "AND Status = 1";

        try {

            DBContext db = new DBContext();
            Connection con = db.getConnection();

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, token);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                Auth user = new Auth();

                user.setUserId(rs.getInt("UserID"));
                user.setRoleId(rs.getInt("RoleID"));
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

    // ======================= CHECK USERNAME =======================
    public boolean checkUsernameExist(String username) {

        String sql = "SELECT * FROM Users WHERE Username = ?";

        try {

            DBContext db = new DBContext();
            Connection con = db.getConnection();

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, username);

            ResultSet rs = ps.executeQuery();

            return rs.next();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    // ======================= CHECK EMAIL =======================
    public boolean checkEmailExist(String email) {

        String sql = "SELECT * FROM Users WHERE Email = ?";

        try {

            DBContext db = new DBContext();
            Connection con = db.getConnection();

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            return rs.next();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    // ======================= REGISTER =======================
    public boolean register(Auth user) {

        // Kiểm tra username
        if (checkUsernameExist(user.getUsername())) {
            return false;
        }

        // Kiểm tra email
        if (checkEmailExist(user.getEmail())) {
            return false;
        }

        String sql = "INSERT INTO Users "
                + "(Username, Password, FullName, Email, RoleID, Status) "
                + "VALUES (?, ?, ?, ?, ?, ?)";

        try {

            DBContext db = new DBContext();
            Connection con = db.getConnection();

            PreparedStatement ps = con.prepareStatement(sql);

            // Hash password trước khi lưu
            String hashedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());

            ps.setString(1, user.getUsername());
            ps.setString(2, hashedPassword);
            ps.setString(3, user.getFullName() != null ? user.getFullName() : user.getUsername());
            ps.setString(4, user.getEmail() != null ? user.getEmail() : (user.getUsername() + "@gmail.com"));
            ps.setInt(5, user.getRoleId() != 0 ? user.getRoleId() : 2);
            ps.setBoolean(6, true);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }
}
