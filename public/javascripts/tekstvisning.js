/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


    
  $(document).ready(function() {
      fixMissingFirstTab();
  
      readerNum = 0;
      var columnWidth = 471; // how wide new columns should be, in pixel
      var startupHash = window.location.hash;
      
        
      // takes an optional argument containing a hashtable
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
            $(window).scrollTo('100%', 0 , {duration:700});
          
      }

        $("#ny_kolonne_bar").click(function() {
            addReaderColumn();
        });

        $(".lukk_kolonne_knapp").live('click', function() {        
            var currentTabId = parseInt($(this).parent().parent().parent().attr("id").substring(3));
            uriRemoveTab(currentTabId);
            number_of_present_tabreaders = $(".tabReader").length;
            
            $(this).parent().parent().parent().parent().remove(); // hide entire tabreader
            $("#høyre").width($("#høyre").width() - columnWidth);

            if(number_of_present_tabreaders > 1){ // only do this if there are 1 or more tabReaders opened

                // decrease width of .container and #høyre
                $(".container").width($(".container").width() - columnWidth);
                
            }
            resize_window();
            return false; // hindrer at vi bytter side
        });

  addNewReader = function(num) {
    var options = arguments[1] || {};
    uriChangeTab(num,0);   
    var newReader = '<span class="tabReader"><div id="tab' + num + '"> <ul> <li class="selected"><a href="#innledning' + num + '"><span>Indledning</span></a></li> <li><a class="variant_tab" href="#variant' + num + '"><span>Varianter</span></a></li> <li><a class="faksimile_tab" href="#faksimile' + num + '"><span>Fax.</span></a></li> <li><a href="#txr' + num + '"><span>Tekstred.</span></a></li><li><a class="kommentar_tab" href="#kommentar' + num + '"><span>Kommentarer</span></a></li> <li id="lukk_kolonne_knapp_li"><a title="Skjul kolonne" href="#skjul" class="lukk_kolonne_knapp"></a></li> </ul> ';
    newReader += '<div id="innledning' + num + '"> <div class="innledningContent text-resizeable"><p><img src="public/images/wait.gif"></p></div></div>';
    newReader +=  '<div id="variant' + num + '"><div class="variant_select">Vis variant: #{variantsAsDropDown variants:variants /} <a id="variant_vejledning" href="../vejledning/varapp_vej" target="_blank">Vejledning</a></div><div class="variantContent text-resizeable">Variant content</div>  </div>';
    newReader += '<div id="faksimile' + num + '" class="faksimile_frame" ><div class="faksimile_select"><a class="forrige_side" href="#">Forrige side</a> | <a class="neste_side" href="#">Næste side</a></div> <div class="faksimileContent"></div></div>';
    newReader += '<div class="txr text-resizeable" id="txr' + num + '"> Her skal txr ligge...  </div>';
    newReader += '<div class="kommentar text-resizeable" id="kommentar' + num + '"> Her skal kommentarene ligge...  </div>';
    newReader += '</div></span>';
    // vis variant-select box over hovedtekst ogsÃ¥
      
      var hovedtekstSelect = 'Vis variant: #{variantsAsDropDown variants:variants /}';
      $("#hovedtekst_select").html(hovedtekstSelect);
      //alert(newReader);
         //alert($("#høyre_toppmeny_nytt_navn").html());
      $("#høyre_toppmeny_nytt_navn").html($("#høyre_toppmeny_nytt_navn").html() + newReader);
      //alert($("#høyre_toppmeny_nytt_navn").html());
     // update uri-hash if changing tab-panel  
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
              var currentTab = parseInt($(ui.panel).parent().attr("id").substring(3));
              uriChangeTab(currentTab, ui.index);
          });          
     }

      
      $('.variantsAsDropDown').change(function() {
         var parentId = $(this).closest("div.ui-tabs").attr("id");
         var tabNumber = parseInt(parentId.substring(3));
         var index = $(this)[0].selectedIndex;
         if (index > 0) {
             uriChangeVariant(tabNumber, index);
         }
         var theUrl = "ajax/getVariantByName/" + $(this).val();
         $.ajax({
             url: theUrl,
             success: function(data) {
                 var variantContent = $("#" + parentId + " .variantContent");
                 variantContent.html(data);
             }
         })
      });

        
         
         $.ajax({
             url: txrUrl,
             success: function(data) {
                 var txrContent = $("#txr" + num);
                 txrContent.html(data);
                 addTooltip($('.persName, .placeName, .myth, .rs_bible'));
                 
                 $(".txrmenu").unbind("click").click(function() {
                    var scrollElement = $(this).closest(".mainTxr").parent();
                    var id = $(this).attr("hrel").replace(/\./g, "\\.");
                    scrollElement.scrollTo(scrollElement.find("#" + id)); // hack as id should be unique - fix if problems
                    scrollElement.scrollTo("-=30px", 700);
                    
                });

             }
         });




         // add comments
        
         $.ajax({
             url: kommentarUrl,
             success: function(data) {
                 var introContent = $("#kommentar" + num);
                 introContent.html(data);
                 addTooltip($('.persName, .placeName, .myth, .rs_bible'));
                 $(".plusComment").click(function() {    
                    $(this).next().slideToggle("slow"); 
                 });
             }
         });

         // add intro
         
         $.ajax({
             url: introUrl,
             success: function(data) {
                 var introContent = $("#innledning" + num);
                 introContent.find(".innledningContent").html(data);
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
                 addTooltip($('.persName, .placeName, .myth, .rs_bible'));
                 $(".plus").click(function() {    
                    $(this).next().slideToggle("slow"); 
                 });
                 $(".intro_menu").unbind("click").click(function() {
                    var scrollElement = $(this).closest(".innledningContent").parent();
                    var id = $(this).attr("hrel").replace(/\./g, "\\.");
                    scrollElement.scrollTo($(scrollElement.find("#" + id)));
                    scrollElement.scrollTo("-=30px", 700);
                 });

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
             }
         })
      });


      // autolast den første varianten & manuset
      if (options["variant"]) {
        $("#tab" + num +' .variantsAsDropDown')[0].selectedIndex = options["variant"];
      }
      
      $("#tab" + num +' .variantsAsDropDown').trigger('change');
      $("#tab" + num +' .manusAsDropDown').trigger('change');

      // vis hovedtekst select nÃ¥r variant-fanen Ã¥pnes
      $('.variant_tab').click(function() {
         // Jørgen: for Ã¥ enable variantview i hovedvinduet, mÃ¥ disse linjene tilbake. Men det er en del mer som mÃ¥ fixes :-)
         // $("#hovedtekst_select").show('medium');
         // resize hovedfeltet
         // resize_window();
         //$("#tekst_innhold").height($(".variant_content").height() - 0);
      });

      // resize layout nÃ¥r kolonner endres
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


    
    var options = {};
    options["variant"] = getCurrentHash(window.location.hash)["v0"];
    options["open_tab"] =  getCurrentHash(window.location.hash)[0];
    options["current_chapter"] = getCurrentHash(window.location.hash)["k"];
    if (getCurrentHash(window.location.hash)["f0"]) theUrl["f0"] = getCurrentHash(window.location.hash)["f0"];
    addNewReader(0, options);
    addCommentListener();

    // resize layout nÃ¥r siden laster
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
                          {     $(this).css("background-color", "transparent");
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

                $("#font_georgia").click(function()  {	$( ".text-resizeable" ).css('font-family', 'Georgia, Garamond, serif');        $.cookie('text_font', 'Klassisk');  });
                $("#font_verdana").click(function()  {	$( ".text-resizeable" ).css('font-family', 'Myriad Pro, Verdana, sans-serif'); $.cookie('text_font', 'Moderne');   });

                // sett riktig tekst-størrelse

                if($.cookie('text_size') > 0) { // hvis brukeren har brukt slideren tidligere

                      //  alert($.cookie('text_size') );
                        $( ".text-resizeable" ).css('font-size', ($.cookie('text_size')/10) + 'px');  // sett tekst-størrelse
                       
                       $( "#slider" ).slider( "value", $.cookie('text_size') );   			// flytt slider knapp
                }

                initChapterHandling();
                startupUri(startupHash);  
                

                
  });

