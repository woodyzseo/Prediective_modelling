* ;
*Variable: curb_weight;
* ;
Label REP_curb_weight= 'Replacement: curb-weight';
REP_curb_weight= curb_weight;
if curb_weight eq . then REP_curb_weight = .;
else
if curb_weight<1095.8998842 then REP_curb_weight=1095.8998842;
else
if curb_weight>3938.8001158 then REP_curb_weight=3938.8001158;
