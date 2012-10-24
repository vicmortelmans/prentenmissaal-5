module namespace query = 'http://www.prentenmissaal.com/prentenmissaal-5/lib/query';
import module namespace data = 'http://www.prentenmissaal.com/prentenmissaal-5/lib/data';

declare function query:nextByFormDate($form, $date) {
(:
    let $day := idx:probe-index-range-value($data:calendarDate,$date,(),true(),false(),true(),false())[1]
:)
    let $day := db:collection($data:calendar)[date ge $date][form eq $form][1] 
    (: because strictly spoken the collection isn't ordered, this is not guaranteed 
       to give the next day... :)
    return query:result($day)
};

declare function query:skipByFormDate($form, $date) {
    let $day := db:collection($data:calendar)[date gt $date][form eq $form][1] 
    return query:result($day)
};

declare function query:previousByFormDate($form, $date) {
    let $day := db:collection($data:calendar)[date lt $date][form eq $form][last()] 
    return query:result($day)
};

declare function query:missalByFormCoordinates($form, $coordinates, $cycle) {
    db:collection($data:missal)
        [matches(day/coordinates,$coordinates) or matches(day-eo/coordinates,$coordinates)]
        [form = $form or (not(form) and $form = 'of')]
        [form = 'eo' or day/cycle = $cycle]
};

declare function query:result($day) {
    <results>
        {$day}
        {query:missalByFormCoordinates($day/form, $day/coordinates, $day/cycle)}
    </results>
};