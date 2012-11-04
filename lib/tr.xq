module namespace tr = 'http://www.prentenmissaal.com/prentenmissaal-5/lib/tr';
import module namespace data = 'http://www.prentenmissaal.com/prentenmissaal-5/lib/data';

declare function tr:daysOf($coordinates as element(),$lang as xs:string) as xs:string {
    let $id :=
        if ($coordinates/@idx) 
        then concat($coordinates,':',$coordinates/@idx)
        else xs:string($coordinates) 
    let $tr := xs:string(idx:probe-index-point-value($data:i18nDaysOfId,$id)/*[name() eq $lang])
    return 
        if ($tr)
        then $tr
        else concat("#",$id,"#")
};

declare function tr:daysEo($coordinates as element(),$lang as xs:string) as xs:string {
    let $id :=
        if ($coordinates/@idx) 
        then concat($coordinates,':',$coordinates/@idx)
        else xs:string($coordinates) 
    let $tr := xs:string(idx:probe-index-point-value($data:i18nDaysEoId,$id)/*[name() eq $lang])
    return 
        if ($tr)
        then $tr
        else concat("#",$id,"#")
};

declare function tr:days($coordinates as element(),$lang as xs:string,$form as xs:string) as xs:string {
    if ($form eq 'of')
    then tr:daysOf($coordinates,$lang)
    else tr:daysEo($coordinates,$lang)
};

declare function tr:term($en as xs:string,$lang as xs:string) as xs:string {
    let $tr := xs:string(idx:probe-index-point-value($data:i18nTerminologyEn,$en)/*[name() eq $lang])
    return 
        if ($tr)
        then $tr
        else concat("#",$en,"#")
};

declare function tr:passage($id as xs:string,$lang as xs:string) as xs:string {
    xs:string(idx:probe-index-point-value($data:i18nPassagesId,$id)/*[name() eq $lang])
};

declare function tr:reference($id as xs:string,$lang as xs:string) as xs:string {
    xs:string(idx:probe-index-point-value($data:i18nReferencesId,$id)/*[name() eq $lang])
};