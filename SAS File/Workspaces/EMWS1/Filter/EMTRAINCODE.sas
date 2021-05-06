

length _FILTERFMT1  $200;
drop _FILTERFMT1 ;
_FILTERFMT1= put(engine_type,$5.0);
length _FILTERNORM1  $32;
drop _FILTERNORM1 ;
%dmnormcp(_FILTERFMT1,_FILTERNORM1);


length _FILTERFMT2  $200;
drop _FILTERFMT2 ;
_FILTERFMT2= put(fuel_system,$4.0);
length _FILTERNORM2  $32;
drop _FILTERNORM2 ;
%dmnormcp(_FILTERFMT2,_FILTERNORM2);


length _FILTERFMT3  $200;
drop _FILTERFMT3 ;
_FILTERFMT3= put(num_of_cylinders,$6.0);
length _FILTERNORM3  $32;
drop _FILTERNORM3 ;
%dmnormcp(_FILTERFMT3,_FILTERNORM3);
if
_FILTERNORM1 not in ( 'DOHCV')
 and
_FILTERNORM2 not in ( 'MFI' , 'SPFI')
 and
_FILTERNORM3 not in ( 'THREE' , 'TWELVE')
and
( horsepower eq . or (1<=horsepower                      ))
;
