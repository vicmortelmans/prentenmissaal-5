module namespace data = 'http://www.prentenmissaal.com/prentenmissaal-5/lib/data';

declare collection data:missal as node()*; 
declare variable $data:missal := xs:QName("data:missal");
(:
declare %an:automatic %an:nonunique %an:value-equality index data:missalCoordinates
  on nodes db:collection(xs:QName("data:missal"))
  by xs:string(./day/coordinates) as xs:string;
declare variable $data:missalCoordinates := xs:QName("data:missalCoordinates");
:)

declare collection data:calendar as node()*;
(: using %an:ordered gives "Zorba data-definition error [zerr:ZDST0006]: 
   "an:ordered": invalid annotation for collection "data:calendar"" :) 
declare variable $data:calendar := xs:QName("data:calendar");
(:
declare %an:automatic %an:nonunique %an:value-range index data:calendarDate
  on nodes db:collection(xs:QName("data:calendar"))
  by xs:string(./date) as xs:string;
declare variable $data:calendarDate := xs:QName("data:calendarDate");
 declare %an:automatic %an:nonunique %an:value-equality index data:calendarCoordinates
  on nodes db:collection(xs:QName("data:calendar"))
  by xs:string(./coordinates) as xs:string;
declare variable $data:calendarCoordinates := xs:QName("data:calendarCoordinates");
:)  

