/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


    

$(document).ready(function() {
    fixMissingFirstTab();
    // takes an optional argument containing a hashtable
    var options = {};
    options["variant"] = getCurrentHash(window.location.hash)["v0"];
    options["open_tab"] =  getCurrentHash(window.location.hash)[0];
    options["current_chapter"] = getCurrentHash(window.location.hash)["k"];
          
    if (getCurrentHash(window.location.hash)["f0"]) theUrl["f0"] = getCurrentHash(window.location.hash)["f0"];
    addNewReader(0, options);
    addCommentListener();
    resize_window();

    $( "#slider" ).slider({
        value:160,
        min: 110,
        max: 220,
        step: 1,
        animate: true,
        range: 'min',
        slide: function( event, ui ) {
            // alert("sliding");
            $.cookie('text_size', ui.value); 	// lagre størrelse satt i slider i cookien
            $( "#amount" ).text( (ui.value/10) + "px" ); 	// oppdater status div
            $( ".text-resizeable" ).css('font-size', (ui.value/10) + "px"); 	// resize tekst
        }
    });

    $( "#amount" ).text( ($( "#slider" ).slider( "value" )/10) + "px" ); // oppdater status div
    $("#settings").hover(function()
    {
        $("#settings_dropdown").show();
        // move dropdown to be just below #settings
        var offset = $(this).offset();
        $(this).css("background-color", "#fff");
        $("#settings_dropdown").css("left", offset.left - $(window).scrollLeft() - 33) ;
    }, function()
    {
        $(this).css("background-color", "transparent");
        $("#settings_dropdown").hide();
    }
    );

    $("#settings_dropdown").hover(function()
    {
        $("#settings_dropdown").show();
        $("#settings").css("background-color", "#fff");

    }, function()
    {
        $("#settings_dropdown").hide();
        $("#settings").css("background-color", "transparent");
    }
    );

    // sjekk om cookie er satt og gi hovedteksten riktig font
    if($.cookie('text_font') == 'Moderne' ) {
        // set proper font
        $( ".text-resizeable" ).css('font-family', 'Myriad Pro, Verdana, sans-serif');
        // select proper radio button
        $('#font_georgia').attr('checked', false);
        $('#font_verdana').attr('checked', true);
    }

    if($.cookie('text_font') == 'Klassisk' ) {
        // set proper font
        $( ".text-resizeable" ).css('font-family', 'Georgia, Garamond, serif');
        // select proper radio button
        $('#font_georgia').attr('checked', true);
        $('#font_verdana').attr('checked', false);
    }

    // hva skjer nÃ¥r brukeren velger en annen font?
    $("#font_georgia").click(function()  {
        $( ".text-resizeable" ).css('font-family', 'Georgia, Garamond, serif');
        $.cookie('text_font', 'Klassisk');
    });
    $("#font_verdana").click(function()  {
        $( ".text-resizeable" ).css('font-family', 'Myriad Pro, Verdana, sans-serif');
        $.cookie('text_font', 'Moderne');
    });

    // sett riktig tekst-størrelse
    if($.cookie('text_size') > 0) { // hvis brukeren har brukt slideren tidligere
        //  alert($.cookie('text_size') );
        $( ".text-resizeable" ).css('font-size', ($.cookie('text_size')/10) + 'px');  // sett tekst-størrelse                       
        $( "#slider" ).slider( "value", $.cookie('text_size') );   			// flytt slider knapp
    }
                
    $("#ny_kolonne_bar").click(function() {
        addReaderColumn();
    });

                
    initChapterHandling();
    startupUri();  
    // addReaderColumn();
    addSimpleReader({}, "Pettertest", "1804_28_txr.xml");                
});

