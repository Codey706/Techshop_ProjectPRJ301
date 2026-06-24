<%-- 
    Document   : logout
    Created on : Jun 24, 2026, 10:35:20 AM
    Author     : Huynh Nhu Y
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mirai Store Logout</title>
    </head>
    <body>
        <a href="${pageContext.request.contextPath}/Auth?view=logout" class="btn btn-danger">
            <i class="bi bi-box-arrow-right"></i> Logout
        </a>
    </body>
</html>
