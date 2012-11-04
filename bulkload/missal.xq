import module namespace data = 'http://www.prentenmissaal.com/prentenmissaal-5/lib/data';
import module namespace fetch = "http://www.zorba-xquery.com/modules/fetch";
import module namespace hash = "http://www.zorba-xquery.com/modules/cryptography/hash";
import module namespace functx = "http://www.functx.com/";

(:
    bulkloading script 
    including logic to add <id> elements used to identify illustrations, e.g. in URLs 
    and to copy in contents for <illustrationref>s 
:)

db:truncate($data:missal);

variable $entries := fn:parse-xml(fetch:content("bulkload/missal.xml"))//mass;
for $url in $entries//(url|refurl) 
    return insert node <id>{substring(hash:md5($url),1,3)}</id> into $url/parent::*;
for $ref in $entries//illustrationref
    return insert node $entries//illustration[url = $ref/refurl][1] into $ref/parent::*;
    
db:insert($data:missal, $entries);

