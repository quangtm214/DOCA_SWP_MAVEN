<%-- 
    Document   : notification
    Created on : Nov 1, 2023, 2:42:03 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>
        <!-- Required meta tags always come first -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <!-- Bootstrap CSS -->
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> 

        <title>Forum</title>
        <!-- Link Iconn  -->
        <link rel="stylesheet" href="fontawesome-free-6.4.2-web/css/fontawesome.css"> 
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

        <!-- jQuery first, then Popper.js, then Bootstrap JS. -->

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>

        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>


        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>


        <!--  -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>

        <!-- Link CSS -->
        <style>
            .dropdown {
                display:inline-block;
                margin-left:20px;
                padding:10px;
            }


            .glyphicon-bell {

                font-size:1.5rem;
            }

            .notifications {
                min-width:420px;
            }

            .notifications-wrapper {
                overflow:auto;
                max-height:250px;
            }

            .menu-title {
                color:#ff7788;
                font-size:1.5rem;
                display:inline-block;
            }

            .glyphicon-circle-arrow-right {
                margin-left:10px;
            }


            .notification-heading, .notification-footer  {
                padding:2px 10px;
            }


            .dropdown-menu.divider {
                margin:5px 0;
            }

            .item-title {

                font-size:1.3rem;
                color:#000;

            }

            .notifications a.content {
                text-decoration:none;
                background:#ccc;

            }

            .notification-item {
                padding:10px;
                margin:5px;
                background:#ccc;
                border-radius:4px;
            }</style>
        <!-- <link rel="stylesheet" href="assets/css/personal-post-style.css"> -->
        <link rel="stylesheet" href="assets/css/standar-style.css">


    </head>
    <body>
        <div class="dropdown">
            <a id="dLabel" role="button" data-toggle="dropdown" data-target="#" href="#">
                <i class="fa fa-bell"></i>
            </a>
            <ul class="dropdown-menu notifications" role="menu" aria-labelledby="dLabel">
                <div class="notification-heading"><h5 class="menu-title">Thông báo của bạn: </h5>
                </div>
                <li class="divider"></li>
                <div class="notifications-wrapper">
                    <c:forEach var="notify" items="${requestScope.listNotification}"> 
                        <a class="content" href="#">
                            <div class="notification-item">
                                <p class="item-title" style="color: gray">${notify.formatTimeDifference()}</p>
                                <c:set var="message" value="${notify.notification_value}" />
                                <c:set var="modifiedMessage" value="${fn:split(message, '-')}"/>
                                <h5 class="item-info" style="color: red"><c:out value="${modifiedMessage[0]}" /></h5>
                                <p class="item-info col-7"><c:out value="${modifiedMessage[1]}" /></p>
                            </div>
                        </a>
                    </c:forEach>
                </div>
            </ul>
        </div>
    </body>
</html>
