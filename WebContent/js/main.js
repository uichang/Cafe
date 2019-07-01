$(function () {

    // main slide
    var slider = $('.main_slide').bxSlider({
        pager: true,
        pagerSelector: '.slide_pager',
        controls: true,
        auto: true,
        pause: 3000,
        infiniteLoop: true,
        controls: true,
        prevText: '',
        nextText: '',
        prevSelector: '.slide_prev',
        nextSelector: '.slide_next',
        responsive: true,
        autoHover: false,
        autoDelay: 0,
        mode: 'fade',
        autoControls: false,
    });    
    $(document).on('click','.bx-next, .bx-prev, .main_slide .bx-pager-link',function() {
        slider.stopAuto();
        slider.startAuto();
    });

});