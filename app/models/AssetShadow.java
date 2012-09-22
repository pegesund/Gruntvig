/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import controllers.DoSearch;
import helpers.Helpers;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.persistence.*;
import play.db.jpa.GenericModel;
import javax.xml.transform.stream.StreamSource;
import net.sf.saxon.s9api.Processor;
import net.sf.saxon.s9api.Serializer;
import net.sf.saxon.s9api.XsltCompiler;
import net.sf.saxon.s9api.XsltExecutable;
import net.sf.saxon.s9api.XsltTransformer;
import play.db.jpa.JPABase;
import play.modules.search.Field;
import play.modules.search.Indexed;

/**
 *
 * @author pe
 *
 * This class is only in use for development with local fs-database
 * It is currently not in use as postgresql is the default database
 *
 *
 */
@Indexed
// @javax.persistence.Entity
@Entity
public class AssetShadow extends GenericModel {

    @Id
    @SequenceGenerator(name = "assetshadow_id_seq_gen", sequenceName = "assetshadow_id_seq")
    @GeneratedValue(generator = "assetshadow_id_seq_gen")
    public long id;
    @Lob
    public String xml;
    @Lob
    public String html;    
    @Field
    @Lob
    public String htmlAsText;
    @Lob
    public String comment;
    @Lob
    public String name;
    @Lob
    public String fileName;
    public int variant;
    public int pictureNumber = 0;
    @Column(name = "import_date")
    @Temporal(TemporalType.TIMESTAMP)
    public java.util.Date importDate;
    @Lob
    public String origin;
    @Lob
    public String xtype;
    @Lob
    public String refs;
}
