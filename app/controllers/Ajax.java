/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.util.List;
import models.Asset;
import models.Chapter;
import models.TextReference;
import play.db.jpa.GenericModel;
import play.mvc.Controller;

/**
 *
 * 
 * Small ajax-functions to be called from javascript
 * 
 * 
 */
public class Ajax extends Application {

    public static void getKommentar(long assetId) {
        Controller.renderHtml(new String("HEY" + assetId));
    }

    public static void getVariant(long assetId, int variantNum) {
        Controller.renderHtml(new String("HEY" + assetId + " : " + variantNum));
    }

    public static void getVariantByName(String fileName) {
        Asset variant = Asset.find("fileName = ?", fileName).first();
        if (variant == null) Controller.renderHtml("");
        Controller.renderHtml(variant.html);
    }

    public static void getManusByName(String fileName) {
        if (fileName == null) return;
        Asset manus = Asset.find("fileName = ?", fileName).first();
        if (manus == null) renderHtml("");
        Controller.renderHtml(manus.html);
    }

    public static void getReference(String fileName, String textId) {
        String content = "";
        if (Application.params._contains("content")) {
            content = Application.params.get("content");
        } else {
            content = TextReference.getReference(fileName + "_" + textId);
        }
        System.out.println("Serving popup: " + content);
        Controller.renderHtml(content);
    }

    public static void getRef(String textId) {
        String content="";
        textId = textId.replaceAll("%20", " ");
        if (Application.params._contains("content")) {
            content = Application.params.get("content");
        } else 
        {
           TextReference ref = TextReference.find("textId = ?", textId).first();
           if (ref != null) content = ref.showName;
        }
        Controller.renderHtml(content);
    }


    public static void getIntro(long id) {
        Asset asset = Asset.find("id = ?", id).first();
        Controller.renderHtml(asset.getCorrespondingIntro());
    }

    public static void getComment(long id) {
        Asset asset = Asset.find("id = ?", id).first();        
        Controller.renderHtml(asset.getCorrespondingComment());
    }

    public static void getTxr(long id) {
        System.out.println("Looking for asset: " + id);
        Asset asset = Asset.findById(id);
        System.out.println("Asset found is: " + asset);
        Controller.renderHtml(asset.getCorrespondingTxr());
    }    
    
    public static void getVeiledning(String fileName) {
        Asset asset = Asset.find("fileName = ?", fileName + ".xml").first();
        if (asset == null) {
            Controller.renderHtml("");
        } else {
            Controller.renderHtml(asset.html);
        }
    }
    
    public static void getChapter(long assetId, int chapterNum) {
        Asset asset = Asset.findById(assetId);
        Chapter chapter = Chapter.find("byAssetAndNum", asset, chapterNum).first();
        Controller.renderHtml(chapter.html);
    }
    
    public static void getNameFromFilename(String fileName) {
        String res = "Fra: " + fileName;
        Asset asset = Asset.find("fileName = ?", fileName).first();
        if (asset != null) {
           Asset root = Asset.find("fileName = ?", asset.rootName + "_txt.xml").first();
           if (root != null) res = "Fra: " + root.name;
        }         
        Controller.renderHtml(res);
    }
    
    public static void getIdFromFilename(String fileName) {
        String res = "Not found";
        Asset asset = Asset.find("fileName = ?", fileName).first();
        if (asset != null) {
            res = Long.toString(asset.id);
        }
        Controller.renderHtml(res);
    }
    
     public static void getFilenameFromId(String id) {
        String res = "Not found";
        Asset asset = Asset.findById(Long.parseLong(id));
        if (asset != null) {
            res = asset.fileName;
        }
        Controller.renderHtml(res);
    }   
}
