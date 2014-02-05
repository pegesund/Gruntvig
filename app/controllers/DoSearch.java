
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
    /* KK 2014-01-30 */    
    public static void avanceret() { 
        System.out.println("Advanced search");
        String lookfor = Application.params.get("lookfor");
        String lucene = Application.params.get("lucene");
      if( lookfor!=null ) {
        System.out.println("Simpel search for: " + lookfor);
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
        System.out.println("Total hits: " + totalHits);
        render(renderAssets, chapters, lookfor, totalHits);
      }
      else if( lucene!=null ) {
        System.out.println("Searching for qps: " + lucene);
        Query qChapter = Search.search("htmlAsText:(" + lucene + ")", Chapter.class);
        List<Chapter> chapters = qChapter.fetch();
        System.out.println("Chapters found: " + chapters.size());
        int totalHits = chapters.size();
        System.out.println("Total hits: " + totalHits);
        ArrayList<Asset> renderAssets = new ArrayList<Asset>();
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
        String[] W= lookfor.split(" ");
        String res= "";
        for( int i= 0; i<W.length; i++ )
            res+= createTeaser( str, W[i], 70 );
        return createTeaser( str, lookfor, 70 );
    }

    /**
     * 
     * Helper function
     * add caching later if slow
     * 
     */
    /* Ændret ifm. avanceret søg, KK 2014-01-30*/
    private static String createTeaser(String str, String lookforOrig, int len) {
        String lookfor = lookforOrig.toLowerCase().replace("*","\\p{L}*").replace("?","\\p{L}");
        int lookforStart = str.indexOf(lookfor) + 1;
        Pattern findWordsPattern = Pattern.compile("(\\s" + lookfor + "|^" + lookfor +")" +"[ ,;!.]", Pattern.CASE_INSENSITIVE);
        Matcher matcher = findWordsPattern.matcher(str);
        //if (matcher.find()) {
        //   lookforStart = matcher.start();
        //} else return "";
        String res= "";
        while( matcher.find() ) {
            lookforStart = matcher.start();
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

            String s = replaceAll(str.substring(start, stop), "(\\s" + lookfor + "|^" + lookfor + ")" + "[ ,;!.]", " <span class='lookedfor'> $1 </span> ");

            if (start != 0) {
                s = "..." + s;
            }
            if (stop != str.length()) {
                s += " ...";
            }
            if ( res.length()!=0 ) {
                s += "<br/>";
            }
            res+= s;
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
