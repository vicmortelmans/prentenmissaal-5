module namespace query = 'http://www.prentenmissaal.com/prentenmissaal-5/lib/query';
import module namespace data = 'http://www.prentenmissaal.com/prentenmissaal-5/lib/data';

declare function query:ill($next,$id) {
    ($next//illustration[id eq $id or $id eq '' or not($next//id = $id)])[1]
};

(:
    these queries return something like this:
    <results>
        <day>...</day>
        <mass>...</mass>
        [<mass>...</mass>...]
    </results>
    multiple masses are typically returned for christmas day
:)

declare function query:nextByFormDate($form, $date) {
    let $date2 := xs:string(xs:date($date) + xs:dayTimeDuration("P30D"))
    let $days := idx:probe-index-range-value($data:calendarDate,$date,$date2,true(),true(),true(),true())[form eq $form]
    let $day := (for $d in $days order by $d/date return $d)[1]
(:
    let $day := db:collection($data:calendar)[date ge $date][form eq $form][1] 
:)
    return query:result($day)
};

declare function query:skipByFormDate($form, $date) {
    let $date2 := xs:string(xs:date($date) + xs:dayTimeDuration("P30D"))
    let $days := idx:probe-index-range-value($data:calendarDate,$date,$date2,true(),true(),false(),true())[form eq $form]
    let $day := (for $d in $days order by $d/date return $d)[1]
    return query:result($day)
};

declare function query:previousByFormDate($form, $date) {
    let $date2 := xs:string(xs:date($date) - xs:dayTimeDuration("P30D"))
    let $days := idx:probe-index-range-value($data:calendarDate,$date2,$date,true(),true(),true(),false())[form eq $form]
    let $day := (for $d in $days order by $d/date descending return $d)[1]
    return query:result($day)
};

declare function query:missalByFormCoordinates($form, $coordinates, $cycle) {
    idx:probe-index-point-value($data:missalCoordinates,xs:string($coordinates))
        [form = $form or (not(form) and $form = 'of')]
        [form = 'eo' or day/cycle = $cycle]
};

declare function query:result($day) {
    <results>
        {$day}
        {query:missalByFormCoordinates($day/form, $day/coordinates, $day/cycle)}
    </results>
};