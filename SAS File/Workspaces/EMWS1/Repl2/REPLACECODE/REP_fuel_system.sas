   
* ;
* Defining: REP_fuel_system;
* ;
Length REP_fuel_system$8;
Label REP_fuel_system='Replacement: fuel-system';
REP_fuel_system=fuel_system;
* ;
* Variable: fuel_system;
* ;
_UFORMAT200 = strip(fuel_system);
if _UFORMAT200 =  "mpfi" then
REP_fuel_system="non-spdi";
else
if _UFORMAT200 =  "2bbl" then
REP_fuel_system="non-spdi";
else
if _UFORMAT200 =  "idi" then
REP_fuel_system="non-spdi";
else
if _UFORMAT200 =  "1bbl" then
REP_fuel_system="non-spdi";
else
if _UFORMAT200 =  "spdi" then
REP_fuel_system="spdi";
else
if _UFORMAT200 =  "4bbl" then
REP_fuel_system="non-spdi";
