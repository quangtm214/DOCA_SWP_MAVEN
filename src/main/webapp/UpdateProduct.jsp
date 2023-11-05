
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
        <link rel="stylesheet" href="assets/css/post-style.css">
        <script>
            $(function () {
                $("#header").load("header.jsp");
            });
            $(function () {
                $("#footer").load("footer.jsp");
            });
        </script>
        <script>
            function showInput() {
                var inputContainer = document.getElementById("input-container");
                inputContainer.style.display = "block";
            }

            function hideInput() {
                var inputContainer = document.getElementById("input-container");
                inputContainer.style.display = "none";
            }
        </script>
    </head>

    <body>
        <jsp:include page="header.jsp" />
        <c:set var="Product" value="${requestScope.productDetail}"/>

        <div class="main-content">
            <div class="row row-content justify-content-center">

                <div class="col-sm-8 mt-5">

                    <!-- viết code vào đây -->

                    <h1>Bài đăng bán của bạn</h1>

                    <form action="UpDate_Product" method="post"  enctype="multipart/form-data">
                        <input type="hidden" name="Productid" value="${Product.productId}" />
                        <h5>Danh mục đăng tin</h5>
                        <div class="dropdown mt-3 mb-3">
                            <select class="form-select" aria-label="Default select example" name="category_Product">
                                <option value="1" ${Product.categoryId == 1 ? 'selected' : ''}>Phụ kiện</option>
                                <option value="2" ${Product.categoryId == 2 ? 'selected' : ''}>Thức ăn</option>
                                <option value="3" ${Product.categoryId == 3 ? 'selected' : ''}>Chuồng động vật</option>
                                <option value="4" ${Product.categoryId == 4 ? 'selected' : ''}>Khác</option>
                            </select>
                        </div>
                        <div class="mt-3 mb-3">
                            <label for="img" class="form-label">Hình Ảnh</label>
                            <input type="file" class="form-control" id="img" name="file" multiple >
                            <img id="preview-img"  src="${Product.productImage}" alt="Preview Image" style="max-width: 100%; max-height: 200px;">
                            <input type="hidden" name="OldImg" value="${Product.productImage}" />
                        </div>
                        <div class="mt-3 mb-3">
                            <label for="title" class="form-label">Tiêu đề</label>
                            <input type="text" class="form-control" id="title" name="title" value="${Product.title}" >
                        </div>
                        <div class="mb-3">
                            <label for="radio-fee">Tính phí:</label>
                            <input type="radio" name="fee" value="fee" id="radio-fee" onclick="showInput()" ${Product.isFree()?"" :"checked"}>
                            <br>
                            <div id="input-container" style="display: none;">
                                <label for="input-fee">Giá:</label>
                                <input type="text" name="input-fee" id="input-fee" class="form-control" value="${Product.price}">
                                <br>
                            </div>
                            <br>

                            <label for="radio-free">Miễn phí:</label>
                            <input type="radio" name="fee" value="free" id="radio-free" onclick="hideInput()" ${Product.isFree()?"checked":""}>
                        </div>
                        <div class="mb-3">
                            <label for="content" class="form-label">Nội dung</label>
                            <textarea class="form-control" id="content" name="content" rows="5" 
                                      >${Product.description}</textarea>
                        </div>
                        <!-- bat dau modal -->
                        <div class="container mt-3">
                            <!--Button mở modal--> 
                            <button type="button" class="btn btn-primary form-control" data-toggle="modal"
                                    data-target="#myModal">
                                Địa chỉ
                            </button>
                            <div id="addressResult">${Product.address}</div>
                            <input type="hidden" id="hiddenAddress" name="NewAddress">
                            <input type="hidden" name="OldAddress" value="${Product.address}">
                            <!--Modal--> 
                            <div class="modal" id="myModal">
                                <div class="modal-dialog">

                                    <div class="modal-content">
                                        <!--Modal Header--> 
                                        <div class="modal-header" data-toggle="collapse" data-target="#categoryList">
                                            <h4 class="modal-title">Địa chỉ</h4>
                                        </div>
                                        <!--Modal body--> 
                                        <div class="col-6">

                                            <select class="form-select form-select-sm mb-3" id="city" aria-label=".form-select-sm" name="city">
                                                <option value="" selected>Chọn tỉnh thành</option>
                                            </select>

                                            <select class="form-select form-select-sm mb-3" id="district" aria-label=".form-select-sm" name="district">
                                                <option value="" selected>Chọn quận huyện</option>
                                            </select>

                                            <select class="form-select form-select-sm mb-3" id="ward" aria-label=".form-select-sm" name="ward">
                                                <option value="" selected>Chọn phường xã</option>
                                            </select>
                                        </div>

                                        <!--Modal footer--> 
                                        <div class="modal-footer">

                                            <button type="submit" class="btn btn-secondary"
                                                    data-dismiss="modal">Đóng</button>
                                            <button type="submit" class="btn btn-secondary" data-dismiss="modal" 
                                                    onclick="displayAddress()">Xong</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <button  type="submit" class="submit mt-5 mb-5 btn btn-primary form-control" value="UpdateProduct">xác nhận sửa nội dung bài bán</button>

                    </form>
                </div>
            </div>
        </div>
        <div id="footer"></div>
    </body>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.21.1/axios.min.js"></script>
    <script>
                                                        var cities = document.getElementById("city");
                                                        var districts = document.getElementById("district");
                                                        var wards = document.getElementById("ward");
                                                        var Parameter = {
                                                            url: "https://raw.githubusercontent.com/kenzouno1/DiaGioiHanhChinhVN/master/data.json",
                                                            method: "GET",
                                                            responseType: "application/json"
                                                        };
                                                        var promise = axios(Parameter);
                                                        promise.then(function (result) {
                                                            renderCity(result.data);
                                                        });

                                                        function renderCity(data) {
                                                            for (const city of data) {
                                                                cities.options[cities.options.length] = new Option(city.Name, city.Name);
                                                            }
                                                            cities.onchange = function () {
                                                                districts.length = 1;
                                                                wards.length = 1;
                                                                if (this.value !== "") {
                                                                    const selectedCity = data.find(city => city.Name === this.value);

                                                                    for (const district of selectedCity.Districts) {
                                                                        districts.options[districts.options.length] = new Option(district.Name, district.Name);
                                                                    }
                                                                }
                                                            };
                                                            districts.onchange = function () {
                                                                wards.length = 1;
                                                                const selectedCity = data.find(city => city.Name === cities.value);
                                                                if (this.value !== "") {
                                                                    const selectedDistrict = selectedCity.Districts.find(district => district.Name === this.value);

                                                                    for (const ward of selectedDistrict.Wards) {
                                                                        wards.options[wards.options.length] = new Option(ward.Name, ward.Name);
                                                                    }
                                                                }
                                                            };
                                                        }

                                                        function displayAddress() {
                                                            var selectedCity = cities.value;
                                                            var selectedDistrict = districts.value;
                                                            var selectedWard = wards.value;

                                                            var address = selectedCity + " - " + selectedDistrict + " - " + selectedWard;
                                                            document.getElementById("addressResult").textContent = address;
                                                            document.getElementById("hiddenAddress").value = address;
                                                        }
    </script>
    <script>
        $(document).ready(function () {
            $('#img').change(function () {
                var input = this;

                if (input.files && input.files[0]) {
                    var reader = new FileReader();

                    reader.onload = function (e) {
                        $('#preview-img').attr('src', '');
                        $('#preview-img').attr('src', e.target.result);
                    };

                    reader.readAsDataURL(input.files[0]);
                }
            });
        });
        const inputFee = document.getElementById('input-fee');
        inputFee.addEventListener('input', formatCurrency);
        function formatCurrency() {
            let value = inputFee.value;
            value = value.replace(/[^0-9.]/g, '');
            if (value !== '') {
                value = parseFloat(value);
                inputFee.value = value.toLocaleString('en-VN', {
                    style: 'currency',
                    currency: 'VND'
                });
            } else {
                inputFee.value = '0';
            }
        }

    </script>
</html>
