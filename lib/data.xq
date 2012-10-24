module namespace data = 'http://www.prentenmissaal.com/prentenmissaal-5/lib/data';

declare collection data:missal as node()*; 
declare variable $data:missal := xs:QName("data:missal");
declare %an:automatic %an:nonunique %an:value-equality index data:missalCoordinates
  on nodes db:collection(xs:QName("data:missal"))/mass
  by ./day/coordinates as xs:string;
declare variable $data:missalCoordinates := xs:QName("data:missalCoordinates");

declare collection data:calendar as node()*; 
declare variable $data:calendar := xs:QName("data:calendar");
declare %an:automatic %an:nonunique %an:value-range index data:calendarDate
  on nodes db:collection(xs:QName("data:calendar"))/day
  by ./date as xs:string;
declare variable $data:calendarDate := xs:QName("data:calendarDate");
 declare %an:automatic %an:nonunique %an:value-equality index data:calendarCoordinates
  on nodes db:collection(xs:QName("data:calendar"))/day
  by ./coordinates as xs:string;
declare variable $data:calendarCoordinates := xs:QName("data:calendarCoordinates");
  