//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require_directory ./lib/lib
//= require lib/chosen.jquery
//= require lib/ajax-chosen
//= require_self

$(document).ready(function() {
    wiki = {};
//    $('#skill_request_skill_list').chosen();
    $(".skill_select").ajaxChosen({
        method: 'GET',
        url: '/skill_requests/new/skill',
        dataType: 'json'
    }, function (data) {
        var terms = {};


        $.each(data, function (i, val) {

            terms[val.id] = val.name;
            wiki[val.id] = val;
        });

        return terms;
    });

    // li#skill_request_skill_list_chzn_c_0.search-choice a.search-choice-close
    //  div#skill_request_skill_list_chzn.chzn-container ul.chzn-choices

    $(".skill_select").chosen().change(function() {
        var selected = $(this).val();
        set_side_wiki(selected);
//        set_wiki(selected);

    });

    function set_side_wiki(selected){
        var wi = wiki;
         content = ''
        if(selected){
            $.each(selected, function(i, id){
                content += '<h6>'+wi[id].name + '</h6>';
                content += '<p>'+ wi[id].wiki + '</p>'
            });
            $('.side-wiki').slideUp();
            $('.side-wiki').html(content);
            $('.side-wiki').slideDown('slow');
            $('ul.chzn-choices').popover({
                html:true,
                "placement":'right',
                trigger: 'hover',
                title: function(){ return 'Wiki'},
                content: function(){ return content }
            });
        }
    }

    function set_wiki(selected) {
        if (selected) {
            $.each(selected, function(i, id) {
                var name = wiki[id].name;
                var li = 'li#skill_request_skill_list_chzn_c_' + i;
                var close_link = 'a.search-choice-close'
                console.log(li);
                $(close_link).click(function() {
                    var li = $(this).parent('li');
                    console.log(li);
                    $('.popover').hide();
                });
                $(li).click(function() {
                    $('.popover').hide();
                });
                $(li).popover({
//                    live:true,
                    "placement":'below',
                    offset: 5,
                    delayOut: 0,
                    trigger: 'hover',
                    html: true,
                    title: function() {
                        return 'Wiki';
                    },
                    content: function() {
                        return wiki[id].name;
                    }
                });

            })

        }
    }

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
