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
    <style>
        .button {
            display: inline-block;
            padding: 10px 20px;
            font-size: 16px;
            font-weight: bold;
            text-align: center;
            text-decoration: none;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        /* Primary button style */
        .primary-button {
            background-color: #ff6f00;
            color: #fff;
        }

        /* Secondary button style */
        .secondary-button {
            background-color: #ffab40;
            color: #fff;
        }
        #showAccountInfoButton {
            transition: transform 0.3s, filter 0.3s;
        }

        #showAccountInfoButton:hover {
            transform: scale(1.05); /* Hiệu ứng nổi lên khi di chuột vào */
            filter: brightness(90%); /* Màu tối đi khi di chuột vào */
        }
        #showChangePasswordButton {
            transition: transform 0.3s, filter 0.3s;
        }

        #showChangePasswordButton:hover {
            transform: scale(1.05); /* Hiệu ứng nổi lên khi di chuột vào */
            filter: brightness(90%); /* Màu tối đi khi di chuột vào */
        }
    </style>
    <body>


        <c:set var="stateChangePass" value="${requestScope.stateChangePass}"/>
        <c:if test="${empty stateChangePass }">
            <c:set var="stateChangePass" value="false"/>
        </c:if>

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
                                        <button class="button primary-button" id="showAccountInfoButton" onclick="showAccountInfo()">Thay đổi thông tin tài khoản</button>
                                        <button class="button secondary-button" id="showChangePasswordButton" onclick="showChangePassword()">Thay đổi mật khẩu</button>
                                    </div>
                                </div>
                                <!-- Account details card-->
                                <div id="accountInfo" style="display: ${stateChangePass==false?'block':'none'};">
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
                                                           placeholder="Username" value="${Owner.userName}" name="txtUsername" required="" >
                                                    <c:if test="${not empty requestScope.isUsernameTaken}">
                                                        <div class="text-danger">Tên người dùng đã tồn tại. Vui lòng chọn một tên khác.</div>
                                                    </c:if>

                                                </div>
                                                <div class="mb-3">
                                                    <label class="small mb-1" for="inputUsername" >Email<span
                                                            class="red-star">*</span></label>
                                                    <input class="form-control" id="inputEmail" type="email"
                                                           placeholder="" value="${Owner.email}" name="txtEmail" required="">
                                                    <c:if test="${not empty requestScope.isEmailTaken}">
                                                        <div class="text-danger">Email đã tồn tại. vui lòng chọn email khác.</div>
                                                    </c:if>
                                                </div>
                                                <!-- Form Group (Phone)-->
                                                <div class="mb-3">
                                                    <label class="small mb-1" for="inputPhone">Số điện thoại <span
                                                            class="red-star">*</span></label>
                                                    <input class="form-control" id="inputPhone" type="number"
                                                           placeholder="Enter your phone number" value="${Owner.mobileNum}" name="txtPhone"  
                                                           required>
                                                    <p id="inputPhoneError" class="text-danger"></p>
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
                                <div id="changePassword" style="display: ${stateChangePass==true?'block':'none'};">
                                    <form action="DispatchServlet" method="post">

                                        <div class="card mb-4">
                                            <div class="card-header">Thông tin tài khoản</div>
                                            <div class="card-body">



                                                <!-- Form Row-->

                                                <div class="form-change-password">
                                                    <div class="row">
                                                        <div class="col-12 col-sm-6 mb-3">
                                                            <div class="mb-2"><b>Thay đổi mật khẩu</b></div>
                                                            <p class="text-success">${SucessMessage}</p>
                                                            <div class="row">

                                                                <div class="col">
                                                                    <div class="form-group">
                                                                        <label class="small mb-1" for="inputCurPassword">Mật khẩu hiện tại <span
                                                                                class="red-star">*</span></label>

                                                                        <input class="form-control" id="inputCurPassword" type="password" name="txtCurPass" value="${Owner.password}" placeholder="">


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
                                                                               placeholder="">
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="row">
                                                                <div class="col">
                                                                    <div class="form-group">
                                                                        <label class="small mb-1" for="inputConfirm">Xác nhận mật khẩu <span
                                                                                class="red-star">*</span></label>
                                                                        <input class="form-control" id="inputConfirm" type="password"
                                                                               placeholder="" name="txtConfirm">
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
                            </div>

                        </div>

                    </div>
                </div>
            </div>
        </div>
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


            function validateForm() {
                console.log("sdt invalid");
                var username = document.getElementById("inputUsername").value;
                var email = document.getElementById("inputEmail").value;
                var phone = document.getElementById("inputPhone").value;


                if (username === "" || email === "" || phone === "") {
                    alert("Vui lòng điền đầy đủ thông tin vào các trường bắt buộc");
                    return false; // Ngăn việc gửi form nếu có trường bị để trống hoặc không có giới tính được chọn
                }
                if (phone.length != 10) {
                    var errorElement = document.getElementById("inputPhoneError");
                    errorElement.textContent = "Số điện thoại phải có 10 chữ số.";
                    return false;
                }


                return true; // Cho phép gửi form nếu các trường đều đã được điền và giới tính đã được chọn và số điện thoại hợp lệ
            }

        </script>

    </body>


</html>