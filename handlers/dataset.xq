module namespace ds = 'http://www.prentenmissaal.com/prentenmissaal-5/dataset';
import module namespace data = 'http://www.prentenmissaal.com/prentenmissaal-5/lib/data';
import module namespace resp = "http://www.28msec.com/modules/http/response";

declare %an:sequential function ds:dumpMissal() {
    resp:set-content-type('application/xml');
    <missal>
    {
        db:collection($data:missal)
    }
    </missal>
};

declare %an:sequential function ds:dumpCalendar() {
    resp:set-content-type('application/xml');
    <calendar>
    {
        db:collection($data:calendar)
    }
    </calendar>
};
