<%-- 
    Document   : create
    Created on : Jun 23, 2026, 8:03:28 PM
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Create Order</title>

        <style>

            body{
                font-family: Arial;
                margin:40px;
            }

            table{
                width:100%;
                border-collapse:collapse;
                margin-bottom:20px;
            }

            table,th,td{
                border:1px solid #ccc;
            }

            th,td{
                padding:10px;
            }

            input,textarea{
                width:100%;
                padding:8px;
                margin-bottom:10px;
                box-sizing:border-box;
            }

            button{
                padding:10px 20px;
                background:#28a745;
                color:white;
                border:none;
                cursor:pointer;
            }

            button:hover{
                background:#218838;
            }

        </style>

    </head>

    <body>

        <h2>Checkout</h2>

        <table>

            <tr>
                <th>Product</th>
                <th>Variant</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Total</th>
            </tr>

            <c:forEach items="${cart}" var="item">

                <tr>

                    <td>${item.productName}</td>

                    <td>${item.variantName}</td>

                    <td>${item.price}</td>

                    <td>${item.quantity}</td>

                    <td>${item.lineTotal}</td>

                </tr>

            </c:forEach>

        </table>

        <h3>
            Subtotal:
            ${subtotal}
        </h3>

        <form action="${pageContext.request.contextPath}/order?action=create"
              method="post">

            <label>Receiver Name</label>

            <input type="text"
                   name="receiverName"
                   required>

            <label>Phone</label>

            <input type="text"
                   name="phone"
                   required>

            <label>Shipping Address</label>

            <textarea name="address"
                      rows="3"
                      required></textarea>

            <label>Note</label>

            <textarea name="note"
                      rows="3"></textarea>

            <button type="submit">
                Place Order
            </button>

        </form>

        <br>

        <a href="${pageContext.request.contextPath}/cart">
            Back to Cart
        </a>

    </body>
</html>