<%-- 
    Document   : Profile
    Created on : Jun 24, 2026, 10:51:47 AM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>My Profile</title>
    </head>
    <body>
        <h2>My Profile</h2>


        <form 
            action="${pageContext.request.contextPath}/profile/update"
            method="post">



            Name:

            <input 
                type="text"
                name="name"
                value="${profile.fullName}">



            <br><br>



            Email:

            <input 
                type="text"
                name="email"
                value="${profile.email}">



            <br><br>



            Phone:

            <input 
                type="text"
                name="phone"
                value="${profile.phone}">



            <br><br>



            Gender:

            <input 
                type="text"
                name="gender"
                value="${profile.gender}">



            <br><br>



            <button type="submit">
                Save
            </button>



        </form>



    </body>

</html>
