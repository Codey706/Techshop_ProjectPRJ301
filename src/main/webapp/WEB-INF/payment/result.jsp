<%-- 
    Document   : result
    Created on : Jun 23, 2026, 8:05:58 PM
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Payment Result</title>

        <style>

            body{
                font-family: Arial;
                margin:40px;
            }

            .container{
                width:650px;
                margin:auto;
                border:1px solid #ccc;
                border-radius:8px;
                padding:25px;
            }

            table{
                width:100%;
                border-collapse:collapse;
                margin-top:20px;
            }

            td{
                padding:10px;
                border-bottom:1px solid #eee;
            }

            .success{
                color:green;
                font-weight:bold;
            }

            .pending{
                color:orange;
                font-weight:bold;
            }

            .failed{
                color:red;
                font-weight:bold;
            }

            a{
                display:inline-block;
                margin-top:20px;
                padding:10px 18px;
                text-decoration:none;
                color:white;
                background:#2196F3;
                border-radius:5px;
            }

            a:hover{
                background:#0b7dda;
            }

        </style>

    </head>

    <body>

        <div class="container">

            <h2>Payment Result</h2>

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
                    <td><b>Total Amount</b></td>
                    <td>${order.totalAmount}</td>
                </tr>

                <tr>
                    <td><b>Payment Method</b></td>
                    <td>${payment.paymentMethod}</td>
                </tr>

                <tr>
                    <td><b>Transaction Code</b></td>
                    <td>${payment.transactionCode}</td>
                </tr>

                <tr>
                    <td><b>Payment Status</b></td>
                    <td>

                <c:choose>

                    <c:when test="${payment.status==1}">
                        <span class="success">
                            Payment Successful
                        </span>
                    </c:when>

                    <c:when test="${payment.status==0}">
                        <span class="pending">
                            Waiting For Payment
                        </span>
                    </c:when>

                    <c:otherwise>
                        <span class="failed">
                            Payment Failed
                        </span>
                    </c:otherwise>

                </c:choose>

                </td>
                </tr>

            </table>

            <a href="${pageContext.request.contextPath}/order">
                View My Orders
            </a>

            &nbsp;&nbsp;

            <a href="${pageContext.request.contextPath}/home">
                Back To Home
            </a>

        </div>

    </body>
</html>
