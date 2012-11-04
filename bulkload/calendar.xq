import module namespace data = 'http://www.prentenmissaal.com/prentenmissaal-5/lib/data';
import module namespace fetch = "http://www.zorba-xquery.com/modules/fetch";

(: bulkloading script :)

db:truncate($data:calendar);

(: there's logic in the bulkloader to only pick the days that have a matching entry
   in missal.xml and then sorts the days by date :)
   
let $missal := fn:parse-xml(fetch:content("bulkload/missal.xml"))//mass
let $entries-of := fn:parse-xml(fetch:content("bulkload/calendar-of.xml"))//day
let $entries-eo := fn:parse-xml(fetch:content("bulkload/calendar-eo.xml"))//day
for $day in ($entries-of, $entries-eo)
where $missal
    [day/coordinates = $day/coordinates or day-eo/coordinates = $day/coordinates]
    [form = $day/form or (not(form) and $day/form = 'of')]
    [form = 'eo' or day/cycle = $day/cycle]
order by $day/date
return db:insert($data:calendar,$day); (: use insert-last when ordered :)
