module namespace day = 'http://www.prentenmissaal.com/prentenmissaal-5/day';
import module namespace data = 'http://www.prentenmissaal.com/prentenmissaal-5/lib/data';
import module namespace resp = "http://www.28msec.com/modules/http/response";
import module namespace query = 'http://www.prentenmissaal.com/prentenmissaal-5/lib/query';
import module namespace request = "http://www.28msec.com/modules/http/request";
import module namespace tr = 'http://www.prentenmissaal.com/prentenmissaal-5/lib/tr';
import module namespace block = 'http://www.prentenmissaal.com/prentenmissaal-5/lib/block';

declare %an:sequential function day:with() {
    resp:set-content-type('text/html');
    let $getform := request:parameter-values("form")
    let $form := 
        if ($getform = ('of','eo'))
        then $getform
        else 'of'
    let $getdate := request:parameter-values("date")
    let $date := 
        if (matches($getdate,'[0-9]{4}-[0-9]{2}-[0-9]{2}'))
        then $getdate
        else substring(xs:string(current-date()),1,10)
    let $getlang := request:parameter-values("lang")
    let $lang := 
        if ($getlang = db:collection($data:supported-languages)//id)
        then $getlang
        else 'en'
    let $id := request:parameter-values("id")
    let $next := query:nextByFormDate($form,$date)
    let $ill := query:ill($next,$id)
    let $mass := $ill/ancestor::mass
    return
    <html>
        <head>
            <title>{tr:days($mass/(day|day-eo)/coordinates,$lang,$form)}</title> 
            <link rel="stylesheet" type="text/css" href="/prentenmissaal-5.css" />
            <script type='text/javascript' src='/jquery-1.8.2.js'></script>
            <script type='text/javascript' src="/jquery.masonry.min.js"></script>
            <script type='text/javascript' src="/prentenmissaal-5.js"></script>
        </head>
        <body>
            <div id="container">
                <div class="item">
                    <div id="near">
                    {                    
                        block:near($form,$date,$next,$lang)
                    }
                    </div>
                    <div id="other">
                    {                    
                        block:other($form,$next,$ill,$lang)
                    }
                    </div>
                </div>
                <div id="day" class="item">
                {                    
                    block:day($form,$next,$ill,$lang)
                }
                </div>
                <div id="image" class="item">
                {                    
                    block:image($ill)
                }
                </div>
                <div id="passage" class="item">
                {                    
                    block:passage($ill,$lang)
                }
                </div>
                <div id="languages" class="item">
                {
                    block:languages($form,$next,$ill,$lang)
                }
                </div>
            </div> 
        </body>
    </html>
};
