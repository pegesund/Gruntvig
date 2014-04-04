Side for å laste opp xml-filer:         http://localhost:9000/UploadXml/uploadForm
Side for å fjerne filer/liste alle filer: http://localhost:9000/admin/listxmlfiles   (template er  Admin/listXmlFiles.html)

Installasjon solr:

wget http://apache.vianett.no/lucene/solr/4.7.1/solr-4.7.1.tgz
tar xvzf solr-4.7.1.tgz
mv example gv
mv collection1 gv
Set core.properties to name=gv
flytt schema.xml inn i solr/gv/conf/schema.xml skjema
start med java -jar start.jar

