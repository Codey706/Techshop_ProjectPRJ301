/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import db.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Products;

/**
 *
 * @author HP
 */
public class AdminProductDAO extends DBContext {

    public List<Products> getList() {
        List<Products> list = new ArrayList<>();
        try {

            String sql = "select * from Products\n"
                    + "order by ProductId desc";

            PreparedStatement statement = this.getConnection().prepareStatement(sql);

            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                Integer ProductId = rs.getInt(1);
                Integer CategoryId = rs.getInt(2);
                Integer BrandId = rs.getInt(3);
                String BaseSKU = rs.getString(4);
                String ProductName = rs.getString(5);
                String Slug = rs.getString(6);
                Integer Views = rs.getInt(7);
                Integer Sold = rs.getInt(8);
                Boolean isFeatured = rs.getBoolean(9);
                Boolean isNew = rs.getBoolean(10);
                Boolean Deleted = rs.getBoolean(11);
                Integer Status = rs.getInt(12);
                String Description = rs.getString(13);
                Integer CreatedBy = rs.getInt(14);
                Timestamp PublishedAt = rs.getTimestamp(15);
                Timestamp CreatedAt = rs.getTimestamp(16);
                Timestamp UpdateAt = rs.getTimestamp(17);

                Products product = new Products(ProductId, CategoryId, BrandId, BaseSKU, ProductName, Slug, Views, Sold, isFeatured, isNew, Deleted, Status, Description, CreatedBy, PublishedAt, CreatedAt, UpdateAt);
                list.add(product);
            }

        } catch (SQLException ex) {
            Logger.getLogger(AdminProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
}
