<%-- 
    Document   : header
    Created on : Jun 22, 2026, 8:40:35 PM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Artist Page</title>
        <link rel="stylesheet" href="<%= request.getContextPath()%>/assets/css/bootstrap.css"/>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg">
            <div class="container-fluid">
                <a class="navbar-brand" href="#">Mirai Shop</a>

                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse justify-content-between" id="navbarNavDropdown">
                    <ul class="navbar-nav">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                Products
                            </a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="<%= request.getContextPath()%>/admin/product">View all products</a></li>
                                <li><a class="dropdown-item" href="<%= request.getContextPath()%>/admin/product?view=create">Add new products</a></li>
                            </ul>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link" href="<%= request.getContextPath()%>/admin/order">Orders</a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link" href="<%= request.getContextPath()%>/admin/order">Vouchers</a>
                        </li>
                    </ul>
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link" href="<%=request.getContextPath()%>/admin/login">Login</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        <main class="container mt-5">