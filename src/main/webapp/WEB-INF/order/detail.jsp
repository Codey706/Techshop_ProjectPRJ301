<%-- 
    Document   : detail
    Created on : Jun 23, 2026, 8:03:39 PM
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Order Detail</title>

        <style>

            body{
                font-family: Arial;
                margin:40px;
            }

            table{
                width:100%;
                border-collapse:collapse;
                margin-top:20px;
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

        </style>

    </head>

    <body>

        <h2>Order Detail</h2>

        <h3>Order Information</h3>

        <p><b>Order ID:</b> ${order.orderId}</p>

        <p><b>Receiver:</b> ${order.receiverName}</p>

        <p><b>Phone:</b> ${order.phone}</p>

        <p><b>Address:</b> ${order.shippingAddress}</p>

        <p><b>Note:</b> ${order.note}</p>

        <p><b>Subtotal:</b> ${order.subtotal}</p>

        <p><b>Shipping Fee:</b> ${order.shippingFee}</p>

        <p><b>Discount:</b> ${order.discountAmount}</p>

        <p><b>Total:</b> ${order.totalAmount}</p>

        <p><b>Status:</b> ${order.status}</p>

        <p><b>Payment Status:</b> ${order.paymentStatus}</p>

        <hr>

        <h3>Products</h3>

        <table>

            <tr>
                <th>Image</th>
                <th>Product</th>
                <th>Variant</th>
                <th>SKU</th>
                <th>Brand</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Total</th>
            </tr>

            <c:forEach items="${details}" var="d">

                <tr>

                    <td>
                        <img src="${d.snapImageUrl}"
                             width="80">
                    </td>

                    <td>${d.snapProductName}</td>

                    <td>${d.snapVariantName}</td>

                    <td>${d.snapVariantSKU}</td>

                    <td>${d.snapBrandName}</td>

                    <td>${d.unitPrice}</td>

                    <td>${d.quantity}</td>

                    <td>${d.unitPrice * d.quantity}</td>

                </tr>

            </c:forEach>

        </table>

        <br>

        <a href="${pageContext.request.contextPath}/order">
            Back to Orders
        </a>

    </body>
</html>