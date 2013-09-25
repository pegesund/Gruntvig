package controllers;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import models.Asset;
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
            System.out.println("Probably empty db or filenames without year");
        }
    }

        
    private static String getYearFromFileName(String fileName) {
        String[] S= fileName.split( "_" );
        String year= S[0],
               sj= S[1],
               litra= "",
               res;
        if( sj.matches("[0-9]*[^0-9]+") ) {
          litra= sj.substring( sj.length()-1 );
          sj= sj.substring( 0, sj.length()-1 );
        }
        res= String.format( "%4s%4s%s", year, sj, litra );
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
/*
    public static void epitekst(String fileName) {
        Asset asset = Asset.find("fileName = ?", fileName).first();
        renderBinary(asset);
    }
*/
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


}
