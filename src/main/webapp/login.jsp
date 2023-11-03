<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html >
    <head>
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

        <!-- Style -->
        <link rel="stylesheet" href="assets/css/login-style.css">

        <title>Login</title>
    </head>

    <body>


        <div class="d-lg-flex half">
            <div class="bg order-1 order-md-2" style="background-image: url('assets/images/dog-and-cat-cover.jpg');"></div>
            <div class="contents order-2 order-md-1">

                <div class="container">
                    <div class="row align-items-center justify-content-center">
                        <div class="col-md-7">
                            <p class="mb-4">Platform for dog and cat lovers.</p>
                            <h3>Login to <strong>Doca</strong></h3>

                            <form action="DispatchServlet">
                                <div class="form-group first">
                                    <label for="username">Username</label>
                                    <input type="text"  name="username" id="username" class="form-control" placeholder="Enter your username" id="username">
                                </div>
                                <div class="form-group last mb-3">
                                    <label for="password">Password</label>
                                    <input type="password"  name="password" id="password" class="form-control" placeholder="Enter your Password" id="password">
                                </div>

                                <div class="d-flex mb-5 align-items-center">
                                    <!--                                    <label class="control control--checkbox mb-0"><span class="caption">Remember me</span>
                                                                            <input type="checkbox" checked="checked" />
                                                                            <div class="control__indicator"></div>
                                                                        </label>-->
                                    <a href="https://accounts.google.com/o/oauth2/auth?scope=email profile&redirect_uri=http://localhost:9939/DOCA_java/GoogleSigninServlet&response_type=code
                                       &client_id=1064043187978-lkhbeshhf0i9hkoqbi30g48tt002klqu.apps.googleusercontent.com&approval_prompt=force" class="btn-google">
                                        <i class="fab fa-google"></i> <span class="btn-google-text">Login With Google</span>
                                    </a>
                                    <span class="ml-auto"><a href="#" class="forgot-pass">Forgot Password</a></span>
                                </div>

                                <input type="submit" value="Log In" name="btAction" class="btn btn-block btn-primary">
                                <p class="footer">Chưa có tài khoản ? đăng kí<a href="signup.jsp"> tại đây </a></p>
                            </form>
                        </div>
                    </div>
                </div>
            </div>


        </div>



        <script src="assets/js/login-main.js"></script>
    </body>

</html>