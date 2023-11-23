<%-- 
    Document   : adminShowPost
    Created on : Oct 19, 2023, 8:22:34 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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

        <link rel="stylesheet" href="assets/css/adminshowpost.css"/>
        <link rel="stylesheet" href="assets/css/standar-style.css">
        <link rel="stylesheet" href="assets/css/forum-style-V3.css">
        <!-- Link JS -->
    </head>

    <style>
        .button {
            transition: transform 0.3s, filter 0.3s;
        }

        .button:hover {
            transform: scale(1.05); /* Hiệu ứng nổi lên khi di chuột vào */
            filter: brightness(90%); /* Màu tối đi khi di chuột vào */
        }
    </style>

    <body>
        <!--set var-->
        <c:set var="listPost" value="${requestScope.listofPost}"/>

        <jsp:include page="headerAdmin.jsp" />

        <div class="container " style="margin-top: 150px;">
            <ul class="nav nav-tabs mb-4">
                <li class="nav-item">
                    <a class="nav-link active" data-bs-toggle="tab" href="AdminManageForumPostServlet">Bài viết</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-bs-toggle="tab" 
                       onclick="redirectToProductServlet()">Sản phẩm</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-bs-toggle="tab"  onclick="redirectToUserServlet()">Tài khoản</a>
                </li>
                 <li class="nav-item">
                    <a class="nav-link" data-bs-toggle="tab"  onclick="redirectToCelendar()">Lịch làm việc</a>
                </li>
            </ul>

            <form id="filterForm" action="AdminManageForumPostServlet" method="GET">
                <!-- Add this script to submit the form -->
                <script>
                    function filterByCategory() {
                        document.getElementById("filterForm").submit();
                    }
                </script>

                <!-- Modify the select element to include onchange event -->
                <select class="form-select" id="categorySelect" name="selectedCategory" onchange="filterByCategory()">
                    <option value="0" ${selectedCategory == 0 ? 'selected' : ''}>Tất cả</option>
                    <option value="5" ${selectedCategory == 5 ? 'selected' : ''}>Câu chuyện</option>
                    <option value="6" ${selectedCategory == 6 ? 'selected' : ''}>Mẹo huấn luyện</option>
                    <option value="7" ${selectedCategory == 7 ? 'selected' : ''}>Mẹo chăm sóc</option>
                    <option value="8" ${selectedCategory == 8 ? 'selected' : ''}>Sự kiện</option>
                    <option value="9" ${selectedCategory == 9 ? 'selected' : ''}>Thất lạc</option>
                </select>

                <!-- Add a submit button -->

            </form>
            <div class="tab-content ">
                <div class=" tab-pane fade show active container" id="forum">
                    <div class="row">

                        <div class="list-group col-md-8">
                            <c:forEach items="${listPost}" var="post">
                                <div class="list-group-item list-group-item-action">
                                    <div class="post my-4 border rounded position-relative">
                                        <div class="post-header">
                                            <div class="profile-info">
                                                <div class="profile-details">
                                                    <div class="post-time text-muted">${post.timePosted}</div>
                                                </div>
                                            </div>

                                        </div>
                                        <div class="post-body">
                                            <p class="post-text ml-0">${post.postContent}</p>
                                            <img src="${post.postImage}" alt="Post Img" class="d-flex mx-auto" style="max-width: 300px; max-height: 300px; border-radius: 2%;">
                                        </div>
                                        <div class="post-footer ">
                                            <div class="container">
                                                <div class="row">
                                                    <div class="col-sm-3">
                                                        <form action="ManagePostForumServlet">
                                                            <input type="hidden" name="categorypost" value="${selectedCategory}" />
                                                            <input type="hidden" name="postId" value="${post.postId}" />
                                                            <input type="hidden" name="postDes" value="${post. postContentFormat()}" />
                                                            <input type="hidden" name="userId" value="${post.userId}" />
                                                            <button class="button btn btn-success approval-button" name="status" value="approved"><i class="fa-solid fa-check"></i>Duyệt</button>
                                                        </form>
                                                    </div>
                                                    <div class="col-sm-5"></div>
                                                    <div class="col-sm-4">
                                                        <button class="button btn btn-danger rejection-button" onclick="showForm(${post.postId})"><i class="fa-solid fa-xmark"></i>Không duyệt</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div id="reasonForm${post.postId}" style="display: none;">
                                            <form action="ManagePostForumServlet">
                                                <div class="form-group">
                                                    <label for="reasonSelect">Lí do: </label>
                                                    <select class="form-control" id="reasonSelect" name="reasonSelect">
                                                        <option value="">Chọn lý do</option>
                                                        <option>Spam nội dung</option>
                                                        <option>Phỉ báng, công kích cá nhân</option>
                                                        <option>Lạm dụng quyền riêng tư</option>
                                                        <option>Giả mạo thông tin</option>
                                                        <option>Phát tán thông tin sai lệch</option>
                                                    </select>
                                                </div>
                                                <input type="hidden" name="status" value="rejected" />
                                                <input type="hidden" name="categorypost" value="${selectedCategory}" />
                                                <input type="hidden" name="postDes" value="${post.postContent}" />
                                                <input type="hidden" name="userId" value="${post.userId}" />
                                                <input type="hidden" name="postId" value="${post.postId}" />
                                                <input type="submit" name="" value="Gửi" />
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <div class="col-md-4">
                            <c:set var="listTop" value="${requestScope.TopUserPost}"/>
                            <jsp:include page="topUser.jsp" />
                        </div>

                    </div>
                </div>
            </div>
            <script>
                function redirectToProductServlet() {
                    window.location.href = "AdminManageProductPostServlet";
                }
                function redirectToUserServlet() {
                    window.location.href = "AllUserServlet";
                }
                function redirectToCelendar() {
                    window.location.href = "manageCalendar";
                }
            </script>
            <script>
                function showForm(postId) {
                    var reasonForm = document.getElementById("reasonForm" + postId);
                    reasonForm.style.display = "block";
                }

                function hideForm() {
                    var reasonForm = document.getElementById("reasonForm");
                    reasonForm.style.display = "none";
                }

                function rejectAction() {
                    showForm();
                }

                function approveAction() {
                    hideForm();
                }

                function submitReason() {
                    var reasonInput = document.getElementById("reasonInput").value;
                    // Thực hiện xử lý với reasonInput ở đây (ví dụ: gửi dữ liệu lên máy chủ)
                    // Sau khi hoàn thành xử lý, bạn có thể ẩn form đi bằng cách sử dụng:
                    // hideForm();
                }
                function submitReason() {
                    var reasonSelect = document.getElementById("reasonSelect").value;
                    var rejectManageProductPost = document.getElementById("RejectManagePostForum").href;
                    rejectManageProductPost += "?reasonSelect=" + encodeURIComponent(reasonSelect);
                    document.getElementById("RejectManagePostForum").href = rejectManageProductPost;
                }
            </script>
            <%-- Kiểm tra giá trị của messShift và hiển thị thông báo alert --%>
            <% if (request.getAttribute("messShift") != null) { %>
            <script>
                alert("<%= request.getAttribute("messShift") %>");
            </script>
            <% } %>
            <!--set var-->



        </div>
    </body>
</html>