/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.util.List;
import models.Asset;
import models.Chapter;

/**
 *
 * 
 * Handles showing of asset assets
 * 
 */
public class ShowAsset extends Application {

    /**
     * Man function to show all tabs
     * 
     */
    public static void tekstvisning(long assetId, int chapterNum) {
        Asset asset = Asset.findById(assetId);
        List<Asset> variants = Asset.getVariants(asset.id);
        List<Asset> manus = Asset.getManus(assetId);
        System.out.println("--- Number of variants: " + variants.size());
        List<Chapter> chapters = Chapter.find("byAsset", asset).fetch();
        Chapter chapter = Chapter.find("byAssetAndNum", asset, chapterNum).first();
        System.out.println("All chapters: " + Chapter.findAll().size());
        System.out.println("Chapters: " + chapters.size());
        System.out.println("Found chapter: " + chapter.num);
        System.out.println("Number of pictures: " + asset.getNumberOfPictures());
        render(asset, chapter, chapters, variants, manus);
    }

    public static void biblio(String fileName) {
        Asset asset = Asset.find("fileName = :fileName").setParameter("fileName", fileName).first();
        if (asset != null) {
            render(asset);
        } else ShowAsset.renderHtml("Filen er ikke funnet - den er antagelig ikke ferdigbehandlet!");        
    }
    
    /**
     * 
     * Used by ajax-calls from javascript
     * 
     */
    public static void findAsset(String fileName) {
        Asset asset = Asset.find("fileName = :fileName").setParameter("fileName", fileName).first();
        if (asset != null) {
            Asset rootAsset = Asset.findById(asset.getCorrespondingRootId());
            System.out.println("Showing asset: " + rootAsset.id);
            tekstvisning(rootAsset.id,0);
        } else ShowAsset.renderHtml("Filen er ikke funnet - den er antagelig ikke ferdigbehandlet!");
    }   
    
    /** 
     * TODO: rewrite to one path
     * 
     * Currently called from javascript
     * 
     */
    
    
    
    public static void vejledning(String fileName) {
        String vejledningSomSkalVises = fileName;
        render(vejledningSomSkalVises);
    }

    public static void placevisning() {
        Asset asset = Asset.find("fileName = :fileName").setParameter("fileName", "place.xml").first();
        render(asset);
    }

    public static void chronovisning() {
        Asset asset = Asset.find("fileName = :fileName").setParameter("fileName", "chrono.xml").first();
        render(asset);
    }

    public static void personvisning() {
        Asset asset = Asset.find("fileName = :fileName").setParameter("fileName", "pers.xml").first();
        render(asset);
    }

    public static void mythvisning() {
        Asset asset = Asset.find("fileName = :fileName").setParameter("fileName", "myth.xml").first();
        render(asset);
    }
    
    public static void biblevisning() {
        Asset asset = Asset.find("fileName = :fileName").setParameter("fileName", "bible.xml").first();
        render(asset);
    }

    public static void registrantenvisning() {
        Asset asset = Asset.find("fileName = :fileName").setParameter("fileName", "regList.xml").first();
        render(asset);
    }

    
    public static void bookinventoryvisning() {
        Asset asset = Asset.find("fileName = :fileName").setParameter("fileName", "bookInventory1805.xml").first();
        render(asset);
    }

    
    public static void bookinventoryvisning1839() {
        Asset asset = Asset.find("fileName = :fileName").setParameter("fileName", "bookInventory1839.xml").first();
        render(asset);
    }

     
}
