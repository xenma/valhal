var creator_counter = 0;

$(document).ready(function(){

    // Add remove title function
    $('[data-function="new-title"]').click(function(){
        var html = '<div class="empty-titles">' + $('.new-title').first().html() + '</div>'

        $('[data-hook="empty_titles"]').append(html);
        return false;
    })
    $('[data-function="delete-title"]').click(function(){
        $(this).parent().parent().remove();
        return false;
    })

    // Add/remove creator functions
    $(".hidden-creator").hide();
    creator_counter = $(".creator, .new-creator, .hidden-creator").length;
    $('[data-function="new-creator"]').click(function(){
        hidden_creator = $("div.hidden-creator");
        new_creator = hidden_creator.clone(true)
            .find("select.creator-id").attr("name","work[creators]["+creator_counter+"][id]").end()
            .find("select.creator-type").attr("name","work[creators]["+creator_counter+"][type]").end();
        hidden_creator.removeClass('hidden-creator').addClass("creator");
        hidden_creator.find("select").each(function(index){
            $(this).addClass("combobox");
            $(this).combobox();
            $(this).click(function(){
                $(this).siblings('.dropdown-toggle').click();
            });
        })
        hidden_creator.show();
        new_creator.insertAfter(hidden_creator);
        creator_counter = creator_counter +1;
        return false;
    })

    $('[data-function="delete-creator"]').click(function(){

        $(this).parent().parent().remove();
        return false;
    })


    // Combobox functionallity
    $('.combobox').combobox();
    $('.combobox').click(function(){
        $(this).siblings('.dropdown-toggle').click();
    });
});