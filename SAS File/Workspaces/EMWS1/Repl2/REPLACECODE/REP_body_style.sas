   
* ;
* Defining: REP_body_style;
* ;
Length REP_body_style$11;
Label REP_body_style='Replacement: body-style';
REP_body_style=body_style;
* ;
* Variable: body_style;
* ;
_UFORMAT200 = strip(body_style);
if _UFORMAT200 =  "sedan" then
REP_body_style="S";
else
if _UFORMAT200 =  "hatchback" then
REP_body_style="H";
else
if _UFORMAT200 =  "wagon" then
REP_body_style="W";
else
if _UFORMAT200 =  "hardtop" then
REP_body_style="C";
else
if _UFORMAT200 =  "convertible" then
REP_body_style="C";
