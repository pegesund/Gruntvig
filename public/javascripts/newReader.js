
readerNum = 0;
var columnWidth = 471; // how wide new columns should be, in pixel
var startupHash = window.location.hash;

/*
 * 
 * @returns {undefined}
 * 
 * Fix menu-handlers for toc-anchors
 * Adds expand-function with plus-ids
 * Adds handlers to intro_menu
 * 
 */
fixTabMenues = function() {
    $("a.toc").each(function(index) {
        var a = $(this);
        var jump = a.attr("href");
        a.removeClass("toc");
        a.click(function() {
            var id = $(".teidiv1").attr("id");
            // $(".innledningContent").parent().scrollTo($("#index.xml-body.1_div.1_div.11"));
        });
        a.removeAttr("href");
    });

    $(".plus").unbind("click").click(function() {
        $(this).next().slideToggle("slow");
    });
    $(".intro_menu").unbind("click").click(function() {
        var scrollElement = $(this).closest(".innledningContent").parent();
        var id = $(this).attr("hrel").replace(/\./g, "\\.");
        scrollElement.scrollTo($(scrollElement.find("#" + id)));
        scrollElement.scrollTo("-=30px", 700);
    });
}

addReaderColumn = function() {
    var options = arguments[0] || {};                  
    readerNum += 1;
    addNewReader(readerNum, options);
    number_of_present_tabreaders = $(".tabReader").length;

    // make room for more columns
    // increase width of .container and #høyre
    if(number_of_present_tabreaders > 1){ // only do this if there are 1 or more tabReaders opened
        $(".container").width($(".container").width() + columnWidth);
    }
    $("#høyre").width($("#høyre").width() + columnWidth);
    resize_window();

    // give new column same font size as existing
    $( ".text-resizeable" ).css('font-size', $('#hovedtekst .text-resizeable').css('font-size'));

    // scroll to rightmost side of page
    $(window).scrollTo('100%', 0 , {
        duration:700
    });          
}

/**
 * 
 * @param {int} num
 * @param {type} hash
 * @returns {void}
 * 
 * Set focus on right tab, adds focus handles
 * 
 */
tabFocusHandler = function(num, options) {
    var i_tab=0;
    for (i_tab = 0; i_tab <= num; i_tab++) {
        if ($("#tab" + i_tab).size() == 0) continue;
        var theTab = $("#tab" + i_tab).tabs();  
        if (i_tab == num) {
            if (options["open_tab"]) {
                theTab.tabs('select', options["open_tab"]);
                uriChangeTab(num, options["open_tab"])
            }
        }

        theTab.bind('tabsselect', function(event, ui) {
            
            // handle closing of tabs
            if (ui.panel.id.substring(0,5) == "skjul") {
                var currentTabId = ui.panel.id.substring(5, 100);
                uriRemoveTab(currentTabId);
                number_of_present_tabreaders = $(".tabReader").length;

                $("#" + ui.panel.id).closest(".tabReader").remove();
                $("#høyre").width($("#høyre").width() - columnWidth);

                if(number_of_present_tabreaders > 1){ // only do this if there are 1 or more tabReaders opened
                    // decrease width of .container and #høyre
                    $(".container").width($(".container").width() - columnWidth);                
                }
                resize_window();
                return;
            }
       
            try {
                var currentTab = parseInt($(ui.panel).parent().attr("id").substring(3));
                uriChangeTab(currentTab, ui.index);
            } catch (err) {
                
            }
        });          
    }
}

/*
 * 
 * @param {hash} options
 * @returns {undefined}
 * 
 * After update of dom-tree, the scrollbar resests to top position
 * This function scrolls back to last seen position
 * 
 */
keepOldScrollPosition = function(options) {
    var linkElementId = options["scrollToObject"];
    var linkNewWindow = options["scrollToInNewWindows"];
    if (linkElementId) {
        var linkElement = $("span[name='" + linkElementId + "']");
        var scrollElement = linkElement.closest(".ui-tabs-panel");
        scrollElement.scrollTo(linkElement);
        scrollElement.scrollTo("-=" + options["scrollToAdjust"] + "px");
    }
    var found = false;
    if (linkNewWindow) {
        for (i = readerNum; i > 0; i--) {
            var rightmostScrollTo = $("#tab" + i).find("#" + linkNewWindow);
            if (rightmostScrollTo.length > 0) {
                found = true;
                break;
            }
        }
        if (found) {
            var linkElement = rightmostScrollTo;
            var scrollElement = linkElement.closest(".ui-tabs-panel");
            scrollElement.scrollTo(linkElement);
            scrollElement.scrollTo("-=30px");
        }
    }
};


