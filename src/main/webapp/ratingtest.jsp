<%-- 
    Document   : ratingtest
    Created on : Nov 18, 2023, 12:45:17 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />
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
    </style>
    </head>
    <body>
        <form action="RatingServlet" method="get">
        <div class="rating">
            <input type="radio" id="rating1" name="rate" value="1" onchange="changeStarRating(1)" />
            <label for="rating1"><i id="star1" class="far fa-star"></i></label>

            <input type="radio" id="rating2" name="rate" value="2" onchange="changeStarRating(2)" />
            <label for="rating2"><i id="star2" class="far fa-star"></i></label>

            <input type="radio" id="rating3" name="rate" value="3" onchange="changeStarRating(3)" />
            <label for="rating3"><i id="star3" class="far fa-star"></i></label>

            <input type="radio" id="rating4" name="rate" value="4" onchange="changeStarRating(4)" />
            <label for="rating4"><i id="star4" class="far fa-star"></i></label>

            <input type="radio" id="rating5" name="rate" value="5" onchange="changeStarRating(5)" />
            <label for="rating5"><i id="star5" class="far fa-star"></i></label>
        </div>

        <input type="submit" value="Submit" />
    </form>

    <script>
        function changeStarRating(rating) {
            var stars = document.querySelectorAll('.rating label i');
            for (var i = 0; i < stars.length; i++) {
                stars[i].classList.remove('filled');
                console.log(stars[i].classList);
            }
            for (var i = 1; i <= rating; i++) {
                var star = document.getElementById('star' + i);
                star.classList.add('filled');
            }
        }
    </script>
    </body>
</html>
