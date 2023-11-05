<%-- 
    Document   : header.jsp
    Created on : Oct 4, 2023, 10:21:56 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<style>
    #notiForm {
        position: absolute;
        top: 0;
        right: 18%;
        z-index: 9999;
    }
</style>
<header>
    <c:set var="Owner" value="${sessionScope.USER_NAME}"/>
    <form action="DispatchServlet" method="post">

        <nav class="navbar navbar-dark navbar-expand-sm fixed-top navbar-color p-0 header">
            <div class="container-fluid d-flex justify-content-center">
                <nav class="navbar navbar-light">
                    <a class="navbar-brand" href="#">
                        <img src="assets/images/logoDoca.png" class="rounded-circle" width="100px" height="100px" alt="">
                    </a>
                </nav>
                <div class="container-fluid d-flex justify-content-between navbar-contain mt-5   ">
                    <div class="dropdown ">
                        <button class="btn dropdown-toggle rounded-pill button_in_header  btn-light border-0" type="button"
                                id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="fa fa-bars" aria-hidden="true"></i><span id="currentPageName"> Danh mục</span>
                        </button>
                        <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                            <a class="dropdown-item" href="DispatchServlet?btAction=goToForum">Bảng tin</a>
                            <a class="dropdown-item" href="DispatchServlet?btAction=goTomarket">Chợ</a>

                        </div>
                    </div>
                    <div class="navbar-search " style="width: 50%;">
                        <form action="">
                            <div class="input-group bg-light">
                                <input type="text" class="form-control" placeholder=""
                                       value="${LastSearch}"
                                       name="search"  id="searchInput">
                                <div class="input-group-btn button-search">
                                    <a class="btn btn-default" type="submit" id="searchButton"
                                       href=""
                                       >
                                        <i class="fa fa-search"></i>
                                    </a>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div>
                        <a href="#" class="btn-notification btn  btn-light border-0 rounded-pill button_in_header" onclick="toggleMenuFormNoti()">
                            <i class="fa fa-bell" ></i>
                            <span class="badge p-0"></span>
                        </a>
                        <a class="btn btn-light border-0 rounded-pill button_in_header" href="getConversationServlet" role="button"><i
                                class="fa-solid fa-message"></i></a>
                            <c:choose>
                                <c:when test="${Owner eq null}">
                                <a class="btn btn-light border-0 rounded-pill button_in_header" href="login.jsp" role="button">
                                    <i class="fa-solid fa-pen-to-square"></i> Tạo Bài Bán
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a class="btn btn-light border-0 rounded-pill button_in_header" href="postProduct.jsp" role="button">
                                    <i class="fa-solid fa-pen-to-square"></i> Tạo Bài Bán
                                </a>
                            </c:otherwise>
                        </c:choose>

                        <c:choose>
                            <c:when test="${Owner eq null}">
                                <a class="btn btn-light border-0 rounded-pill button_in_header" href="login.jsp" role="button">
                                    <i class="fa fa-arrow-right-to-bracket"></i>Login
                                </a>
                                <a class="btn btn-light border-0 rounded-pill button_in_header" href="signup.jsp" role="button">
                                    <i class=" fa fa-user-plus"></i> SignUp
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a class="btn btn-light border-0 rounded-pill button_in_header" href="#" role="button" onclick="toggleMenuForm()">
                                    <img src="${Owner.avatar}"
                                         alt="Profile Image"
                                         class="rounded-circle profile-image" 
                                         style="width: 30px; height: 30px;">
                                    ${Owner.userName}
                                </a>
                            </c:otherwise>
                        </c:choose>



                    </div>
                </div>
            </div>


        </nav>
        <div class="setting position-absolute shadow-lg bg-body rounded " id="settingForm" style="display: none; right: 3%; z-index: 3;">
            <div class="card">
                <div class="card-body">
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item"> <a href="accountmanage.jsp" style="color: black;">quản lý tài khoản</a></li>
                        <li class="list-group-item"><a href="getPersonalPost" style="color: black;">quản lý tin </a></li>
                        <li class="list-group-item"><a href="getPersonalProduct" style="color: black;">quản lý sản phẩm</a>
                        </li>
                        <li class="list-group-item"><a href="ListProductSaved" style="color: black;">sản phẩm đã lưu</a></li>
                        <li class="list-group-item"> <a href="LogOutServlet" style="color: black;">logout</a></li>
                    </ul>

                </div>
            </div>
        </div>
        <div class="setting position-absolute shadow-lg bg-body rounded" id="notiForm" style="display: none; right: 18%; top:0px; position: absolute;">
            <div class="card">
                <h5 class="menu-title">Thông báo của bạn</h5>
                <div class="notifications-wrapper" id="notificationsWrapper">
                    <!-- Dữ liệu từ server sẽ được render vào đây -->
                </div>
            </div>
        </div>
    </form>

</header>

