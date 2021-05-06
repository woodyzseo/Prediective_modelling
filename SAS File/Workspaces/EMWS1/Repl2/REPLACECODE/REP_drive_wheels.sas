   
* ;
* Defining: REP_drive_wheels;
* ;
Length REP_drive_wheels$3;
Label REP_drive_wheels='Replacement: drive-wheels';
REP_drive_wheels=drive_wheels;
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