/**
 * 
 * @param {int} num
 * @returns {void}
 * 
 * Opens up a new column and fills this with content
 * 
 * 
 */
addNewReader = function(num) {
    var options = arguments[1] || {};
    uriChangeTab(num,0); 
    var newReader = '<span class="tabReader"><div id="tab' + num + '"> <ul> <li class="selected"><a href="#innledning' + num + '"><span>Indledning</span></a></li> <li><a class="variant_tab" href="#variant' + num + '"><span>Varianter</span></a></li> <li><a class="faksimile_tab" href="#faksimile' + num + '"><span>Fax.</span></a></li> <li><a href="#txr' + num + '"><span>Tekstred.</span></a></li><li><a class="kommentar_tab" href="#kommentar' + num + '"><span>Kommentarer</span></a></li> <li id="lukk_kolonne_knapp_li"><span class="ui-closable-tab"><a title="Skjul kolonne" href="#skjul' + num + '" class="lukk_kolonne_knapp"></a></span></li> </ul> ';
    newReader += '<div id="innledning' + num + '"> <div class="innledningContent text-resizeable"><p><img src="public/images/wait.gif"></p></div></div>';
    newReader +=  '<div id="variant' + num + '"><div class="variant_select">' + hovedtekstSelect + ' <a id="variant_vejledning" href="../vejledning/varapp_vej" target="_blank">Vejledning</a></div><div class="variantContent text-resizeable">Variant content</div>  </div>';
    newReader += '<div id="faksimile' + num + '" class="faksimile_frame" ><div class="faksimile_select"><a class="forrige_side" href="#">Forrige side</a> | <a class="neste_side" href="#">Næste side</a></div> <div class="faksimileContent"></div></div>';
    newReader += '<div class="txr text-resizeable" id="txr' + num + '"> Her skal txr ligge...  </div>';
    newReader += '<div class="kommentar text-resizeable" id="kommentar' + num + '"> Her skal kommentarene ligge...  </div>';
    newReader += '<div class="empty_tab" id="skjul' + num + '"></div>';
    newReader += '</div></span>';
    $("#hovedtekst_select").html(hovedtekstSelect);
    $("#høyre_toppmeny_nytt_navn").html($("#høyre_toppmeny_nytt_navn").html() + newReader);
    //alert($("#høyre_toppmeny_nytt_navn").html());
    // update uri-hash if changing tab-panel  
    tabFocusHandler(num, options);
    
    $('.variantsAsDropDown').change(function() {
        var parentId = $(this).closest("div.ui-tabs").attr("id");
        var tabNumber = parseInt(parentId.substring(3));
        var index = $(this)[0].selectedIndex;
        if (index >= 0) {
            uriChangeVariant(tabNumber, index);
        }
        var theUrl = "ajax/getVariantByName/" + $(this).val();
        $.ajax({
            url: theUrl,
            success: function(data) {
                var variantContent = $("#" + parentId + " .variantContent");
                variantContent.html(data);
                keepOldScrollPosition(options);
            }
        })
    });
       
         
    $.ajax({
        url: txrUrl,
        success: function(data) {
            var txrContent = $("#txr" + num);
            txrContent.html(data);
            addMouseHandlers(txrUrl);
            keepOldScrollPosition(options);
        }
    });
       
    $.ajax({
        url: kommentarUrl,
        success: function(data) {
            var introContent = $("#kommentar" + num);
            introContent.html(data);
            addMouseHandlers(kommentarUrl);
            keepOldScrollPosition(options);
        }
    });

    $.ajax({
        url: introUrl,
        success: function(data) {
            var introContent = $("#innledning" + num);
            introContent.find(".innledningContent").html(data);
            fixTabMenues();
            addMouseHandlers(introUrl);
            keepOldScrollPosition(options);
        }
    });

    // dropdown - hovedtekst
    $("#hovedtekst .variantsAsDropDown").change(function() {
        var theUrl = "ajax/getVariantByName/" + $(this).val();
        $.ajax({
            url: theUrl,
            success: function(data) {
                var variantContent = $("#hovedtekst #tekst_innhold");
                variantContent.html(data);
                addMouseHandlers(theUrl);
                keepOldScrollPosition(options);
            }
        })
    });

    // autolast den første varianten & manuset
    if (options["variant"]) {
        $("#tab" + num +' .variantsAsDropDown')[0].selectedIndex = options["variant"];
    }
      
    $("#tab" + num +' .variantsAsDropDown').trigger('change');

    // vis hovedtekst select når variant-fanen åpnes, sjekk evt. jøgens gamle sjekk inn hvis problemer
    $('.variant_tab').click(function() {
        });

    // resize layout når kolonner endres
    resize_window();

    for (var i=0; i <= num; i++) {
        faksimiler[i] = new addFaksimile(i);
        if (theUrl["f" + i]) 
            faksimiler[i].gotoPage(theUrl["f" + i]);
    }
    removeShadowImages(num);
                
    if (num == 0) {
        if (options["current_chapter"]) {
            currentChapter = parseInt(options["current_chapter"]);
        } else {
            currentChapter = 0; 
        }             
        gotoChapter(currentTextId, currentChapter);
    }
} // end new reader



