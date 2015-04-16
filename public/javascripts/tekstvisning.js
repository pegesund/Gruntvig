/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */



// ***************************************************************
// Handling of dropdown checkboxes for optional views
// KK 2015-03-02 -->

function mkPBox( ed ) {
/*
 * Make a check box for showing pagenumbers of a given edition 
 * String ed: edition siglum, i.e. class name suffix "pb*" of element to show
 */
  var pBoxDiv= document.getElementById( "pBoxDiv" ),
      newPBox= document.createElement( "div" ),
      newInput= document.createElement( "input" ),
      newLabel= document.createTextNode( ed );
        if( document.getElementById("showHidePag"+ed) ) return;
         newInput.id= "showHidePag"+ed ;
         newInput.className= "setInput" ;
         newInput.type= "checkbox" ;
         newInput.defaultChecked= true ;
         pBoxDiv.appendChild( newPBox );
         newPBox.appendChild( newInput );
         newPBox.appendChild( newLabel );
  $("#showHidePag"+ed).click(function() {
    if( this.checked )
      $( ".pb"+ed ).show();
    else
      $( ".pb"+ed ).hide();
  });
}

function mkShowBox ( type, label, css, milestoneStartEnd ) {
/*
 * Make a check box for som elements to highlight
 *  String type: class name of element to show 
 *  String label: label for the check box
 *  Object css: property name/value pairs to higlight the element
 *  Boolean milestoneStartEnd: 
 *    true, if milestone elements with class names "*Start" and "*End" prefixed
 *    with type, exist and should be shown/hidden as well, 
 *    false or absent, if not
 */
  var boxDiv= document.getElementById( "showBoxDiv" ),
      newBox= document.createElement( "div" ),
      newInput= document.createElement( "input" ),
      newLabel= document.createTextNode( label );
      newBox.className = "checkBoxShow"
  if( document.getElementById("showHide"+type) ) return;
  if( $("."+type).length==0 ) return ;
    newInput.id= "showHide"+type ;
    newInput.className= "setInput" ;
    newInput.type= "checkbox" ;
    newInput.defaultChecked= true ;
    newInput.checked= true ;
    boxDiv.appendChild( newBox );
    newBox.appendChild( newInput );
    newBox.appendChild( newLabel );
  $("#showHide"+type).click(function() {
    if( this.checked ) {
      $( "."+type ).css( css );
      if( milestoneStartEnd ) {
        $( "."+type+"Start" ).show();
        $( "."+type+"End" ).show();
      }
    }
    else {
      $( "."+type ).css( {"color": "inherit"} );
      if( milestoneStartEnd ) {
        $( "."+type+"Start" ).hide();
        $( "."+type+"End" ).hide();
      }
    }
  });
}

function loadCookie() { // load cookies and set accordingly
  $(".setInput").each(function(){
    this.checked= true;
    if( $.cookie(this.id) == "false" ) {
      this.click()
    }
  });
}

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
    addEndNoteListener();
    resize_window();

    $("#showNot").click(function(){
      $(".setInput").each(function(){
        this.checked= true; // "checked"
        this.click() // toggle "checked" i.e. to false and remove show
      });
    });
    $("#showAll").click(function(){
      $(".setInput").each(function(){
        this.checked= false;
        this.click()
      });
    });

    function saveCookie() {
      var expDays= { expires: 1 };
      $(".setInput").each(function(){
        $.cookie( this.id, this.checked.toString(), expDays ); // , path: '/'
      });
      $.cookie('text_size', $("#slider").slider("value"), expDays);
        // lagre størrelse satt i slider i cookien
      $.cookie('text_font', $("#font_georgia")[0].checked ? 'Klassisk':'Moderne', expDays);
    }
    $("#saveCookie").click( saveCookie );

    $( "#slider" ).slider({
        value:160,
        min: 110,
        max: 220,
        step: 1,
        animate: true,
        range: 'min',
        slide: function( event, ui ) {
            // alert("sliding");
            // $.cookie('text_size', ui.value); 	// lagre størrelse satt i slider i cookien // done now in saveCookie on user request only
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
        //$.cookie('text_font', 'Klassisk'); // done now in saveCookie on user request only
    });
    $("#font_verdana").click(function()  {
        $( ".text-resizeable" ).css('font-family', 'Myriad Pro, Verdana, sans-serif');
        //$.cookie('text_font', 'Moderne'); // done now in saveCookie on user request only
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
    // addSimpleReader({}, "Pettertest", "1804_28_txr.xml");                

    if( document.cookie != "" ) {
      loadCookie();
      saveCookie(); // to postpone expiration for another period
    }
    // ***************************************************************
});
