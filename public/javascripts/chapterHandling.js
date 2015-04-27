/* *
 * 
 * Handle chapters
 * 
 * 
 */



var gotoNextChapter = function() {
    if (currentChapter >= ($(".chapterSelector option").size()/2) - 1) return;
    currentChapter += 1;
    gotoChapter(currentTextId, currentChapter); 
}

var gotoPrevChapter = function() {
    if (currentChapter == 0) return;
    currentChapter -= 1;
    gotoChapter(currentTextId, currentChapter); 
}


var fixFootnotes = function() {
   $(".footMarker").each(function(index, value) {
       $(this).unbind("click").click(function(event) {
              event.preventDefault();
              var noteId = $(this).attr("href");
              $("#tekst_innhold").scrollTo(noteId, 800);
              return false;
       });
    });
}

var fixPageNumbersToFaks = function() {
            $(".faksimile_viewer").click(function() {
                $(".faksimile_tab:first").trigger('click');
                var fax = $(this).attr("hrel");
                var patt1=new RegExp("([0-9]+).jpg");
                var faxNumber = parseInt(patt1.exec(fax)[1]);
                var tab_nr = parseInt($(".faksimile_tab:first").attr("href").replace("#faksimile", ""));
                faksimiler[tab_nr].gotoPage(faxNumber);
                uriChangeTab(tab_nr, 2);
                uriChangeFaksimile(tab_nr, faxNumber);
            });   
}

var gotoChapter = function(text, chapter) {
    var chapterUrl = "ajax/getChapter/" + text + "/" + chapter;
    $.ajax({
        url: chapterUrl,
        success: function(data) {
            var chapterContent = $("#tekst_innhold");
            chapterContent.html(data);
            $("#tekst_innhold .chapter").hide();
            fixFootnotes();
            $("#tekst_innhold .chapter").fadeIn(2000, function() {
                
                });
            addTooltip($('.persName, .placeName, .myth, .mythStart, .mythEnd, .bible, .bibleStart, .bibleEnd'));
            addCommentListener();
            addEndNoteListener();
            fixPageNumbersToFaks();

            // add checkboxes for choosing pagenumbering, see tekstvisning.js
            var edFound= [];
            $("span[class^='pb']").each( function(){
              var ed= this.className.substring(2);
              if( !(ed in edFound) ) {
                mkPBox( ed );
                edFound[ed]= true ;
              }
            });
        
            // add checkboxes for other tings
            mkShowBox( "lem",       "Tekstkritik", {"color": "#4DBC4D"} );
            mkShowBox( "seg",       "Kommentarer", {"color": "#4DBC4D"}, true );
            mkShowBox( "persName",  "Personnavne", {"color": "#4DBC4D"} );
            mkShowBox( "myth",      "Mytologi",    {"color": "#4DBC4D"}, true );
            mkShowBox( "bible",     "Bibelsteder", {"color": "#4DBC4D"}, true );
            mkShowBox( "placeName", "Stednavne",   {"color": "#4DBC4D"} );
            loadCookie();
            
            // highlight search results
            hlSearch();
        }
    }); 
    $('.chapterSelector').val(currentChapter + "");
    uriChangeChapter(currentChapter);
        
}

var initChapterHandling = function() {
    $(".next").click(function() {
        gotoNextChapter();
    });

    $(".previous").click(function() {
        gotoPrevChapter();
    });


    $('.chapterSelector').change(function() {
        currentChapter = parseInt($(this).val());
        gotoChapter(currentTextId, currentChapter);                           
    });
    
}

