<%-- 
    Document   : header.jsp
    Created on : Oct 4, 2023, 10:21:56 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<style>
    #notiForm {
        position: absolute;
        top: 0;
        right: 18%;
        z-index: 9999;
    }
    .button {
        transition: transform 0.3s, filter 0.3s;
    }

    .button:hover {
        transform: scale(1.05); /* Hiệu ứng nổi lên khi di chuột vào */
        filter: brightness(90%); /* Màu tối đi khi di chuột vào */
    }
    a.button.btn.btn-light.border-0.rounded-pill.button_in_header {
        background-color: black;
        color: white;
    }
    .container-fluid.d-flex.justify-content-center {
        background-color: #24202c;
        color: white;
    }
</style>
<header>
    <title>ADMIN | DOCA</title>
    <c:set var="Owner" value="${sessionScope.USER_NAME}"/>
    <form action="DispatchServlet" method="post">
        <nav class="navbar navbar-dark navbar-expand-sm fixed-top navbar-color p-0 header">
            <div class="container-fluid d-flex justify-content-center">
                <nav class="navbar navbar-light">
                    <a class="navbar-brand" href="#">
                        <img src="assets/images/logo.png" class="rounded-circle" width="100px" height="100px" alt="">
                    </a>
                </nav>
                <div class="container-fluid d-flex justify-content-between navbar-contain mt-5   ">
                    <h1>Trang quản lý </h1>
                    <div>
                        <a class="button btn btn-light border-0 rounded-pill button_in_header" href="#" role="button" onclick="toggleMenuForm()">
                            <img src="${Owner.avatar}"
                                 alt="Profile Image"
                                 class="rounded-circle profile-image" 
                                 style="width: 30px; height: 30px;">
                            ${Owner.userName}
                        </a>
                        <a class="button btn btn-light border-0 rounded-pill button_in_header" href="LogOutServlet" role="button" onclick="toggleMenuForm()">
                            logout
                        </a>
                    </div>
                </div>
            </div>

        </nav>
    </form>

</header>


