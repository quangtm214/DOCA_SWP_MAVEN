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
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> 

        <!--  -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>

        <!-- Link CSS -->
        <link rel="stylesheet" href="assets/css/standar-style.css">
        <link rel="stylesheet" href="assets/css/forum-style-V3.css">
        <style>
            a.username {
                color: #050505;
            }
            .post-time.text-muted {
                color: #adaeb0;
            }
            .post.my-4.border.rounded.position-relative {
                background-color: #ffffff;
            }
            p.post-text {
                color: #050505;
                margin-left: 60px;
                margin-right: 60px;
            }
            a.sell.d-flex {
                width: 120%;
            }
            /*>>>>>>>>>>>>>>>>>>>>>>>>>>> css moi postdetail.jsp*/
            img.img-content.col-sm-7 {
                margin-left: 290px;
                border-radius: 5%;
                padding: 0;
            }
            .like-count {
                border-top: 1px solid #ccc; /* Màu và độ dày của đường kẻ phía trên */
                border-bottom: 1px solid #ccc; /* Màu và độ dày của đường kẻ phía dưới */
                padding: 10px 0; /* Khoảng cách giữa đường kẻ và nội dung */
                margin-top: 10px;
                color: blue;
            }
            .delete-comment {
                display: inline-block; /* Để nút hiển thị trên cùng một hàng với văn bản */
                padding: 5px 10px; /* Điều chỉnh kích thước của nút */
                border: none; /* Loại bỏ viền của nút */
                border-radius: 20px; /* Bo tròn viền của nút */
                background-color: #FF5733; /* Màu nền của nút */
                color: #fff; /* Màu chữ trắng */
                text-decoration: none; /* Loại bỏ gạch chân mặc định của liên kết */
                transition: background-color 0.3s; /* Hiệu ứng thay đổi màu nền */
            }

            /* CSS khi di chuột vào nút */
            .delete-comment:hover {
                background-color: #E64222; /* Thay đổi màu nền khi di chuột vào nút */
            }
        </style>
    </head>

    <body>
        <c:set var="Posts" value="${requestScope.listInPage}"/>
        <c:set var="listCategory" value="${requestScope.listCategory}"/>
        <c:set var="listOfComment" value="${requestScope.listOfComment}"/>
        <c:set var="listOfOwnerLike" value="${requestScope.listOfOwnerLike}"/>
        <c:set var="listOfLike" value="${requestScope.listOfLike}"/>
        <c:set var="Owner" value="${sessionScope.USER_NAME}"/>
        <jsp:include page="header.jsp" />

        <div class="main-content">
            <div class="row row-content justify-content-center">
                <div class="col-sm-8 ">
                    <div class="card create-post-card">
                        <div class="card-body d-flex align-items-center">
                            <div class="profile-image-container">
                                <c:choose>
                                    <c:when test="${not empty Owner.avatar}">
                                        <img src="${Owner.avatar}" alt="Profile Image" class="rounded-circle profile-image">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="https://res.cloudinary.com/dy2t6fuqj/image/upload/v1699194944/UserAvatar/ylnn4ipr2xaiql9q8b31.png" alt="Default Image" class="rounded-circle profile-image">
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <button type="button" class="btn btn-light btn-createpost btn-block p-0 ml-2 rounded-pill "
                                    data-bs-toggle="modal" data-bs-target="#exampleModal">
                                <div class="d-flex justify-content-start">
                                    <i class="fa fa-edit ml-3 mt-1"></i>
                                    Cùng chia sẽ nội dung về chó mèo
                                </div>

                            </button>

                            <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel"
                                 aria-hidden="true">
                                <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                                    <form action="PostForum" method="post" onsubmit="return validateCheckBoxes()" enctype="multipart/form-data">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="exampleModalLabel">Bài đăng của bạn</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                        aria-label="Close">&times;</button>
                                            </div>
                                            <div class="modal-body">
                                                <div class="mb-3">
                                                    <div class="form-check form-check-inline">
                                                        <input name="category" class="form-check-input" type="checkbox" id="inlineCheckbox1"
                                                               value="5" checked>
                                                        <label class="form-check-label" for="inlineCheckbox1" >Câu chuyện</label>
                                                    </div>
                                                    <div class="form-check form-check-inline">
                                                        <input name="category" class="form-check-input" type="checkbox" id="inlineCheckbox2"
                                                               value="6">
                                                        <label class="form-check-label" for="inlineCheckbox2">Mẹo huấn luyệnn</label>
                                                    </div>
                                                    <div class="form-check form-check-inline">
                                                        <input name="category" class="form-check-input" type="checkbox" id="inlineCheckbox3"
                                                               value="7">
                                                        <label class="form-check-label" for="inlineCheckbox2">Mẹo chắm sóc</label>
                                                    </div>
                                                    <div class="form-check form-check-inline">
                                                        <input name="category" class="form-check-input" type="checkbox" id="inlineCheckbox4"
                                                               value="8">
                                                        <label class="form-check-label" for="inlineCheckbox2">Sự kiện</label>
                                                    </div>
                                                    <div class="form-check form-check-inline">
                                                        <input name="category" class="form-check-input" type="checkbox" id="inlineCheckbox5"
                                                               value="9">
                                                        <label class="form-check-label" for="inlineCheckbox2">Chó mèo thất lạc</label>
                                                    </div>
                                                    <p id="error-message" style="color: red; display: none;">Vui lòng chọn ít nhất một checkbox.</p>
                                                </div>
                                                <div class="mb-3">
                                                    <label for="message-text" class="col-form-label">Nội dung:
                                                    </label>
                                                    <textarea name="content" class="form-control" id="message-text" rows="7"></textarea>
                                                </div>
                                                <div class="mb-3">
                                                    <label for="formFile" class="form-label"><i class="fa fa-picture-o"></i>
                                                        Chọn ảnh: </label>
                                                    <input class="form-control" type="file" id="formFile" name="file"  multiple>
                                                    <img id="previewImage" src="#" alt="Preview" style="max-width: 200px; max-height: 200px; display: none;">
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="submit" class="btn btn-primary" >Đăng</button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>


                    <div class="container rounded-pill p-0" style="background-color: #CAD2C5;">
                        <nav class="navbar navbar-dark navbar-expand-xxl ">

                            <button class="navbar-toggler" type="button" data-toggle="collapse"
                                    data-target="#navbarToggleExternalContent" aria-controls="navbarToggleExternalContent"
                                    aria-expanded="false" aria-label="Toggle navigation">
                                <i class="fa-sharp fa-solid fa-bars" style="color: #000000;"></i>
                            </button>

                            <ul class="collapse nav nav-tabs navbar-light justify-content-center border-0 show"
                                id="navbarToggleExternalContent">
                                <c:forEach items="${listCategory}" var="category">
                                    <c:set var="selectedCategoryID" value="${category.categoryID}" />
                                    <li class="nav-item rounded-pill ">
                                        <a style="height: 80%;" class="nav-link rounded-pill mt-1 ${indexcategoryID==category.categoryID ? "active" : " "}"
                                           href="forumServlet?categoryID=${selectedCategoryID}" >
                                            <strong style="color: black;">${category.categoryName}</strong></a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </nav>
                    </div>

                    <div class="row justify-content-center">
                        <div class="tab-content col-md-10">
                            <c:set var="count" value="0"/>
                            <c:forEach items="${Posts}" var="post">
                                <c:set var="count" value="${count + 1}" />
                                <div role="tabpanel" class="tab-pane fade show active " id="${indexcategoryID}">
                                    <div class="post my-4 border rounded position-relative">
                                        <div class="post-header">
                                            <div class="profile-info">
                                                <c:forEach items="${ListOfUser}" var="user">
                                                    <c:if test="${user.user_ID==post.userId}">
                                                        <c:set var="userName" value="${user.userName}"/>
                                                        <c:set var="userAvatar" value="${user.avatar}"/>
                                                        <c:set var="userID" value="${user.user_ID}"/>
                                                    </c:if>
                                                </c:forEach>
                                                <img src="${userAvatar}"
                                                     alt="Profile Image"
                                                     class="rounded-circle profile-image">
                                                <div class="profile-details">

                                                    <a href="Profilemember?userId=${userID}" class="username">${userName}</a>
                                                    <div class="post-time text-muted">${post.formatTimeDifference()}</div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="post-body">
                                            <p class="post-text" data-toggle="modal" data-target="#modalID${post.postId}">${post.postContent}</p>

                                            <a href="postDetailServlet?postId=${post.postId}" class="sell d-flex">
                                                <img class="img-content col-sm-7" data-toggle="modal" 
                                                     style="margin-left: 130px;" data-target="#modalID${post.postId}" src="${post.postImage}" alt="Post Image">
                                            </a>
                                        </div>
                                        <div class="post-footer">
                                            <c:set var="isLiked" value="false"/>
                                            <c:forEach items="${listOfOwnerLike}" var="like" >
                                                <c:if test="${like.postId == post.postId }">
                                                    <c:set var="isLiked" value="true"/>
                                                </c:if>
                                            </c:forEach>
                                            <a href="UpdateLike?postId=${post.postId}&slectedCategoryID=${indexcategoryID}&isLiked=${isLiked}">
                                                <button id="likeButton" class="btn flex-grow-1 btn_in_post ${isLiked=="true"? 'active':''}" 
                                                        style="background-color: ${isLiked=="true"? '#4CAF50':''}">   
                                                    <i class="fas fa-thumbs-up"></i> <span id="likeCount" style="color: blue"></span> Thích
                                                </button>
                                            </a>

                                            <button class="btn  flex-grow-1 btn-light btn_in_post" 
                                                    onclick="toggleCommentForm('${post.postId}')">
                                                <i class="fas fa-comment"></i> Bình luận
                                            </button>
                                        </div>
                                        <div id="commentForm${post.postId}" class="comment-form2" style="display: none;">
                                            <form action="DispatchServlet" method="post">
                                                <input type="text" name="commentDes" value="" placeholder="Write a comment..."/>
                                                <input type="submit" name="btAction" value="send" />
                                                <input type="hidden" name="postID" value="${post.postId}" />
                                                <input type="hidden" name="slectedCategoryID" value="${indexcategoryID}" />
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                            <c:if test="${count==0}">
                                <p>không có nội dung bạn tìm kiếm</p>
                            </c:if>

                        </div>

                    </div>

                    <nav aria-label="Page navigation ">
                        <c:set var="numberPage" value="${requestScope.numberPage}"/>
                        <ul class="pagination justify-content-center ">
                            <c:forEach begin="1" end="${numberPage}" var="i">
                                <li class="page-item rounded-pill ${indexPageForum} ${indexPageForum==i?"active":""}" >
                                    <a class="page-link rounded-pill ml-2 mt-4" href="forumServlet?index=${i}&categoryID=${indexcategoryID}">${i}</a>
                                </li>
                            </c:forEach> 


                        </ul>
                    </nav>


                </div>
            </div>

        </div>
        <script>
            function validateCheckBoxes() {
                var checkboxes = document.getElementsByName('category');
                var checked = false;
                for (var i = 0; i < checkboxes.length; i++) {
                    if (checkboxes[i].checked) {
                        checked = true;
                        break;
                    }
                }
                if (!checked) {
                    document.getElementById('error-message').style.display = 'block';
                } else {
                    document.getElementById('error-message').style.display = 'none';
                }
                return checked;
            }
        </script>



        <script>
            function toggleCommentForm(postid) {
                const commentForm = document.getElementById('commentForm' + postid);
                commentForm.style.display = commentForm.style.display === 'none' ? 'block' : 'none';
            }

        </script>


        <script>
            function toggleOptions(button) {
                const options = button.nextElementSibling;
                options.style.display = options.style.display === 'none' ? 'block' : 'none';
            }
        </script>
        <!--        alert when success create -->
        <script>
            window.addEventListener('DOMContentLoaded', (event) => {
                var successMessage = "<c:out value='${successMessage}' />";
                if (successMessage) {
                    alert(successMessage);
                }
            });
        </script>

    </body>
</html>
