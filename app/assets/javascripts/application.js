//= require jquery
//= require jquery_ujs
//= require lib/nested_form
//= require lib/jquery-ui/jquery-ui-1.8.16.custom.min
//= require lib/jquery-ui/jquery.ui.datepicker-cs
//= require lib/rails.validations
//= require lib/orbit/jquery.orbit-1.2.3.min
//= require lib/jquery.hoverIntent.minified
//= require lib/waypoints.min.js
//= require lib/jquery.progressbar.min
//= require twitter/bootstrap/alerts
//= require lib/twitter/twipsy
//= require twitter/bootstrap/dropdown
//= require twitter/bootstrap/modal
//= require twitter/bootstrap/popover
//= require twitter/bootstrap/scrollspy
//= require twitter/bootstrap/tabs


//= require chosen.jquery.js
//= require lib/ajax-chosen

//= require features/skill_requirements
//= require features/_featured


//= require_self

$(document).ready(function() {

    // PROFILE SHOW
    $('.progress-bar').twipsy({
        title: function() {
            return ('aktuálně <strong>' + parseFloat($(this).css('width')) * 100 / 680) + '% </strong> <a href="#" class="profile-strength-whyx">Proč?</a>';
        },
        placement: 'right',
        html: true,
//        live: true,
        trigger: 'manual'
    });

    $('.progress-bar').css({width:null});
    $('.progress-bar').delay(1000).animate({width: '100%'}, 2000).delay(300).animate({width: '45%'}, {
        duration: 1000,
        complete: function() {
            $(this).twipsy('show');
        },
        step:function(now) {
        }

    });

    $('.bar-wrap, .profile-strength-why').popover({
        live: true,
        delayIn: 500,
        delayOut: 500,
        html:true,
        "placement":'below',
        trigger: 'hover',
        title: function() {
            return 'Wiki'
        },
        content: function() {
            return $('#bar-wrap-content').html();
        }
    })
    


    // SKILL REQEST DETAIL
    /*$('.company').hover(function(){
     var id = $(this).attr('id');
     $('#company_detail_'+id).slideToggle('slow');
     }, function(){
     var id = $(this).attr('id');
     $('#company_detail_'+id).slideToggle('slow');
     }, 2000)*/

    //$.waypoints.settings.scrollThrottle = 30;
    $('.left-column').waypoint(
        function(event, direction) {
//                    $('.top').toggleClass('hidden', direction === "up");
            console.log(direction);
        }, {
        }).find('.company-detail.active').waypoint(function(event, direction) {
            $(this).parent().toggleClass('sticky', direction === "down");
            console.log(direction);
            event.stopPropagation();
        });
    $('.company').each(function() {
        var id = $(this).attr('id');
        var company = $(this);
        var company_detail = $('#company_detail_' + id);
        company.click(function() {
            company.addClass('active');
            $('.company').not(this).removeClass('active');
        })
        company.hoverIntent(function() {
            $(this).find('.btn').not('.active').animate({opacity:1}, 1500, 'linear');
        }, function() {
            $(this).find('.btn').not('.active').animate({opacity:0}, 0);
        })
        company.find('.btn').click(function(e) {
            e.preventDefault();

            $(this).toggleClass('active success');
            $('#bids .btn.active').not(this).removeClass('active success').animate({opacity:0}, 0);
            show_company_content($(this));
        })
        /*company.find('a.show-ask-question').click(function(e) {
         e.preventDefault();
         company_detail.show();
         show_chat_window(company_detail);
         })
         company.find('a.show-company-detail').click(function(e) {
         e.preventDefault();
         company_detail.show();
         show_company_detail(company_detail);
         })*/
    })
    function show_chat_window(company_detail) {
        company_detail.find('.chat').slideDown('slow');
    }

    function show_company_detail(company_detail) {
        company_detail.find('.info').slideDown('slow');
        company_detail.find('.info').addClass('active');
        $('.company-detail').not(company_detail).find('.info').removeClass('active');
        $('.company-detail').not(company_detail).find('.info').hide();
    }

    function change_content() {
        console.log('change content');
        console.log($(this));
    }

    $('.company-detail .module').bind('select:my', change_content);
    $('.company .btn').bind('select:my', change_content);

    function toggle_content(button, modul_class) {
        var id = button.parents('.company').attr('id');
        var company = $('#company_detail_' + id);
        var modul = company.find('.' + modul_class);

        hide_others(company);


        if (button.hasClass('active')) {
            company.addClass('active');
            company.show();
            modul.addClass('active');
//            modul.slideDown('slow');
            modul.show("slide", { direction: "left" }, 1000);
        } else {
            company.removeClass('active');
            modul.removeClass('active');
//            modul.hide();
            modul.hide("slide", { direction: "left" }, 1000);
            company.hide("slide", { direction: "left" }, 1000);
        }

        console.log('id:' + id);
    }

    function hide_others(company) {

        var others = $('.company-detail.active');
        others.removeClass('active').hide();
        others.children('.module.active').removeClass('active').hide();
    }

    function show_company_content(button) {

        if (button.hasClass('show-company-detail')) {
            toggle_content(button, 'info');
        } else if (button.hasClass('show-ask-question')) {
            toggle_content(button, 'chat');
        } else if (button.hasClass('show-accept-bid')) {
            $('#confirm-bid').modal('show');
        }
    }

// LOGIN/REGISTRATION FORMS
    $('input[type=text], input[type=password], input[type=checkbox], select', 'form.user-form').focus(function() {
        $(this).parents('form').addClass('active');
    })

    $('form').click(function() {
        $(this).addClass('active');
    })
    $('form').hover(function() {
        $(this).addClass('active');
    }, function() {
        $(this).removeClass('active');
    })


    $('input[type=text], input[type=password], input[type=checkbox], select', 'form.user-form').blur(function() {
        $(this).parents('form').removeClass('active');
    })
    if (location.hash) {
        $('input[type=text]', location.hash).first().trigger('click');
        $('html, body').animate({scrollTop:0}, 500);
    }

// CLOSE MESSAGES
//$('.alert-message.info').delay(2000).fadeOut(1600, "linear");


    $(".datepicker").datepicker();

    clientSideValidations.callbacks.element.fail = function(element, message, callback) {
        callback();
        move_to_error_wrapper(element);
        $(element).parents('form').addClass('active');
    }

    clientSideValidations.callbacks.element.pass = function(element, callback) {
        move_out_of_error_wrapper(element);
        callback();
    }

    function move_to_error_wrapper(element) {
        if (element.data('valid') !== false) {
            var menu = $(element).parent().parent().find('#skill_requirement_skill_list_chzn');
            var wrapper = element.parent();
            wrapper.prepend(menu);
        }
    }

    function move_out_of_error_wrapper(element) {
        var menu = $(element).prev();
        var wrapper = $(element).parent();
        wrapper.after(menu);
    }


})

$(function () {

    function get_help_content() {
        return $('.help-content.hidden').html();
    }


    $('textarea[rel=popover]').popover({
        offset: 5,
        delayOut: 500,
        trigger: 'focus',
        html: true,
        title: function() {
            return 'Doporučení';
        },
        content: function() {
            return get_help_content();
        }
    })
    $("a[rel=popover]")
        .popover({
            offset: 10
        })
        .click(function(e) {
            e.preventDefault()
        })
})
