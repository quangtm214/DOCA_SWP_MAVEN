<%-- 
    Document   : manageCelendar
    Created on : Nov 22, 2023, 11:41:44 PM
    Author     : Admin
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
        <link rel="stylesheet" href="assets/css/standar-style.css">
        <!-- Link CSS -->
    </head>
    <body>

        <c:set var="ListOfWeek" value="${sessionScope.ListOfWeek}"/>
        <c:set var="listAdmin" value="${sessionScope.listAdmin}"/>
        <c:set var="currentDate" value="${sessionScope.currentDate}"/>
        <c:set var="listDateInWeek" value="${applicationScope.listDateInWeek}"/>
        <c:set var="listCelanderAdmin" value="${requestScope.listCelanderAdmin}"/>
        <c:set var="foundShift" value="${applicationScope.foundShift}"/>
        <%
            java.time.LocalDate currentDate = java.time.LocalDate.now();
        %>
        <jsp:include page="headerAdmin.jsp" />
        <c:set var="Owner" value="${sessionScope.USER_NAME}"/>
        <div class="container" style="margin-top: 150px;">
            <ul class="nav nav-tabs mb-4">
                <c:if test="${foundShift==true}">
                    <li class="nav-item">
                        <a class="nav-link " data-bs-toggle="tab" onclick="redirectToPostServlet()">Bài viết</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-bs-toggle="tab" onclick="redirectToProductServlet()">Sản phẩm</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-bs-toggle="tab" onclick="redirectToUserServlet()">Tài khoản</a>
                    </li>
                </c:if>
                <li class="nav-item">
                    <a class="nav-link active" data-bs-toggle="tab"  href="#">Lịch làm việc</a>
                </li>
            </ul>
            <div class="container">
                <div class="timetable-img text-center">
                    <img src="img/content/timetable.png" alt="">
                </div>
                <div class="table-responsive">
                    <table class="table table-bordered text-center">
                        <thead>
                            <tr class="bg-light-gray">
                                <th class="text-uppercase">Time
                                    <div class="dropdown mt-3 mb-3">
                                        <form id="filterForm" action="MangeDateInWeek" method="post">
                                            <script>
                                                function filterByCategory() {
                                                    document.getElementById("filterForm").submit();
                                                }
                                            </script>
                                            <select class="form-select" aria-label="Default select example" name="selectedWeek"  onchange="filterByCategory()">
                                                <c:forEach items="${ListOfWeek}" var="week">
                                                    <option value="${week.startDate}/${week.endDate}" ${inWeek==week.startDate?'selected':''}>${week.startDate} - ${week.endDate}</option>
                                                </c:forEach>
                                            </select>
                                        </form>
                                    </div>
                                </th>
                                <c:forEach items="${listDateInWeek}" var="date">
                                    <th class="text-uppercase">${date.day}
                                        <p>${date.date}</p>
                                    </th>
                                </c:forEach>
                            </tr>
                        </thead>
                        <form action="setupAdminCelander" method="post">
                            <c:if test="${Owner.user_ID==1032}">
                                <tbody>
                                    <tr>
                                        <td class="align-middle">Ca 1 (06:00 - 14:00)</td>
                                        <c:forEach items="${listDateInWeek}" var="date">
                                            <c:set var="AdminInSlot1" value=""/>
                                            <c:forEach items="${listCelanderAdmin}" var="celanderAdmin">
                                                <c:if test="${celanderAdmin.date==date.date}">
                                                    <c:if test="${celanderAdmin.shift=='1'}">
                                                        <c:set var="AdminInSlot1" value="${celanderAdmin.staff_Id}"/>
                                                    </c:if>
                                                </c:if>
                                            </c:forEach>
                                            <td>
                                                <select class="form-select" aria-label="Default select example" name="Slot1_${date.date}">
                                                    <c:set var="currentDate" value="<%= java.time.LocalDate.now() %>"/>
                                                    <c:choose>
                                                        <c:when test="${date.date > currentDate}">
                                                            <option value=""></option>
                                                            <c:forEach items="${listAdmin}" var="admin">
                                                                <option style="color: ${admin.user_ID == Owner.user_ID ? 'red' : 'black'}" value="${admin.user_ID}" ${AdminInSlot1 == admin.user_ID ? 'selected' : ''}>${admin.userName}</option>
                                                            </c:forEach>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <c:forEach items="${listAdmin}" var="admin">
                                                                <c:if test="${AdminInSlot1 == admin.user_ID}">
                                                                    <option style="color: ${admin.user_ID == Owner.user_ID ? 'red' : 'black'}" value="${admin.user_ID}">${admin.userName}</option>
                                                                </c:if>
                                                            </c:forEach> 
                                                        </c:otherwise>
                                                    </c:choose>
                                                </select>
                                            </td>
                                        </c:forEach>
                                    </tr>

                                    <tr>
                                        <td class="align-middle">Ca 2 (14:00 - 22:00)</td>
                                        <c:forEach items="${listDateInWeek}" var="date">
                                            <c:set var="AdminInSlot2" value=""/>
                                            <c:forEach items="${listCelanderAdmin}" var="celanderAdmin">
                                                <c:if test="${celanderAdmin.date==date.date}">
                                                    <c:forEach items="${listAdmin}" var="admin">
                                                        <c:if test="${celanderAdmin.shift=='2'}">
                                                            <c:set var="AdminInSlot2" value="${celanderAdmin.staff_Id}"/>
                                                        </c:if>
                                                    </c:forEach> 
                                                </c:if>
                                            </c:forEach>
                                            <td>
                                                <select class="form-select" aria-label="Default select example" name="Slot2_${date.date}" >
                                                    <c:set var="currentDate" value="<%= java.time.LocalDate.now() %>"/>
                                                    <c:choose>
                                                        <c:when test="${date.date > currentDate}">
                                                            <option value=""></option>
                                                            <c:forEach items="${listAdmin}" var="admin">
                                                                <option style="color: ${admin.user_ID == Owner.user_ID ? 'red' : 'black'}"  value="${admin.user_ID}" ${AdminInSlot2 == admin.user_ID ? 'selected' : ''}>${admin.userName}</option>
                                                            </c:forEach>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <c:forEach items="${listAdmin}" var="admin">
                                                                <c:if test="${AdminInSlot2 == admin.user_ID}">
                                                                    <option style="color: ${admin.user_ID == Owner.user_ID ? 'red' : 'black'}" value="${admin.user_ID}">${admin.userName}</option>
                                                                </c:if>
                                                            </c:forEach> 
                                                        </c:otherwise>
                                                    </c:choose>
                                                </select>
                                            </td>
                                        </c:forEach>
                                    </tr>

                                    <tr>
                                        <td class="align-middle">Ca 3 (22:00 - 14:00)</td>
                                        <c:forEach items="${listDateInWeek}" var="date">
                                            <c:set var="AdminInSlot3" value=""/>
                                            <c:forEach items="${listCelanderAdmin}" var="celanderAdmin">
                                                <c:if test="${celanderAdmin.date==date.date}">
                                                    <c:forEach items="${listAdmin}" var="admin">
                                                        <c:if test="${celanderAdmin.shift=='3'}">
                                                            <c:set var="AdminInSlot3" value="${celanderAdmin.staff_Id}"/>
                                                        </c:if>
                                                    </c:forEach> 
                                                </c:if>
                                            </c:forEach>
                                            <td>
                                                <select class="form-select" aria-label="Default select example" name="Slot3_${date.date}" >
                                                    <c:set var="currentDate" value="<%= java.time.LocalDate.now() %>"/>
                                                    <c:choose>
                                                        <c:when test="${date.date > currentDate}">
                                                            <option value=""></option>
                                                            <c:forEach items="${listAdmin}" var="admin">
                                                                <option style="color: ${admin.user_ID == Owner.user_ID ? 'red' : 'black'}" value="${admin.user_ID}" ${AdminInSlot3 == admin.user_ID ? 'selected' : ''}>${admin.userName}</option>
                                                            </c:forEach>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <c:forEach items="${listAdmin}" var="admin">
                                                                <c:if test="${AdminInSlot3 == admin.user_ID}">
                                                                    <option style="color: ${admin.user_ID == Owner.user_ID ? 'red' : 'black'}" value="${admin.user_ID}">${admin.userName}</option>
                                                                </c:if>
                                                            </c:forEach> 
                                                        </c:otherwise>
                                                    </c:choose>
                                                </select>
                                            </td>
                                        </c:forEach>
                                    </tr>
                                </tbody>
                            </c:if>


                            <c:if test="${Owner.user_ID!=1032}"> 
                                <tbody>
                                    <tr>
                                        <td class="align-middle">Ca 1 (06:00 - 14:00)</td>
                                        <c:forEach items="${listDateInWeek}" var="date">
                                            <c:set var="AdminInSlot1" value=""/>
                                            <c:forEach items="${listCelanderAdmin}" var="celanderAdmin">
                                                <c:if test="${celanderAdmin.date==date.date}">
                                                    <c:if test="${celanderAdmin.shift=='1'}">
                                                        <c:set var="AdminInSlot1" value="${celanderAdmin.staff_Id}"/>
                                                    </c:if>
                                                </c:if>
                                            </c:forEach>
                                            <td>
                                                <c:forEach items="${listAdmin}" var="admin">
                                                    <c:if test="${AdminInSlot1 == admin.user_ID}">
                                                        <p style="color: ${admin.user_ID == Owner.user_ID ? 'red' : 'black'}">${admin.userName}</p>
                                                    </c:if>
                                                </c:forEach> 
                                            </td>
                                        </c:forEach>
                                    </tr>

                                    <tr>
                                        <td class="align-middle">Ca 2 (14:00 - 22:00)</td>
                                        <c:forEach items="${listDateInWeek}" var="date">
                                            <c:set var="AdminInSlot2" value=""/>
                                            <c:forEach items="${listCelanderAdmin}" var="celanderAdmin">
                                                <c:if test="${celanderAdmin.date==date.date}">
                                                    <c:forEach items="${listAdmin}" var="admin">
                                                        <c:if test="${celanderAdmin.shift=='2'}">
                                                            <c:set var="AdminInSlot2" value="${celanderAdmin.staff_Id}"/>
                                                        </c:if>
                                                    </c:forEach> 
                                                </c:if>
                                            </c:forEach>
                                            <td>
                                                <c:forEach items="${listAdmin}" var="admin">
                                                    <c:if test="${AdminInSlot2 == admin.user_ID}">
                                                        <p style="color: ${admin.user_ID == Owner.user_ID ? 'red' : 'black'}">${admin.userName}</p>
                                                    </c:if>
                                                </c:forEach> 
                                            </td>
                                        </c:forEach>
                                    </tr>

                                    <tr>
                                        <td class="align-middle">Ca 3 (22:00 - 14:00)</td>
                                        <c:forEach items="${listDateInWeek}" var="date">
                                            <c:set var="AdminInSlot3" value=""/>
                                            <c:forEach items="${listCelanderAdmin}" var="celanderAdmin">
                                                <c:if test="${celanderAdmin.date==date.date}">
                                                    <c:forEach items="${listAdmin}" var="admin">
                                                        <c:if test="${celanderAdmin.shift=='3'}">
                                                            <c:set var="AdminInSlot3" value="${celanderAdmin.staff_Id}"/>
                                                        </c:if>
                                                    </c:forEach> 
                                                </c:if>
                                            </c:forEach>
                                            <td>
                                                <c:forEach items="${listAdmin}" var="admin">
                                                    <c:if test="${AdminInSlot3 == admin.user_ID}">
                                                        <p style="color: ${admin.user_ID == Owner.user_ID ? 'red' : 'black'}">${admin.userName}</p>
                                                    </c:if>
                                                </c:forEach> 
                                            </td>
                                        </c:forEach>
                                    </tr>
                                </tbody>
                            </c:if>
                    </table>
                    <c:if test="${Owner.user_ID==1032}">
                        <input type="submit" value="Cập nhật" name="btAction" class="btn btn-block btn-primary">
                    </c:if>
                    </form>
                </div>
            </div>
        </div>
        <script>
            function redirectToProductServlet() {
                window.location.href = "AdminManageProductPostServlet";
            }
            function redirectToPostServlet() {
                window.location.href = "AdminManageForumPostServlet";
            }
            function redirectToUserServlet() {
                window.location.href = "AllUserServlet";
            }
        </script>
        <%-- Kiểm tra giá trị của messShift và hiển thị thông báo alert --%>
        <% if (request.getAttribute("messnotShift") != null) { %>
        <script>
            alert("<%= request.getAttribute("messnotShift") %>");
        </script>
        <% } %>
        <!--set var-->
    </body>
</html>
