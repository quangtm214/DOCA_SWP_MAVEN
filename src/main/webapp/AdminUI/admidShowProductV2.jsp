<%-- 
    Document   : admidShowProductV2
    Created on : Oct 16, 2023, 9:44:31 PM
    Author     : Admin
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
    <body>
        <!--set var-->
        <c:set var="Products" value="${requestScope.listOfProduct}"/>

        <jsp:include page="headerAdmin.jsp" />

        <div class="container"  style="margin-top: 150px;">
           
            <ul class="nav nav-tabs mb-4">
                <li class="nav-item">
                    <a class="nav-link " data-bs-toggle="tab" onclick="redirectToPostServlet()">Forum</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" data-bs-toggle="tab" href="#product">Product</a>
                </li>
            </ul>

            <div class="tab-content">
                <div class="tab-pane fade show active container" id="product">
                    <div class="row">
                        <div class="col-sm-1"></div>
                        <div class="list-group col-sm-10">
                            <c:forEach items="${Products}" var="product">
                                <!--<form action="ManagePostProductServlet">-->
                                <div class="list-group-item list-group-item-action p-0">
                                    <div class="post my-4 border rounded position-relative  p-0">
                                        <div class="post-body row" >
                                            <c:set var="img" value="${product.productImage}"/>
                                            <div class="col-sm-4">
                                                <img class="image" src=${img} alt="Hình ảnh" style="max-width: 250px; max-height: 250px; border-radius: 2%; object-fit: cover;"/>
                                            </div>
                                            <div class="font col-sm-8 ">
                                                <h5><strong>${title}</strong></h5>

                                                <c:if test="${!product.isFree()}">
                                                    <h6 style="color:rgb(242, 106, 106);">Giá: <fmt:formatNumber value="${product.price}" type="currency" currencyCode="VND" /></h6>
                                                </c:if>
                                                <c:if test="${product.isFree()}">
                                                    <h6 style="color:rgb(242, 106, 106);">Miễn phí</h6>
                                                </c:if>
                                                <br>
                                                <h6 style="font-size: 15px; opacity: 0.5;">Ðịa chỉ: ${product.address}</h6>
                                                <p>${product.productContentFormat()}</p>
                                            </div>
                                        </div>



                                        <div class="post-footer">
                                            <div class="container">
                                                <div class="row">
                                                    <div class="col-sm-3">
                                                        <form action="ManagePostProductServlet">
                                                            <input type="hidden" name="productId" value="${product.productId}" />
                                                            <input type="hidden" name="productTitle" value="${product.title}" />
                                                            <button class="btn btn-success approval-button" name="status" value="approve"><i class="fa-solid fa-check"></i> Duyệt</button>
                                                        </form>
                                                    </div>
                                                    <div class="col-sm-6"></div>
                                                    <div class="col-sm-3">
                                                        <button class="btn btn-danger rejection-button" onclick="showForm(${product.productId})"><i class="fa-solid fa-xmark"></i> Không duyệt</button>
                                                    </div>
                                                </div>
                                            </div>
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
                                                        <option >Giá cả không hợp lý</option>
                                                    </select>
                                                </div>
                                                <input type="hidden" name="status" value="reject" />
                                                <input type="hidden" name="productTitle" value="${product.title}" />
                                                <input type="hidden" name="productId" value="${product.productId}" />
                                                <input type="submit" name="" value="Gửi" />
                                            </form>
                                        </div>
                                    </div>
                                </div>
                                <script>
                                    function redirectToPostServlet() {
                                        window.location.href = "AdminManageForumPostServlet";
                                    }
                                </script>
                                <!--</form>-->
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
                                        var rejectManageProductPost = document.getElementById("RejectManageProductPost").href;
                                        rejectManageProductPost += "?reasonSelect=" + encodeURIComponent(reasonSelect);
                                        document.getElementById("RejectManageProductPost").href = rejectManageProductPost;
                                    }
                                </script>
                            </c:forEach>
                        </div>
                        <div class="col-sm-1"></div>
                    </div>
                </div>
            </div>
        </div>



    </body>
</html>
