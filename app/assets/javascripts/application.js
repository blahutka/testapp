//= require jquery
//= require jquery_ujs
//= require lib/jquery-ui/jquery-ui-1.8.16.custom.min
//= require lib/jquery-ui/jquery.ui.datepicker-cs
//= require lib/rails.validations
//= require twitter/bootstrap
//= require_directory ./lib/lib
//= require lib/chosen.jquery
//= require lib/ajax-chosen

//= require features/skill_requirements
//= require_self

$(document).ready(function() {

    $( ".datepicker" ).datepicker();

    clientSideValidations.callbacks.element.fail = function(element, message, callback) {

        if (element.data('valid') !== false) {
//            element.parent().find('.message').hide().show('slide', {direction: "left", easing: "easeOutBounce"}, 500);
            console.log('fail');
            $(element).next('.add-on').hide();
            callback();
        }
    }
    clientSideValidations.callbacks.element.before = function(element, eventData) {

        console.log('before');
    }
    clientSideValidations.callbacks.element.pass = function(element, callback) {
        // Take note how we're passing the callback to the hide()
        // method so it is run after the animation is complete.
//        element.parent().find('.message').hide('slide', {direction: "left"}, 500, callback());
        callback();
        $(element).next('.add-on').addClass('active')
        $(element).next('.add-on').show();


    }

    hide_el();
    $('.switch input[type=radio]').click(function() {
        hide_el();
    })

    function hide_el() {
        $('.switch input[type=radio]').each(function() {
            var radio = $(this);
            var input = $(this).parent().siblings();
            var li = $(this).parent().parent();
            if (radio.is(':checked')) {
                input.show();
                li.addClass('well');
            } else {
                input.hide();
                li.removeClass('well');
            }
        })
    }


})

$(function () {
    function get_help_content() {
        return $('.help-content.hidden').html();
    }

    $('.add-date-time').click(function(e) {
        $(this).toggleClass('active');

        if ($(this).is('.active')) {
            $(this).text('- Odebrat alternativni čas');
            $(this).parent().prev('.date-time').clone().appendTo($(this).parents('li.well'));
        } else {
            $(this).text('+ Přidat alternativni cas');
            $(this).parent().next('.date-time').remove();
        }

        e.preventDefault()
    })

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
