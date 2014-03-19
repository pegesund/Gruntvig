function entity(str, mode) {
		str = (str) ? str : "";
		mode = (mode) ? mode : "string";

		var e = document.createElement("div");
		e.innerHTML = str;

		if (mode == "numeric") {
			return "&#" + e.innerHTML.charCodeAt(0) + ";";
		}
		else if (mode == "utf16") {
			var un = e.innerHTML.charCodeAt(0).toString(16);
			while (un.length < 4) un = "0" + un;
			return "\\u" + un;
		}
		else return e.innerHTML;
	}

var month=new Array(12);
	month[0]="januar";
	month[1]="februar";
	month[2]="marts";
	month[3]="april";
	month[4]="maj";
	month[5]="juni";
	month[6]="juli";
	month[7]="august";
	month[8]="september";
	month[9]="oktober";
	month[10]="november";
	month[11]="december";

	Timeline.DefaultEventSource.Event.prototype.fillTime = function(elmt, labeller) {
		var startDate = this._start;
		var endDate = this._end;
		var startString = startDate.getDate() + " " + month[startDate.getMonth()] + " " + startDate.getFullYear();
		var endString = endDate.getDate() + " " + month[endDate.getMonth()] + " " + endDate.getFullYear();
        if (this._instant) {
            if (this.isImprecise()) {
                elmt.appendChild(elmt.ownerDocument.createTextNode(startString + " " + entity('&ndash;') + " " + endString));
            } else {
                elmt.appendChild(elmt.ownerDocument.createTextNode(startString));
            }
        } else {
            if (this.isImprecise()) {
                elmt.appendChild(elmt.ownerDocument.createTextNode(
                    this.getProperty("start") + " ~ " + this.getProperty("latestStart")));
                elmt.appendChild(elmt.ownerDocument.createElement("br"));
                elmt.appendChild(elmt.ownerDocument.createTextNode(
                    this.getProperty("earliestEnd") + " ~ " + this.getProperty("end")));
            } else {
                elmt.appendChild(elmt.ownerDocument.createTextNode(startString + " " + entity('&ndash;') + " " + endString));
            }
        }
    };

// Simile timelinep

var addTimeLine = function() {

var eventSource = new Timeline.DefaultEventSource();

// Example of changing the theme from the defaults
// The default theme is defined in
// http://simile-widgets.googlecode.com/svn/timeline/tags/latest/src/webapp/api/scripts/themes.js
var theme = Timeline.ClassicTheme.create(); // create the theme
theme.event.bubble.width = 200;   // modify it
theme.event.bubble.height = 300;
theme.event.track.height = 25;
theme.event.track.gap = 2;
theme.event.tape.height = 3;

theme.timeline_start = new Date(Date.UTC(1780,0,0,00,00,00,0));
theme.timeline_stop = new Date(Date.UTC(1920,0,0,00,00,00,0));
theme.event.instant.iconWidth = 12;
theme.event.instant.iconHeight = 14;


var bandInfos = [

Timeline.createHotZoneBandInfo({
    zones: [
    {
        start:    "jan 01 1780 00:00:00 GMT",
        end:      "Jan 01 1900 00:00:00 GMT",
        magnify:  300,
        unit:     Timeline.DateTime.MONTH
    }
    ],
    eventSource:    eventSource,
    date:           "Jan 01 1850 00:00:00 GMT",
    width:          "87%",
    intervalUnit:   Timeline.DateTime.CENTURY,
    theme:          theme, // Apply the theme
    layout:         'original',
    intervalPixels: 200
}),

Timeline.createBandInfo({
    overview:	true,
    eventSource:    eventSource,
    date:           "Jan 01 1780 00:00:00 GMT",
    width:          "13%",
    intervalUnit:   Timeline.DateTime.DECADE,
    theme:          theme, // Apply the theme
    layout:         'original',
    intervalPixels: 200
})   ];

bandInfos[1].syncWith = 0;
bandInfos[1].highlight = true;

//for (var i = 0; i < bandInfos.length; i++) {
//    bandInfos[i].decorators = [
//        new Timeline.SpanHighlightDecorator({
//            startDate:  "Sept 01 1783 00:00:00 GMT",
//            endDate:    "Sept 02 1872 00:00:00 GMT",
//            color:      "#eee", // set color explicitly
//            opacity:    40,
//            theme:      theme
//        })
//        ];
//}

var tl = Timeline.create(document.getElementById("my-timeline"), bandInfos);



Timeline.loadXML("../public/tidslinje/unpub.xml", function(xml, url) {
    eventSource.loadXML(xml, url);

    $i = 0;
    $('.timeline-event-label').each(function() {
   
//        // gj?r verkene kursiv
//        if($(this).css('color') == 'rgb(155, 132, 24)') {
//            $i++; alert($i);
//            $(this).css('font-style', 'italic');
//            $(this).width($(this).width() * 1.2);
//
//        }

    });

});

Timeline.loadXML("../public/tidslinje/life.xml", function(xml, url) {
    eventSource.loadXML(xml, url);
});

Timeline.loadXML("../public/tidslinje/pub.xml", function(xml, url) {
    eventSource.loadXML(xml, url);
});

Timeline.loadXML("../public/tidslinje/domestic.xml", function(xml, url) {
    eventSource.loadXML(xml, url);
});

Timeline.loadXML("../public/tidslinje/international.xml", function(xml, url) {
    eventSource.loadXML(xml, url);
});




//
//Timeline.loadXML("../public/xml/test/verk.xml", function(xml, url) {
//    eventSource.loadXML(xml, url);
//
//    $('.timeline-event-label').each(function() {
//
//        // gj?r verkene kursiv
//        if($(this).css('color') == 'rgb(210, 47, 30)') {
//
//            //alert('got my attribute');
//            $(this).css('font-style', 'italic');
//            $(this).width($(this).width() * 1.2);
//        }
//
//        // gj?r periodene bold
//        if($(this).css('color') == 'rgb(153, 153, 153)') {
//
//            //alert('got my attribute');
//            $(this).css('font-weight', 'bold');
//            $(this).width($(this).width() * 1.2);
//        }
//
//    });
//
//    $('.timeline-event-icon').each(function() {
//
//
//        // flytt alle ikoner litt opp s? vi f?r plass til bok ikonet
//
//        current_top = $(this).css('top').replace("px", "");
//
//        $(this).css('top', (current_top - 2) + 'px');
//
//    });
//
//});



}
