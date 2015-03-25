/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 * 
 * File to handle mouseover and click-effects
 * 
 */


// tooltip

/**
 * 
 * Adds tooltip, but also link-handlers for docin/docout
 * 
 * @param {type} tags
 * @returns {undefined}
 */
var addTooltip = function(tags) {
    tags.cluetip({
        cluetipClass: 'jtip',
        closeText: 'Luk',
        mouseOutClose: true,
        width: 375,
        dropShadow: false,
        sticky: true,
        ajaxCache: false,
        arrows: false
    });
    addDocOutListener();
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
            if ($('.tabReader').length == 0) {
                addNewReader(0);
            }

            // switch to right tab
            $(".kommentar_tab:first").trigger('click');

            // scroll to target comment
            $(".kommentar").scrollTo(target);
            $(".kommentar").scrollTo("-=30px", 5000);
            target.effect("highlight", {color: "red"}, 5000);
        });

    });
}

// add scroll to comment

var addEndNoteListener = function() { // KK 2014.10.07
    $('.endNoteRef').each(function(index) {
        var elem = $(this);
        elem.click(function() {
            var target = $("#"+elem.attr("target"));
            
            currentChapter= elem.attr("chp");
            gotoChapter(currentTextId,currentChapter);

            // delay scroll to target endnote at least as much as fadein in chapterhandling
            window.setTimeout( "delayedScroll('" + elem.attr("target") + "')", 2000 );
        });

    });
}

function delayedScroll(t) { // KK 2014.10.07
            var target = $("#"+t);           
            // scroll to target endnote
            $("#tekst_innhold").scrollTo(target);
            $("#tekst_innhold").scrollTo("-=30px", 700);
            target.effect("highlight", {}, 5000);     
}


var docOutTodocInLink = function(link) {
    var l = link.split("#");
    if (l.length < 2) {
        return "Not found";
    }

    var fileElements = l[0].match("(.*?)_([a-z]+[0-9]*).xml$");
    var link = fileElements[1] + "_" + fileElements[2] + "_" + l[1];
    return [fileElements[1], fileElements[2], l[1]];
}

var addDocOutListener = function() {
    $(".docOut, .docIn").unbind("click").click(function() {
        var options = {};
        options["scrollToObject"] = $(this).attr("name");
        options["scrollToAdjust"] = $(this).position().top;
        var target = $(this).attr("name");
        if (target.indexOf("#") === -1) {
            var win=window.open(target, '_blank');
            win.focus();
            return;
        }
        var link = docOutTodocInLink(target);
        var scrollToInNewWindow = link[0] + "_" + link[1] + "_" + link[2];
        options["scrollToInNewWindows"] = scrollToInNewWindow;
        possibleExistingForeignId = $("#" + scrollToInNewWindow);
        if (rootFile == link[0] || possibleExistingForeignId.length > 0) {
            var openTab = 0;
            switch (link[1]) {
                case "intro":
                    openTab = 0;
                    break;
                case "txr" :
                    openTab = 3;
                    break;
                case "com" :
                    openTab = 4;
                    break;
            }
            if (/v[0-9]+/.test(link[1]))
                openTab = 1;
            options["open_tab"] = openTab;
            var found = false;
            var i;
            var rightmostScrollTo;
            for(i = readerNum; i >= 0; i--) {
                rightmostScrollTo = $("#tab" + i).find("#" + scrollToInNewWindow);
                if (rightmostScrollTo.length > 0) {
                    // check if the wished panel is seleted in the tab
                    var theTab = $("#tab" + i).tabs();
                    if (openTab == theTab.tabs('option', 'selected')) {
                        found = true;
                        break;
                    }
                }
            }
            if (found) {
                var linkElement = rightmostScrollTo;
                var scrollElement = linkElement.closest(".ui-tabs-panel");
                scrollElement.scrollTo(linkElement);
                scrollElement.scrollTo("-=30px");                
            } else {
                addReaderColumn(options); 
            }
        } else {
            var showFile = link[0] + "_" + link[1] + ".xml";
            $.ajax({
                url: "ajax/getNameFromFilename/" + showFile,
                success: function(showName) {
                    var linkElement = $("#" + scrollToInNewWindow);
                    if (linkElement.length > 0) {
                        var scrollElement = linkElement.closest(".ui-tabs-panel");
                        scrollElement.scrollTo(linkElement);
                        scrollElement.scrollTo("-=30px");
                    } else {
                        addSimpleReader(options, showName, showFile);
                    }
                }
            });
        }
    });
};