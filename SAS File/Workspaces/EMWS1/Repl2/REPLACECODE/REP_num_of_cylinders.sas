   
* ;
* Defining: REP_num_of_cylinders;
* ;
Length REP_num_of_cylinders$6;
Label REP_num_of_cylinders='Replacement: num-of-cylinders';
REP_num_of_cylinders=num_of_cylinders;
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
