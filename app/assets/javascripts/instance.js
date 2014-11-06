$(document).ready(function(){
    evaluateEmbargoFields();
    $embargo_check = $('#instance_embargo');
    $embargo_check.click(evaluateEmbargoFields);

});

//enable the detailed embargo fields if there is an embargo
function evaluateEmbargoFields() {
    $checkbox = $('#instance_embargo');
    $detailed = $('[data-hook="embargo_detailed"]');
    if ($checkbox.is(':checked')) {
        $detailed.attr('disabled', false);
    } else {
        $detailed.attr('disabled', true);
    }
}
