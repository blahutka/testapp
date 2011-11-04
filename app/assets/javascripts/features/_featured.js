$(document).ready(function() {
    $('#featured').orbit({
            animation: 'fade',                  // fade, horizontal-slide, vertical-slide, horizontal-push
            animationSpeed: 800,                // how fast animtions are
            timer: true,
            captions: true,
            bullets: true,
            directionalNav: false,
            pauseOnHover: true,
            startClockOnMouseOut: true,
            startClockOnMouseOutAfter: 500
        }
    );
})