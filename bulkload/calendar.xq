import module namespace data = 'http://www.prentenmissaal.com/prentenmissaal-5/lib/data';
import module namespace fetch = "http://www.zorba-xquery.com/modules/fetch";

(: bulkloading script :)

db:truncate($data:calendar);

let $missal := fn:parse-xml(fetch:content("bulkload/missal.xml"))//mass
let $entries-of := fn:parse-xml(fetch:content("bulkload/calendar-of.xml"))//day
let $entries-eo := fn:parse-xml(fetch:content("bulkload/calendar-eo.xml"))//day
for $day in ($entries-of, $entries-eo)
where $missal
    [matches(day/coordinates,$day/coordinates) or matches(day-eo/coordinates,$day/coordinates)]
    [form = $day/form or (not(form) and $day/form = 'of')]
    (: using matches() to catch e.g. christmas that has multiple masses identified as
       Z1225:1, Z1225:2, Z1225:3 :)
order by $day/date
return db:insert($data:calendar,$day); (: use insert-last when ordered :)
