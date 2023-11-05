<%-- 
    Document   : profilemember
    Created on : Oct 15, 2023, 2:28:28 PM
    Author     : Admin
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

        <title>Account</title>
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

        <link rel="stylesheet" href="assets/css/profilePrivate.css">
        <link rel="stylesheet" href="assets/css/standar-style.css">

        <!-- Link JS -->


        <!--        <script>
                    $(function () {
                        $("#header").load("header.jsp");
                    });
                </script>-->
    </head>
    <body>
        <c:set var="productList" value="${productlist}"/>
        <c:set var="postList" value="${postlist}"/>
        <c:set var="OwnerProfile" value="${requestScope.OwnerProfile}"/>
        <jsp:include page="header.jsp" />
        <div class="main-content">
            <div class="row row-content justify-content-center">
                <div class="col-sm-8 ">
                    <div class="row">
                        <div class="col-lg-4">
                            <div class="card mb-4">
                                <div class="card-body text-center">
                                    <img src="${OwnerProfile.avatar}" alt="avatar" class="img-fluid"
                                         style=" object-fit: cover;
                                         border-radius: 50%;  width: 150px;
                                         height: 150px;">
                                    <h5 class="my-3">${OwnerProfile.userName}</h5>

                                </div>
                                <div>
                                    <c:if test="${averageRate > 0.0}">
                                        <div class="row ml-1 ">
                                            <p class="mr-2">điểm trung bình:  ${averageRate}/5</p>
                                            <a href="getListFeedbackServlet?seller_id=${OwnerProfile.user_ID}" >(${feedbackCount} đánh giá)</a>
                                        </div>
                                    </c:if>
                                    <c:if test="${averageRate == 0.0}">
                                        <p>không có đánh giá</p>
                                    </c:if>

                                </div>
                            </div>
                            <div class="card mb-4 mb-lg-0">
                                <div class="card-body p-0">
                                    <ul class="list-group list-group-flush rounded-3">
                                        <li class="list-group-item d-flex justify-content-between align-items-center p-2">
                                            <i class="fa fa-phone"></i>
                                            <c:choose>
                                                <c:when test="${OwnerProfile.getMobileNum() == 'null'}">
                                                    <p class="mb-0 ml-3">Người dùng chưa cập nhật số điện thoại</p>
                                                </c:when>
                                                <c:otherwise>
                                                    <p class="mb-0">${OwnerProfile.mobileNum}</p>
                                                </c:otherwise>
                                            </c:choose>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-8">

                            <div class="row m-0">
                                <ul class="nav nav-tabs" id="myTabs">
                                    <li class="nav-item ">
                                        <a class="nav-link text-dark active" id="product-tab" data-toggle="tab"
                                           href="#product">Bài rao bán</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link text-dark " id="post-tab" data-toggle="tab" href="#post">
                                            Bài đăng thông tin</a>
                                    </li>
                                </ul>
                            </div>
                            <div class="tab-content" class="row">
                                <div id="product" class="tab-pane fade show active">
                                    <div class="card-group container justify-content-center product">
                                        <div class="row">
                                            <c:forEach items="${productList}" var="product">
                                                <div class="col-sm-6  mt-1" >
                                                    <div class="card" style="height: 100%;">
                                                        <a href="productDetailServlet?productId=${product.productId}">
                                                            <img class="card-img" src="${product.productImage}" alt="alt" />
                                                            <h5 class="card-title">${product.title}</h5>
                                                            <h3 class="card-text">
                                                                <fmt:formatNumber value="${product.price}" type="currency" currencyCode="VND" /></h3>
                                                            <p class="card-text"><small>${product.address}</small></p>
                                                            <h6 class="card-text"><small>
                                                                    <fmt:formatDate pattern = "yyyy-MM-dd" 
                                                                                    value = "${product.timePosted}" />
                                                                </small>
                                                            </h6>
                                                        </a>   
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>


                                <div id="post" class="tab-pane fade">
                                    <div class="card-group container justify-content-center product">
                                        <div class="row">
                                            <c:forEach items="${postList}" var="post">
                                                <div class="col-sm-6  mt-1" >
                                                    <div class="card" style="height: 100%;">
                                                        <div class="card-body">
                                                            <a href="postDetailServlet?postId=${post.postId}">
                                                                <h5>
                                                                    <fmt:formatDate pattern="yyyy-MM-dd" value="${post.timePosted}" />
                                                                </h5>
                                                                <h5 class="card-title post-content">${post.postContent}</h5>
                                                                <img class="card-img" src="${post.postImage}" alt="alt" />
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>

                                <script>
                                    var postContentElements = document.getElementsByClassName("post-content");
                                    var maxLength = 40;
                                    for (var i = 0; i < postContentElements.length; i++) {
                                        var postContent = postContentElements[i].textContent;
                                        if (postContent.length > maxLength) {
                                            postContentElements[i].textContent = postContent.substring(0, maxLength) + "...";
                                        }
                                    }
                                </script>

                            </div>


                        </div>
                    </div>
                </div>
            </div>
        </div>

    </body>
    <style>
        .card {
            border: 1px solid #ccc;
            margin: 10px;
            padding: 10px;
        }

        .card-title {
            font-size: 18px;
        }

        .card-subtitle {
            color: #888;
        }

        .card-text {
            font-size: 20px;
            color: #333;
        }

        .card-img {
            max-width: 250px;
            height: auto;
        }
    </style>
</html>