import module namespace data = 'http://www.prentenmissaal.com/prentenmissaal-5/lib/data';
import module namespace fetch = "http://www.zorba-xquery.com/modules/fetch";

(: bulkloading script :)

db:truncate($data:supported-languages);

let $entries := fn:parse-xml(fetch:content("bulkload/supported-languages.xml"))//lang
return
  db:insert($data:supported-languages, $entries);
