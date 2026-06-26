<%-- 
    Document   : list
    Created on : Jun 23, 2026, 8:05:30 PM
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Payment List</title>

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
                color:white;
                background:#2196F3;
                padding:6px 12px;
                border-radius:4px;
            }

            a:hover{
                background:#0b7dda;
            }

        </style>

    </head>

    <body>

        <h2>Payment List</h2>

        <table>

            <tr>
                <th>Payment ID</th>
                <th>Order ID</th>
                <th>Method</th>
                <th>Amount</th>
                <th>Currency</th>
                <th>Status</th>
                <th>Action</th>
            </tr>

            <c:forEach items="${payments}" var="p">

                <tr>

                    <td>${p.paymentId}</td>

                    <td>${p.orderId}</td>

                    <td>${p.paymentMethod}</td>

                    <td>${p.amount}</td>

                    <td>${p.currency}</td>

                    <td>

                <c:choose>

                    <c:when test="${p.status==1}">
                        Paid
                    </c:when>

                    <c:when test="${p.status==0}">
                        Pending
                    </c:when>

                    <c:otherwise>
                        Failed
                    </c:otherwise>

                </c:choose>

                </td>

                <td>

                    <a href="${pageContext.request.contextPath}/payment?action=result&orderId=${p.orderId}">
                        View
                    </a>

                </td>

                </tr>

            </c:forEach>

        </table>

        <br>

        <a href="${pageContext.request.contextPath}/home">
            Back Home
        </a>

    </body>
</html>