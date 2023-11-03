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


        <link rel="stylesheet" href="assets/css/standar-style.css">
        <link rel="stylesheet" href="assets/css/forum-style-V3.css">
        <!-- Link JS -->

    </head>
    <body>
        <!--set var-->
        <c:set var="listPost" value="${requestScope.listofPost}"/>

        <div class="container">
            <h1>Admin Page</h1>

            <ul class="nav nav-tabs mb-4">
                <li class="nav-item">
                    <a class="nav-link active" data-bs-toggle="tab" href="AdminManageForumPostServlet">Forum</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-bs-toggle="tab" 
                       onclick="redirectToProductServlet()">Product</a>
                </li>
            </ul>

            <div class="tab-content">
                <div class="tab-pane fade show active" id="forum">
                    <div class="list-group">
                        <c:forEach items="${listPost}" var="post">
                            <div class="list-group-item list-group-item-action">
                                <div class="post my-4 border rounded position-relative">
                                    <div class="post-header">
                                        <div class="profile-info">
                                            <img src="assets/images/doge.jpeg" alt="Profile Image"
                                                 class="rounded-circle profile-image">
                                            <div class="profile-details">
                                                <a href="#" class="username">${post.userId}</a>
                                                <div class="post-time text-muted">${post.timePosted}</div>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="post-body">
                                        <p class="post-text">${post.postContent}</p>
                                        <img src="${post.postImage}" alt="Post Img">
                                    </div>
                                    <div class="post-footer">
                                        <form action="ManagePostForumServlet">
                                            <input type="hidden" name="postId" value="${post.postId}" />
                                            <input type="hidden" name="postDes" value="${post.postContent}" />
                                            <button class="btn btn-danger" name="status" value="approved">Duyệt</button>
                                        </form>
                                        <button class="btn btn-danger" onclick="showForm(${post.postId})">Không duyệt</button>
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
                                            <input type="hidden" name="postDes" value="${post.postContent}" />
                                            <input type="hidden" name="postId" value="${post.postId}" />
                                            <input type="submit" name="" value="Gửi" />
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
            <script>
                function redirectToProductServlet() {
                    window.location.href = "AdminManageProductPostServlet";
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

            <!--                <div class="tab-pane fade" id="product">
                                <div class="list-group">
            <c:forEach items="${Products}" var="product">
                <form action="ManagePostProductServlet">
                <div class="list-group-item list-group-item-action">
                    <div class="post my-4 border rounded position-relative">
                        <div class="post-header">
                            <div class="profile-info">
                                <img src="assets/images/doge.jpeg" alt="Profile Image"
                                     class="rounded-circle profile-image">
                                <div class="profile-details">
                                    <a href="#" class="username">${product.userId}</a>
                                    <div class="post-time text-muted">${product.timePosted}</div>
                                </div>
                            </div>
                        </div>
                        <div class="post-body row" style="width: 80%">
                <c:set var="img" value="ImgUploadByUser/${product.productImage}"/>
                <div class="col-md-6"> <img class="image" src=${img} alt="Hình ảnh"></div>
                <div class="font col-md-6">
                    <h5><strong>${title}</strong></h5>
                    <h6 style="color:rgb(242, 106, 106);">Tiền: ${product.price}</h6>
                    <br>
                    <h6 style="font-size: 15px; opacity: 0.5;">Ðịa chỉ: ${product.address}</h6>
                    <p>${product.description}</p>
                </div>
            </div>



            <div class="post-footer">
                <form action="ManagePostProductServlet">
                    <input type="hidden" name="productId" value="${product.productId}" />
                    <button class="btn btn-danger" name="status" value="approve">Duyệt</button>
                </form>
                <button class="btn btn-danger" onclick="showForm(${product.productId})">Không duyệt</button>
            </div>
            <div id="reasonForm${product.productId}" style="display: none;">
                <form action="ManagePostProductServlet">
                    <div class="form-group">
                        <label for="reasonSelect">Lí do: </label>
                        <select class="form-control" id="reasonSelect" name="reasonSelect">
                            <option value="">Chọn lý do</option>
                            <option >Vi phạm quy định</option>
                            <option >Không đáng tin cậy</option>
                            <option >Không phù hợp với mục đích</option>
                            <option >Không đủ chất lượng</option>
                            <option >Vi phạm bản quyền</option>
                            <option >Không phù hợp với đạo đức</option>
                        </select>
                    </div>
                    <input type="hidden" name="status" value="reject" />
                    <input type="hidden" name="productId" value="${product.productId}" />
                    <input type="submit" name="" value="Gửi" />
                </form>
            </div>
        </div>
    </div>
    </form>
    <script>
        function showForm(productID) {
            var reasonForm = document.getElementById("reasonForm" + productID);
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
            </c:forEach>
        </div>
    </div>-->
        </div>

    </body>
</html>
