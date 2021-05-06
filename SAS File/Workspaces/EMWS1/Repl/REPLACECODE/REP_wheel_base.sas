* ;
*Variable: wheel_base;
* ;
Label REP_wheel_base= 'Replacement: wheel-base';
REP_wheel_base= wheel_base;
if wheel_base eq . then REP_wheel_base = .;
else
if wheel_base<81.954600847 then REP_wheel_base=81.954600847;
else
if wheel_base>115.17739915 then REP_wheel_base=115.17739915;
