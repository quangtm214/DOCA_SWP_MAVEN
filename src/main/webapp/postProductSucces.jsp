<%-- 
    Document   : postProductSucces
    Created on : Oct 16, 2023, 9:18:39 AM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <link rel="stylesheet" href="assets/css/productDetail.css">
        <!-- Link JS -->


        <script>
            $(function () {
                $("#header").load("header.jsp");
            });
        </script>
    </head>
    <body>
        <c:set var="productPost" value="${requestScope.product}"/>
         <c:set var="Owner" value="${sessionScope.USER_NAME}"/>

        <div id="header"></div>

        <div class="main-content">
            <div class="row row-content justify-content-center">
                <div class="col-sm-8 ">
                    <div class="container pt-5">
                        <div class="row">
                            <div class="col">
                              
                                  <img class="col-sm-6 image-content mt-5 img-fluid" 
                                       src="${productPost.productImage}"alt="Hình ảnh">
                                
                                  <!--<img style="width: 100px" src="" src="C:/Users/Admin/Desktop/V3DocaProject/Doca_javaV2/Doca_java/Doca_java/src/main/webapp/ImgUploadByUser/2023-10-16_10-49-39.jpg" alt="">-->
                                  
                                <div class="product_info">
                                    <c:set var="title" value="${productPost.title}"/>
                                    <h2 class="title">${title}</h2>
                                    <c:set var="price" value="${productPost.price}"/>
                                    <h4 class="price text-danger">${price}</h4>
                                    <p class="product_des">${productPost.description}</p>
                                    <h4 class="text-secondary">Local</h4>
                                    <p class="product_address">
                                        <i class="fa fa-location-dot"></i>
                                        ${product.address}
                                    </p>
                                    <h5 class="text-secondary">Product Type</h5>
                                    <p>${category.categoryName}</p>
                                </div>
                                <a href="profileMemberOther.html">
                                    <div class="profile-image-container">
                                        <img src="${Owner.avatar}" alt="Profile Image" class="rounded-circle profile-image">
                                    </div>
                                    <h6 class="userName mt-2">${Owner.userName}</h6>
                                </a>
                            </div>
                            

                        </div>

                    </div>


                </div>


            </div>
        </div>
    </div>
</body>
</html>
