$(document).ready(function(){
   evaluateEmbargoFields();
   $('[data-toggle="embargo_detailed"]').click(evaluateEmbargoFields);

});

//enable the detailed embargo fields if there is an embargo
function evaluateEmbargoFields() {
    $checkbox = $('[data-toggle="embargo_detailed"]');
    $detailed = $('[data-hook="embargo_detailed"]');
    if ($checkbox.is(':checked')) {
        $detailed.attr('disabled', false);
    } else {
        $detailed.attr('disabled', true);
    }
}
