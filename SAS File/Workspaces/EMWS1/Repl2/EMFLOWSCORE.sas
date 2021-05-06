   
* ;
* Defining New Variables;
* ;
Length REP_aspiration $5;
Label REP_aspiration='Replacement: aspiration';
format REP_aspiration $5.0;
REP_aspiration= aspiration;
Length REP_body_style $11;
Label REP_body_style='Replacement: body-style';
REP_body_style= body_style;
Length REP_drive_wheels $3;
Label REP_drive_wheels='Replacement: drive-wheels';
REP_drive_wheels= drive_wheels;
Length REP_engine_location $5;
Label REP_engine_location='Replacement: engine-location';
REP_engine_location= engine_location;
Length REP_fuel_system $8;
Label REP_fuel_system='Replacement: fuel-system';
REP_fuel_system= fuel_system;
Length REP_fuel_type $6;
Label REP_fuel_type='Replacement: fuel-type';
REP_fuel_type= fuel_type;
Length REP_num_of_cylinders $6;
Label REP_num_of_cylinders='Replacement: num-of-cylinders';
REP_num_of_cylinders= num_of_cylinders;
   
* ;
* Replace Specific Class Levels ;
* ;
length _UFormat200 $200;
drop   _UFORMAT200;
_UFORMAT200 = " ";
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
* ;
* Variable: drive_wheels;
* ;
_UFORMAT200 = strip(drive_wheels);
if _UFORMAT200 =  "fwd" then
REP_drive_wheels="F";
else
if _UFORMAT200 =  "rwd" then
REP_drive_wheels="R";
else
if _UFORMAT200 =  "4wd" then
REP_drive_wheels="4";
* ;
* Variable: engine_location;
* ;
_UFORMAT200 = strip(engine_location);
if _UFORMAT200 =  "front" then
REP_engine_location="F";
else
if _UFORMAT200 =  "rear" then
REP_engine_location="R";
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
* ;
* Variable: fuel_type;
* ;
_UFORMAT200 = strip(fuel_type);
if _UFORMAT200 =  "gas" then
REP_fuel_type="G";
else
if _UFORMAT200 =  "diesel" then
REP_fuel_type="D";
* ;
* Variable: num_of_cylinders;
* ;
_UFORMAT200 = strip(num_of_cylinders);
if _UFORMAT200 =  "four" then
REP_num_of_cylinders="<=4";
else
if _UFORMAT200 =  "six" then
REP_num_of_cylinders=">4";
else
if _UFORMAT200 =  "five" then
REP_num_of_cylinders=">4";
else
if _UFORMAT200 =  "two" then
REP_num_of_cylinders="<=4";
