* ;
*Variable: IMP_stroke;
* ;
Label REP_IMP_stroke= 'Replacement: Imputed stroke';
REP_IMP_stroke= IMP_stroke;
if IMP_stroke eq . then REP_IMP_stroke = .;
else
if IMP_stroke<2.3537374593 then REP_IMP_stroke=2.3537374593;
else
if IMP_stroke>4.148915602 then REP_IMP_stroke=4.148915602;
