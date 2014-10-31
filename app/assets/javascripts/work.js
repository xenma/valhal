$(document).ready(function(){
    $('[data-function="new-title"]').click(function(){
        var html = '<div class="empty-titles">' + $('.new-title').first().html() + '</div>'

        $('[data-hook="empty_titles"]').append(html);
        return false;
    })

    $('[data-function="delete-title"]').click(function(){
        $(this).parent().remove();
    })
});