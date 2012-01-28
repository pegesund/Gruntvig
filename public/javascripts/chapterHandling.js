/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 * 
 * use of globals: currentTextId, currentChapter
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

var gotoChapter = function(text, chapter) {
    var chapterUrl = "ajax/getChapter/" + text + "/" + chapter;
    $.ajax({
        url: chapterUrl,
        success: function(data) {
            var chapterContent = $("#tekst_innhold");
            chapterContent.html(data);
            $("#tekst_innhold .chapter").hide();
            $("#tekst_innhold .chapter").fadeIn(3000, function() {
                
                });
            addTooltip($('.persName, .placeName, .myth'));
            addCommentListener();
            $(".faksimile_viewer").click(function() {
                $(".faksimile_tab:first").trigger('click');
                var fax = $(this).attr("hrel");
                var patt1=new RegExp("([1-9][0-9]+).jpg");
                var faxNumber = parseInt(patt1.exec(fax)[1]);
                var tab_nr = parseInt($(".faksimile_tab:first").attr("href").replace("#faksimile", ""));
                faksimiler[tab_nr].gotoPage(faxNumber);
                uriChangeTab(tab_nr, 2);
                uriChangeFaksimile(tab_nr, faxNumber);
            });
            
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

