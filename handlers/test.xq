module namespace test = 'http://www.prentenmissaal.com/prentenmissaal-5/test';
import module namespace data = 'http://www.prentenmissaal.com/prentenmissaal-5/lib/data';
import module namespace query = 'http://www.prentenmissaal.com/prentenmissaal-5/lib/query';
import module namespace resp = "http://www.28msec.com/modules/http/response";
import module namespace request = "http://www.28msec.com/modules/http/request";

(:
declare %an:sequential function test:indices() {
    resp:set-content-type('application/xml');
    <index>
    {(
        idx:probe-index-point-value($data:missalCoordinates,"P091"),
        idx:probe-index-point-value($data:calendarCoordinates,"P091"),
        idx:probe-index-range-value($data:calendarDate,"2012-03-01","2012-05-01",true(),true(),true(),true())
    )}
    </index>
};
:)

declare %an:sequential function test:queryByFormDate() {
    resp:set-content-type('application/xml');
    let $form := request:parameter-values("form")
    let $date := request:parameter-values("date")
    return
        <result>
            <next>
            {
                query:nextByFormDate($form,$date)
            }
            </next>
            <skip>
            {
                query:skipByFormDate($form,$date)
            }
            </skip>
            <previous>
            {
                query:previousByFormDate($form,$date)
            }
            </previous>
        </result>
};
