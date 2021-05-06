   
* ;
* Defining: REP_fuel_type;
* ;
Length REP_fuel_type$6;
Label REP_fuel_type='Replacement: fuel-type';
REP_fuel_type=fuel_type;
* ;
* Variable: fuel_type;
* ;
_UFORMAT200 = strip(fuel_type);
if _UFORMAT200 =  "gas" then
REP_fuel_type="G";
else
if _UFORMAT200 =  "diesel" then
REP_fuel_type="D";
