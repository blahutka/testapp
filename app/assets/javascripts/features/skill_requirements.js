$(document).ready(function() {
    // FORM TRACKING


//    $('input, textarea, select').blur(function () {
//        console.log($(this).attr('name') + ': ' + ($(this).val() ? true : false));
//    });


    // WIKI
    if (wiki == undefined) {
        wiki = {};
    }
    $('.local-chosen').chosen().next().find('input[type=text]').hide();

    $('.local-chosen').each(function() {
        var menu = $(this);
        menu.chosen();
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

    hide_el();
    $('.switch input[type=radio]').click(function() {
        hide_el();
    })

    function hide_el() {
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
            row.next().find('select').each(function(){
                $(this).find('option:first').attr('selected', true);
                $(this).trigger("liszt:updated");
            })
            row.next().hide();
        }

        e.preventDefault();
    })

    // CALENDAR INPUT

    /*    $('#calendar-holder-1', '#calendar-holder-2').datepicker({
     showAnim: 'fold',
     altField: '#skill_requirement_when_1_date',
     onCreate: function(){
     console.log('creted');
     },
     onSelect: function(dateText, el) {
     $(this).hide();
     $("#calendar").trigger("liszt:updated");
     $('#calendar_chzn a.chzn-single span').text(dateText);
     }
     }).hide();
     $('#calendar-holder').mouseleave(function() {
     $(this).hide();
     })
     $('#calendar-1_chzn a.chzn-single', '#calendar-2_chzn a.chzn-single').click(function() {
     $('#calendar-holder').show();
     });*/

    $('.input.date-time').last().hide();

    $('.calendar-holder').each(function() {
        var calendar_holder = $(this);
        var fake_menu = calendar_holder.parent().find('.calendar-menu').next().find('a');
        var date_menu = calendar_holder.next().find('option:last');
        var hidden_field_id = calendar_holder.next().attr('id');

        calendar_holder.hide();
        calendar_holder.mouseleave(function() {
            $(this).hide();
        })
        calendar_holder.datepicker({
            altField: '#' + hidden_field_id,
            onSelect: function(dateText, el) {
                $(this).hide();
                date_menu.html(dateText).attr('value', dateText).attr('selected', true);
                date_menu.trigger("liszt:updated");
            }
        });

        $(fake_menu).click(function() {
            calendar_holder.show();
        })
    })


})