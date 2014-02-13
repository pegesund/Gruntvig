
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import models.Asset;
import models.Chapter;
import play.modules.search.Query;
import play.modules.search.Search;

/**
 *
 * 
 * 
 * Controller to handle search for freetext
 * 
 * 
 */
public class DoSearch extends Application {

    /**
     * Advanced Search
     */
    /* KK 2014-02-12 */    
    public static void avanceret() { 
        System.out.println("Advanced search");
        String lookfor = Application.params.get("lookfor");
        String lucene = Application.params.get("lucene");
        String grundtvig = Application.params.get("grundtvig");
        String kommentar = Application.params.get("kommentar");
        List<Chapter> chapters= null;
        int chaptersSize= 0;
        ArrayList<Asset> renderAssets = new ArrayList<Asset>();
      if( lucene!=null ) {
        System.out.println("Searching for qps: " + lucene);

        if( grundtvig!=null ) { // Søg i Grundtvigteksternes kapitler (chapters)
          Query qChapter = Search.search("htmlAsText:(" + lucene + ")", Chapter.class);
          chapters = qChapter.fetch();
          chaptersSize= chapters.size();
        }

        if( kommentar!=null ) { // Søg i kommentarfiler (assets)
          Query qAsset = Search.search("htmlAsText:" + lucene, Asset.class);
          List<Asset> assets = qAsset.fetch();
          List<Asset> allAssets = Asset.findAll();
          for (Asset asset : assets) {
            System.out.println("Asset file match: " + asset.fileName);
          }
          for (Asset asset: assets) {
            if (asset.type.equals(Asset.introType) || asset.type.equals(Asset.txrType) || asset.type.equals(Asset.commentType) || asset.type.equals(Asset.variantType) || asset.type.equals(Asset.manusType) /*||  asset.type.equals(Asset.rootType)*/) {
                try {
                    long _id = asset.getCorrespondingRootId();
                    renderAssets.add(asset);
                } catch (Exception _e) {
                    
                }
            }
          }
        }

        int totalHits = renderAssets.size() + chaptersSize;
        System.out.println("Total hits: " + totalHits);
        lookfor= lucene;
        render(renderAssets, chapters, lookfor, totalHits);
      }
      else
        render();
    }

    
    public static void tools() {
        render();
    }
    
    /**
     * 
     * Search
     * Look in intro, variants, manus and txt-files (chapters).
     * 
     */
    public static void doSearch() {
        String lookfor = Application.params.get("lookfor");
        System.out.println("Searching for: " + lookfor);
        Query qChapter = Search.search("htmlAsText:" + lookfor, Chapter.class);
        List<Chapter> chapters = qChapter.fetch();
        System.out.println("Chapters found: " + chapters.size());
        Query qAsset = Search.search("htmlAsText:" + lookfor, Asset.class);
        List<Asset> assets = qAsset.fetch();
        System.out.println("Assets found: " + chapters.size());

        System.out.println("Total assets: " + assets.size());
        List<Asset> allAssets = Asset.findAll();
        for (Asset asset : assets) {
            System.out.println("Asset file match: " + asset.fileName);
        }

        ArrayList<Asset> renderAssets = new ArrayList<Asset>();
        for (Asset asset: assets) {
            if (asset.type.equals(Asset.introType) || asset.type.equals(Asset.variantType) || asset.type.equals(Asset.manusType) ||  asset.type.equals(Asset.rootType)) {
                try {
                    long _id = asset.getCorrespondingRootId();
                    renderAssets.add(asset);
                } catch (Exception _e) {
                    
                }
            }
        }

        int totalHits = renderAssets.size() + chapters.size();
        System.out.println("Total hits: " + renderAssets.size());
        render(renderAssets, chapters, lookfor, totalHits);
    }

    public static String createTeaser(String str, String lookfor) {
        return createTeaser( str, lookfor, 70 );
    }

