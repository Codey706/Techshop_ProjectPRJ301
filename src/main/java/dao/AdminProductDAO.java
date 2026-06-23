/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import db.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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

            String sql = "select ProductId,\n"
                    + "ProductName,\n"
                    + "BaseSKU,\n"
                    + "Views,\n"
                    + "Sold,\n"
                    + "Status from Products\n"
                    + "order by ProductId desc";

            PreparedStatement statement = this.getConnection().prepareStatement(sql);

            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                Integer ProductId = rs.getInt(1);
                String BaseSKU = rs.getString(2);
                String ProductName = rs.getString(3);
                Integer Views = rs.getInt(4);
                Integer Sold = rs.getInt(5);
                Integer Status = rs.getInt(6);

                Products product = new Products(ProductId, null, null, BaseSKU, ProductName, null, Views, Sold, null, null, null, Status, null, null, null, null, null);
                list.add(product);
            }

        } catch (SQLException ex) {
            Logger.getLogger(AdminProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
}
