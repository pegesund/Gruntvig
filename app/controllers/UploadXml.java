/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.io.File;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import models.Asset;
import models.Chapter;
import models.TextReference;
import play.mvc.Controller;

/**
 *
 * 
 * Starting point for uploading of xml-files
 * 
 */
public class UploadXml extends Application {

    public static void testXsltTransformation() throws Exception {
        // inline to test xslt of simple file
        // xmlToHtml("/home/pe/gruntvig/xml/1826_433A_1_v1.xml");
        render();
    }

    public static void uploadForm() {
        render();
    }

    /**
     * Handle upload of xml-file
     * Check for file-type and create assets in database
     * 
     */
    public static void uploadFile(String filesname, String comment, File epub) {
        System.out.println("Starting upload");
        Asset asset = null;
        String fileName = epub.getName();
        if (fileName.endsWith(".jpg")) {
            Asset.uploadImage(filesname, comment, epub);
        } else {
            asset = Asset.uploadXmlFile(filesname, comment, epub);
        }
        if (fileName.equals("myth.xml")
                || fileName.equals("pers.xml")
                || fileName.equals("place.xml")) {
            TextReference.uploadReferenceFile(asset);
        } else if (fileName.replace(".xml", "").endsWith("_com")) {
            TextReference.uploadComments(asset);
        }
        if (asset == null) {
            Controller.renderHtml("Upload of file done: ");
        } else {
            render(asset);
        }
    }
}
