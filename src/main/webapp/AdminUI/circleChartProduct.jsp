<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Pie Chart Example</title>
        <script src="https://cdn.jsdelivr.net/npm/apexcharts@3.28.3/dist/apexcharts.min.js"></script>
        <style>
            #chartContainer {
                width: 400px;
                height: 400px;
                margin: 0 auto;
            }
        </style>
    </style>
</head>
<body>
    <div id="chartContainer"></div>

    <script>
        // Get the data from the server-side
        var data = [
        <c:forEach var="dto" items="${listCount}" varStatus="loop">
        {
        category: "${dto.categoryName}",
                count: ${dto.count}
        }<c:if test="${not loop.last}">,</c:if>
        </c:forEach>
        ];

        // Create the pie chart
        var options = {
            series: data.map(item => item.count),
            labels: data.map(item => item.category),
            chart: {
                type: 'pie'
            }
        };
        var chart = new ApexCharts(document.querySelector('#chartContainer'), options);
        chart.render();
    </script>
</body>
</html>