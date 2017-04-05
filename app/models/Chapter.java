/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import controllers.DoSearch;
import helpers.Helpers;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.io.StringWriter;
import java.util.List;
import javax.persistence.*;
import javax.persistence.Entity;
import play.db.jpa.GenericModel;
import play.data.validation.Required;
import org.w3c.dom.*;
import javax.xml.xpath.*;
import javax.xml.parsers.*;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import org.apache.solr.client.solrj.SolrServer;
import org.apache.solr.common.SolrInputDocument;
import org.hibernate.annotations.Type;
import play.db.jpa.JPABase;

/**
 *
 *
 * Root-texts are dividet into Chapters Starts counting from 0 Keeps a version
 * of text to index as well as precompiled html
 *
 *
 */
@Entity
public class Chapter extends GenericModel {

    @Id
    @SequenceGenerator(name = "chapter_id_seq_gen", sequenceName = "chapter_id_seq")
    @GeneratedValue(generator = "chapter_id_seq_gen")
    public long id;
    @Lob
    @Type(type = "org.hibernate.type.TextType")
    public String name;
    @Lob
    @Type(type = "org.hibernate.type.TextType")
    public String html;
    @Lob
    @Type(type = "org.hibernate.type.TextType")
    public String htmlAsText;
    @Required
    @ManyToOne
    public Asset asset;
    public int num;

    public Chapter(String name, int num, Asset asset, String html) {
        this.name = name;
        this.num = num;
        this.asset = asset;
        this.html = html;
    }

    public void index() {
        try {
            SolrServer server = Helpers.getSolrServer();
            SolrInputDocument doc1 = new SolrInputDocument();
            doc1.addField("id", "chapter_" + id);
            doc1.addField("text", htmlAsText);
            doc1.addField("type", "chapter");
            doc1.addField("pgid", id);
            doc1.addField("sj", DoSearch.extractSj(this.asset.fileName));
            server.add(doc1);
            server.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }        
    }
    
    /**
     * Override of save function in JPA Currently all div-tags with empty
     * class-defs are deleted
     *
     */
    @Override
    public <T extends JPABase> T save() {
        // remove empty div's
        html = html.replaceAll("<div class='[^']+'/>", "").replaceAll("<div class=\"[^\"]+\"/>", "");
        this.htmlAsText = Helpers.stripHtml(html);
        T t = super.save();
        index();
        return t;
    }
    
    @Override
    public <T extends JPABase> T delete() {
        try {
            SolrServer server = Helpers.getSolrServer();
            server.deleteById("chapter_" + id);
            server.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return super.delete();
    }
  
    public String getNamePlain() {
        if ((int)name.charAt(0) == 8195) {
            return name.substring(1);
        } else return name;
    }

    /**
     * Create text-teaser where lookfor is highlightet
     *
     * @return teser as html
     */
    public String getTeaser(String lookfor) {
        return DoSearch.createTeaser(htmlAsText, lookfor);
    }

    /**
     * When a new Asset is imported all old chapters connected to this assed are
     * deleted
     */
    private static void deleteOldChapters(Asset asset) {
        // System.out.println("**** Chapters on this asset: " + TextReference.find("asset", asset).fetch().size());
        for (Object o : Chapter.all().fetch()) {
            Chapter c = (Chapter) o;
            // System.out.println("Chapter id: " + c.asset);
        }
        List<Chapter> oldChapters = Chapter.find("asset = ?", asset).fetch();
        for (Chapter c: oldChapters) {
            c.delete();
        }
        System.out.println("Deleted " + oldChapters.size() + " old chapters" + " assetid: " + asset.id);
    }

    /**
     * Helper function only: Translates a html-dom-tree to a String
     *
     * @return html-string without xml-declaration
     */
    private static String nodeToString(Node node) {
        StringWriter sw = new StringWriter();
        try {
            Transformer t = TransformerFactory.newInstance().newTransformer();
            t.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION, "yes");
            t.transform(new DOMSource(node), new StreamResult(sw));
        } catch (TransformerException te) {
            System.out.println("nodeToString Transformer Exception");
        }
        return sw.toString();
    }

    /**
     * Divide a xml-file into chapters, chapters are divided by div-tags,
     * attribute name is name of chapter Fixme: use xpath selector. Should work
     * with current library which should be the latest
     *
     */
    public static void createChaptersFromAsset(Asset asset) {
        System.out.println("Creating chapters from asset: " + asset.fileName + " , id: " + asset.id);
        deleteOldChapters(asset);
        try {
            DocumentBuilderFactory domFactory = DocumentBuilderFactory.newInstance();
            domFactory.setNamespaceAware(true);
            DocumentBuilder builder = domFactory.newDocumentBuilder();
            InputStream in = new ByteArrayInputStream(asset.html.getBytes("UTF-8"));
            Document doc = builder.parse(in);

            XPath xpath = XPathFactory.newInstance().newXPath();

            // xpath does not seem to work, picking up every top-level divs?! Check later if probs.
            XPathExpression expr = xpath.compile("//div[@class='frontChapter']|//div[@class='chapter']|//div[@class='kolofonBlad']|//div[@class='titlePage' and not(ancestor::div[@class='frontChapter'])]");

            Object result = expr.evaluate(doc, XPathConstants.NODESET);
            NodeList nodes = (NodeList) result;
            System.out.println("Number of chapters: " + nodes.getLength());
            // System.out.println("Txt-content: " + asset.html);
            if (nodes.getLength() > 0) {
                // System.out.println("xhtml: " + asset.html);
                for (int i = 0; i < nodes.getLength(); i++) {
                    Node node = nodes.item(i);
                    // System.out.println("Chapter node: " + Helpers.nodeToString(node));
                    // System.out.println("---------------------------------------------------");
                    String name = "- afsnit mangler titel - " + (i + 0);
                    if (i == 0) {
                        name = "[Kolofon]";
                    }
                    if (node.getAttributes().getNamedItem("name") != null) {
                        name = node.getAttributes().getNamedItem("name").getNodeValue();
                        System.out.println("Chapter id found: " + name);
                    }

                    if (node.getAttributes().getNamedItem("rend") != null) {
                        name = node.getAttributes().getNamedItem("rend").getNodeValue();
                        System.out.println("Chapter id found: " + name);
                    }
                    Chapter chapter = new Chapter(name, i, asset, nodeToString(node));
                    chapter.save();
                    // System.out.println("Chapter: " + i + nodeToString(node));
                }
            } else {
                System.out.println("No chapters found, using hole file as chapter 1");
                Chapter chapter = new Chapter("Afsnit 1", 0, asset, nodeToString(doc.getDocumentElement()));
                chapter.save();
            }
            System.out.println("Total chapters: " + Chapter.count());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
