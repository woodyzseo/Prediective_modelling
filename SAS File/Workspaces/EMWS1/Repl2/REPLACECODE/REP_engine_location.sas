   
* ;
* Defining: REP_engine_location;
* ;
Length REP_engine_location$5;
Label REP_engine_location='Replacement: engine-location';
REP_engine_location=engine_location;
* ;
* Variable: engine_location;
* ;
_UFORMAT200 = strip(engine_location);
if _UFORMAT200 =  "front" then
REP_engine_location="F";
else
if _UFORMAT200 =  "rear" then
REP_engine_location="R";
