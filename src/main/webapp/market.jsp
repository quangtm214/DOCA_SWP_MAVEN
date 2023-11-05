<%-- 
    Document   : market.jsp
    Created on : Oct 4, 2023, 10:27:35 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
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

        <link rel="stylesheet" href="assets/css/marketv2.css">
        <link rel="stylesheet" href="assets/css/standar-style.css">
        <style>
            a.sell.d-flex {
                background-color: white;
            }
        </style>
    </head>

    <body>
        <c:set var="Products" value="${requestScope.listInPage}"/>
        <c:set var="SaveProductsList" value="${sessionScope.listOfSaveProduct}"/>

        <jsp:include page="header.jsp" />

        <div class="main-content">
            <div class="row row-content justify-content-center">
                <div class="product col-sm-8" >
                    <form action="DispatchServlet" method="post"> <!--this is for DispatchServlet-->
                        <div class="product-post col-sm-12 mt-2">
                            <div class="btn1 d-flex ">
                                <div class="btn-group" style="width: 200px;">
                                    <select name="city" class="form-select form-select-sm rounded-pill" style="width: 100%;" id="city"
                                            aria-label=".form-select-sm">
                                        <option value="" >
                                            Toàn quốc
                                        </option>
                                    </select> 

                                </div>

                                <div  class="btn-group" style="width: 200px;">
                                    <select name="lowerPrice" class="form-control rounded-pill" style="width: 200px;" >
                                        <option value="0" ${selectedLowerPrice == 0 ? 'selected' : ''} >Chọn theo giá</option>
                                        <option value="1000000" ${selectedLowerPrice == 1000000 ? 'selected' : ''}> giá bé hơn 1tr</option>
                                        <option value="700000" ${selectedLowerPrice == 700000 ? 'selected' : ''}> giá bé hơn 700.000</option>
                                        <option value="500000" ${selectedLowerPrice == 500000 ? 'selected' : ''}> giá bé hơn 500.000</option>
                                        <option value="300000" ${selectedLowerPrice == 300000 ? 'selected' : ''}> giá bé hơn 300.000</option>
                                        <option value="200000" ${selectedLowerPrice == 200000 ? 'selected' : ''}> giá bé hơn 200.000</option>
                                        <option value="100000" ${selectedLowerPrice == 100000 ? 'selected' : ''}> giá bé hơn 100.000</option>
                                    </select>
                                </div>



                                <div class="dropdown" style="width: 200px;">
                                    <select name="category" class="form-control  rounded-pill" style="width: 200px;">
                                        <option value="0" ${selectedCategory == 0 ? 'selected' : ''}>Danh mục</option>
                                        <option value="1" ${selectedCategory == 1 ? 'selected' : ''}>Phụ Kiện</option>
                                        <option value="2" ${selectedCategory == 2 ? 'selected' : ''}>Thức Ăn</option>
                                        <option value="3" ${selectedCategory == 3 ? 'selected' : ''}>Chuồng thú cưng</option>
                                        <option value="4" ${selectedCategory == 4 ? 'selected' : ''}>Khác</option>
                                    </select>

                                </div>

                                <div style="width: 200px;">
                                    <input type="hidden" name="listOfProduct" value="${Products}" />
                                    <input class=" rounded-pill"  style="width: 100px; height: 38px" type="submit" name="btAction" value="Lọc" />
                                </div>
                            </div>

                            <div class="tab-content">
                                <c:set var="countDisplay" value="0" />
                                <c:forEach items="${Products}" var="product">
                                    <c:set var="countDisplay" value="${count + 1}" />
                                    <div  style="position: relative; border-bottom: 1px solid rgb(224, 224, 224);">
                                        <a href="productDetailServlet?productId=${product.productId}" class="sell d-flex" style="width: 100%;">
                                            <c:set var="img" value="${product.productImage}"/>
                                            <img class="image" src=${img} alt="${product.title}">
                                            <div class="font">
                                                <c:set var="title" value="${product.title}"/>
                                                <h5><strong>${title}</strong></h5>
                                                <c:set var="price" value="${product.price}"/>
                                                <c:if test="${!product.isFree()}">
                                                    <h6 style="color:rgb(242, 106, 106);"><fmt:formatNumber value="${product.price}" type="currency" currencyCode="VND" /> đ</h6>
                                                </c:if>
                                                <c:if test="${product.isFree()}">
                                                    <h6 style="color:rgb(242, 106, 106);">miễn phí</h6>
                                                </c:if>
                                                <c:set var="address" value="${product.address}"/>
                                                <h6 style="font-size: 15px; opacity: 0.5;">${address}</h6>
                                                <h6 style="font-size: 15px; opacity: 0.5;">
                                                    <small class="text-muted">${product.formatTimeDifference()}</small>
                                                </h6>
                                            </div>
                                        </a>
                                        <c:set var="isSaved" value="false"/>
                                        <c:set var="productIDChangeSave" value="${product.productId}"/>

                                        <c:forEach items="${SaveProductsList}" var="saveProduct" >
                                            <c:if test="${saveProduct.productId == product.productId }">
                                                <c:set var="isSaved" value="true"/>
                                            </c:if>
                                        </c:forEach>
                                        <c:url var="saveProductLink" value="DispatchServlet" >
                                            <c:param name="btAction" value="saveProduct"></c:param>
                                            <c:param name="isSaved" value="${isSaved}"></c:param>
                                            <c:param name="productIDChangeSave" value="${productIDChangeSave}"></c:param>
                                        </c:url>
                                        <span class="like-icon">
                                            <a class="fa fa-heart border-0 p-0" 
                                               href="${saveProductLink}"
                                               style="color: ${isSaved=="true"? "red":"gray"}; cursor: pointer; position: absolute; bottom: 30px; right: 40px;">

                                            </a>
                                        </span>
                                    </div>
                                </c:forEach>
                                <c:if test="${countDisplay eq 0}">
                                    <p>Không có sản phẩm nào</p>
                                </c:if>
                            </div>  
                        </div>



                        <nav aria-label="Page navigation ">
                            <c:set var="numberPage" value="${requestScope.numberPage}"/>
                            <ul class="pagination justify-content-center">
                                <c:forEach begin="1" end="${numberPage}" var="i">
                                    <li class="page-item rounded-pill ${indexPageMarket==i?"active":""}" >
                                        <a class="page-link rounded-pill ml-2 mt-4" href="marketServlet?index=${i}">${i}</a>
                                    </li>
                                </c:forEach> 


                            </ul>
                        </nav>
                    </form>
                </div>
            </div>
        </div>

        <footer>

        </footer>

    </body>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.21.1/axios.min.js"></script>
    <script>
        var citis = document.getElementById("city");
        var districts = document.getElementById("district");
        var wards = document.getElementById("ward");
        var Parameter = {
            url: "https://raw.githubusercontent.com/kenzouno1/DiaGioiHanhChinhVN/master/data.json",
            method: "GET",
            responseType: "application/json",
        };
        var promise = axios(Parameter);
        promise.then(function (result) {
            renderCity(result.data);
        });
        var selectedLocal = "${selectedLocal}";
        function renderCity(data) {
            for (const x of data) {
                let selected = selectedLocal == x.Name ? true : false;
                citis.options[citis.options.length] = new Option(x.Name, x.Name, true, selected);
            }
            citis.onchange = function () {
                district.length = 1;
                ward.length = 1;
                if (this.value != "") {
                    const result = data.filter(n => n.Id === this.value);

                    for (const k of result[0].Districts) {
                        district.options[district.options.length] = new Option(k.Name, k.Id);
                    }
                }
            };
            district.onchange = function () {
                ward.length = 1;
                const dataCity = data.filter((n) => n.Id === citis.value);
                if (this.value != "") {
                    const dataWards = dataCity[0].Districts.filter(n => n.Id === this.value)[0].Wards;

                    for (const w of dataWards) {
                        wards.options[wards.options.length] = new Option(w.Name, w.Id);
                    }
                }
            };
        }



    </script>
    <script>
        var likeButtons = document.querySelectorAll(".like-button");
        var isLiked = false;

        likeButtons.forEach(function (likeButton) {
            var heartIcon = likeButton.querySelector('i');

            likeButton.addEventListener("click", function () {
                if (isLiked) {
                    heartIcon.className = "fa fa-heart-o";
                } else {
                    heartIcon.className = "fa fa-heart";
                }
                isLiked = !isLiked;
            });
        });
    </script>
</html>
