<%-- 
    Document   : forum
    Created on : Oct 4, 2023, 10:16:52 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <!-- Required meta tags always come first -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta http-equiv="x-ua-compatible" content="ie=edge">


        <title>DOCA</title>
        <!-- Link Iconn  -->
        <link rel="stylesheet" href="fontawesome-free-6.4.2-web/css/fontawesome.css"> 
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

        <!-- jQuery first, then Popper.js, then Bootstrap JS. -->

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>

        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>


        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> 

        <!--  -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>

        <!-- Link CSS -->
        <link rel="stylesheet" href="assets/css/standar-style.css">
        <link rel="stylesheet" href="assets/css/forum-style-V3.css">
        <style>
            table {
                border-collapse: separate;
                border-spacing: 15px;
            }
        </style>
    </head>

    <body>
        <c:set var="Owner" value="${sessionScope.USER_NAME}"/>

        <jsp:include page="header.jsp" />

        <div class="main-content">
            <div class="row row-content justify-content-center">
                <div class="col-sm-8 text-center">
                    <h3>Chọn người đã quan tâm sản phẩm để thực hiện trao đổi</h3>
                    <div class="container">
                        <div class="row">
                            <div class="col-sm-2"></div>
                            <div class="col-sm-8">
                                <table>
                                    <thead>
                                        <tr>
                                            <th scope="col">Ảnh đại diện</th>
                                            <th scope="col">Tên người quan tâm</th>
                                            <th scope="col">Thời gian</th>
                                            <th scope="col"></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${listUserHaveSave}" var="user">
                                            <c:if test="${user.user_ID != Owner.user_ID}">
                                                <tr>
                                                    <td>
                                                        <img src="${user.avatar}"
                                                             alt="Profile Image"
                                                             class="rounded-circle profile-image" 
                                                             style="width: 30px; height: 30px;">
                                                    </td>
                                                    <td>
                                                        <a href="Profilemember?userId=${user.user_ID}">
                                                            <h5 class="text-dark mb-0 mr-5" data-toggle="tooltip" data-placement="top"
                                                                title="Xem trang cá nhân ${user.userName}">${user.userName}</h5>
                                                        </a>
                                                    </td>
                                                    <td>
                                                        <c:forEach items="${listSaveProduct}" var="save">
                                                            <c:if test="${save.userID==user.user_ID}">
                                                                ${save.formatTimeDifference()}
                                                            </c:if>
                                                        </c:forEach>
                                                    </td>

                                                    <c:set var="count" value="0" />
                                                    <c:set var="countApprove" value="0" />
                                                    <c:set var="countComplete" value="0" />
                                                    <c:forEach items="${listConverOfProduct}" var="conversation">
                                                        <c:if test="${conversation.buyer_id == user.user_ID}">
                                                            <c:set var="count" value="${count + 1}" />
                                                            <c:if test="${conversation.status=='approve'}">
                                                                <c:set var="countApprove" value="${countApprove +1 }" />
                                                            </c:if>
                                                            <c:if test="${conversation.status=='complete'}">
                                                                <c:set var="countComplete" value="${countComplete +1 }" />
                                                            </c:if>
                                                        </c:if>
                                                    </c:forEach>
                                                    <c:choose>
                                                        <c:when test="${count==0}">
                                                            <td>
                                                                <a href="CreateConversation?ProductID=${productID}&buyerID=${user.user_ID}">
                                                                    <button class="rounded-pill" style="background-color: #85C1E9 " data-toggle="tooltip" data-placement="top" title="Tạo cuộc trò chuyện với ${user.userName}">
                                                                        Tiếp cận
                                                                        <i class="fa-regular fa-hand-point-right" style="color: black;" ></i>

                                                                    </button>
                                                                </a>
                                                            </td>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <c:if test="${countApprove == 0}">
                                                                <c:if test="${countComplete!=0}">
                                                                    <td>
                                                                        <a href="CreateConversation?ProductID=${productID}&buyerID=${user.user_ID}">
                                                                            <button class="rounded-pill" style="background-color: #F9E79F "
                                                                                    data-toggle="tooltip" data-placement="top" title="Bạn đã bán sản phẩm cho ${user.userName}"
                                                                                    >Đã giao dịch   
                                                                                <i class="fa-regular fa-handshake" style="color: black;" ></i>

                                                                            </button>

                                                                        </a>
                                                                    </td>
                                                                </c:if>
                                                                <c:if test="${countComplete==0}">
                                                                    <td>
                                                                        <a href="CreateConversation?ProductID=${productID}&buyerID=${user.user_ID}">
                                                                            <button class="rounded-pill" style="background-color: #76D7C4"
                                                                                    data-toggle="tooltip" data-placement="top" title="Đi tới cuộc trò chuyện với ${user.userName}"
                                                                                    >Đang trò chuyện
                                                                                <i class="fa-regular fa-comments" style="color: black;" ></i>

                                                                            </button>
                                                                        </a>
                                                                    </td>
                                                                </c:if>
                                                            </c:if>
                                                            <c:if test="${countApprove!=0}">
                                                                <td>
                                                                    <a href="CreateConversation?ProductID=${productID}&buyerID=${user.user_ID}">
                                                                        <button class="rounded-pill" style="background-color: #C39BD3 "
                                                                                data-toggle="tooltip" data-placement="top" title="Bạn đang giao dịch với ${user.userName}"
                                                                                >Đang giao dịch   
                                                                            <i class="fa-solid fa-people-carry-box" style="color: black;" ></i>
                                                                           
                                                                        </button>

                                                                    </a>
                                                                </td>
                                                            </c:if>

                                                        </c:otherwise>
                                                    </c:choose>
                                                </tr>
                                            </c:if>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <div class="col-sm-2"></div>
                        </div>
                    </div>
                </div>
            </div>

        </div>



    </body>
</html>
