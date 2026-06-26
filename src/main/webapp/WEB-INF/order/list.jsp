<%-- 
    Document   : list
    Created on : Jun 23, 2026, 8:03:16 PM
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>My Orders</title>

        <style>
            body{
                font-family: Arial;
                margin:40px;
            }

            table{
                width:100%;
                border-collapse:collapse;
            }

            table,th,td{
                border:1px solid #ccc;
            }

            th,td{
                padding:10px;
                text-align:center;
            }

            th{
                background:#f2f2f2;
            }

            a{
                text-decoration:none;
                padding:5px 10px;
                background:#2196F3;
                color:white;
                border-radius:4px;
            }

            a:hover{
                background:#0b7dda;
            }

            .cancel{
                background:red;
            }

            .cancel:hover{
                background:darkred;
            }

        </style>

    </head>

    <body>

        <h2>My Orders</h2>

        <table>

            <tr>
                <th>Order ID</th>
                <th>Receiver</th>
                <th>Phone</th>
                <th>Total</th>
                <th>Status</th>
                <th>Payment</th>
                <th>Action</th>
            </tr>

            <c:forEach items="${orders}" var="o">

                <tr>

                    <td>${o.orderId}</td>

                    <td>${o.receiverName}</td>

                    <td>${o.phone}</td>

                    <td>${o.totalAmount}</td>

                    <td>${o.status}</td>

                    <td>${o.paymentStatus}</td>

                    <td>

                        <a href="${pageContext.request.contextPath}/order?action=detail&id=${o.orderId}">
                            Detail
                        </a>

                        &nbsp;

                        <a class="cancel"
                           onclick="return confirm('Cancel this order?')"
                           href="${pageContext.request.contextPath}/order?action=cancel&id=${o.orderId}">
                            Cancel
                        </a>

                    </td>

                </tr>

            </c:forEach>

        </table>

        <br>

        <a href="${pageContext.request.contextPath}/home">
            Continue Shopping
        </a>

    </body>
</html>
