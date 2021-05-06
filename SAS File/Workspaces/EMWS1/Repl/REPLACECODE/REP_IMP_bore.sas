* ;
*Variable: IMP_bore;
* ;
Label REP_IMP_bore= 'Replacement: Imputed bore';
REP_IMP_bore= IMP_bore;
if IMP_bore eq . then REP_IMP_bore = .;
else
if IMP_bore<2.5610632332 then REP_IMP_bore=2.5610632332;
else
if IMP_bore>4.0442428893 then REP_IMP_bore=4.0442428893;
