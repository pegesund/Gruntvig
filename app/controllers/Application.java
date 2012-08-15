package controllers;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import models.Asset;
import play.mvc.*;

/*
 * Main class, all other controllers should extend this
 */
public class Application extends Controller {


    /*
     * make sure header always can reach assets
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
        int pos = fileName.indexOf("18");
        String year = fileName.substring(pos, pos + 4);
        return year;
    }
    
    /*
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

    // eksempel på en register/leksikon side
    public static void register_side() {
        render();
    }

//     public static void vejledning() {
//        Asset asset = Asset.find("fileName = ?", "place.xml").first();
//        render();
//    }
}