/**
 * 
 * adds click handlers to txt- or comfiles
 * 
 */
var addMouseHandlers = function(fileName) {
    addTooltip($('.persName, .placeName, .myth, .rs_bible'));
    if (fileName.match(/getComment/) || fileName.match(/_com/)) {
        $(".plusComment").unbind("click").click(function() {    
            $(this).next().slideToggle("slow"); 
        });
    }
    if (fileName.match(/getTxr/) || fileName.match(/_txr/)) {                
        $(".txrmenu").unbind("click").click(function() {
            var scrollElement = $(this).closest(".mainTxr").parent();
            var id = $(this).attr("hrel").replace(/\./g, "\\.");
            scrollElement.scrollTo(scrollElement.find("#" + id)); // hack as id should be unique - fix if problems
            scrollElement.scrollTo("-=30px", 700);     
        });
    }  
    fixTabMenues();
} 

/*
 * This function adds a reader for links between different root-texts
 * In this reader only one tab is showed
 * 
 */
addSimpleReader = function(options, showName, url) {
    readerNum += 1;
    var num = readerNum;
    uriAddForeignTab(readerNum, url);
    var newReader = '<span class="tabReader"><div id="tab' + num + '" class="foreign"> <ul> <li class="selected"><a href="#foreign' + num + '"><span>' + showName + '</span></a></li>  <li id="lukk_kolonne_knapp_li"><a title="Skjul kolonne" href="#skjul' + num + '" class="lukk_kolonne_knapp"></a></li> </ul> ';
    newReader += '<div class="text-resizeable" id="foreign' + num + '"> <div class="text-resizeable innledningContent txr kommentar"><p><img src="public/images/wait.gif"></p></div></div>';
    newReader += '<div class="empty_tab" id="skjul' + num + '"></div>';
    newReader += '</div></span>';
    $("#hovedtekst_select").html(hovedtekstSelect);
    $("#høyre_toppmeny_nytt_navn").html($("#høyre_toppmeny_nytt_navn").html() + newReader);
    tabFocusHandler(num, {});
    number_of_present_tabreaders = $(".tabReader").length;
    $(".container").width($(".container").width() + columnWidth);
    $("#høyre").width($("#høyre").width() + columnWidth);
    resize_window();
    //$( ".text-resizeable" ).css('font-size', $('#hovedtekst .text-resizeable').css('font-size'));
    // $( ".text-resizeable" ).css('font-size', '14');
    $.ajax({
        url: "ajax/getManusByName/"  + url,
        success: function(data) {
            var simpleContent = $("#foreign" + num).children().first();
            simpleContent.html(data);
            addMouseHandlers(url);
            fixTabMenues();
            keepOldScrollPosition(options);
            if (options["scrollToInNewWindows"] != undefined) {
                var sto = $("#" + options["scrollToInNewWindows"]);
                var scrollElement = sto.closest(".innledningContent").parent();
                scrollElement.scrollTo(sto);
                scrollElement.scrollTo("-=30px", 700);
            }
        }
    });
    
}