<%-- 
    Document   : process
    Created on : Jun 23, 2026, 8:05:47 PM
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Payment</title>

        <style>

            body{
                font-family: Arial;
                margin:40px;
            }

            .container{
                width:600px;
                margin:auto;
                border:1px solid #ccc;
                padding:20px;
                border-radius:8px;
            }

            table{
                width:100%;
                margin-bottom:20px;
            }

            td{
                padding:8px;
            }

            button{
                padding:10px 20px;
                background:#28a745;
                color:white;
                border:none;
                cursor:pointer;
                border-radius:5px;
            }

            button:hover{
                background:#218838;
            }

        </style>

    </head>

    <body>

        <div class="container">

            <h2>Payment</h2>

            <table>

                <tr>
                    <td><b>Order ID</b></td>
                    <td>${order.orderId}</td>
                </tr>

                <tr>
                    <td><b>Receiver</b></td>
                    <td>${order.receiverName}</td>
                </tr>

                <tr>
                    <td><b>Phone</b></td>
                    <td>${order.phone}</td>
                </tr>

                <tr>
                    <td><b>Address</b></td>
                    <td>${order.shippingAddress}</td>
                </tr>

                <tr>
                    <td><b>Total Amount</b></td>
                    <td>${order.totalAmount}</td>
                </tr>

            </table>

            <form action="${pageContext.request.contextPath}/payment?action=process"
                  method="post">

                <input type="hidden"
                       name="orderId"
                       value="${order.orderId}">

                <h3>Select Payment Method</h3>

                <input type="radio"
                       name="paymentMethod"
                       value="COD"
                       checked>

                Cash On Delivery (COD)

                <br><br>

                <input type="radio"
                       name="paymentMethod"
                       value="VNPAY">

                VNPay (Coming Soon)

                <br><br>

                <button type="submit">
                    Confirm Payment
                </button>

            </form>

        </div>

    </body>
</html>