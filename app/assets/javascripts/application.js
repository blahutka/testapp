//= require jquery
//= require jquery_ujs
//= require lib/jquery-ui/jquery-ui-1.8.16.custom.min
//= require lib/jquery-ui/jquery.ui.datepicker-cs
//= require lib/rails.validations
//= require twitter/bootstrap

//= require chosen.jquery.js
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
