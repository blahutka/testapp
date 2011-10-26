$(document).ready(function() {
    // FORM TRACKING


//    $('input, textarea, select').blur(function () {
//        console.log($(this).attr('name') + ': ' + ($(this).val() ? true : false));
//    });


    // WIKI
    if (wiki == undefined) {
        wiki = {};
    }

    $('.local-chosen').each(function() {
        var menu = $(this);
        menu.find('input[type=text]').hide();
        menu.chosen({allow_single_deselect: true});
        menu.next('.chzn-container').find('input[type=text]').hide();
    })


    $(".remote-chosen").ajaxChosen({
        no_results_text: "Nic nalezeno",
        method: 'GET',
        url: '/skill_requirements/new/skill',
        dataType: 'json'
    }, function (data) {
        var terms = {};
        $.each(data, function (i, val) {
            terms[val.id] = val.name;
            wiki[val.id] = val;
        });

        return terms;
    });
    $(".remote-chosen").chosen({ 'allow_single_deselect': true}).change(function() {
        // Trigger validation on menu
        $(this).data('changed', true);
        $(this).trigger('focusout');

    })

// li#skill_request_skill_list_chzn_c_0.search-choice a.search-choice-close
//  div#skill_request_skill_list_chzn.chzn-container ul.chzn-choices

    /*    $(".skill_select").chosen().change(function() {
     var selected = $(this).val();
     set_side_wiki(selected);
     //        set_wiki(selected);

     });*/

    function set_side_wiki(selected) {
        var content = ''
        if (selected) {
            $.each(selected, function(i, id) {
                content += '<h6>' + wiki[id].name + '</h6>';
                content += '<p>' + wiki[id].wiki + '</p>'
            });
            $('.side-wiki').slideUp();
            $('.side-wiki').html(content);
            $('.side-wiki').slideDown('slow');
            $('ul.chzn-choices').popover({
                html:true,
                "placement":'right',
                trigger: 'hover',
                title: function() {
                    return 'Wiki'
                },
                content: function() {
                    return content
                }
            });
        }
    }

    function set_tag_wiki(selected) {
        if (selected) {
            $.each(selected, function(i, id) {
                var name = wiki[id].name;
                var li = 'li#skill_request_skill_list_chzn_c_' + i;
                var close_link = 'a.search-choice-close'
                $(close_link).click(function() {
                    var li = $(this).parent('li');
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

    when_switch();
    $('.switch input[type=radio]').click(function() {
        when_switch();
    })

    function when_switch() {
        $('.switch input[type=radio]').each(function() {
            var radio = $(this);
            var input = $(this).parent().parent().find('.inline-inputs, .input');
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

    $('a.add-date-time').click(function(e) {
        var row = $(this).parents('.input.date-time');
        var link = $(this);
        link.toggleClass('active');

        if (link.is('.active')) {
            link.text('- Odebrat alternativni čas');
            row.next().show();
        } else {
            link.text('+ Přidat alternativni cas');
            $('#skill_requirement_when_2_date').attr('value', '');
//            row.next().find('.calendar-menu').next().find('a span').text('Den');
            row.next().find('select').each(function() {
                $(this).find('option:first').attr('selected', true);
                $(this).trigger("liszt:updated");
            })
            row.next().hide();
        }

        e.preventDefault();
    })

    // CALENDAR INPUT

    $('.calendar-holder').each(function() {
        var calendar_holder = $(this);
        var fake_menu = calendar_holder.parent().find('.calendar-menu').next().find('a');
        var date_menu = calendar_holder.next();
        //var hidden_field_id = calendar_holder.next().attr('id');

        calendar_holder.hide();
        calendar_holder.mouseleave(function() {
            $(this).hide();
        });
        calendar_holder.datepicker({
            onSelect: function(dateText, el) {
                $(this).hide();
                date_menu.find(':selected').html(dateText).attr('value', dateText).attr('selected', true);
                date_menu.trigger("liszt:updated");
            }
        });

        $(fake_menu).click(function() {
            calendar_holder.show();
        })
    })

    $('#skill_requirement_when_2_date').each(function() {
        var date_menu = $(this);
        var wrap = date_menu.parents('.input.date-time');

        if (date_menu.find(':selected').val()) {
            wrap.show();
        } else {
            wrap.hide();
        }
    });

    function get_invalid() {
        var form = $('form');
         form.filter('form[data-validate]').each(function() {
             console.log($(this).data('valid'));
         });
    }
    $('form').submit(function(){
        var first = $(this).find('[data-validate]').first();
        var top = first.offsetTop;
        window.scroll(0,0);
        console.log($(this).find('[data-validate]').first())
         first.scrollTop += 10;
//        $(this).find('[data-validate]').last(function() {
//             console.log($(this).data('valid'));
//            $(this).scrollTop += 10;
//         });
    })


})