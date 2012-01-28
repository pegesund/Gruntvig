/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 * 
 * File to handle mouseover and click-effects
 * 
 */


// tooltip

var addTooltip = function (tags) {
    tags.cluetip({
        cluetipClass: 'jtip', 
        closeText : 'Luk', 
        mouseOutClose: true, 
        width: 375, 
        dropShadow: false, 
        sticky: true, 
        ajaxCache: false, 
        arrows: false
    });
}

var removeTooltip = function(tags) {
    tags.cluetip('destroy');
}


// add popup references
/*

    $('.seg').each(function(index) {
        var elem = $(this);
        var url = "/ajax/getReference/" + rootFile + "/" + elem.attr("id");
        var new_tag = $("<a></a>");
        new_tag.attr("href", url);
        new_tag.attr("rel", url);
        new_tag.attr("class", "reference");
        new_tag.html(elem.html());
        elem.replaceWith(new_tag);

    });

    $('.reference').cluetip({cluetipClass: 'jtip', closeText : 'Lukk', mouseOutClose: true, width: 375, dropShadow: false, sticky: true, ajaxCache: false, arrows: false});

*/

// add scroll to comment

var addCommentListener = function() {
    $('.seg, .segStart, .segEnd').each(function(index) {
        var elem = $(this);
        elem.click(function() {
            var target = $("#scrollTarget_" + elem.attr("id"));
            // alert("Looking for id: " + "#scrollTarget_" + elem.attr("id"));
            // switch to "Kommentar" tab

            // if there are no visible tabReaders, we must first add one to show the comments
            if($('.tabReader').length == 0){
                addNewReader(0);
            }

            // switch to right tab
            $(".kommentar_tab:first").trigger('click');

            // scroll to target comment
            $(".kommentar").scrollTo(target);
            $(".kommentar").scrollTo("-=30px", 700);
            target.effect("highlight", {}, 5000);
        });

    });
}