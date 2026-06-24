<%-- 
    Document   : register
    Created on : Jun 24, 2026, 10:09:10 AM
    Author     : Huynh Nhu Y
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Mirai Store - Sign Up</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/login.css">
    </head>

    <body>

        <div class="mirai-header">
            <img src="${pageContext.request.contextPath}/assets/images/logo.png?v=2" alt="Mirai Store">
            <span>Mirai <span style="font-weight: 400; color: #6c757d;">Store</span></span>
        </div>

        <div class="d-flex justify-content-center align-items-center flex-grow-1 my-3">

            <div class="login-card">

                <div class="logo-container">
                    <img src="${pageContext.request.contextPath}/assets/images/logo.png?v=2" 
                         alt="Logo" 
                         class="logo-img-center">
                </div>

                <h1 class="login-title">SIGN UP</h1>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger p-2 small mb-3 text-center">
                        ${error}
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/Auth" method="post">
                    <input type="hidden" name="action" value="register">

                    <div class="input-group custom-input mb-3">
                        <span class="input-group-text">
                            <i class="bi bi-person"></i> </span>
                        <input type="text"
                               class="form-control"
                               name="username"
                               placeholder="Username"
                               required>
                    </div>

                    <div class="input-group custom-input mb-3">
                        <span class="input-group-text">
                            <i class="bi bi-envelope"></i> </span>
                        <input type="email"
                               class="form-control"
                               name="email"
                               placeholder="Email Address"
                               required>
                    </div>

                    <div class="input-group custom-input mb-3">
                        <span class="input-group-text">
                            <i class="bi bi-lock"></i>
                        </span>
                        <input type="password"
                               class="form-control"
                               name="password"
                               placeholder="Password"
                               required>
                    </div>

                    <div class="input-group custom-input mb-4">
                        <span class="input-group-text">
                            <i class="bi bi-shield-lock"></i>
                        </span>
                        <input type="password"
                               class="form-control"
                               name="confirmPassword"
                               placeholder="Confirm Password"
                               required>
                    </div>

                    <button type="submit" class="btn login-btn w-100">
                        SIGN UP
                    </button>
                </form>

                <p class="text-center signup-text">
                    Already have an account?
                    <a href="${pageContext.request.contextPath}/Auth?view=login">Login here</a>
                </p>

            </div>
        </div>

        <div class="mirai-footer">
            &copy; 2026 <a href="#">Mirai Store</a>. All rights reserved.
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
