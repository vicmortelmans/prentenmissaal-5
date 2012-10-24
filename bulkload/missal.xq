import module namespace data = 'http://www.prentenmissaal.com/prentenmissaal-5/lib/data';
import module namespace fetch = "http://www.zorba-xquery.com/modules/fetch";

db:truncate($data:missal);

let $entries := fn:parse-xml(fetch:content("bulkload/missal.xml"))//mass
return
  db:insert($data:missal, $entries);
