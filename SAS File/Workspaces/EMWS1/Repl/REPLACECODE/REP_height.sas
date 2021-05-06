* ;
*Variable: height;
* ;
Label REP_height= 'Replacement: height';
REP_height= height;
if height eq . then REP_height = .;
else
if height<46.545892936 then REP_height=46.545892936;
else
if height>61.328107064 then REP_height=61.328107064;
