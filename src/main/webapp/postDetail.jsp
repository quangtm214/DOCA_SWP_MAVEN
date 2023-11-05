<%-- 
    Document   : postDetail
    Created on : 18 thg 10, 2023, 18:42:35
    Author     : minhluan
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> 

        <!--  -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
        <!-- <link rel="stylesheet" href="assets/css/forum-style.css"> -->
        <link rel="stylesheet" href="assets/css/standar-style.css">
        <link rel="stylesheet" href="assets/css/forum-style-V3.css">
        <style>
            .user-info-container {
                display: flex; /* Use Flexbox for horizontal alignment */
                align-items: center; /* Vertically center the content */
                gap: 10px; /* Add some spacing between the image and the username */
            }

            .profile-image {
                width: 50px; /* Adjust the width of the profile image as needed */
                height: 50px; /* Adjust the height of the profile image as needed */
                border-radius: 50%; /* Make it circular if the image is a user's profile picture */
            }

            .comment-username {
                font-weight: bold; /* Apply styles to the username as needed */
                margin: 0; /* Reset margin to ensure there's no extra spacing */
            }
            .comment-wrapper {
                background-color: #696969;
                border-radius: 10px;
                padding: 10px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }

            .comment-details {
                color: #E4E6Eb
            }

            .comment-content {

                margin: 0;
            }
            #shareButton {
                background-color: #4CAF50; /* Green background color */
                border: none; /* Remove border */
                color: white; /* Text color */
                padding: 10px 20px; /* Add padding */
                text-align: center; /* Center align text */
                text-decoration: none; /* Remove underline */
                display: inline-block; /* Display as inline block */
                font-size: 16px; /* Font size */
                cursor: pointer; /* Add cursor pointer */
                border-radius: 4px; /* Add border radius */
            }

            /* Styles for the popup */
            .popup {
                display: none; /* Hide the popup by default */
                position: fixed; /* Position the popup */
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.4); /* Semi-transparent background */
                z-index: 1; /* Set the popup above other elements */
            }

            /* Styles for the popup content */
            .popup-content {
                background-color: #fefefe;
                margin: 10% auto; /* Center the popup vertically and horizontally */
                padding: 20px;
                border: 1px solid #888;
                width: 500px;
            }

            /* Close button styles */
            .popup-content span {
                color: #aaa;
                float: right;
                font-size: 28px;
                font-weight: bold;
                cursor: pointer;
            }

            /* Close button hover styles */
            .popup-content span:hover {
                color: #000;
            }

            /* Copy button styles */
            #copyButton {
                background-color: #008CBA;
                border: none;
                color: white;
                padding: 10px 20px;
                text-align: center;
                text-decoration: none;
                display: inline-block;
                font-size: 16px;
                cursor: pointer;
                border-radius: 4px;
            }
        </style>
    </head>

    <body>
        <c:set var="post" value="${requestScope.postDetail}" />
        <c:set var="listOfComment" value="${requestScope.listOfComment}"/>
        <c:set var="OwnerComment" value="${sessionScope.USER_NAME}"/>

        <jsp:include page="header.jsp" />

        <div class="main-content">
            <div class="row row-content justify-content-center">
                <div class="col-sm-8 ">
                    <div class="post main-content my-4 border rounded position-relative">
                        <div class="post-header">
                            <div class="profile-info">

                                <img src="${owner.avatar}"
                                     alt="Profile Image"
                                     class="rounded-circle profile-image">
                                <div class="profile-details">

                                    <a href="#" class="username">${owner.userName}</a>
                                    <div class="post-time text-muted">Ngày đăng bài: ${post.formatTimeDifference()}</div>
                                </div>
                            </div>
                        </div>

                        <div class="post-body ">
                            <div class="d-flex justify-content-center">
                                <p class="post-text">
                                    ${post.postContentFormat()}
                                </p>
                            </div>
                            <div class="d-flex justify-content-center">
                                <img class="img-content"src="${post.postImage}" alt="Post Image"  style=" object-fit: cover;
                                     border-radius: 10%;">
                            </div>
                            <p class="like-count">số lượt like của bài viết này: ${likeCount}</p>
                        </div>
                        <button id="shareButton">Chia sẻ</button>
                        <div class="popup" id="sharePopup">
                            <div class="popup-content">
                                <span onclick="closePopup()" style="float: right; cursor: pointer;">&times;</span>
                                <p id="shareURL">URL bài viết: </p>
                                <button id="copyButton">Copy Link</button>
                            </div>
                        </div>
                        <c:forEach items="${listOfComment}" var="comment">
                            <c:if test="${comment.postId==post.postId}">
                                <div class="comment mt-5">
                                    <c:forEach items="${ListOfUser}" var="user">
                                        <c:if test="${user.user_ID==comment.userId}">
                                            <c:set var="userName" value="${user.userName}"/>
                                            <c:set var="userAvatar" value="${user.avatar}"/>
                                        </c:if>
                                    </c:forEach>
                                    <div class="user-info-container">
                                        <img src=${userAvatar} alt="Avatar" class="profile-image">
                                        <p class="comment-username">${userName}</p>
                                    </div>
                                    <div class="comment-wrapper mt-3 d-inline-block">
                                        <div class="comment-details mt-3">
                                            <p class="comment-content">${comment.commentDes}</p>
                                        </div>
                                    </div>
                                </div>
                                <!--xoá comment-->
                                <c:if test="${OwnerComment.user_ID==comment.userId}">
                                    <a href="deleteCommentServlet?commentId=${comment.commentId}&postId=${post.postId}">Xoá comment</a>
                                </c:if>
                            </c:if>

                        </c:forEach>

                    </div>
                </div>
            </div>
        </div>

    </body>
    <script>
        document.getElementById('shareButton').addEventListener('click', function () {
            var shareURL = window.location.href; // URL của bài viết
            var sharePopup = document.getElementById('sharePopup');
            var shareURLDiv = document.getElementById('shareURL');
            shareURLDiv.textContent = "URL bài viết: " + shareURL;
            sharePopup.style.display = 'block';
        });

        document.getElementById('copyButton').addEventListener('click', function () {
            var shareURL = window.location.href; // URL của bài viết
            var tempInput = document.createElement('input');
            tempInput.setAttribute('value', shareURL);
            document.body.appendChild(tempInput);
            tempInput.select();
            document.execCommand('copy');
            document.body.removeChild(tempInput);
            alert("URL đã được sao chép vào clipboard: " + shareURL);
        });

        function closePopup() {
            console.log("close");
            var sharePopup = document.getElementById('sharePopup');
            sharePopup.style.display = 'none';
        }
    </script>

</html>
