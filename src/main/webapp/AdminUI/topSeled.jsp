<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>User Post Ranking</title>
        <!-- Add Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <!-- Add Chart.js library -->
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <!-- Add Chart.js plugin for data labels -->
        <script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>
    </head>

    <body> 
       
        <div class="container" style="width: 500px">

            <canvas id="postChart"></canvas>
        </div>

        <!-- Add Bootstrap JS -->
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

        <c:set var="listTop" value="${requestScope.listUserByRank}"/> <!-- Ensure that the 'listTop' variable is set -->

        <script>
            document.addEventListener('DOMContentLoaded', () => {
            <%-- Get data from the data attribute --%>
            const data = [
            <c:forEach items="${listTop}" var="userPost" varStatus="loop">
            {
            user: '${userPost.userName}',
                    posts: ${userPost.countPostOfMonth},
                    avatar: '${userPost.avatar}'
            }<c:if test="${not loop.last}">,</c:if>
            </c:forEach>
            ];
            <%-- Extract user and post counts from the data --%>
            const users = data.map(item => item.user);
                    const posts = data.map(item => item.posts);
                    const avatars = data.map(item => item.avatar);
            <%-- Create a chart using Chart.js --%>
            const ctx = document.getElementById('postChart').getContext('2d');
                    new Chart(ctx, {
                    type: 'bar',
                            data: {
                            labels: users,
                                    datasets: [{
                                    label: 'Thành viên bán được nhiều sản phẩm',
                                            data: posts,
                                            backgroundColor: 'rgba(75, 192, 192, 0.6)',
                                            borderColor: 'rgba(75, 192, 192, 1)',
                                            borderWidth: 0.5,
                                            barThickness: 40 // Adjust the thickness of the bars
                                    }]
                            },
                            options: {
                            responsive: true,
                                    scales: {
                                    x: {
                                    display: true, // Display the x-axis
                                            grid: {
                                            display: false // Hide the x-axis grid lines
                                            }
                                    },
                                            y: {
                                            display: false // Hide the y-axis
                                            }
                                    },
                                    plugins: {
                                    datalabels: {
                                    anchor: 'end',
                                            align: 'top', // Display labels at the top of the bars
                                            formatter: function (value, context) {
                                            const index = context.dataIndex;
                                                    const user = users[index];
                                                    const postCount = posts[index];
                                                    const avatarnn = avatars[index];
                                                    return `<img src="${avatarnn}" alt="Avatar" width="40" height="40"> ${user}: ${postCount}`; // Display user and post count
                                            },
                                            color: '#000', // Set the color of the data labels
                                            font: {
                                            size: 16,
                                            weight: 'bold' // Set the font weight of the data labels
                                            },
                                            offset: 0, // Set the offset of the data labels
                                            padding: {
                                            top: 5 // Set the padding at the top of the data labels
                                            }
                                    }
                                    }
                            }
                    });
            });
        </script>
    </body>
</html>