<%-- 
    Document   : Product_Saved
    Created on : Oct 14, 2023, 10:57:46 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
        <link rel="stylesheet" href="assets/css/standar-style.css">

    </head>

    <body>
        <jsp:include page="header.jsp" />
        <c:set var="listOfSaved" value="${requestScope.listOfSaved}"/>
        <c:set var="message" value="${requestScope.Message}"/>
        <div class="main-content">
            <div class="row row-content justify-content-center">

                <div class="col-sm-8 ">
                    <div class="row m-5">
                        <div class="nav nav-tabs" id="myTabs">
                            <div class="nav-item ">
                                <a class="nav-link text-dark active" id="product-tab" data-toggle="tab" href="#product">Sản
                                    Phẩm Đã Lưu</a>
                            </div>

                        </div>
                    </div>
                    <div class="tab-content  ">
                        <div id="product" class="tab-pane fade show active ">
                            <div class="row justify-content-center" >
                                <label>${message}</label>

                            </div>
                            <div class="row justify-content-start" >

                                <c:forEach items="${listOfSaved}" var="porduct">
                                    <div class=" card col-3 justify-content-center ">
                                        <img class="image" src="${porduct.productImage}" alt="Hình ảnh">
                                        <div class="card-body">
                                            <div class="font">
                                                <a href="productDetailServlet?productId=${porduct.productId}">
                                                    <h5>
                                                        <strong>
                                                            ${porduct.title}
                                                        </strong>
                                                    </h5>
                                                </a>
                                                <h6 style="color:rgb(242, 106, 106);"><fmt:formatNumber value="${porduct.price}" type="currency" currencyCode="VND" /></h6>
                                                <div class="d-flex justify-content-between align-items-center">
                                                    <h6 style="font-size: 15px; opacity: 0.5;">${porduct.address}</h6>
                                                    <span class="like-icon">
                                                        <a href="DeleteSaveProduct_InSavePage?productID=${porduct.productId}" class="like-button">
                                                            <i class="fa fa-heart" style="color: red;"></i>
                                                        </a>
                                                    </span>
                                                </div>

                                            </div>

                                        </div>
                                        <div class="card-footer">
                                            <small class="text-muted">${porduct.formatTimeDifference()}</small>
                                        </div>
                                    </div>
                                </c:forEach>

                            </div>


                        </div>


                    </div>
                </div>
            </div>
        </div>
    </body>
    <script>
        var likeButtons = document.querySelectorAll(".like-button");
        var isLiked = false;

        likeButtons.forEach(function (likeButton) {
            likeButton.addEventListener("click", function () {
                if (isLiked) {
                    likeButton.innerHTML = '<i class="fa fa-heart-o" style="color: red;"></i>';
                } else {
                    likeButton.innerHTML = '<i class="fa fa-heart" style="color: red;"></i>';
                }
                isLiked = !isLiked;
            });
        });
    </script>
</html>
