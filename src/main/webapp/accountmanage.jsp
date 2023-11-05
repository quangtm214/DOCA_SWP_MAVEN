<%--
Document : accountmanage
Created on : Oct 15, 2023, 2:13:31 PM
Author : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html> <html>
    <head> <!-- Required meta tags always come first --> 
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"> 
        <meta http-equiv="x-ua-compatible" content="ie=edge"> <!-- Bootstrap CSS --> <!-- Bootstrap CSS --> <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

        <title>Account</title>

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
        <link rel="stylesheet" href="assets/css/profilePrivate.css">

        <!-- Link JS -->


        <!--        <script>
                    $(function () {
                        $("#header").load("header.jsp");
                    });
                </script>-->
    </head>
    <body>


        <c:set var="Owner" value="${sessionScope.USER_NAME}"/>
        <jsp:include page="header.jsp" />

        <div class="main-content">
            <div class="row row-content justify-content-center">
                <div class="col-sm-8">
                    <!--Edit profile  -->
                    <div class="container px-4 mt-4 edit-profile">
                        <hr class="mt-0 mb-4">

                        <div class="row">
                            
                                <c:if test="${Owner.getMobileNum() == 'null'}">
                                    <p class="mb-0 ml-3">Để trải nghiệm tốt hơn, vui lòng cung cấp thông tin còn thiếu.</p>
                                </c:if >

                            <div class="col-sm-12">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <button id="showAccountInfoButton" onclick="showAccountInfo()">Thông tin tài khoản</button>
                                        <button id="showChangePasswordButton" onclick="showChangePassword()">Thay đổi mật khẩu</button>
                                    </div>
                                </div>
                                <!-- Account details card-->
                                <div id="accountInfo" >
                                    <form action="DispatchServlet" method="post"  onsubmit="return validateForm()" enctype="multipart/form-data" >

                                        <div class="card mb-4">
                                            <div class="card-header">Thông tin tài khoản</div>
                                            <div class="card mb-4 mb-xl-0">
                                                <div style="margin: 20px 0 0 20px">Ảnh đại diện</div>
                                                <div class="card-body text-center">
                                                    <!-- Profile picture image-->
                                                    <img class="img-account-profile rounded-circle" src="${Owner.avatar}"
                                                         alt=""   style=" object-fit: cover;
                                                         border-radius: 50%;  width: 150px;
                                                         height: 150px;">
                                                    <h6>${Owner.userName}</h6>
                                                    <hr />
                                                    <!-- Profile picture upload button-->
                                                    <div class="input-group">
                                                        <label class="input-group-text" for="inputGroupFile01">Tải lên</label>
                                                        <input type="file" class="form-control" id="inputGroupFile01" name="avatar" >
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="card-body">



                                                <!-- Form Group (username)-->
                                                <div class="mb-3">
                                                    <label class="small mb-1" for="inputUsername" >Usename<span
                                                            class="red-star">*</span></label>
                                                    <input class="form-control" id="inputUsername" type="text"
                                                           placeholder="Username" value="${Owner.userName}" name="txtUsername" >
                                                    <c:if test="${not empty requestScope.isUsernameTaken}">
                                                        <div class="text-danger">Tên người dùng đã tồn tại. Vui lòng chọn một tên khác.</div>
                                                    </c:if>

                                                </div>
                                                <div class="mb-3">
                                                    <label class="small mb-1" for="inputUsername" >Email<span
                                                            class="red-star">*</span></label>
                                                    <input class="form-control" id="inputEmail" type="email"
                                                           placeholder="" value="${Owner.email}" name="txtEmail">
                                                    <c:if test="${not empty requestScope.isEmailTaken}">
                                                        <div class="text-danger">Email đã tồn tại. vui lòng chọn email khác.</div>
                                                    </c:if>
                                                </div>
                                                <!-- Form Group (Phone)-->
                                                <div class="mb-3">
                                                    <label class="small mb-1" for="inputPhone">Số điện thoại <span
                                                            class="red-star">*</span></label>
                                                    <input class="form-control" id="inputPhone" type="number"
                                                           placeholder="Enter your phone number" value="${Owner.mobileNum}" name="txtPhone" required="bắt buộc">
                                                </div>

                                                <!-- Form Address -->

                                                <div class="mb-3">
                                                    <select id="gender" class="form-control" name="txtGender" required>
                                                        <option value="" disabled selected>Chọn giới tính</option>
                                                        <option value="male" ${Owner.gender == 'male'? 'selected' : ''}>Nam</option>
                                                        <option value="female" ${Owner.gender == 'female'? 'selected' : ''}>Nữ</option>
                                                        <option value="other" ${Owner.gender == 'other'? 'selected' : ''}>Khác</option>
                                                    </select>
                                                </div>

                                                <!-- Form Row-->
                                                <div class="row gx-3 mb-3">

                                                </div>

                                                <!-- Save changes button-->
                                                <input type="submit" value="Thay đổi thông tin" name="btAction" class="btn btn-block btn-primary">

                                            </div>
                                        </div>
                                    </form>
                                </div>
                                <div id="changePassword" style="display: none;">
                                    <form action="DispatchServlet">

                                        <div class="card mb-4">
                                            <div class="card-header">Thông tin tài khoản</div>
                                            <div class="card-body">





                                                <!-- Form Row-->

                                                <div class="form-change-password">
                                                    <div class="row">
                                                        <div class="col-12 col-sm-6 mb-3">
                                                            <div class="mb-2"><b>Thay đổi mật khẩu</b></div>
                                                            <div class="row">
                                                                <div class="col">
                                                                    <div class="form-group">
                                                                        <label class="small mb-1" for="inputCurPassword">Mật khẩu hiện tại <span
                                                                                class="red-star">*</span></label>
                                                                        <input class="form-control" id="inputCurPassword" type="password" name="txtCurPass"
                                                                               placeholder="">
                                                                        <c:if test="${requestScope.isCurPasswordIncorrect}">
                                                                            <div class="text-danger">Mật khẩu hiện tại không đúng. Vui lòng kiểm tra lại.</div>
                                                                        </c:if>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="row">
                                                                <div class="col">
                                                                    <div class = "form-group">
                                                                        <label class="small mb-1" for="inputPassword">Mật khẩu mới <span
                                                                                class="red-star">*</span></label>
                                                                        <input class="form-control" id="inputPassword" type="password" name="txtPassword"
                                                                               placeholder="•••••">
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="row">
                                                                <div class="col">
                                                                    <div class="form-group">
                                                                        <label class="small mb-1" for="inputConfirm">Xác nhận mật khẩu <span
                                                                                class="red-star">*</span></label>
                                                                        <input class="form-control" id="inputConfirm" type="password"
                                                                               placeholder="•••••" name="txtConfirm">
                                                                        <c:if test="${requestScope.isPasswordMismatch}">
                                                                            <div class="text-danger">Xác nhận mật khẩu không khớp. Vui lòng kiểm tra lại.</div>
                                                                        </c:if>

                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!-- Save changes button-->
                                                <input type="submit" value="Thay đổi mật khẩu" name="btAction" class="btn btn-block btn-primary">

                                            </div>
                                        </div>

                                    </form>
                                </div>    

                                <div class="card mb-4">
                                    <div class="card-header">Liên kết mạng xã hội</div>
                                    <div class="card-body">

                                        <button class="btn btn-primary btn-content" type="button"><svg width="20"
                                                                                                       height="20" viewBox="0 0 20 20" fill="none"
                                                                                                       xmlns="http://www.w3.org/2000/svg">
                                            <path
                                                d="M18.8002 10.1951C18.8002 9.47569 18.7405 8.95069 18.6112 8.40625H10.2041V11.6534H15.1389C15.0394 12.4604 14.5022 13.6757 13.3082 14.4923L13.2915 14.601L15.9496 16.6133L16.1338 16.6312C17.8251 15.1048 18.8002 12.859 18.8002 10.1951Z"
                                                fill="#4285F4"></path>
                                            <path
                                                d="M10.2043 18.7499C12.6219 18.7499 14.6515 17.9721 16.134 16.6305L13.3084 14.4915C12.5523 15.0068 11.5375 15.3665 10.2043 15.3665C7.83642 15.3665 5.8267 13.8402 5.11029 11.7305L5.00528 11.7392L2.24129 13.8295L2.20514 13.9277C3.6776 16.786 6.70216 18.7499 10.2043 18.7499Z"
                                                fill="#34A853"></path>
                                            <path
                                                d="M5.11025 11.7322C4.92122 11.1878 4.81182 10.6044 4.81182 10.0016C4.81182 9.39881 4.92122 8.8155 5.1003 8.27106L5.09529 8.15511L2.29666 6.03125L2.2051 6.07381C1.59823 7.25994 1.25 8.59191 1.25 10.0016C1.25 11.4113 1.59823 12.7432 2.2051 13.9294L5.11025 11.7322Z"
                                                fill="#FBBC05"></path>
                                            <path
                                                d="M10.2043 4.63331C11.8857 4.63331 13.0199 5.34303 13.6666 5.93612L16.1937 3.525C14.6417 2.11528 12.6219 1.25 10.2043 1.25C6.70216 1.25 3.6776 3.21387 2.20514 6.07218L5.10034 8.26944C5.8267 6.15972 7.83642 4.63331 10.2043 4.63331Z"
                                                fill="#EB4335"></path>
                                            </svg><a> Liên kết với google</a></button>

                                    </div>
                                </div>

                            </div>

                        </div>

                    </div>
                </div>
            </div>
        </div>
    </body>

    <script>
        function showAccountInfo() {
            var accountInfo = document.getElementById("accountInfo");
            var changePassword = document.getElementById("changePassword");

            if (accountInfo.style.display === "none") {
                accountInfo.style.display = "block";
                changePassword.style.display = "none";
            }
        }

        function showChangePassword() {
            var accountInfo = document.getElementById("accountInfo");
            var changePassword = document.getElementById("changePassword");

            if (changePassword.style.display === "none") {
                accountInfo.style.display = "none";
                changePassword.style.display = "block";
            }
        }

        // Gọi một trong hai hàm ở đây để hiển thị một trong hai nội dung mặc định khi trang tải
        //showAccountInfo();
        //showChangePassword();

