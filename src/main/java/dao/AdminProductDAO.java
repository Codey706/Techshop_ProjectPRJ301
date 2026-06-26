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
import model.Brands;
import model.Categories;
import model.ProductImages;
import model.Products;

/**
 *
 * @author HP
 */
public class AdminProductDAO extends DBContext {

    public List<Products> getList() {
        List<Products> list = new ArrayList<>();
        try {

            String sql = "SELECT p.ProductId, p.ProductName, p.BaseSKU, "
                    + "c.CategoryName, b.BrandName, p.[Status], p.Sold, p.[Views], "
                    + "pi.ImageUrl "
                    + "FROM Products p "
                    + "JOIN Categories c ON p.CategoryId = c.CategoryId "
                    + "JOIN Brands b ON p.BrandId = b.BrandId "
                    + "JOIN ProductImages pi ON p.ProductId = pi.ProductId AND pi.IsThumbnail = 1 "
                    + "ORDER BY p.ProductId DESC";
            PreparedStatement statement = this.getConnection().prepareStatement(sql);

            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                Integer productId = rs.getInt(1);
                String productName = rs.getString(2);
                String baseSKU = rs.getString(3);
                String categoryName = rs.getString(4);
                String brandName = rs.getString(5);

                Integer status = rs.getInt(6);
                Integer sold = rs.getInt(7);
                Integer views = rs.getInt(8);
                String imageUrl = rs.getString(9);

                ProductImages product_img = new ProductImages(null, null, imageUrl, null, null, null, null, null);
                Brands brand = new Brands(null, brandName, null, null, null, null, null);
                Categories category = new Categories(null, categoryName, null, null, null);
                Products product = new Products(productId, null, null, baseSKU, productName, null, views, sold, null, null, null, status, null, null, null, null, null, category, brand, product_img);
                list.add(product);
            }

        } catch (SQLException ex) {
            Logger.getLogger(AdminProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
}
