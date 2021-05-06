* ;
*Variable: IMP_price;
* ;
Label REP_IMP_price= 'Replacement: Imputed price';
REP_IMP_price= IMP_price;
if IMP_price eq . then REP_IMP_price = .;
else
if IMP_price<-8881.562846 then REP_IMP_price=-8881.562846;
else
if IMP_price>34427.946684 then REP_IMP_price=34427.946684;
