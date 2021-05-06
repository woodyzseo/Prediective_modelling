* ;
*Variable: width;
* ;
Label REP_width= 'Replacement: width';
REP_width= width;
if width eq . then REP_width = .;
else
if width<60.189403674 then REP_width=60.189403674;
else
if width>71.200596326 then REP_width=71.200596326;
