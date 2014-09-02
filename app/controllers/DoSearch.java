
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import helpers.Helpers;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import models.Asset;
import models.Chapter;
import org.apache.solr.client.solrj.SolrQuery;
import org.apache.solr.client.solrj.SolrQuery.SortClause;
import org.apache.solr.client.solrj.SolrServer;
import org.apache.solr.client.solrj.response.QueryResponse;
import org.apache.solr.common.SolrDocument;
import org.apache.solr.common.SolrDocumentList;
import org.apache.solr.common.SolrInputDocument;

/**
 *
 *
 *
 * Controller to handle search for freetext
 *
 *
 */
public class DoSearch extends Application {
    
    
    public static int PAGESIZE = 5;
    
    private static String composeOr(String[] str) {
        String akk="(";
        int i = 0;
        for (String s: str) {
            i++;
            akk += " type:" + s;
            if (i < str.length) akk += " OR ";
        }
        akk += " )";
        return akk;
    }

    /**
     * Advanced Search
     */
    /* KK 2014-02-13, 2014-03-06 */
    public static void avanceret() {
        System.out.println("Advanced search");
        String lucene = params.get("lucene");
        String grundtvig = params.get("grundtvig");
        String kommentar = params.get("kommentar");
        String realWords = params.get("words");
        int page = 1;
        long totalAll = 0;
        int pageSize = PAGESIZE;
        if (params._contains("page")) {
            page = Integer.parseInt(params.get("page"));
        }
        String cat = "";

        if (lucene == null || lucene.contains(".ingenting")) { // Simple search from header or no search
            String words = Application.params.get("words");
            if (words != null) {
                lucene = words.replaceAll("\\s+", " AND ");
            }
            /*otherwise no search*/
            grundtvig = kommentar = "jatak";
        }

        if (lucene != null) {
            lucene = lucene.replaceAll("[!()+,.;:]", "");
            if (lucene.contains("OR")) {
                lucene = "(" + lucene + ")";
            }            
            System.out.println("Searching for qps: " + lucene);
            List<Chapter> chapters = new ArrayList<Chapter>();
            ArrayList<Asset> renderGrundtvigAssets = new ArrayList<Asset>();
            ArrayList<Asset> renderCommentAssets = new ArrayList<Asset>();
            SolrServer server = Helpers.getSolrServer();
            SolrQuery query = new SolrQuery();
            String q = "text:" + lucene;
            String types[] = {};
            if (grundtvig != null && kommentar == null) {
                types = new String[] {Asset.variantType, Asset.manusType, "chapter"};
            }
            if (grundtvig == null && kommentar != null) {
                types = new String[] {Asset.introType, Asset.txrType, Asset.commentType, Asset.veiledningType};                
            }
            if (grundtvig != null && kommentar != null) {
                types = new String[] {Asset.introType, Asset.txrType, Asset.commentType, Asset.veiledningType, Asset.variantType, Asset.manusType, "chapter"}; 
            }
            query.setQuery(q + " AND " + composeOr(types));
            System.out.println("Query: " + query.getQuery());
            int start = (page - 1) * pageSize;
            System.out.println("Setting start-pos to: " + start);
            query.setStart(start);
            query.setRows(pageSize);
            query.setSort(new SortClause("sj", SolrQuery.ORDER.asc));
            try {
                QueryResponse rsp = server.query(query);
                SolrDocumentList docs = rsp.getResults();
                totalAll = docs.getNumFound();
                for (SolrDocument doc : docs) {
                    System.out.println("Found type: " + doc.getFirstValue("type"));
                    long id = Long.parseLong(doc.getFieldValue("pgid").toString());
                    String type = doc.getFieldValue("type").toString();
                    if (grundtvig != null && type.equals("chapter")) {
                        Chapter c = Chapter.findById(id);
                        chapters.add(c);
                    } else {                   
                        Asset asset = Asset.findById(id);
                        if (grundtvig != null && (asset.type.equals(Asset.variantType) || asset.type.equals(Asset.manusType))) {
                            renderGrundtvigAssets.add(asset);
                        } else
                        if (kommentar != null && (asset.type.equals(Asset.introType) || asset.type.equals(Asset.txrType) || asset.type.equals(Asset.commentType) || asset.type.equals(Asset.veiledningType))) {
                            renderCommentAssets.add(asset);
                        }                        
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
                render();
                return;
            }

            if (grundtvig != null) cat += "grundtvig";
            if (kommentar != null) cat += "kommentar";              
            int totalHits = renderGrundtvigAssets.size() + renderCommentAssets.size() + chapters.size();
            System.out.println("Total hits: " + totalHits);
            System.out.println("Total all: " + totalAll);
            String lookfor = lucene;
            int totalPages = (int) Math.ceil((double)totalAll / (double)pageSize);
            boolean first = false;
            render(renderGrundtvigAssets, chapters, lookfor, totalHits, renderCommentAssets, cat, totalAll, pageSize, totalPages, page, first);
        } else {
            boolean first = true;
            render(first);
        }
    }

    public static void tools() {
        render();
    }


    /**
     *
     * Search Look in intro, variants, manus and txt-files (chapters). Now
     * obsolete, 2014-03-13
     */
    public static void doSearch() {
        /*String lookfor = Application.params.get("lookfor");
        System.out.println("Searching for: " + lookfor);
        Query qChapter = Search.search("htmlAsText:" + lookfor, Chapter.class);
        List<Chapter> chapters = qChapter.fetch();
        System.out.println("Chapters found: " + chapters.size());
        Query qAsset = Search.search("htmlAsText:" + lookfor, Asset.class);
        List<Asset> assets = qAsset.fetch();
        System.out.println("Assets found: " + chapters.size());

        System.out.println("Total assets: " + assets.size());
        for (Asset asset : assets) {
            System.out.println("Asset file match: " + asset.fileName);
        }

        ArrayList<Asset> renderAssets = new ArrayList<Asset>();
        for (Asset asset : assets) {
            if (asset.type.equals(Asset.introType) || asset.type.equals(Asset.variantType) || asset.type.equals(Asset.manusType) || asset.type.equals(Asset.rootType)) {
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
*/
    }

    public static String createTeaser(String str, String lookfor) {
        return createTeaser(str, lookfor, 70);
    }

    /**
     *
     * Helper function add caching later if slow
     *
     */
    /* Vis kontekst for *alle* fund af *alle* søgeord i lookfor
     * Vis kontekst for proximity søgning (afsluttende med ~tal)
     * KK 2014-02-12 */
    private static String createTeaser(String str, String lookforOrig, int len) {
        String lookfor = lookforOrig.replaceAll(" (AND|&&|OR|\\|\\||NOT|\\+|-) ", " ").toLowerCase().replace("*", "\\p{L}*").replace("?", "\\p{L}");
        int prox = 0;
        if (lookfor.contains("\"") && lookfor.contains("~")) {
            int n = lookfor.indexOf("~") + 1;
            int m = n + 1;
            while (m <= lookfor.length() && lookfor.substring(n, m).matches("[0-9]+")) {
                m++;
            }
            prox = (m == n + 1) ? 0 : Integer.parseInt(lookfor.substring(n, m - 1));
            lookfor = lookfor.replace(" ", "|").replaceAll("~[0-9.]*", "").replace("\"", "");
        } else if (lookfor.contains("\"")) {
            lookfor = lookfor.replace("\"", "");
            lookfor = lookfor.replace(" ", "\\P{L}+");
        } else {
            lookfor = lookfor.replace(" ", "|");
        }
        System.out.println("Teaser for: " + lookfor);
        System.out.println("prox= " + prox);
        int lookforStart;
        //Pattern findWordsPattern = Pattern.compile("(\\s" + lookfor + "|^" + lookfor +")" +"[ ,;!.]", Pattern.CASE_INSENSITIVE);
        String match = "\\b(" + lookfor + ")\\b";
        Pattern findWordsPattern = Pattern.compile(match, Pattern.CASE_INSENSITIVE);
        Matcher matcher = findWordsPattern.matcher(str);
        //if (matcher.find()) {
        //   lookforStart = matcher.page();
        //} else return "";
        String res = "";
        int stop = 0;
        while (matcher.find(stop)) {
            boolean skip = false;
            lookforStart = matcher.start();
            int start = Math.max(lookforStart - len, 0);
            if (start < /*previous*/ stop) {
                start = stop;
            } else {
                while (start > 0 && !str.substring(start, start + 1).equals(" ")) {
                    start--;
                }
            }
            int lookforEnd = lookforStart + lookfor.length();
            stop = Math.min(lookforEnd + len, str.length());
            while (stop < str.length() && !str.substring(stop, stop + 1).equals(" ")) {
                stop++;
            }
            // del kun ved hele ord
            if (prox > 0) {
                int proxEnd = lookforStart;
                String[] W = lookfor.split("\\|");
                int p = prox + W.length;
                //System.out.println( p );
                while (proxEnd + 1 < str.length() && p > 0) {
                    proxEnd++;
                    if (str.substring(proxEnd, proxEnd + 1).equals(" ")) {
                        p--;
                    }
                    //System.out.println( str.substring( lookforStart,proxEnd ) + "," + p + "," + proxEnd );
                }
                start = lookforStart;
                stop = proxEnd;
                String proximity = str.substring(start, stop).toLowerCase();
                //System.out.println( proximity );
                for (int i = 0; i < W.length; i++) {
                    if (!proximity.matches(".*\\b" + W[i] + "\\b.*")) {
                        skip = true;
                        break;
                    }
                    //System.out.println( W[i] + (skip?" skipped":" found") );
                }
            }
            if (!skip) {
                String s = replaceAll(str.substring(start, stop), match, " <span class='lookedfor'> $1 </span> ");
                if (start != 0) {
                    s = "..." + s;
                }
                if (res.length() != 0) {
                    s = "<br/>" + s;
                }
                if (stop != str.length()) {
                    s += " ...";
                }
                res += s;
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
     lookforStart = matcher.page();
     } else return "";
     int lookforEnd = lookforStart + lookfor.length();
     int page = lookforStart;
     int stop = lookforEnd;
     while (stop < str.length() && ((stop - lookforEnd) < len)) {
     stop++;
     }

     while (stop < str.length() && !str.substring(stop, stop + 1).equals(" ")) {
     stop++;
     }

     // del kun ved hele ord
     while (page > 0 && ((lookforStart - page) < len)) {
     page--;
     }

     while (page > 0 && !str.substring(page, page + 1).equals(" ")) {
     page--;
     }

     String s = replaceAll(str.substring(page, stop), "(\\s" + lookfor + "|^" + lookfor +")" +"[ ,;!.]", " <span class='lookedfor'> $1 </span> ");

     if (page != 0) {
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
    
    static public Long extractSj(String str) {
        String res = "";
        try {
            Pattern pattern = Pattern.compile("\\d+_(\\d+)");
            Matcher matcher = pattern.matcher(str);
            if (matcher.find()) {
                System.out.println("Js is: " + matcher.group(1));
                res = matcher.group(1);
            } else  {
               res = "";
            }       
            return Long.parseLong(res);
        } catch (Exception e) {
            return 0L;
        }
    }
    
    
}
