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
