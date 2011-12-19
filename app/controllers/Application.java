package controllers;

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
        } catch (Exception e) {
            System.out.println("Probably empty db");
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