//        function showSuccessMessage() {
//            alert("Cập nhật thành công");
//
//        }

        function validateForm() {
            var username = document.getElementById("inputUsername").value;
            var email = document.getElementById("inputEmail").value;
            var phone = document.getElementById("inputPhone").value;
            var genderMale = document.getElementsByName("gender")[0].checked;
            var genderFemale = document.getElementsByName("gender")[1].checked;
            var genderOther = document.getElementsByName("gender")[2].checked;

            if (username === "" || email === "" || phone === "" || (!genderMale && !genderFemale && !genderOther)) {
                alert("Vui lòng điền đầy đủ thông tin vào các trường bắt buộc");
                return false; // Ngăn việc gửi form nếu có trường bị để trống hoặc không có giới tính được chọn
            }
            if (phone.length != 10) {
                alert("Số điện thoại phải có độ dài 10 chữ số");
                return false; // Ngăn việc gửi form nếu số điện thoại không đúng độ dài
            }

            if (!/^\d+$/.test(phone)) {
                alert("Số điện thoại chỉ được chứa các chữ số.");
                return false; // Ngăn việc gửi form nếu số điện thoại không hợp lệ
            }

            // Thực hiện cập nhật dữ liệu ở đây
            // Sau khi cập nhật thành công, gọi hàm showSuccessMessage() để hiển thị thông báo
//            showSuccessMessage();

            return true; // Cho phép gửi form nếu các trường đều đã được điền và giới tính đã được chọn và số điện thoại hợp lệ
        }

    </script>
    <% String javascript = (String) request.getAttribute("javascript");
    if (javascript != null) { %>
    <script>
        <%= javascript %>
    </script>
    <% } %>
</html>