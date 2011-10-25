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

        if (element.data('valid') !== false) {
            var menu = $(element).parent().parent().find('#skill_requirement_skill_list_chzn');
            console.log(menu)
            var error = element.parent();
            error.prepend(menu);
        }
    }
    clientSideValidations.callbacks.element.before = function(element, eventData) {

        console.log('before');
    }
    clientSideValidations.callbacks.element.pass = function(element, callback) {
        var menu = $(element).prev();
        var wrap = $(element).parent();
        wrap.after(menu);
        console.log(wrap);
        callback();



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
