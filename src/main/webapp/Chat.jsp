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
        <link rel="stylesheet" href="assets/css/chat-style.css">
        <style>
            .rating input[type="radio"] {
                display: none;
            }

            .rating label {
                display: inline-block;
                cursor: pointer;
            }

            .rating label i.fa-star {
                color: #ddd;
            }

            .rating label i.filled {
                color: orange;

            }
            .chat-point:hover{
                cursor: pointer;
            }
            .cancel {
                transition: transform 0.3s, filter 0.3s;
            }

            .cancel:hover {
                transform: scale(1.05); /* Hiệu ứng nổi lên khi di chuột vào */
                filter: brightness(90%); /* Màu tối đi khi di chuột vào */
            }
            .success {
                transition: transform 0.3s, filter 0.3s;
            }

            .success:hover {
                transform: scale(1.05); /* Hiệu ứng nổi lên khi di chuột vào */
                filter: brightness(90%); /* Màu tối đi khi di chuột vào */
            }
        </style>
    </head>

    <body>
        <c:set var="ListOfConversation" value="${sessionScope.ListOfConversation}"/>
        <c:set var="ListOfProductInConversation" value="${sessionScope.ListOfProductInConversation}"/>
        <c:set var="ListOfPartner" value="${sessionScope.ListOfPartner}"/>
        <c:set var="ListOfMessage" value="${requestScope.ListOfMessage}"/>
        <c:set var="Owner" value="${sessionScope.USER_NAME}"/>
        <jsp:include page="header.jsp" />

        <div class="main-content">
            <div class="row row-content justify-content-center">
                <div class="chat col-sm-9 mt-4" >
                    <div class="row container p-0">
                        <div class="listConversation col-sm-4 " style="background-color: #A2D9CE; height: 590px; overflow: scroll;" >
                            <ul class="list-group">
                                <c:forEach items="${ListOfConversation}" var="conversation">
                                    <c:set var="conversationHavedShow" value="false"/>
                                    <c:forEach items="${ListOfProductInConversation}" var="Product">
                                        <c:if test="${conversationHavedShow==false}">
                                            <c:if test="${Product.productId == conversation.product_id}">
                                                <c:set var="conversationHavedShow" value="true"/>
                                                <li id="conver_${conversation.conversation_id}" class="Convert-li list-group-item border-0 m-1
                                                    ${stayConversation.conversation_id == conversation.conversation_id ? 'active':''}" 
                                                    style="background-color: #A2D9CE">
                                                    <c:if test="${conversation.seller_id==Owner.user_ID}">
                                                        <c:set var="AnotherUserID" value="${conversation.buyer_id}"/>
                                                    </c:if>
                                                    <c:if test="${conversation.buyer_id==Owner.user_ID}">
                                                        <c:set var="AnotherUserID" value="${conversation.seller_id}"/>
                                                    </c:if>
                                                    <c:set var="partnerhaveShow" value="false"/>
                                                    <c:forEach items="${ListOfPartner}" var="partner">
                                                        <c:if test="${partnerhaveShow==false}">
                                                            <c:if test="${partner.user_ID == conversation.buyer_id || partner.user_ID == conversation.seller_id}">
                                                                <c:set var="partnerhaveShow" value="true"/>
                                                                <div class="container p-0">
                                                                    <div class="row" >
                                                                        <div class="col-sm-3 p-0">
                                                                            <img src="${partner.avatar}"
                                                                                 alt="Profile Image"
                                                                                 class="rounded-circle profile-image" style=" object-fit: cover;
                                                                                 border-radius: 50%;  width: 46px;
                                                                                 height: 46px;">
                                                                        </div>
                                                                        <div class="col-lg-6 p-0">
                                                                            <p class="mb-1">${partner.userName}</p>


                                                                            <a class=" Conversation-name "
                                                                               onclick="loadMessages(${conversation.conversation_id},${AnotherUserID});">  
                                                                                <small class="d-inline-block text-truncate chat-point"  style="color: black;max-width: 150px; max-height: 3em;"> ${Product.title}</small>
                                                                            </a>

                                                                        </div>
                                                                        <div class="col-xl-3 p-0">
                                                                            <img src="${Product.productImage}"
                                                                                 alt="Product Image"
                                                                                 class="Product-image ml-1 " style=" object-fit: cover;
                                                                                 border-radius: 10%;  max-width: 60px;
                                                                                 max-height: 60px;">
                                                                        </div>
                                                                    </div>
                                                                </div>

                                                            </c:if>
                                                        </c:if>
                                                    </c:forEach>
                                                    <!-- just buyer can feedback -->
                                                    <c:if test="${conversation.buyer_id == Owner.user_ID}"> 
                                                        <c:if test="${conversation.status=='approve'}">
                                                            <div class="row">
                                                                <div class="col-md-6 p-0">
                                                                    <p style="color: #119077;">
                                                                        <small>Giao dịch đang thực hiện</small>
                                                                    </p> 
                                                                </div>
                                                                <div class="col-md-6 p-0">
                                                                    <button class="success rounded-pill" style="background-color: #2874A6;" 
                                                                            data-toggle="tooltip"
                                                                            data-placement="top" title="Bạn đã nhận được sản phẩm từ người bán."
                                                                            >
                                                                        <a class="text-dark" href="completeConversation?buyerID=${conversation.buyer_id }&producID=${Product.productId}">
                                                                            Đã nhận hàng
                                                                        </a>
                                                                    </button>
                                                                </div>
                                                            </div>
                                                        </c:if>
                                                        <c:if test="${conversation.status=='complete'}">
                                                            <div class="row">
                                                                <div class="col-md-6 p-0">
                                                                    <p style="color: #E3B71A;">
                                                                        <small>Giao dịch thành công</small>
                                                                    </p> 
                                                                </div>
                                                                <div class="col-md-6 p-0">
                                                                    <a onclick="openFeedbackForm(${conversation.conversation_id})"
                                                                       data-toggle="tooltip"
                                                                       data-placement="top" title="Đánh giá người bán và sản phẩm."
                                                                       >
                                                                        <p style="color: #95A5A6;">
                                                                            Đánh giá người bán
                                                                        </p>
                                                                    </a>
                                                                </div>
                                                            </div>
                                                        </c:if>

                                                        <c:if test="${conversation.status == 'reject'}">
                                                            <p>
                                                                <small class="" style="color: #EC7063;">Giao dịch đã bị hủy 
                                                                    <i class="fa fa-exclamation"></i>
                                                                    Bạn không thể theo dõi sản phẩm này nữa
                                                                </small>
                                                            </p>

                                                        </c:if>
                                                        <c:if test="${Product.status=='saled'}">
                                                            <c:if test="${conversation.status !='approve' && conversation.status !='complete' }">
                                                                <p><small style="color: #6330B7;">Rất tiếc: Sản phẩm đã bán cho người khác</small></p>
                                                            </c:if>
                                                        </c:if> 
                                                    </c:if>
                                                    <c:if test="${conversation.seller_id == Owner.user_ID}">
                                                        <c:if test="${conversation.status == 'approve'}">
                                                            <div class="row m-0">
                                                                <div class="col-md-7 pr-0">
                                                                    <p style="color: #119077;">
                                                                        <small>Giao dịch đang thực hiện</small>
                                                                    </p> 
                                                                </div>
                                                                <div class="col-md-5 p-0">
                                                                    <button class="cancel rounded-pill" style="background-color: #EC7063;" 
                                                                            data-toggle="tooltip"
                                                                            data-placement="top" title="Hủy giao dịch khi khách hàng đổi ý hoặc không nhận hàng."
                                                                            >
                                                                        <a class="text-dark" href="cancelTransaction?buyerID=${conversation.buyer_id }&producID=${Product.productId}">
                                                                            Hủy giao dịch
                                                                        </a>
                                                                    </button>
                                                                </div>
                                                            </div>
                                                        </c:if>
                                                        <c:if test="${conversation.status == 'waiting'}">
                                                            <c:if test="${Product.status=='saled'}">
                                                                <p><small style="color: #F02100;">Sản phẩm đã giao dịch với khách hàng khác</small></p>
                                                            </c:if>
                                                            <c:if test="${Product.status =='approved'}">
                                                                <button class="success rounded-pill" style="background-color: #4BAC74;" 
                                                                        data-toggle="tooltip"
                                                                        data-placement="top" title="Xác nhận sẽ giao dịch với khách hàng này."
                                                                        >
                                                                    <a class="text-dark" href="confirmSave?buyerID=${conversation.buyer_id }&producID=${Product.productId}">
                                                                        Chấp nhận giao dịch
                                                                    </a>
                                                                </button>
                                                            </c:if>
                                                        </c:if>
                                                        <c:if test="${conversation.status == 'reject'}">
                                                            <p>
                                                                <small class="" style="color: #EC7063;">Giao dịch đã bị hủy
                                                                    <i class="fa fa-exclamation"></i>
                                                                </small>
                                                            </p>
                                                        </c:if>
                                                        <c:if test="${conversation.status == 'complete'}">
                                                            <p style="color: #E3B71A;"
                                                               data-toggle="tooltip"
                                                               data-placement="top" title="Cuộc giao dịch thành công."
                                                               >
                                                                <small>Khách hàng đã nhận được sản phẩm</small>
                                                            </p> 
                                                        </c:if>
                                                    </c:if>





                                                </li>
                                                <div class="modal fade" id="ratingModal${conversation.conversation_id}" tabindex="-1" role="dialog" aria-labelledby="ratingModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog" role="document">
                                                        <form action="CreateFeedbackServlet" method="post">
                                                            <div class="modal-content">
                                                                <div class="modal-header">
                                                                    <h5 class="modal-title" id="ratingModalLabel">Đánh giá người bán </h5>
                                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">×</button>
                                                                </div>
                                                                <div class="modal-body">
                                                                    <div class="form-group start">
                                                                        <label for="ratingTitle">Đánh giá:</label>
                                                                        <div class="rating">
                                                                            <input type="radio" id="rating1" name="rating" value="1" onchange="changeStarRating(1)" />
                                                                            <label for="rating1"><i id="star1" class="far fa-star"></i></label>

                                                                            <input type="radio" id="rating2" name="rating" value="2" onchange="changeStarRating(2)" />
                                                                            <label for="rating2"><i id="star2" class="far fa-star"></i></label>

                                                                            <input type="radio" id="rating3" name="rating" value="3" onchange="changeStarRating(3)" />
                                                                            <label for="rating3"><i id="star3" class="far fa-star"></i></label>

                                                                            <input type="radio" id="rating4" name="rating" value="4" onchange="changeStarRating(4)" />
                                                                            <label for="rating4"><i id="star4" class="far fa-star"></i></label>

                                                                            <input type="radio" id="rating5" name="rating" value="5" onchange="changeStarRating(5)" />
                                                                            <label for="rating5"><i id="star5" class="far fa-star"></i></label>
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label for="comment">Bình luận:</label>
                                                                        <textarea name="feedback_content" class="form-control" id="comment"></textarea>
                                                                    </div>
                                                                </div>
                                                                <div class="modal-footer">

                                                                    <input type="hidden" name="seller_id" value="${Product.userId}" />
                                                                    <input type="hidden" id="hiddenRating${conversation.conversation_id}" name="rate" value="" />
                                                                    <input type="hidden" name="product_id" value="${conversation.product_id}" />
                                                                    <button type="submit" class="btn btn-primary">Gửi đánh giá</button>
                                                                </div>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>
                                            </c:if>
                                        </c:if>
                                    </c:forEach>
                                </c:forEach>
                            </ul>
                        </div>
                        <div class="listMessage col-sm-8 pr-0 " style=" height: 590px;background-color: #9DCAC1; " >
                            <div style="height: 50px; " >
                                <div class="row profile-seller-info mt-2" style="display: none;">
                                    <img src=""
                                         alt="Profile Image"
                                         class="rounded-circle profile-image ml-2" style=" object-fit: cover;
                                         border-radius: 50%;  width: 50px;
                                         height: 50px;">
                                    <a id="profileLink" style="color: black;" href="" class="username"></a>
                                </div>
                            </div>
                            <!-- Message list content goes here -->
                            <div id="messageContainer" style="height: 490px; overflow:scroll;">
                                <div id="slogan" class="chat-message d-flex justify-content-center align-items-center" style=" height: 400px;">
                                    <p>Chat để kết nối - Cùng nhau làm nên giao dịch tốt nhất!</p>
                                </div>
                            </div>
                            <div > 
                                <form id="message_input" style="display: none;">
                                    <div class="row d-flex justify-content-between m-0">
                                        <div class=" pl-0 flex-grow-1">
                                            <input type="text" class="form-control p-0" placeholder="" 
                                                   style="width: 100%">
                                        </div>
                                        <div class="mr-3">
                                            <button class="btn  " style="background-color:  #7FB3D5;">
                                                <i class="fa fa-paper-plane"></i>
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script>
            let conversationidRating;
            function openFeedbackForm(conversationid) {
                $('#ratingModal' + conversationid).modal('show');
                conversationidRating = conversationid;
            }

            function closeEditForm(postId) {
                $('#ratingModal' + conversationid).modal('hide');

            }
            function saveChanges() {
                var editedContent = $('#edited-content').val();
                // Thực hiện các thay đổi và lưu bài viết tại đây
                closeEditForm(); // Đóng popup sau khi hoàn thành
            }

            function changeStarRating(rating) {
                var ratingform = document.getElementById('ratingModal' + conversationidRating);
                var hiddenInput = document.getElementById('hiddenRating' + conversationidRating);
                var stars = ratingform.querySelectorAll('.rating label i');
                for (var i = 0; i < stars.length; i++) {
                    stars[i].classList.remove('filled');
                    console.log(stars[i].classList);
                }
                for (var i = 0; i < rating; i++) {
//                  
                    stars[i].classList.add('filled');
//                  
                }

                hiddenInput.setAttribute('value', rating);

            }
        </script>
        <script>
            let currentConversationID;
            let FirstRender = true;
            function loadMessages(conversationID, AnotherUserID) {
                if (typeof messageInterval !== 'undefined') {
                    clearInterval(messageInterval);
                    console.log("xóa inteval cu")
                }
                currentConversationID = conversationID;
                const liElements = document.getElementsByClassName("Convert-li");
                for (let i = 0; i < liElements.length; i++) {
                    const liElement = liElements[i];
                    liElement.id !== "conver_" + conversationID ?
                            liElement.classList.remove('active') : (liElement.classList.add('active'), FirstRender = true);
                    //put active for conversation have been choosed
                }
                const message_input = document.getElementById('message_input');
                const fetchAndRenderMessages = () => {
                    fetch('getMessageInConversation?conversationID=' + currentConversationID)
                            .then(response => response.json())
                            .then(data => {
                                renderMessages(data);
                                message_input.style.display = 'block';
                            });
                };
                const fetchAndRenderOtherProfile = () => {
                    fetch('getOtherUserProfileServlet?userID=' + AnotherUserID)
                            .then(response => response.json())
                            .then(data => {
                                renderOtherProfile(data);
                                console.log(data);
                            });
                };
                fetchAndRenderOtherProfile();
                fetchAndRenderMessages();
                messageInterval = setInterval(fetchAndRenderMessages, 1000);

            }
            const renderOtherProfile = (data) => {
                const profileInfo = document.querySelector('.profile-seller-info');
                const profileImage = profileInfo.querySelector('.profile-image');
                const username = profileInfo.querySelector('.username');
                const profileLink = document.getElementById('profileLink');
                // Cập nhật thông tin người bán
                profileImage.src = data.avatar;
                username.textContent = data.userName;
                profileLink.href = "Profilemember?userId=" + data.user_ID;
                // Hiển thị phần tử profile-seller-info
                profileInfo.style.display = 'block';
            };
            function renderMessages(messages) {
                var messageContainer = document.getElementById('messageContainer');

                messageContainer.innerHTML = '';
                if (messages.content === "Không có tin nhắn.") {
                    messageContainer.innerHTML = `
                                <div class="default-message">
                                <p>Bắt đầu nhắn tin để thực hiện mua bán</p>
                                </div>`;
                } else {
                    var messageDivs = messages.map(function (message) {
                        if (message.user_id === ${Owner.user_ID}) {

                            messageDiv = `
                                       <div class="col-6 offset-6 pt-2">
                                          <div class="my-message bg-info text-white pt-2 pb-2 pl-3 pr-3">`
                                    + message.messages_content +
                                    `</div>
                                      </div>`;
                        } else {

                            messageDiv = `
                                          <div class="col-6 pt-2">
                                              <div class="their-message bg-secondary text-white pt-2 pb-2 pl-3 pr-3">`
                                    + message.messages_content +
                                    `</div>
                                          </div>
                                          <div class="col-6 pt-2">
                                          </div>
                                           `;
                        }
                        return messageDiv;
                    });
                    messageContainer.innerHTML = messageDivs.join('');
                    if (FirstRender) {
                        messageContainer.scrollTop = messageContainer.scrollHeight;
                        FirstRender = false; //just the fist time render it go the bottom of the chat
                    }
                }
            }

            const form = document.getElementById('message_input');
            const input = form.querySelector('input');
            const button = form.querySelector('button');
            button.addEventListener('click', sendMessage);
            function sendMessage(event) {
                event.preventDefault();
                const message = input.value;
                if (message.trim() === '') {
                    return;
                }
                console.log(message)
                const conversationID = currentConversationID;
                console.log(conversationID)
                fetch('createMessage?message=' + message + '&conversationID=' + conversationID)
                        .then(response => response.json())
                        .then(result => {
                            console.log(result);
                        })
                        .catch(error => {
                            console.error('Error:', error);
                        });
                input.value = '';
            }
        </script>
    </body>
</html>
