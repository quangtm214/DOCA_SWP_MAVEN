<%-- 
    Document   : signup
    Created on : Oct 12, 2023, 10:37:31 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="vi">
<head>
   <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta http-equiv="x-ua-compatible" content="ie-edge">
    <title>Đăng ký tài khoản</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="fontawesome-free-6.4.2-web/css/fontawesome.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

    <!-- Custom CSS -->
    
    <link rel="stylesheet" href="assets/css/standar-style.css">
    <link rel="stylesheet" href="assets/css/forum-style-V3.css">
</head>
<body class="bo1">
    <div class="container mt-3 text-center" >
        <div class="rounded-circle">
            <img src="assets/images/3200d8638cee49468cc31caf01adb0d0.png" alt="Logo" style="max-width: 100px; border-radius: 50%;">
        </div>
    </div>
    
    
    <div class="container mt-5" style="background-color: #f9f9f9" >
        <div class="row justify-content-center">
            <div class="col-md-6">
                <form id="registrationForm" action="DispatchServlet" method="POST">
                    <h3 class="mb-4 text-center">Đăng ký tài khoản</h3>
                   
                    <div class="form-group">
                        <label for="username">Tên đăng nhập</label>
                        <input type="text" id="username" class="form-control" placeholder="Tên đăng nhập" name="txtUsername" required>
                        <i class="zmdi zmdi-account"></i>
                    </div>
                     <c:set var="usernameTaken" value="${param.usernameTaken}" />
                     <c:if test="${param.usernameTaken eq 'true'}">
                         <div class="alert alert-danger">Tên đăng nhập đã tồn tại. Vui lòng chọn tên khác.</div>
                     </c:if>

                    <div class="form-group">
                        <label for="email">Email</label>
                        <input type="email" id="email" class="form-control" placeholder="Email" name="txtEmail" required>
                        <i class="zmdi zmdi-email"></i>
                    </div>
                         <c:if test="${not empty param.emailTaken}">
                             <div class="alert alert-danger">Email đã được sử dụng. Vui lòng sử dụng địa chỉ email khác.</div>
                         </c:if>
                    
                    
                    <div class="form-group">
                        <label for="phone">Số điện thoại</label>
                        <input type="text" id="phone" class="form-control" placeholder="Số điện thoại" name="txtPhone" required> 
                    </div>
                    
                    
                    <div class="form-group">
                        <label for="gender">Giới tính</label>
                        <select id="gender" class="form-control" name="txtGender" required>
                            <option value="" disabled selected>Chọn giới tính</option>
                            <option value="male">Nam</option>
                            <option value="female">Nữ</option>
                            <option value="other">Khác</option>
                        </select>
                    </div>
                    
                    
                    <div class="form-group">
                        <label for="password">Mật khẩu</label>
                        <input type="password" id="password" class="form-control" placeholder="Mật khẩu" name="txtPassword" required>                 
                    </div>
                    
                    
                    <div class="form-group">
                        <label for="confirmPassword">Xác nhận mật khẩu</label>
                        <input type="password" id="confirmPassword" class="form-control" placeholder="Xác nhận mật khẩu" name="txtConfirm" required>
                        <span class="error-text" id="confirmPasswordError"></span>
                    </div>
                    
                    
                   <div class="form-group">
                       <label for="avatar">Chọn ảnh đại diện (Avatar)</label>
                       <input type="file" id="avatar" class="form-control" name="avatarFile">
                    </div>
                    
                   <button class="btn btn-primary" value="Create New Account" name="btAction" onclick="return validateForm()">
                       Đăng ký tài khoản <i class="zmdi zmdi-arrow-right">
                            </i></button>
                   <p class="footer mt-3 text-center">Đã có tài khoản? <a href="login.jsp">Đăng nhập</a></p>
                </form>
            </div>
        </div>
    </div>
<script>
    document.querySelector('form').addEventListener('submit', function(event) {
        const password = document.getElementById('password').value;
        const confirmPassword = document.getElementById('confirmPassword').value;
        const confirmPasswordError = document.getElementById('confirmPasswordError');
        
        if (password !== confirmPassword) {
            confirmPasswordError.textContent = 'Mật khẩu xác nhận không khớp.';
            event.preventDefault(); // Ngăn chặn việc gửi biểu mẫu nếu có lỗi
        } else {
            confirmPasswordError.textContent = ''; // Xóa thông báo lỗi nếu mật khẩu khớp
        }
    });
    
    function validateForm() {
    var form = document.getElementById("registrationForm");
    var requiredFields = form.querySelectorAll('[required]');

    for (var i = 0; i < requiredFields.length; i++) {
        if (requiredFields[i].value.trim() === '') {
            alert("Vui lòng điền tất cả thông tin.");
            return false; // Prevent the form from being submitted
        }
    }

    return true; // Allow the form to be submitted if all required fields are filled
}
</script>
    <!-- Bootstrap và jQuery Scripts -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>