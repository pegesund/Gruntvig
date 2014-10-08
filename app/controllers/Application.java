package controllers;

import helpers.Helpers;
import java.io.IOException;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.Asset;
import models.Chapter;
import org.apache.solr.client.solrj.SolrServer;
import org.apache.solr.client.solrj.SolrServerException;
import org.apache.solr.common.SolrInputDocument;
import play.mvc.*;

/**
 * Main class, all other controllers should extend this
 */
public class Application extends Controller {


    /**
     * Make sure header always can reach assets
     * This way all controllers keeps a sorted version of the assets as arguments
     * 
     */
    @Before
    static void addAssetToTemplate() {
        try {
            renderArgs.put("assets", Asset.find("type = ? order by name", "root").fetch());
            List<Asset> sillySortedAssets = Asset.find("type = ? order by name", "root").fetch();
            Collections.sort(sillySortedAssets, new SillyComparator());
            renderArgs.put("sortedAssets", sillySortedAssets);            
        } catch (Exception e) {
            renderArgs.put("sortedAssets", Asset.find("type = ? order by name", "root").fetch());
            System.out.println("Probably empty db or filenames without year, assets not sorted");
        }
    }

        
    private static String getYearFromFileName(String fileName) {
        String[] S= fileName.split( "_" );
        String year= S[0],
               sj= S[1],
               litra= "",
               sjSub=S[2],
               res;
        if( sj.matches("[0-9]*[^0-9]+") ) {
          litra= sj.substring( sj.length()-1 );
          sj= sj.substring( 0, sj.length()-1 );
        }
        res= String.format( "%4s%4s%s%2s", year, sj, litra, sjSub ); /*KK 2014-01-08 sjSub er en dårlig ide*/
        //System.out.println( ">"+res );
        return res;
    }
    
    /**
     * Sort txt-files in menu by order of year in filename :-)
     */
    private static class SillyComparator implements Comparator<Asset> {

        public int compare(Asset t, Asset t1) {
            return getYearFromFileName(t.fileName).compareTo(getYearFromFileName(t1.fileName));
        }
      }
    
    public static void index() {
        render();
    }

    public static void tidslinje() {
        render();
    }

    public static void kort() {
        Asset asset = Asset.find("fileName = ?", "map_vej.xml").first();
        render(asset);
    }

    public static void viskort(String fileName) {
        Asset asset = Asset.find("fileName = ?", fileName).first();
        render(asset);
    }

    public static void krono() {
        render();
    }

    public static void alfa() {
        render();
    }

    
    // eksempel på en register/leksikon side
    public static void register_side() {
        render();
    }


    public static void testSolr() {
        try {
            SolrServer server = Helpers.getSolrServer();
            SolrInputDocument doc1 = new SolrInputDocument();
            doc1.addField( "id", "idx" );
            doc1.addField( "text", "Petters hemmelige tekst" );
            doc1.addField( "comment", "Petters hemmelige comment" );
            doc1.addField( "type", "testtype");
            server.add(doc1);
            server.commit();
            Application.renderText("Document added: server: " + server);
        } catch (Exception ex) {
            ex.printStackTrace();
            Application.renderText("Problems with solr, look in log");    
        }
    }
    
    
    // deletes all from solr: run http://localhost:9000/Application/clearSolr
    public static void clearSolr() {
        try {
            SolrServer server = Helpers.getSolrServer();
            server.deleteByQuery("id:*"); 
            server.commit();
            Application.renderText("Solr-data cleared: " + server);
        } catch (Exception ex) {
            ex.printStackTrace();
            Application.renderText("Problems with solr, look in log");    
        }        
    }
    
    
    public static void solrAll() {
        try {
            SolrServer server = Helpers.getSolrServer();
            server.deleteByQuery("id:*"); 
            server.commit();
            List<Asset> all = Asset.findAll();
            for (Asset a: all) {
                a.index();
            }
            List<Chapter> allChapters = Chapter.findAll();
            for (Chapter c: allChapters) {
                c.index();
            }
            Application.renderText("Done with reindex: " + server);
        } catch (Exception e) {
            e.printStackTrace();
            Application.renderText("Problems with solr, look in log");                
        }       
    }    
}
