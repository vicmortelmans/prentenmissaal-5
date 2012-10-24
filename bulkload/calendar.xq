import module namespace data = 'http://www.prentenmissaal.com/prentenmissaal-5/lib/data';
import module namespace fetch = "http://www.zorba-xquery.com/modules/fetch";

db:truncate($data:calendar);

let $missal := fn:parse-xml(fetch:content("bulkload/missal.xml"))//mass
let $entries-of := fn:parse-xml(fetch:content("bulkload/calendar-of.xml"))//day
let $entries-eo := fn:parse-xml(fetch:content("bulkload/calendar-eo.xml"))//day
for $day in ($entries-of, $entries-eo)
where $missal
    [day/coordinates = $day/coordinates]
    [form = $day/form or (form = '' and $day/form = 'of')]
order by $day/date
return db:insert-last($data:calendar,$day);
