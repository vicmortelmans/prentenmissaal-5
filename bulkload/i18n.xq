import module namespace data = 'http://www.prentenmissaal.com/prentenmissaal-5/lib/data';
import module namespace fetch = "http://www.zorba-xquery.com/modules/fetch";

(: bulkloading script :)

db:truncate($data:i18nDaysOf);
db:truncate($data:i18nDaysEo);
db:truncate($data:i18nTerminology);

let $entries := fn:parse-xml(fetch:content("bulkload/i18n-days-of.xml"))/rows/row[en ne '']
return db:insert($data:i18nDaysOf, $entries);
let $entries := fn:parse-xml(fetch:content("bulkload/i18n-days-eo.xml"))/rows/row[en ne '']
return db:insert($data:i18nDaysEo, $entries);
let $entries := fn:parse-xml(fetch:content("bulkload/i18n-terminology.xml"))/rows/row[en ne '']
return db:insert($data:i18nTerminology, $entries);
