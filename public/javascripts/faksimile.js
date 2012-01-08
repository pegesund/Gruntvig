/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

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

    $(".neste_side").click(function()
    {
        if (iviewer_num + 1 > numOfPictures) return false;
        iviewer_num += 1;
        iviewer.loadImage(iviewer_src + "_" + iviewer_num + ".jpg");
        return false;
    });

    $(".forrige_side").click(function()
    {
        if (iviewer_num == 1) return false;
        iviewer_num -= 1;
        iviewer.loadImage(iviewer_src + "_" + iviewer_num + ".jpg");
        return false;
    });
}
