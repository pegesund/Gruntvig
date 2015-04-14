// gv.js;
//  (c) Karsten Kynde 2011-12-03
//  til brug for Grundtvigs Værker

var minus= '&#x2013;';

function showhide( plus, id ) {
  var elem= document.getElementById( id );
  if ( !elem ) { alert( 'no block to split' ); }
  if ( elem.style.display=='block' ) {
    elem.style.display= 'none';
    plus.innerHTML= '+';
    }
  else {
    elem.style.display= 'block';
    plus.innerHTML= minus;
    }
  }

// Visning af tekst i separat vindue, KK 2014-04-03
function blank(target, loc, x, y) {
    if ( !x) { x= "685"; }
    if ( !y) { y= screen.availHeight-100; }
    var w= window.open(loc,target,"width="+x+",height="+y+",resizable=yes,scrollbars=yes,status=no,menubar=yes,titlebar=no,location=yes",true);
    w.focus();
    return false;
    }

// Fremhævelse af søgeresultater, KK 2015-03-27
// med tak til Zoom Search, www.wrensoft.com

function ZRetrieveQuery()
{
  var hlQueryStr, hl;
  hlQueryStr= window.location.search.substring(1).match(/keywords=([^&]*)/);
  if( hlQueryStr!=null ) hl= hlQueryStr[1];
  else return false ;
  if( hl.search(/(%22|")~[0-9]+$/)>=0 ) { // if proximity search, higlight all keywords
    hl= hl.replace( /^(%22|")/, "" ).replace( /(%22|")~[0-9]+$/, "" );
  }
  //alert( "Key words are: " + hl );
  var terms;

  //hl= hl.replace( /%C3%A6/, "æ" );
  //hl= hl.replace( /%C3%B8/, "ø" );
  //hl= hl.replace( /%C3%A5/, "å" ); // �, �, �, to make up for an error in MSIE 8, SKS-E, 1.6 KK 2012-02-21
  if ((document.charset && document.charset == "utf-8") ||
    (document.characterSet && document.characterSet == "UTF-8"))
    hl = decodeURIComponent(hl);
  else // stops excecution, SKS-E, 1.8 KK 2013-01-10
      hl = unescape(hl);
  hl = hl.toLowerCase();
  // create array of terms
  //var term = hl.split("+");
  var re = /\"(.*?)\"|[^\\+\"]+/g;
  terms = hl.match(re);

  // convert terms in regexp patterns
  for (var i=0;i<terms.length;i++) // take each term in turn
  {
      if(terms[i] != "")
      {
          if (terms[i].indexOf("\"") != -1)
          {
              // contains double quotes
              terms[i]=terms[i].replace(/\"/g,"");
              terms[i]=terms[i].replace(/\+/g," ");
          }
          else
          {
              terms[i]=terms[i].replace(/\+/g,"");
          }

          if (terms[i].indexOf("*") != -1 || terms[i].indexOf("?") != -1)
          {
              // convert wildcard pattern to regexp
              terms[i] = terms[i].replace(/\\/g, " ");
              terms[i] = terms[i].replace(/\^/g, " ");

              //term[i] = term[i].replace(/\+/g, " "); // split on this so no point in looking

              terms[i] = terms[i].replace(/\#/g, " ");
              terms[i] = terms[i].replace(/\$/g, " ");
              terms[i] = terms[i].replace(/\./g, " ");

              // check if search term only contains only wildcards
              // if so, we will not attempt to highlight this term
              var wildcards = /\w/;
              if (wildcards.test(terms[i]))
              {
                terms[i] = terms[i].replace(/\*/g, "[^\\s]*");
                terms[i] = terms[i].replace(/\?/g, "[^\\s]"); // insist upon one non whitespace
              }
              else
                terms[i] = "";
          }

          if (terms[i] != "")
          {
             terms[i] = "(>[\\s]*|>[^<]+[\\b\\W])("+terms[i]+")(<|[\\b\\W][^>]*<)";
          }
      }
  }
  return terms;
}

function ZHighlightText(terms, text)
{
    text=text.replace(/&amp;/ig, '&');
    text=text.replace(/&nbsp;/ig, '');

    for (var i=0; i<terms.length; i++) // take each term in turn
    {
        if(terms[i] != "")
        {
            // we need a loop for the main search to catch all between ><
            // and we add  before each found to ignore those done etc
            // todo: develop reliable single pass regexp and dispose of loop
            var l = 0;
            re = new RegExp(terms[i], "gi");
            var count = 0; // just incase
            text = ">" + text + "<"; // temporary tag marks
            do
            {
                l=text.length;
                text=text.replace(re, '$1<span class="highlight">$2</span>$3');
                count++;
            }
            //while(re.lastIndex>0 && count<100); lastIndex not set properly under netscape
            while(l!=text.length && count<100);
            text = text.substring(1, text.length-1); // remove temporary tags
        }
    }
    text = text.replace(eval("//g"), '');
    text = text.replace(eval("//g"), '&nbsp;');

    return(text);
}

function ZHighlightReplace(q, node)
{
  var node_value = node.nodeValue;
  var newtext = ZHighlightText(q, node_value);
  if (newtext != node_value)
  {
    var repl = document.createElement('span');
    repl.innerHTML = newtext;
    node.parentNode.replaceChild(repl, node);
  }
}

function ZHighlightSearch( q, root, highlight ) {
  for (var i = 0, j = root.length; i < j; i++) {
    if ( highlight && root[i].nodeType === 3 ) { // 3=Node.TEXT_NODE
      ZHighlightReplace(q, root[i]);
    }
    else {
      if( root[i].className && root[i].className.indexOf("text-resizeable")>=0 ) { // tekst_innhold or tab0
        highlight= true;
      }
      ZHighlightSearch( q, root[i].childNodes, highlight );
    }
  }
}

function hlSearch() {
  var terms = ZRetrieveQuery()
  if( terms ) {
    ZHighlightSearch( terms, document.body.childNodes, false );
  }
}

//$(document).ready(hlSearch);
