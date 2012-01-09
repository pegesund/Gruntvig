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
}

var theUrl = {};


// this is a kind of hack
// it is written since the first reader-column is treated specially in the html and css
// consider redisign html
var fixMissingFirstTab = function() {
    var oldUrl = getCurrentHash(window.location.hash);
    var skeys = sort_keys(oldUrl);
    var smallest_str = skeys[0];
    if (!smallest_str) return;
    var smallest = parseInt(smallest_str);
    if (smallest == 0) return;
    var newUrl = {};
    var i = 0;
    for (i = smallest; i < skeys.length + smallest; i++) {
        if (oldUrl[i] + "") {
            newUrl[i - smallest] = oldUrl[i];
        }
        if (oldUrl["v" + i]) {
            newUrl["v" + (i - smallest)] = oldUrl["v" + i];
        }
    }
    window.location.hash = JSON.stringify(newUrl);
} 


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
}

var uriChangeChapter = function(chapterNum) {
    theUrl["k"]=chapterNum;
    $(".chapterSelector")[0].selectedIndex = chapterNum;
    window.location.hash = JSON.stringify(theUrl);
}

var uriChangeTab = function(tabNr, openTab) {
    theUrl[tabNr] = openTab;
    window.location.hash = JSON.stringify(theUrl);
}

var uriChangeVariant = function(tabNr, varNr) {
    theUrl["v" + tabNr] = varNr;
    window.location.hash = JSON.stringify(theUrl);
}

var uriChangeFaksimile = function(tabNr, faxNr) {
    theUrl["f" + tabNr] = faxNr;
    window.location.hash = JSON.stringify(theUrl);
}

var uriRemoveTab = function(tabNr) {
    delete theUrl[tabNr];
    delete theUrl["v" + tabNr];
    window.location.hash = JSON.stringify(theUrl);    
}

var startupUri = function(hash) {
    var oldHash = getCurrentHash(hash);
    if (oldHash["k"]) {
        theUrl["k"] = oldHash["k"];
    }
    var num = 1;
    var i;
    for (i=0; i<20; i++) {
        var options = {};
        if (oldHash[i] != undefined) {
            options["open_tab"] = oldHash[i];
            if (oldHash["v"+i] != undefined) {
                options["variant"] = oldHash["v" + i];
            }
            if (oldHash["f"+i] != undefined) {
                theUrl["f" + i] = oldHash["f" + i];
            }
            if (i != 0) addReaderColumn(options);
            num++;
        }
    }
    window.location.hash = JSON.stringify(theUrl);
}