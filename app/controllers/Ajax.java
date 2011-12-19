/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import models.Asset;
import models.TextReference;
import play.mvc.Controller;

/**
 *
 * @author pe
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
        Controller.renderHtml(TextReference.getReference(fileName + "_" + textId));
    }

    public static void getRef(String textId) {
        TextReference ref = TextReference.find("textId = ?", textId).first();
        // System.out.println("Showing ref: " + ref.showName);
        Controller.renderHtml(ref.showName);
    }


    public static void getIntro(long id) {
        Asset asset = Asset.find("id = ?", id).first();
        Controller.renderHtml(asset.getCorrespondingIntro());
    }

    public static void getComment(long id) {
        Asset asset = Asset.find("id = ?", id).first();
        Controller.renderHtml(asset.getCorrespondingComment());
    }

    public static void getVeiledning(String fileName) {
        Asset asset = Asset.find("fileName = ?", fileName + ".xml").first();
        Controller.renderHtml(asset.html);
    }


}
