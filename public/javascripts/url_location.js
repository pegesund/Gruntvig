/* 
 * 
 * Handle persistent urls to pass on
 * windows.locaction.redirect
 * 
 * Side-effects:
 * 
 * currentHash is global
 * readerNum is global
 * 
 */

var sort_keys = function(o)
{
    var keys = [];
    for (var key in o)
    {
            keys.push(key);
    }
    return keys.sort();
};

var theUrl = {};


var makeContinousUrl = function(oldHash) {
    var j = 0;
    var i;
    var newHash = {};
    if (typeof oldHash["k"] !== 'undefined') newHash["k"] = oldHash["k"]; 
    for (i=0; i<20; i++) {
        if (typeof oldHash[i + ""] !== 'undefined') { 
            newHash[j + ""] = oldHash[i + ""];
            if (typeof oldHash["v"] !== 'undefined') newHash["v" + j] = oldHash["v" + i];
            if (typeof oldHash["x"] !== 'undefined') newHash["x" + j] = oldHash["x" + i];
            
            if (typeof oldHash["f"] !== 'undefined') newHash["f" + j] = oldHash["f" + i];
            j++;
        }
    }
    return newHash;
};


var fixMissingFirstTab = function() {
    var oldUrl = getCurrentHash(window.location.hash);
    var newUrl = makeContinousUrl(oldUrl);
    theUrl = newUrl;
    window.location.hash = JSON.stringify(newUrl);
};


var getCurrentHash = function(hash) {
    if (!hash) return "";
    if (!hash.length > 0) return "";
    return JSON.parse(hash.substring(1), function (key, value) {
        var type;
        if (value && typeof value === 'object') {
            type = value.type;
            if (typeof type === 'string' && typeof window[type] === 'function') {
                return new (window[type])(value);
            }
        }
        return value;
    });
};

var uriChangeChapter = function(chapterNum) {
    theUrl["k"]=chapterNum;
    $(".chapterSelector")[0].selectedIndex = chapterNum;
    window.location.hash = JSON.stringify(theUrl);
};

var uriChangeTab = function(tabNr, openTab) {
    theUrl[tabNr] = openTab;
    window.location.hash = JSON.stringify(theUrl);
};

var uriChangeVariant = function(tabNr, varNr) {
    theUrl["v" + tabNr] = varNr;
    window.location.hash = JSON.stringify(theUrl);
};

var uriChangeFaksimile = function(tabNr, faxNr) {
    theUrl["f" + tabNr] = faxNr;
    window.location.hash = JSON.stringify(theUrl);
};

var uriRemoveTab = function(tabNr) {
    delete theUrl[tabNr];
    delete theUrl["v" + tabNr];
    delete theUrl["x" + tabNr];
    delete theUrl["f" + tabNr];
    window.location.hash = JSON.stringify(theUrl);    
};

var uriAddForeignTab = function(tabNr, fileName) {
    $.ajax({
        url: "ajax/getIdFromFilename/"  + fileName,
        success: function(fileId) {
           theUrl["x" + tabNr] = fileId;
            window.location.hash = JSON.stringify(theUrl);
        }
    });   
};

var startupUri = function() {
    var oldHash = theUrl;
    if (oldHash["k"]) {
        theUrl["k"] = oldHash["k"];
    }
    var num = 1;
    var i;
    for (i=0; i<20; i++) {
        var j = num - 1;
        var options = {};
        if ((oldHash[i] != undefined) || (oldHash["x" + i] != undefined)) {
            options["open_tab"] = oldHash[i];
            if (oldHash["v"+i] != undefined) {
                options["variant"] = oldHash["v" + i];
            }
            if (oldHash["f"+i] != undefined) {
                theUrl["f" + i] = oldHash["f" + i];
            }
            if (oldHash["x" + i] != undefined) {
                theUrl["x" + i] = oldHash["x" + i];
                var fileName = $.ajax({
                    type: "GET",
                    url: "ajax/getFilenameFromId/" + theUrl["x" + i],
                    async: false,
                }).responseText;
                var showName = $.ajax({
                    type: "GET",
                    url: "ajax/getNameFromFilename/" + fileName,
                    async: false,
                }).responseText;
                addSimpleReader({}, showName, fileName);
                continue;
            }
            if (i != 0) addReaderColumn(options);
            num++;
        }
    }
    window.location.hash = JSON.stringify(theUrl);
};