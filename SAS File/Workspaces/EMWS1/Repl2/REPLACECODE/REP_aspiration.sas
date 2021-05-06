   
* ;
* Defining: REP_aspiration;
* ;
Length REP_aspiration$5;
Label REP_aspiration='Replacement: aspiration';
format REP_aspiration $5.0;
REP_aspiration=aspiration;
* ;
* Variable: aspiration;
* ;
_UFORMAT200 = strip(
put(aspiration,$5.0));
if _UFORMAT200 =  "std" then
REP_aspiration="S";
else
if _UFORMAT200 =  "turbo" then
REP_aspiration="T";
