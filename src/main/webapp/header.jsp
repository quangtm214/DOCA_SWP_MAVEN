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
    .container-fluid.d-flex.justify-content-center {
        background-color: #fadadd;
    }
    li.list-group-item  {
        transition: transform 0.3s ease-in-out;
    }

    li.list-group-item:hover {
        transform: scale(1.05);
    }
    .list-group a{
        text-decoration: none;
    }
    button#dropdownMenuButton {
        background-color: #add8e6;
    }
    a#searchButton {
        background-color: #add8e6;
    }
    a.btn-notification.btn.btn-light.border-0.rounded-pill.button_in_header {
        background-color: #add8e6;
    }
    a.btn.btn-light.border-0.rounded-pill.button_in_header {
        background-color: #add8e6;
    }
</style>

<header>
    <title>DOCA</title>
    <c:set var="Owner" value="${sessionScope.USER_NAME}"/>

    <!--    <form action="DispatchServlet" method="post">-->

    <nav class="navbar navbar-dark navbar-expand-sm fixed-top navbar-color p-0 header">
        <div class="container-fluid d-flex justify-content-center">
            <nav class="navbar navbar-light">
                <a class="navbar-brand" href="DispatchServlet?btAction=goToForum">
                    <img src="assets/images/logoDoca.png" class="rounded-circle" width="100px" height="100px" alt="logo">
                </a>
            </nav>
            <div class="container-fluid d-flex justify-content-between navbar-contain mt-5   ">
                <div class="dropdown ">
                    <button class="btn dropdown-toggle rounded-pill button_in_header  btn-light border-0" type="button"
                            id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <i class="fa fa-bars" aria-hidden="true"></i><span id="currentPageName"> Danh mục</span>
                    </button>
                    <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                        <a class="dropdown-item" href="DispatchServlet?btAction=goToForum"><i class="fa-solid fa-dog"></i>Bảng tin</a>
                        <a class="dropdown-item" href="DispatchServlet?btAction=goTomarket"><i class="fa-solid fa-cat"></i>Chợ</a>

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
                                <i class="fa-solid fa-pen-to-square"></i> Tạo bài bán
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a class="btn btn-light border-0 rounded-pill button_in_header" href="postProduct.jsp" role="button">
                                <i class="fa-solid fa-pen-to-square"></i> Tạo bài bán
                            </a>
                        </c:otherwise>
                    </c:choose>

                    <c:choose>
                        <c:when test="${Owner eq null}">
                            <a class="btn btn-light border-0 rounded-pill button_in_header" href="login.jsp" role="button">
                                <i class="fa fa-arrow-right-to-bracket"></i>Đăng nhập
                            </a>
                            <a class="btn btn-light border-0 rounded-pill button_in_header" href="signup.jsp" role="button">
                                <i class=" fa fa-user-plus"></i> Đăng ký
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
                    <a href="accountmanage.jsp" style="color: black;"><li class="list-group-item"><i class="fa-solid fa-address-card"></i>Quản lý tài khoản</li></a>
                    <a href="getPersonalPost" style="color: black;"><li class="list-group-item"><i class="fa-solid fa-newspaper"></i>Quản lý tin của bạn</li></a>
                    <a href="getPersonalProduct" style="color: black;"><li class="list-group-item"><i class="fa fa-archive"></i>Quản lý sản phẩm</li></a>
                    <a href="getListFeedbackServlet?seller_id=${Owner.user_ID}" style="color: black;"><li class="list-group-item"><i class="fa-solid fa-star"></i>Xem đánh giá của bạn</li></a>
                    <a href="ListProductSaved" style="color: black;"><li class="list-group-item"><i class="fa-solid fa-bookmark"></i>Sản phẩm đã lưu</li></a>
                    <a href="LogOutServlet" style="color: black;"><li class="list-group-item"><i class="fa-sharp fa-solid fa-arrow-right-from-bracket"></i>Đăng xuất</li></a>
                </ul>
            </div>
        </div>
    </div>
    <div class="setting position-absolute shadow-lg bg-body rounded" id="notiForm" style="display: none; right: 18%; top:0px; position: absolute; max-width: 380px; min-width: 300px; z-index: 3;">
        <div class="card">
            <h4 class="menu-title">Thông báo </h4>
            <div class="notifications-wrapper" id="notificationsWrapper" style="overflow: scroll; max-height:490px; height: 100%; ">
                <!-- Dữ liệu từ server sẽ được render vào đây -->
            </div>
        </div>
    </div>
    <!--    </form>-->

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
            const itemWrapper = document.createElement('P');
            itemWrapper.classList.add('content');

            const notificationItem = document.createElement('div');
            notificationItem.classList.add('notification-item');

            const itemTitle = document.createElement('p');
            itemTitle.classList.add('item-title');
            itemTitle.style.color = '#33FFA2';
            itemTitle.style.margin = '0';
            itemTitle.textContent = formatTimeDifference(notify.timeNotification);


            const itemInfo1 = document.createElement('h6');
            itemInfo1.classList.add('item-info');
            itemInfo1.style.color = 'black';
            itemInfo1.textContent = notify.notification_value.split('-')[0];

            const itemInfo2 = document.createElement('p');
            itemInfo2.classList.add('item-info');
            itemInfo2.textContent = notify.notification_value.split('-')[1];

            notificationItem.appendChild(itemTitle);
            notificationItem.appendChild(itemInfo1);
            notificationItem.appendChild(itemInfo2);

            itemWrapper.appendChild(notificationItem);
            notificationsWrapper.appendChild(itemWrapper);
            notificationsWrapper.appendChild(document.createElement('hr'));
        });
    };
    const formatTimeDifference = (timeNotification) => {
        const currentTime = new Date();
        const notificationTime = new Date(timeNotification);
        const timeDifference = currentTime - notificationTime;
        //console.log(timeDifference);
        const millisecondsInSecond = 1000;
        const millisecondsInMinute = millisecondsInSecond * 60;
        const millisecondsInHour = millisecondsInMinute * 60;
        const millisecondsInDay = millisecondsInHour * 24;
        const millisecondsInMonth = millisecondsInDay * 30;
        const millisecondsInYear = millisecondsInMonth * 12;
        if (timeDifference < millisecondsInMinute) {
            const seconds = Math.floor(timeDifference / millisecondsInSecond);
            return seconds + `giây trước`;
        } else if (timeDifference < millisecondsInHour) {
            const minutes = Math.floor(timeDifference / millisecondsInMinute);

            return minutes + ` phút trước`;
        } else if (timeDifference < millisecondsInDay) {

            const hours = Math.floor(timeDifference / millisecondsInHour);
//            console.log(millisecondsInHour);
//            console.log(hours);
            return hours + ` giờ trước`;
        } else if (timeDifference < millisecondsInMonth) {
            const days = Math.floor(timeDifference / millisecondsInDay);
            return days + ` ngày trước`;
        } else if (timeDifference < millisecondsInYear) {
            const months = Math.floor(timeDifference / millisecondsInMonth);
            return months + ` tháng trước`;

        } else {
            const years = Math.floor(timeDifference / millisecondsInYear);
            return years + ` năm trước`;
        }

    };



</script>
<script>

    var currentURL = window.location.href;


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
    } else {
        // Nếu không ở trang "forum.jsp" hoặc "market.jsp", vô hiệu hóa khả năng tìm kiếm
        searchInput.disabled = true;
        searchButton.disabled = true;
    }

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


