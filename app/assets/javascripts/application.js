//= require jquery
//= require jquery_ujs
//= require lib/nested_form
//= require lib/jquery-ui/jquery-ui-1.8.16.custom.min
//= require lib/jquery-ui/jquery.ui.datepicker-cs
//= require lib/rails.validations
//= require twitter/bootstrap

//= require chosen.jquery.js
//= require lib/ajax-chosen

//= require features/skill_requirements
//= require_self

$(document).ready(function() {

    $(".datepicker").datepicker();

    clientSideValidations.callbacks.element.fail = function(element, message, callback) {
        callback();
        move_to_error_wrapper(element);
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
