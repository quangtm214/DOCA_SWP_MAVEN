    var heartIcon1 = document.getElementById("heart-icon-1");
    var heartIcon2 = document.getElementById("heart-icon-2");
    var heartIcon3 = document.getElementById("heart-icon-3");

    var isSolid1 = false;
    var isSolid2 = false;
    var isSolid3 = false;

    heartIcon1.addEventListener("click", function () {
        toggleHeartIcon(heartIcon1, isSolid1);
        isSolid1 = !isSolid1;
    });

    heartIcon2.addEventListener("click", function () {
        toggleHeartIcon(heartIcon2, isSolid2);
        isSolid2 = !isSolid2;
    });

    heartIcon3.addEventListener("click", function () {
        toggleHeartIcon(heartIcon3, isSolid3);
        isSolid3 = !isSolid3;
    });

    function toggleHeartIcon(icon, isSolid) {
        if (isSolid) {
            icon.classList.remove("fa-solid");
            icon.classList.add("fa-regular");
        } else {
            icon.classList.remove("fa-regular");
            icon.classList.add("fa-solid");
        }
    }
