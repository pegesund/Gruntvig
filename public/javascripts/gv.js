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
function blank(target, loc, target, x, y) {
    if ( !x) { x= "685"; }
    if ( !y) { y= screen.availHeight-100; }
    var w= window.open(loc,target,"width="+x+",height="+y+",resizable=yes,scrollbars=yes,status=no,menubar=yes,titlebar=no,location=yes",true);
    w.focus();
    return false;
    }
