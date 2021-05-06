* ;
*Variable: length;
* ;
Label REP_length= 'Replacement: length';
REP_length= length;
if length eq . then REP_length = .;
else
if length<139.36573105 then REP_length=139.36573105;
else
if length>207.69426895 then REP_length=207.69426895;
