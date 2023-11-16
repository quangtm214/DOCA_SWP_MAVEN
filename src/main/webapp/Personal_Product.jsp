<%-- 
    Document   : Personal_product
    Created on : Oct 16, 2023, 10:17:15 PM
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
        <!-- <link rel="stylesheet" href="assets/css/personal-post-style.css"> -->
        <link rel="stylesheet" href="assets/css/standar-style.css">

    </head>

    <body>
        <jsp:include page="header.jsp" />
        <c:set var="listProductOfPersonal" value="${requestScope.listProductOfPersonal}"/>
        <c:set var="message" value="${requestScope.Message}"/>
        <c:set var="IN" value="${sessionScope.IN}"/>



        <div class="main-content">
            <div class="row row-content justify-content-center">

                <div class="col-sm-8 ">

                    <!-- viết code vào đây -->
                    <div class="container mt-5 justify-content-center">
                        <h1>Quản lý sản phẩm của bạn</h1>

                        <div class="row-content">
                            <nav class="navbar navbar-light navbar-expand-lg container-fluid rounded-pill"
                                 style="background-color: #CAD2C5;"
                                 >

                                <div class="container justify-content-center">

                                    <ul class="nav nav-tabs border-0">
                                        <li class="nav-item rounded-pill">
                                            <a class="nav-link ${IN eq 'display' ? 'active' : ''} rounded-pill mt-1" href="#display" role="tab" data-toggle="tab">
                                                <strong style="color: black;">Đang hiển thị</strong>
                                            </a>
                                        </li>
                                        <li class="nav-item rounded-pill">
                                            <a class="nav-link ${IN eq 'denied' ? 'active' : ''} rounded-pill mt-1" href="#denied" role="tab" data-toggle="tab">
                                                <strong style="color: black;">Bị từ chối</strong>
                                            </a>
                                        </li>
                                        <li class="nav-item rounded-pill">
                                            <a class="nav-link ${IN eq 'waiting' ? 'active' : ''} rounded-pill mt-1" href="#waiting" role="tab" data-toggle="tab">
                                                <strong style="color: black;">Chờ duyệt</strong>
                                            </a>
                                        </li>
                                        <li class="nav-item rounded-pill">
                                            <a class="nav-link ${IN eq 'saled' ? 'active' : ''} rounded-pill mt-1" href="#saled" role="tab" data-toggle="tab">
                                                <strong style="color: black;">Đã bán</strong>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </nav>

                        </div>
                        <!-- content -->
                        <div class="tab-content mt-5 pb-5">
                            <div role="tabpanel" class="tab-pane fade ${IN eq 'display' ? 'show active' : ''}" id="display"> 
                                <c:set var="countDisplay" value="0" />
                                <c:forEach items="${listProductOfPersonal}" var="product">
                                    <c:if test="${product.status eq 'approved'}">
                                        <c:set var="countDisplay" value="${count + 1}" />
                                        <img class="col-sm-6 image-content mt-5 img-fluid"
                                             src="${product.productImage}" alt="Hình ảnh">
                                        <div class="font">
                                            <h5>${product.title}</h5>
                                            <h6>giá tiền: <fmt:formatNumber value="${product.price}" type="currency" currencyCode="VND" /></h6>
                                            <p>${product.address}</p>
                                            <p>
                                                Sản phẩm đang ở chế độ:
                                                <span class="${product.isPublic() ? 'text-success' : 'text-danger'}">
                                                    ${product.isPublic() ? 'Công khai' : 'Ẩn'}
                                                </span>
                                            </p>
                                            <c:forEach items="${listOfCountSaveproduct}" var="countSave">
                                                <c:if test="${countSave.productId== product.productId}">
                                                    <a href="getListUserHavedSaveProduct?productId=${product.productId}">Sản phẩm có  ${countSave.countSave} lượt quan tâm</a>
                                                </c:if>
                                            </c:forEach>
                                        </div>
                                        <a class="btn btn-primary" href="goUpdateProduct?ProductID=${product.productId}&IN=display" >sửa sản phẩm</a>
                                        <a class="btn btn-secondary" href="SetIsPublic?ProductID=${product.productId}&isPublic=${product.isPublic()}&IN=display">

                                            <c:choose>
                                                <c:when test="${product.isPublic()}">
                                                    Ẩn sản phẩm <i class="fa fa-eye-slash"></i>
                                                </c:when>
                                                <c:otherwise>
                                                    Hiện sản phẩm <i class="fa fa-eye"></i>
                                                </c:otherwise>
                                            </c:choose>
                                        </a>
                                        <hr>
                                    </c:if>
                                </c:forEach>
                                <c:if test="${countDisplay eq 0}">
                                    <p>${message}</p>
                                </c:if>
                            </div>

                            <div role="tabpanel" class="tab-pane fade ${IN eq 'denied' ? 'show active' : ''} " id="denied">
                                <c:set var="countDenied" value="0" />
                                <c:forEach items="${listProductOfPersonal}" var="product">
                                    <c:if test="${product.status eq 'rejected'}">
                                        <c:set var="countDenied" value="${count + 1}" />
                                        <img class="col-sm-6 image-content mt-5 img-fluid"
                                             src="${product.productImage}" alt="Hình ảnh">
                                        <div class="font">
                                            <h5>${product.title}</h5>
                                            <h6>giá tiền: <fmt:formatNumber value="${product.price}" type="currency" currencyCode="VND" /></h6>
                                            <p>${product.address}</p>
                                            <p>Lí do từ chối: ${product.reason}</p>
                                            <p class="text-warning">Tin đăng này không được sửa. Vui lòng đăng tin khác!</p>
                                        </div>

                                        <a class="btn btn-success" href="UpdateProduct.jsp">Đăng sản phẩm mới</a>
                                        <hr>
                                    </c:if>
                                </c:forEach>
                                <c:if test="${countDenied eq 0}">
                                    <p>${message}</p>
                                </c:if>
                            </div>
                            <div role="tabpanel" class="tab-pane fade  ${IN eq 'waiting' ? 'show active' : ''}  " id="waiting">
                                <c:set var="countWaiting" value="0" />
                                <c:forEach items="${listProductOfPersonal}" var="product">
                                    <c:if test="${product.status eq 'pending'}">
                                        <c:set var="countWaiting" value="${count + 1}" />
                                        <img class="col-sm-6 image-content mt-5 img-fluid"
                                             src="${product.productImage}" alt="Hình ảnh">
                                        <div class="font">
                                            <h5>${product.title}</h5>
                                            <h6>giá tiền: <fmt:formatNumber value="${product.price}" type="currency" currencyCode="VND" /></h6>
                                            <p>${product.address}</p>
                                            <p>Đang chờ </p>     
                                        </div>
                                        <a class="btn btn-primary" href="goUpdateProduct?ProductID=${product.productId}&IN=waiting" >sửa sản phẩm</a>

                                        <hr> 
                                    </c:if>
                                </c:forEach>
                                <c:if test="${countWaiting eq 0}">
                                    <p>${message}</p>
                                </c:if>
                            </div>



                            <div role="tabpanel" class="tab-pane fade  ${IN eq 'saled' ? 'show active' : ''}  " id="saled">
                                <c:set var="countsaled" value="0" />
                                <c:forEach items="${listProductOfPersonal}" var="product">
                                    <c:if test="${product.status eq 'saled'}">
                                        <c:set var="countsaled" value="${count + 1}" />
                                        <img class="col-sm-6 image-content mt-5 img-fluid"
                                             src="${product.productImage}" alt="Hình ảnh">
                                        <div class="font">
                                            <h5>${product.title}</h5>
                                            <h6>giá tiền: <fmt:formatNumber value="${product.price}" type="currency" currencyCode="VND" /></h6>
                                            <p>${product.address}</p>
                                            <p>Đã bán </p>     
                                        </div>
                                        <a class="btn btn-primary" href="resaledProduct?producID=${product.productId}" >Bán lại sản phẩm</a>

                                        <hr> 
                                    </c:if>
                                </c:forEach>
                                <c:if test="${countsaled eq 0}">
                                    <p>${message}</p>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>


            </div>
        </div>

    </body>
</html>
