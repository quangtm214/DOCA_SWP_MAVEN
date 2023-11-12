<%-- 
    Document   : alluser
    Created on : Nov 1, 2023, 2:38:01 PM
    Author     : Admin
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
        <link rel="stylesheet" href="assets/css/forum-style-V3.css">
        <!-- Link JS -->



    </head>
    <body>
        <jsp:include page="headerAdmin.jsp" />

        <div class="container" style="margin-top: 150px;">
            <ul class="nav nav-tabs mb-4">
                <li class="nav-item">
                    <a class="nav-link " data-bs-toggle="tab" onclick="redirectToPostServlet()">Bài viết</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-bs-toggle="tab" 
                       onclick="redirectToProductServlet()">Sản phẩm</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" data-bs-toggle="tab"  href="#">Tài khoản</a>
                </li>
            </ul>
            <form action="DispatchServlet" method="POST" class="mb-3">
                <div class="input-group">
                    <input type="text" name="txtSearch" class="form-control" placeholder="Tìm kiếm tên tài khoản" value="${param.txtSearch}">
                    <input type="hidden" class="btn btn-primary" value="Search User" name="btAction">
                    <button type="submit" class="btn btn-primary">
                        <i class="fa fa-search"></i>
                    </button>
                </div>
            </form>
            <div class="table-responsive">
                <c:if test="${ not empty ErroMessage }">
                    <div class="row">
                        <div class="col-sm-auto pr-0">
                            <p class="text-danger">${ErroMessage}</p>
                        </div>
                        <div class="col-sm-auto pl-1">
                            <p class="text-warning">${param.txtSearch}</p>
                        </div>
                    </div>
                </c:if>
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>User ID</th>
                            <th>Username</th>

                            <th>Gender</th>
                            <th>Email</th>
                            <th>Mobile Number</th>
                            <th>Status</th>

                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${userList}" var="user">
                            <tr>
                        <form action="DispatchServlet" method="Post">
                            <td><input type="hidden" name="user_id" value="${user.user_ID}">${user.user_ID}</td>
                            <td>${user.userName}</td>

                            <td>${user.gender}</td>
                            <td>${user.email}</td>
                            <td>${user.mobileNum}</td>
                            <td><c:choose>
                                    <c:when test="${user.status}">
                                        <span class="badge bg-success">Ava</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-danger">Banned</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${user.status}">
                                        <a href="DeleteUserSerlvet?user_id=${user.user_ID}&action=ban&txtSearch=${param.txtSearch}" 
                                           class="btn btn-danger">Ban Account</a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="DeleteUserSerlvet?user_id=${user.user_ID}&action=unban&txtSearch=${param.txtSearch}" 
                                           class="btn btn-success">Unban Account</a>
                                    </c:otherwise>
                                </c:choose></td>
                        </form>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <script>
            function redirectToProductServlet() {
                window.location.href = "AdminManageProductPostServlet";
            }
            function redirectToPostServlet() {
                window.location.href = "AdminManageForumPostServlet";
            }
        </script>
    </body>
</html>
