/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author ADMIN
 */
public class ReviewDAO {
    public void insertReview(
int userId,
int productId,
String content,
int rating
){


String sql =
"INSERT INTO reviews(user_id,product_id,content,rating)"
+" VALUES(?,?,?,?)";


}



public void updateReview(
int id,
String content
){

}



public void deleteReview(
int id
){

}


}