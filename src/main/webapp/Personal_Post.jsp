
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
        <c:set var="listPostOfPersonal" value="${requestScope.listPostOfPersonal}"/>
        <c:set var="message" value="${requestScope.Message}"/>


        <div class="main-content">
            <div class="row row-content justify-content-center">
                <div class="col-sm-8 ">
                    <!-- viết code vào đây -->
                    <div class="container mt-5 justify-content-center">
                        <h1>Quản lý bài viết của bạn</h1>

                        <div class="row-content">
                            <nav class="navbar navbar-light navbar-expand-lg container-fluid rounded-pill"
                                 style="background-color: #CAD2C5;"
                                 >

                                <div class="container justify-content-center">

                                    <ul class="nav nav-tabs border-0">
                                        <li class="nav-item rounded-pill">
                                            <a class="nav-link active rounded-pill mt-1" href="#display" role="tab"
                                               data-toggle="tab"><strong style="color: black;">Đang hiển thị</strong></a>
                                        </li>
                                        <li class="nav-item rounded-pill">
                                            <a class="nav-link rounded-pill mt-1" href="#denied" role="tab"
                                               data-toggle="tab"><strong style="color: black;">Bị từ
                                                    chối</strong></a>
                                        </li>
                                        <li class="nav-item rounded-pill">
                                            <a class="nav-link rounded-pill mt-1" href="#waiting" role="tab"
                                               data-toggle="tab"><strong style="color: black;">Chờ
                                                    duyệt</strong></a>
                                        </li>
                                    </ul>
                                </div>
                            </nav>

                        </div>
                        <!-- content -->
                        <div class="tab-content mt-5 pb-5">

                            <div role="tabpanel" class="tab-pane fade show active" id="display"> 
                                <c:set var="countDisplay" value="0" />
                                <c:forEach items="${listPostOfPersonal}" var="post">
                                    <c:if test="${post.status eq 'approved'}">
                                        <c:set var="countDisplay" value="${count + 1}" />
                                        <img class="col-sm-6 image-content mt-5 img-fluid"
                                             src="${post.postImage}" alt="Hình ảnh">
                                        <div class="font">
                                            <p>${post.postContent}</p>
                                        </div>
                                        <input type="submit" value="sửa bài viết">
                                        <input type="submit" value="xoá bài viết">
                                        <hr>
                                    </c:if>
                                </c:forEach>
                                <c:if test="${countDisplay eq 0}">
                                    <p>${message}</p>
                                </c:if>
                            </div>

                            <div role="tabpanel" class="tab-pane fade " id="denied">
                                <c:set var="countDenied" value="0" />
                                <c:forEach items="${listPostOfPersonal}" var="post">
                                    <c:if test="${post.status eq 'rejected'}">
                                        <c:set var="countDenied" value="${count + 1}" />
                                        <p>${post.reason}</p>
                                        <img class="col-sm-6 image-content mt-5 img-fluid"
                                             src="${post.postImage}" alt="Hình ảnh">
                                        <div class="font">
                                            <p>${post.postContent}</p>
                                        </div>
                                        <input type="submit" value="sửa bài viết">
                                        <input type="submit" value="xoá bài viết">
                                        <hr>
                                    </c:if>
                                </c:forEach>
                                <c:if test="${countDenied eq 0}">
                                    <p>${message}</p>
                                </c:if>
                            </div>
                            <div role="tabpanel" class="tab-pane fade " id="waiting">
                                <c:set var="countWaiting" value="0" />
                                <c:forEach items="${listPostOfPersonal}" var="post">
                                    <c:if test="${post.status eq 'pending'}">
                                        <c:set var="countWaiting" value="${count + 1}" />
                                        <c:set var="countDisplay" value="${count + 1}" />
                                        <img class="col-sm-6 image-content mt-5 img-fluid"
                                             src="${post.postImage}" alt="Hình ảnh">
                                        <div class="font">
                                            <p>${post.postContent}</p>
                                        </div>
                                        <input type="submit" value="sửa bài viết">
                                        <input type="submit" value="xoá bài viết">
                                        <hr>
                                    </c:if>
                                </c:forEach>
                                <c:if test="${countWaiting eq 0}">
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
