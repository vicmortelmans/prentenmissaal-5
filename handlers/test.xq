module namespace test = 'http://www.prentenmissaal.com/prentenmissaal-5/test';
import module namespace data = 'http://www.prentenmissaal.com/prentenmissaal-5/lib/data';
import module namespace query = 'http://www.prentenmissaal.com/prentenmissaal-5/lib/query';
import module namespace resp = "http://www.28msec.com/modules/http/response";
import module namespace request = "http://www.28msec.com/modules/http/request";
import module namespace tr = 'http://www.prentenmissaal.com/prentenmissaal-5/lib/tr';

declare %an:sequential function test:indices() {
    resp:set-content-type('application/xml');
    <index>
        <missalCoordinates>{idx:probe-index-point-value($data:missalCoordinates,"P091")}</missalCoordinates>
        <calendarCoordinates>{idx:probe-index-point-value($data:calendarCoordinates,"P091")}</calendarCoordinates>
        <calendarDate>{idx:probe-index-range-value($data:calendarDate,"2012-03-01","2012-05-01",true(),true(),true(),true())}</calendarDate>
        <i18nPassagesId>{idx:probe-index-point-value($data:i18nPassagesId,"Mt 9,12-13")}</i18nPassagesId>
        <i18nReferencesId>{idx:probe-index-point-value($data:i18nReferencesId,"Mt 9,12-13")}</i18nReferencesId>
    </index>
}; 

declare %an:sequential function test:i18n() {
    resp:set-content-type('application/xml');
    <i18n>
        <daysOf>{tr:daysOf("Z1225:1","nl")}</daysOf>
        <daysEo>{tr:daysOf("Z0725","nl")}</daysEo>
        <days>{tr:days("Z0725","nl","of")}</days>
        <trans>{tr:term("Easter","nl")}</trans>
        <passage>{tr:passage("Matteüs 5,10-12a","nl")}</passage>
        <reference>{tr:reference("Matteüs 5,10-12a","nl")}</reference>
    </i18n>
}; 

declare %an:sequential function test:queryByFormDate() {
    resp:set-content-type('application/xml');
    let $form := request:parameter-values("form")
    let $date := request:parameter-values("date")
    let $id := request:parameter-values("id")
    return
        <result>
            <next>
            {
                query:nextByFormDate($form,$date)
            }
            </next>
            <nextill>
            {
                query:ill(query:nextByFormDate($form,$date),$id)
            }
            </nextill>
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

