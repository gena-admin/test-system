// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
var dragAndDrop = function(options) {
    var hidden_field = $('#protection_answered_positions');
    $('i').draggable(
        { containment: "table", revert: 'invalid' }
    );

    $('td').droppable({
        drop: function(ev, ui) {
            var dropped = $(ui.draggable);
            var droppedOn = $(this);
            droppedOn.droppable("disable");
            dropped.parent().droppable("enable");
            dropped.detach().css({top: 0, left: 0}).appendTo(droppedOn);
            var positions = $('.game-table td').not('td:empty');
            var result = [];
            positions.each(function() {
                var $item = $(this);
                result.push($item.data('dx') + ',' + $item.data('dy'));
            });
            hidden_field.val(result.join('|'));
            if ($.isFunction(options['onDrop']))
                options['onDrop']();
        }
    });

    $('td').not('td:empty').droppable("disable");
    $('td.incorrect').droppable("disable");
}

