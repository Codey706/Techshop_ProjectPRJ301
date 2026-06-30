<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>

    <head>

        <title>My Profile - Mirai Store</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" 
              rel="stylesheet">

        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
              rel="stylesheet">


        <style>


            body{
                background:#f8f9fc;
                font-family:'Segoe UI',sans-serif;
            }



            .profile-box{

                width:850px;
                margin:50px auto;

            }



            .profile-header{

                background:linear-gradient(135deg,#0056b3,#00a8ff);
                height:180px;
                border-radius:25px 25px 0 0;
                position:relative;

            }



            .avatar{

                width:120px;
                height:120px;

                background:white;

                border-radius:50%;

                position:absolute;

                bottom:-60px;
                left:50%;
                transform:translateX(-50%);

                display:flex;
                justify-content:center;
                align-items:center;

                font-size:50px;
                font-weight:bold;

                color:#0056b3;

                box-shadow:0 5px 15px #999;

            }




            .card-custom{

                border:none;
                border-radius:25px;

                box-shadow:0 10px 30px rgba(0,0,0,.1);

                overflow:hidden;

            }



            .content{

                padding:80px 60px 40px;

            }



            h2{

                color:#0056b3;
                font-weight:700;

            }




            .form-control{

                border-radius:12px;
                padding:12px;

            }



            label{

                font-weight:600;

            }




            .btn-main{

                background:#0056b3;
                color:white;

                border-radius:12px;

                padding:10px 35px;

            }



            .btn-main:hover{

                background:#003d80;
                color:white;

            }


            .password-title{

                margin-top:40px;

            }



        </style>


    </head>


    <body>



        <div class="profile-box">


            <div class="card-custom">



                <div class="profile-header">


                    <div class="avatar">

                        ${profile.username.substring(0,1)}

                    </div>


                </div>




                <div class="content">



                    <h2 class="text-center mb-4">

                        <i class="bi bi-person-circle"></i>

                        My Profile

                    </h2>



                    <c:if test="${not empty sessionScope.message}">

                        <div class="alert alert-success text-center">

                            ${sessionScope.message}

                        </div>

                        <c:remove var="message" scope="session"/>

                    </c:if>



                    <c:if test="${not empty sessionScope.error}">

                        <div class="alert alert-danger text-center">

                            ${sessionScope.error}

                        </div>

                        <c:remove var="error" scope="session"/>

                    </c:if>





                    <form action="${pageContext.request.contextPath}/profile/update"
                          method="post">



                        <div class="row">


                            <div class="col-md-6 mb-3">

                                <label>

                                    Username

                                </label>

                                <input class="form-control"
                                       value="${profile.username}"
                                       readonly>


                            </div>



                            <div class="col-md-6 mb-3">

                                <label>

                                    Full name

                                </label>

                                <input class="form-control"
                                       name="name"
                                       value="${profile.fullName}">


                            </div>




                            <div class="col-md-6 mb-3">

                                <label>

                                    Email

                                </label>

                                <input class="form-control"
                                       name="email"
                                       value="${profile.email}">


                            </div>




                            <div class="col-md-6 mb-3">

                                <label>

                                    Phone

                                </label>


                                <input class="form-control"
                                       name="phone"
                                       value="${profile.phone}">


                            </div>



                            <div class="col-md-6 mb-3">

                                <label>

                                    Gender

                                </label>

                                <select class="form-control" name="gender">


                                    <option>${profile.gender}</option>

                                    <option>Male</option>

                                    <option>Female</option>


                                </select>


                            </div>



                        </div>



                        <div class="text-center mt-3">

                            <button class="btn btn-main">

                                <i class="bi bi-save"></i>

                                Save Changes

                            </button>


                        </div>


                    </form>





                    <hr>



                    <h4 class="password-title">

                        <i class="bi bi-shield-lock"></i>

                        Change Password

                    </h4>



                    <form action="${pageContext.request.contextPath}/profile/change-password"
                          method="post">



                        <div class="row">


                            <div class="col-md-6">


                                <label>

                                    Old password

                                </label>


                                <input type="password"
                                       class="form-control"
                                       name="oldPassword">


                            </div>




                            <div class="col-md-6">


                                <label>

                                    New password

                                </label>


                                <input type="password"
                                       class="form-control"
                                       name="newPassword">


                            </div>


                        </div>



                        <div class="text-center mt-4">


                            <button class="btn btn-danger px-4">

                                Change Password

                            </button>


                        </div>



                    </form>



                </div>



            </div>


        </div>



    </body>

</html>