<script>
    function toggleMenuForm() {
        console.log("checkform")
        const commentForm = document.getElementById('settingForm');
        commentForm.style.display = commentForm.style.display === 'none' ? 'block' : 'none';
    }

    function toggleMenuFormNoti() {
        fetchNoti();
        const commentForm = document.getElementById('notiForm');
        commentForm.style.display = commentForm.style.display === 'none' ? 'block' : 'none';

    }
    const fetchNoti = () => {
        fetch('NotificationServlet')
                .then(response => response.json())
                .then(data => {
                    console.log(data);
                    renderNoti(data);
                });
    };

    const renderNoti = (data) => {
        const notificationsWrapper = document.getElementById('notificationsWrapper');
        notificationsWrapper.innerHTML = ''; // Xóa nội dung cũ trước khi render

        data.forEach(notify => {
            const itemWrapper = document.createElement('a');
            itemWrapper.classList.add('content');
            itemWrapper.href = '#';

            const notificationItem = document.createElement('div');
            notificationItem.classList.add('notification-item');

            const itemTitle = document.createElement('p');
            itemTitle.classList.add('item-title');
            itemTitle.style.color = 'gray';
//            itemTitle.textContent = notify.formatTimeDifference();

            const itemInfo1 = document.createElement('h5');
            itemInfo1.classList.add('item-info');
            itemInfo1.style.color = 'red';
            itemInfo1.textContent = notify.notification_value.split('-')[0];

            const itemInfo2 = document.createElement('p');
            itemInfo2.classList.add('item-info', 'col-7');
            itemInfo2.textContent = notify.notification_value.split('-')[1];

            notificationItem.appendChild(itemTitle);
            notificationItem.appendChild(itemInfo1);
            notificationItem.appendChild(itemInfo2);

            itemWrapper.appendChild(notificationItem);
            notificationsWrapper.appendChild(itemWrapper);
        });
    };

    function formatTimeDifference(timeNotification) {
        var currentTime = new Date();
        var timeDifferenceMillis = currentTime.getTime() - timeNotification.getTime();

        var days = Math.floor(timeDifferenceMillis / (1000 * 60 * 60 * 24));
        var hours = Math.floor((timeDifferenceMillis / (1000 * 60 * 60)) % 24);
        var minutes = Math.floor((timeDifferenceMillis / (1000 * 60)) % 60);

        var formattedTimeDifference;
        if (days > 0) {
            formattedTimeDifference = days + " ngày trước";
        } else if (hours > 0) {
            formattedTimeDifference = hours + " giờ trước";
        } else {
            formattedTimeDifference = minutes + " phút trước";
        }

        return formattedTimeDifference;
    }



</script>
<script>
    // Lấy URL hiện tại
    var currentURL = window.location.href;

    // Lấy phần tử có id là "currentPageName"
    var currentPageName = document.getElementById("currentPageName");

    // Kiểm tra URL và đặt nội dung cho phần tử <span>
    if (currentURL.includes("forum.jsp")) {
        currentPageName.textContent = "Bảng tin";
    } else if (currentURL.includes("market.jsp")) {
        currentPageName.textContent = "Chợ";
    }
</script>
<script>
    var currentPage = "<%= request.getRequestURI() %>";
    var searchInput = document.querySelector('input[name="search"]');
    var searchButton = document.getElementById("searchButton");

    if (currentPage.includes("forum.jsp")) {
        searchInput.placeholder = "Tìm kiếm bài viết";
        searchButton.setAttribute("href", "DispatchServlet?btAction=searchForum");
    } else if (currentPage.includes("market.jsp")) {
        searchInput.placeholder = "Tìm kiếm sản phẩm";
        searchButton.setAttribute("href", "DispatchServlet?btAction=searchMarket");
    }

    searchButton.addEventListener("click", function () {
        var searchValue = searchInput.value;
        var href = searchButton.getAttribute("href");

        if (searchValue) {
            var encodedSearchValue = encodeURIComponent(searchValue);
            var searchUrl = href + "&searchValue=" + encodedSearchValue;
            searchButton.setAttribute("href", searchUrl);
        }
    });
</script>
<script>
    var currentPage = "<%= request.getRequestURI() %>";
    var searchInput = document.querySelector('input[name="search"]');
    var searchButton = document.getElementById("searchButton");

    if (currentPage.includes("forum.jsp")) {
        searchInput.placeholder = "Tìm kiếm bài viết";
        searchButton.setAttribute("href", "DispatchServlet?btAction=searchForum");
    } else if (currentPage.includes("market.jsp")) {
        searchInput.placeholder = "Tìm kiếm sản phẩm";
        searchButton.setAttribute("href", "DispatchServlet?btAction=searchMarket");
    } else {
        // Nếu không ở trang "forum.jsp" hoặc "market.jsp", vô hiệu hóa khả năng tìm kiếm
        searchInput.disabled = true;
        searchButton.disabled = true;
    }

//    searchButton.addEventListener("click", function () {
//        var searchValue = searchInput.value;
//        var href = searchButton.getAttribute("href");
//
//
//        if (searchValue) {
//            var encodedSearchValue = encodeURIComponent(searchValue);
//            var searchUrl = href + "&searchValue=" + encodedSearchValue;
//            searchButton.setAttribute("href", searchUrl);
//        }
//    });
    searchButton.addEventListener("click", function (event) {
        if (searchInput.disabled) {
            // Ngăn chặn tìm kiếm khi nút bị vô hiệu hóa
            event.preventDefault();
        } else {
            var searchValue = searchInput.value;
            var href = searchButton.getAttribute("href");

            if (searchValue) {
                var encodedSearchValue = encodeURIComponent(searchValue);
                var searchUrl = href + "&searchValue=" + encodedSearchValue;
                searchButton.setAttribute("href", searchUrl);
            }
        }
    });
</script>

