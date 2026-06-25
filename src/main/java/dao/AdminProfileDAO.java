/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import db.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.User;

/**
 *
 * @author ADMIN
 */
public class AdminProfileDAO extends DBContext {

    public User getProfile(int id) {

        String sql
                = "SELECT * FROM Users WHERE UserId=?";

        try {

            PreparedStatement ps
                    = getConnection()
                            .prepareStatement(sql);

            ps.setInt(1, id);

            ResultSet rs
                    = ps.executeQuery();

            if (rs.next()) {

                User u = new User();

                u.setUserId(
                        rs.getInt("UserId")
                );

                u.setRoleId(
                        rs.getInt("RoleId")
                );

                u.setUsername(
                        rs.getString("Username")
                );

                u.setFullName(
                        rs.getString("FullName")
                );

                u.setEmail(
                        rs.getString("Email")
                );

                u.setPhone(
                        rs.getString("Phone")
                );

                u.setGender(
                        rs.getString("Gender")
                );

                u.setAvatar(
                        rs.getString("Avatar")
                );

                return u;

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return null;

    }

    public void updateProfile(User u) {

        String sql
                = "UPDATE Users SET FullName=?, Email=?, Phone=?, Gender=? WHERE UserId=?";

        try {

            PreparedStatement ps
                    = getConnection()
                            .prepareStatement(sql);

            ps.setString(1, u.getFullName());

            ps.setString(2, u.getEmail());

            ps.setString(3, u.getPhone());

            ps.setString(4, u.getGender());

            ps.setInt(5, u.getUserId());

            ps.executeUpdate();

        } catch (Exception e) {

            e.printStackTrace();

        }

    }

}
