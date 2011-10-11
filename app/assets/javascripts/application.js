//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require_self

$(document).ready(function() {
    hide_el();
    $('.switch input').click(function() {
        hide_el();

    })

    function hide_el() {
        $('.switch input').each(function() {
            var label = $(this);
            var input = $(this).parent().siblings();
            var li = $(this).parent().parent();

            if (label.is(':checked')) {
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
    $('.add-date-time').click(function(e){
        $(this).toggleClass('active');

        if($(this).is('.active')){
            $(this).text('- Odebrat alternativni čas');
            $(this).parent().prev('.date-time').clone().appendTo($(this).parents('li.well'));
        } else {
            $(this).text('+ Přidat alternativni cas');
            $(this).parent().next('.date-time').remove();
        }

        e.preventDefault()
    })

    $('textarea[rel=popover]').popover({offset: 5,
        delayOut: 500,
        trigger: 'focus',
        html: true,
        title: function() { return 'Doporučení'; },
        content: function() { return get_help_content(); }
    })
    $("a[rel=popover]")
        .popover({
            offset: 10
        })
        .click(function(e) {
            e.preventDefault()
        })
})
