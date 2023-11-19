<%-- 
    Document   : productDetail
    Created on : Oct 12, 2023, 10:29:19 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <!-- Required meta tags always come first -->
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



        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
        <!-- <link rel="stylesheet" href="assets/css/forum-style.css"> -->
        <link rel="stylesheet" href="assets/css/standar-style.css">
        <link rel="stylesheet" href="assets/css/productDetail.css">
        <style>

            .profile-image-container {
                width: 100px;
                height: 100px;
                overflow: hidden; /* Tránh ảnh bị tràn ra ngoài khung */
            }

            .profile-image-container img {
                width: 100%;
                height: 100%;
                object-fit: cover; /* Hiển thị hình ảnh tỉ lệ đúng và không bị méo */
            }
            .product-image{
                width: 450px;
                height: 450px;
            }
            .price{
                color: red;
            }
            .row.row-content.justify-content-center {
                background-color: #f5f5f5;
            }
            .col {
                background-color: white;
            }
            .col-sm-8 {
                margin-top: -45px;
            }
            .profile-info {
                display: flex; /* Sử dụng flexbox để sắp xếp nằm ngang */
                align-items: center; /* Canh giữa các phần tử theo chiều dọc */
            }
            #sellerPhone {
                transition: transform 0.3s, filter 0.3s;
            }

            #sellerPhone:hover {
                transform: scale(1.05); /* Hiệu ứng nổi lên khi di chuột vào */
                filter: brightness(90%); /* Màu tối đi khi di chuột vào */
            }
            #chat {
                transition: transform 0.3s, filter 0.3s;
            }

            #chat:hover {
                transform: scale(1.05); /* Hiệu ứng nổi lên khi di chuột vào */
                filter: brightness(90%); /* Màu tối đi khi di chuột vào */
            }
            #chat a{
                text-decoration: none;
            }
        </style>
    </head>

    <body>
        <c:set var="product" value="${requestScope.productDetail}" />
        <c:set var="category" value="${requestScope.category}" />
        <c:set var="OwnerAccount" value="${sessionScope.USER_NAME}"/>
        <c:set var="MessageERRO" value="${requestScope.Message}"/>
        <jsp:include page="header.jsp" />
        <div class="main-content">
            <div class="row row-content justify-content-center">
                <div class="col-sm-8 ">
                    <div class="container pt-5">
                        <c:if test="${empty product}">
                            <div class="row  ml-0  d-flex justify-content-center" style="margin-top: 300px;">

                                <h3>Sản phẩm không còn tồn tại</h3>
                                <h4 >${MessageERRO}</h4>
                                <form action="DispatchServlet" >
                                    <button class="btn btn-warning text-white" name="btAction" value="goTomarket">Về trang chợ</button>
                                </form>
                            </div>
                        </c:if>
                        <c:if test="${not empty product}">
                            <div class="row">
                                <div class="col">
                                    <c:set var="img" value="${product.productImage}"/>
                                    <img class="product-image" src=${img} alt="" style="max-width: 100%;  object-fit: cover;">
                                    <div class="product_info">
                                        <c:set var="title" value="${product.title}"/>
                                        <h2 class="title">${title}</h2>
                                        <c:if test="${!product.isFree()}">
                                            <h4 class="price text-danger">Giá: <fmt:formatNumber value="${product.price}" type="currency" currencyCode="VND" /></h4>
                                        </c:if>
                                        <c:if test="${product.isFree()}">
                                            <h4 class="price text-danger">Miễn phí</h4>
                                        </c:if>

                                        <p class="product_des">${product.productContentFormat()}</p>
                                        <h4 class="text-secondary">Khu Vực</h4>
                                        <p class="product_address">
                                            <i class="fa fa-location-dot"></i>
                                            ${product.address}
                                        </p>
                                        <h5 class="text-secondary">Loại sản phẩm</h5>
                                        <p>${category.categoryName}</p>
                                    </div>

                                </div>
                                <div class="col">
                                    <div class="row">
                                        <a href="Profilemember?userId=${owner.user_ID}">
                                            <div class="profile-info">
                                                <div class="profile-image-container">
                                                    <img src="${owner.avatar}" alt="Profile Image" class="rounded-circle profile-image">
                                                </div>

                                                <h6 class="userName mt-2">${owner.userName}</h6>
                                            </div>
                                        </a>
                                    </div>
                                    <div class="row mt-5">
                                        <p>Sản phẩm có  ${countSave} lượt quan tâm</p>
                                        <button class="btn btn-outline-secondary bg-light btn-block text-success"
                                                id="sellerPhone"><i class="fa-solid fa-phone"></i> Hiện số người bán</button>

                                        <br>
                                        <c:if test="${product.userId  != OwnerAccount.user_ID }">
                                            <button id='chat' class="btn btn-outline-secondary bg-light btn-block text-success mt-2">
                                                <a href="CreateConversation?ProductID=${product.productId}&sellerID=${product.userId}" >
                                                    <i class="fa fa-comments"></i> Chat với người bán
                                                </a>
                                            </button>
                                        </c:if>
                                    </div>

                                </div>
                            </div>
                        </c:if>
                    </div>

                </div>
            </div>
        </div>





        <script>
            var button = document.getElementById("sellerPhone");
            var owner = {
                mobileNum: ${owner.mobileNum}
            };
            button.addEventListener("click", function () {
                if (owner.mobileNum === null) {
                    button.textContent = "Người bán chưa cập nhật số điện thoại";
                } else {
                    button.textContent = owner.mobileNum;
                }
            });
        </script>
    </body>

</html>
