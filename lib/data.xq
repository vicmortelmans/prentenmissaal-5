module namespace data = 'http://www.prentenmissaal.com/prentenmissaal-5/lib/data';

declare collection data:missal as node()*; 
declare variable $data:missal := xs:QName("data:missal");
declare %an:automatic %an:nonunique %an:value-equality index data:missalCoordinates
  on nodes db:collection(xs:QName("data:missal"))
  by xs:string(./(day,day-eo)/coordinates) as xs:string;
declare variable $data:missalCoordinates := xs:QName("data:missalCoordinates");

declare collection data:calendar as node()*; (: %an:ordered  is not supported :)
declare variable $data:calendar := xs:QName("data:calendar");
declare %an:automatic %an:nonunique %an:value-range index data:calendarDate
  on nodes db:collection(xs:QName("data:calendar"))
  by xs:string(./date) as xs:string;
declare variable $data:calendarDate := xs:QName("data:calendarDate");
declare %an:automatic %an:nonunique %an:value-equality index data:calendarCoordinates
  on nodes db:collection(xs:QName("data:calendar"))
  by xs:string(./coordinates) as xs:string;
declare variable $data:calendarCoordinates := xs:QName("data:calendarCoordinates");

declare collection data:i18nDaysOf as node()*; 
declare variable $data:i18nDaysOf := xs:QName("data:i18nDaysOf");
declare %an:automatic %an:unique %an:value-equality index data:i18nDaysOfId
  on nodes db:collection(xs:QName("data:i18nDaysOf"))
  by xs:string(./id) as xs:string;
declare variable $data:i18nDaysOfId := xs:QName("data:i18nDaysOfId");

declare collection data:i18nDaysEo as node()*; 
declare variable $data:i18nDaysEo := xs:QName("data:i18nDaysEo");
declare %an:automatic %an:unique %an:value-equality index data:i18nDaysEoId
  on nodes db:collection(xs:QName("data:i18nDaysEo"))
  by xs:string(./id) as xs:string;
declare variable $data:i18nDaysEoId := xs:QName("data:i18nDaysEoId");

declare collection data:i18nTerminology as node()*; 
declare variable $data:i18nTerminology := xs:QName("data:i18nTerminology");
declare %an:automatic %an:unique %an:value-equality index data:i18nTerminologyEn
  on nodes db:collection(xs:QName("data:i18nTerminology"))
  by xs:string(./en) as xs:string;
declare variable $data:i18nTerminologyEn := xs:QName("data:i18nTerminologyEn");

declare collection data:passages as node()*; 
declare variable $data:passages := xs:QName("data:passages");
declare %an:automatic %an:unique %an:value-equality index data:i18nPassagesId
  on nodes db:collection(xs:QName("data:passages"))
  by xs:string(./id) as xs:string;
declare variable $data:i18nPassagesId := xs:QName("data:i18nPassagesId");

declare collection data:references as node()*; 
declare variable $data:references := xs:QName("data:references");
declare %an:automatic %an:unique %an:value-equality index data:i18nReferencesId
  on nodes db:collection(xs:QName("data:references"))
  by xs:string(./id) as xs:string;
declare variable $data:i18nReferencesId := xs:QName("data:i18nReferencesId");

declare collection data:supported-languages as node()*; 
declare variable $data:supported-languages := xs:QName("data:supported-languages");
