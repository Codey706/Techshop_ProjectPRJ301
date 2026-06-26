<%-- 
    Document   : cancel
    Created on : Jun 23, 2026, 8:04:41 PM
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Cancel Order</title>

        <style>

            body{
                font-family: Arial;
                text-align:center;
                margin-top:80px;
            }

            .box{
                width:500px;
                margin:auto;
                border:1px solid #ccc;
                padding:30px;
                border-radius:10px;
            }

            .btn{
                padding:10px 20px;
                text-decoration:none;
                color:white;
                border-radius:5px;
            }

            .yes{
                background:red;
            }

            .no{
                background:#2196F3;
            }

        </style>

    </head>

    <body>

        <div class="box">

            <h2>Cancel Order</h2>

            <p>
                Are you sure you want to cancel this order?
            </p>

            <br>

            <a class="btn yes"
               href="${pageContext.request.contextPath}/order?action=confirmCancel&id=${param.id}">
                Yes, Cancel
            </a>

            &nbsp;&nbsp;

            <a class="btn no"
               href="${pageContext.request.contextPath}/order">
                No
            </a>

        </div>

    </body>
</html>