module namespace block = 'http://www.prentenmissaal.com/prentenmissaal-5/lib/block';
import module namespace tr = 'http://www.prentenmissaal.com/prentenmissaal-5/lib/tr';
import module namespace query = 'http://www.prentenmissaal.com/prentenmissaal-5/lib/query';
import module namespace data = 'http://www.prentenmissaal.com/prentenmissaal-5/lib/data';

declare function block:day($form,$next,$ill,$lang) {
    let $mass := $ill/ancestor::mass
    return
    (
        <div class="cycle">{tr:term(block:cycle($next/day/cycle),$lang)}</div>,
        <div class="season">{tr:term($mass/(time|time-eo),$lang)}</div>,
        <div class="date">{$next/day/i18n/*[name() eq $lang]}</div>,
        <div class="title">{tr:days($mass/(day|day-eo)/coordinates,$lang,$form)}</div>,
        <div class="form">
        {
            if ($form eq 'of')
            then 
            (
                <span class="thisform">{tr:term("Ordinary form of the Roman Rite",$lang)}</span>,
                <span class="otherform">,
                    <a href="{block:url('eo',$next/day/date,$lang,'')}">{tr:term("Extraordinary form",$lang)}</a>
                </span>
            )
            else
            (
                <span class="thisform">{tr:term("Extraordinary form of the Roman Rite",$lang)}</span>,
                <span class="otherform">
                    <a href="{block:url('of',$next/day/date,$lang,'')}">{tr:term("Ordinary form",$lang)}</a>
                </span>
            )
        }
        </div>
    )
};

declare function block:image($ill) {
    let $copyright := if ( normalize-space($ill/copyright) != '' )
      then concat('© ',$ill/copyright)
      else ""
    let $caption := 
        block:simplify(
            fn:concat(
                    normalize-space($ill/title), " (",
                    normalize-space($ill/artist), ", ",
                    normalize-space($ill/year), ", ",
                    normalize-space($ill/location), ", ",
                    normalize-space($copyright),") "
            )
        )
    let $googleurl := concat('http://images.google.com/searchbyimage?gbv=2&amp;site=search&amp;image_url=',encode-for-uri($ill/url/text()),'&amp;sa=X&amp;ei=H6RaTtb5JcTeiALlmPi2CQ&amp;ved=0CDsQ9Q8')
    return
    (
        <div class="image">
            <img src="{$ill/url}" alt="{$ill/title}"/>
        </div>,
        <div class="caption">
            <span class="metadata">{$caption}</span>
            <span class="google"><a href="{$googleurl}" target="_blank">google</a></span>
        </div>
    )
};

declare function block:passage($ill,$lang) {
    (
        <div class="passagereference">{tr:reference($ill/passagereference,$lang)}</div>,
        <div class="passage">{tr:passage($ill/passagereference,$lang)}</div>
    )
};

declare function block:near($form,$date,$next,$lang) {
    let $back := query:previousByFormDate($form,$date)
    let $backill := query:ill($back,'')
    let $backurl := block:url($form,$back/day/date,$lang,'')
    let $forw := query:skipByFormDate($form,xs:string($next/day/date))
    let $forwill := query:ill($forw,'')
    let $forwurl := block:url($form,$forw/day/date,$lang,'')
    return
    (
        <div class="back thumbnail">
          <div class="thumbnailbox">
            <div class="thumbnailcontainer">
                <a href="{$backurl}">
                    <img src="{$backill/url}" alt="{$backill/title}" class="thumbnailportrait"/>
                </a>
            </div>
          </div>
        </div>,
        <div class="forw thumbnail">
          <div class="thumbnailbox">
            <div class="thumbnailcontainer">
                <a href="{$forwurl}">
                    <img src="{$forwill/url}" alt="{$forwill/title}" class="thumbnailportrait"/>
                </a>
            </div>
          </div>
        </div>
    )
};

declare function block:other($form,$next,$ill,$lang) {
    for $i in $next//illustration
    where $i ne $ill
    return 
        <div class="other thumbnail">
          <div class="thumbnailbox">
            <div class="thumbnailcontainer">
                <a href="{block:url($form,$next/day/date,$lang,$i/id)}">
                    <img src="{$i/url}" alt="{$i/url}" class="thumbnailportrait"/>
                </a>
            </div>
          </div>
        </div>
};

declare function block:languages($form,$next,$ill,$lang) {
    for $l in db:collection($data:supported-languages)
    where $l/id ne $lang
    return
        <div class="language"><a href="{block:url($form,$next/day/date,$l/id,$ill/id)}">{$l/name}</a></div>
};


(: AUXILIARY FUNCTIONS :)

declare function block:cycle($cycle) {
    let $map :=
        <cycles>
            <cycle>
                <id>A</id>
                <name>Year A</name>
            </cycle>
            <cycle>
                <id>B</id>
                <name>Year B</name>
            </cycle>
            <cycle>
                <id>C</id>
                <name>Year C</name>
            </cycle>
        </cycles>
    return $map/cycle[id eq $cycle]/name
};

declare function block:simplify ( $string as xs:string ) as xs:string {
  fn:replace(
    fn:replace(
      fn:replace(
        fn:replace(
          fn:replace(
            $string,
            ", (, )+",
            ", "
          ),
          "\(, ",
          "("
        ),
        ", \)",
        ")"
      ),
      "\(, \)",
      ""
    ),
    "\(\)",
    ""
  )
};

declare function block:url($form,$date,$lang,$id) {
    replace
    (
        replace
        (
            replace
            (
                replace
                (
                    "/day/with?form=%form&amp;date=%date&amp;lang=%lang&amp;id=%id",
                    "%form",$form
                ),
                "%date",$date
            ),
            "%lang",$lang
        ),
        "%id",$id
    )
};
