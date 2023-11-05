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
                        <div class="listConversation col-sm-4 " style="background-color: #A3B18A; height: 590px; overflow: scroll;" >
                            <ul class="list-group">
                                <c:forEach items="${ListOfConversation}" var="conversation">
                                    <c:set var="conversationHavedShow" value="false"/>
                                    <c:forEach items="${ListOfProductInConversation}" var="Product">
                                        <c:if test="${conversationHavedShow==false}">
                                            <c:if test="${Product.productId == conversation.product_id}">
                                                <c:set var="conversationHavedShow" value="true"/>
                                                <li id="conver_${conversation.conversation_id}" class="Convert-li list-group-item border-0 m-1" 
                                                    style="background-color: #A3B18A">
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
                                                                        <div class="col-sm-6 p-0">
                                                                            <p class="mb-1">${partner.userName}</p>

                                                                            <a class=" Conversation-name"
                                                                               onclick="loadMessages(${conversation.conversation_id},${AnotherUserID});">  
                                                                                <small class="text-muted"> ${Product.title}</small>
                                                                            </a>
                                                                        </div>
                                                                        <div class="col-sm-3 p-0">
                                                                            <img src="${Product.productImage}"
                                                                                 alt="Product Image"
                                                                                 class="Product-image ml-1 " style=" object-fit: cover;
                                                                                 border-radius: 10%;  width: 60px;
                                                                                 height: 60px;">
                                                                        </div>
                                                                    </div>
                                                                </div>

                                                            </c:if>
                                                        </c:if>
                                                    </c:forEach>
                                                    <!-- just buyer can feedback -->
                                                    <c:if test="${conversation.buyer_id == Owner.user_ID}"> 
                                                        <a  onclick="openFeedbackForm(${conversation.conversation_id})">
                                                            <p style="color: yellow">
                                                                <small>Ðánh giá người bán</small>
                                                            </p>
                                                        </a>
                                                    </c:if>
                                                </li>
                                                <div class="modal fade" id="ratingModal${conversation.conversation_id}" tabindex="-1" role="dialog" aria-labelledby="ratingModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog" role="document">
                                                        <form action="CreateFeedbackServlet" method="post">
                                                            <div class="modal-content">
                                                                <div class="modal-header">
                                                                    <h5 class="modal-title" id="ratingModalLabel">Đánh giá người bán </h5>
                                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                        <span aria-hidden="true">&times;</span>
                                                                    </button>
                                                                </div>
                                                                <div class="modal-body">

                                                                    <div class="form-group">
                                                                        <label for="rating">Đánh giá:</label>
                                                                        <select name="rate" class="form-control" id="rating">
                                                                            <option value="5">5 sao</option>
                                                                            <option value="4">4 sao</option>
                                                                            <option value="3">3 sao</option>
                                                                            <option value="2">2 sao</option>
                                                                            <option value="1">1 sao</option>
                                                                        </select>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label for="comment">Bình luận:</label>
                                                                        <textarea name="feedback_content" class="form-control" id="comment"></textarea>
                                                                    </div>
                                                                </div>
                                                                <div class="modal-footer">
                                                                    <input type="hidden" name="seller_id" value="${Product.userId}" />
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
                        <div class="listMessage col-sm-8 pr-0 " style=" height: 590px;background-color: #DAD7CD; " >
                            <div style="height: 56px; " >
                                <div class="row profile-seller-info mt-2" style="display: none;">
                                    <img src=""
                                         alt="Profile Image"
                                         class="rounded-circle profile-image ml-2" style=" object-fit: cover;
                                         border-radius: 50%;  width: 50px;
                                         height: 50px;">
                                    <a id="profileLink" href="" class="username"></a>
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
                                    <div class="row ">
                                        <div class="col-10 pl-1">
                                            <input type="text" class="form-control p-0" placeholder="" 
                                                   style="width: 420px">
                                        </div>
                                        <div class="col-2 p-0">
                                            <button class="btn btn-primary">Send</button>
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
            function openFeedbackForm(conversationid) {
                $('#ratingModal' + conversationid).modal('show');
            }

            function closeEditForm(postId) {
                $('#ratingModal' + conversationid).modal('hide');
            }
            function saveChanges() {
                var editedContent = $('#edited-content').val();
                // Thực hiện các thay đổi và lưu bài viết tại đây
                closeEditForm(); // Đóng popup sau khi hoàn thành
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