    /**
     * 
     * Helper function
     * add caching later if slow
     * 
     */
    /* Vis kontekst for *alle* fund af *alle* søgeord i lookfor
     * Vis kontekst for proximity søgning (afsluttende med ~tal)
     * KK 2014-02-12 */
    private static String createTeaser(String str, String lookforOrig, int len) {
        String lookfor = lookforOrig.replaceAll(" (AND|&&|OR|\\|\\||NOT|\\+|-) "," ").toLowerCase().replace("*","\\p{L}*").replace("?","\\p{L}");
        int prox= 0;
        if( lookfor.contains("\"") && lookfor.contains("~") ) {
            int n= lookfor.indexOf("~")+1;
            int m= n+1;
            while( m<=lookfor.length() && lookfor.substring(n,m).matches("[0-9]+") )
                m++;
            prox= (m==n+1)?0:Integer.parseInt(lookfor.substring(n,m-1));
            lookfor = lookfor.replace(" ","|").replaceAll("~[0-9.]*","").replace("\"","");
        }
        else if( lookfor.contains("\"") )
            lookfor = lookfor.replace("\"","");
        else
            lookfor = lookfor.replace(" ","|");
        System.out.println("Look for: " + lookfor );
        System.out.println( prox );
        int lookforStart;
        //Pattern findWordsPattern = Pattern.compile("(\\s" + lookfor + "|^" + lookfor +")" +"[ ,;!.]", Pattern.CASE_INSENSITIVE);
        String match= "\\b(" + lookfor + ")\\b";
        Pattern findWordsPattern = Pattern.compile(match, Pattern.CASE_INSENSITIVE);
        Matcher matcher = findWordsPattern.matcher(str);
        //if (matcher.find()) {
        //   lookforStart = matcher.start();
        //} else return "";
        String res= "";
        int stop= 0;
        while( matcher.find(stop) ) {
            boolean skip= false;
            lookforStart = matcher.start();
            int lookforEnd = lookforStart + lookfor.length();
            stop= Math.min( lookforEnd+len, str.length() );
            while (stop < str.length() && !str.substring(stop, stop + 1).equals(" ")) {
                stop++;
            }
            // del kun ved hele ord
            int start= Math.max( lookforStart-len, 0 );
            while (start > 0 && !str.substring(start, start + 1).equals(" ")) {
                start--;
            }
            if( prox>0 ) {
                int proxEnd= lookforStart;
                String[] W= lookfor.split("\\|");
                int p= prox+W.length;
                //System.out.println( p );
                while ( proxEnd+1 < str.length() && p>0 ) {
                  proxEnd++;
                  if( str.substring(proxEnd, proxEnd+1).equals(" ") )
                    p--;
                  //System.out.println( str.substring( lookforStart,proxEnd ) + "," + p + "," + proxEnd );
                }
                start= lookforStart;
                stop= proxEnd;
                String proximity= str.substring( start, stop ).toLowerCase();
                System.out.println( proximity );
                for( int i=0; i<W.length; i++ ) {
                    if( !proximity.matches(".*\\b" + W[i] + "\\b.*") ) {
                        skip= true;
                        break;
                    }
                    System.out.println( W[i] + (skip?" skipped":" found") );
                }
            }
            if( !skip ) {
                String s= replaceAll(str.substring(start, stop), match, " <span class='lookedfor'> $1 </span> ");
                if (start != 0) {
                    s = "..." + s;
                }
                if ( res.length()!=0 ) {
                    s = "<br/>" + s;
                }
                if (stop != str.length()) {
                    s += " ...";
                }
                res+= s;
            }
        }
        return res;
    }

    /*
    private static String createTeaser(String str, String lookforOrig, int len) {
        String lookfor = lookforOrig.toLowerCase();
        int lookforStart = str.indexOf(lookfor) + 1;
        Pattern findWordsPattern = Pattern.compile("(\\s" + lookfor + "|^" + lookfor +")" +"[ ,;!.]", Pattern.CASE_INSENSITIVE);
        Matcher matcher = findWordsPattern.matcher(str);
        if (matcher.find()) {
           lookforStart = matcher.start();
        } else return "";
        int lookforEnd = lookforStart + lookfor.length();
        int start = lookforStart;
        int stop = lookforEnd;
        while (stop < str.length() && ((stop - lookforEnd) < len)) {
            stop++;
        }

        while (stop < str.length() && !str.substring(stop, stop + 1).equals(" ")) {
            stop++;
        }

        // del kun ved hele ord
        while (start > 0 && ((lookforStart - start) < len)) {
            start--;
        }

        while (start > 0 && !str.substring(start, start + 1).equals(" ")) {
            start--;
        }

        String s = replaceAll(str.substring(start, stop), "(\\s" + lookfor + "|^" + lookfor +")" +"[ ,;!.]", " <span class='lookedfor'> $1 </span> ");

        if (start != 0) {
            s = "..." + s;
        }
        if (stop != str.length()) {
            s += "...";
        }
        return s;
    }
    */
    
    static private String replaceAll(String string, String regex, String replaceWith) {
        Pattern myPattern = Pattern.compile(regex, Pattern.CASE_INSENSITIVE);
        /*for space,new line, tab checks*/
        //Pattern myPattern = Pattern.compile(regex+"[ /n/t/r]", Pattern.CASE_INSENSITIVE);
        string = myPattern.matcher(string).replaceAll(replaceWith);
        return string;
    }
}
