/* 
 * 
 * Handles faksimiler
 * Treated as objects to keep scope
 * Fix bug in iviewer by removing double images
 *  
 *    */


// fix bug i iviewer to allow more images in same dom
var removeShadowImages = function (num) {
    for (var i=0; i <= num; i++) {
       $("#faksimile" + i + " img:not(:first-child)").remove();
    }
}

var addFaksimile = function(num) {

    // vis faksimile (https://github.com/can3p/iviewer)
    var iviewer = {};
    var iviewer_src = "public/images/" + rootFile;
    var iviewer_num = 1;
        
    $("#faksimile" + num + " .faksimileContent").iviewer(
    {
        src: iviewer_src + "_" + iviewer_num + ".jpg",
        zoom: 'fit',
        zoom_min: 25,
                      
        initCallback: function()
        {
            iviewer = this;
        }
    });

    $("#tab" + num + " .neste_side").click(function()
    {
        if (iviewer_num + 1 > numOfPictures) return false;
        iviewer_num += 1;
        iviewer.loadImage(iviewer_src + "_" + iviewer_num + ".jpg");
        return false;
    });

    $("#tab" + num + " .forrige_side").click(function()
    {
        if (iviewer_num == 1) return false;
        iviewer_num -= 1;
         alert("Going to page: " + iviewer_num);
        iviewer.loadImage(iviewer_src + "_" + iviewer_num + ".jpg");
        return false;
    });
}
