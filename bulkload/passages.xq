import module namespace data = 'http://www.prentenmissaal.com/prentenmissaal-5/lib/data';
import module namespace fetch = "http://www.zorba-xquery.com/modules/fetch";

(: bulkloading script :)

db:truncate($data:passages);

let $entries := fn:parse-xml(fetch:content("bulkload/passages.xml"))//row
return
  db:insert($data:passages, $entries);
