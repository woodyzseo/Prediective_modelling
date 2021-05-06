*************************************;
*** begin scoring code for regression;
*************************************;

length _WARN_ $4;
label _WARN_ = 'Warnings' ;

length I_Risk $ 12;
label I_Risk = 'Into: Risk' ;
*** Target Values;
array REG3DRF [2] $12 _temporary_ ('1' '0' );
label U_Risk = 'Unnormalized Into: Risk' ;
format U_Risk BEST12.;
*** Unnormalized target values;
ARRAY REG3DRU[2]  _TEMPORARY_ (1 0);

*** Generate dummy variables for Risk ;
drop _Y ;
label F_Risk = 'From: Risk' ;
length F_Risk $ 12;
F_Risk = put( Risk , BEST12. );
%DMNORMIP( F_Risk )
if missing( Risk ) then do;
   _Y = .;
end;
else do;
   if F_Risk = '1'  then do;
      _Y = 0;
   end;
   else if F_Risk = '0'  then do;
      _Y = 1;
   end;
   else do;
      _Y = .;
   end;
end;

drop _DM_BAD;
_DM_BAD=0;

*** Check LOG_REP_engine_size for missing values ;
if missing( LOG_REP_engine_size ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check REP_city_mpg for missing values ;
if missing( REP_city_mpg ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check REP_highway_mpg for missing values ;
if missing( REP_highway_mpg ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check REP_wheel_base for missing values ;
if missing( REP_wheel_base ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check REP_width for missing values ;
if missing( REP_width ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Generate dummy variables for IMP_num_of_doors ;
drop _1_0 ;
if missing( IMP_num_of_doors ) then do;
   _1_0 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( IMP_num_of_doors , BEST12. );
   %DMNORMIP( _dm12 )
   if _dm12 = '4'  then do;
      _1_0 = -1;
   end;
   else if _dm12 = '2'  then do;
      _1_0 = 1;
   end;
   else do;
      _1_0 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for REP_num_of_cylinders ;
drop _12_0 ;
if missing( REP_num_of_cylinders ) then do;
   _12_0 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm6 $ 6; drop _dm6 ;
   %DMNORMCP( REP_num_of_cylinders , _dm6 )
   if _dm6 = '<=4'  then do;
      _12_0 = 1;
   end;
   else if _dm6 = '>4'  then do;
      _12_0 = -1;
   end;
   else do;
      _12_0 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** If missing inputs, use averages;
if _DM_BAD > 0 then do;
   _P0 = 0.54;
   _P1 = 0.46;
   goto REG3DR1;
end;

*** Compute Linear Predictor;
drop _TEMP;
drop _LP0;
_LP0 = 0;

***  Effect: IMP_num_of_doors ;
_TEMP = 1;
_LP0 = _LP0 + (    1.63943543531856) * _TEMP * _1_0;

***  Effect: LOG_REP_engine_size ;
_TEMP = LOG_REP_engine_size ;
_LP0 = _LP0 + (   -7.30437327772944 * _TEMP);

***  Effect: REP_city_mpg ;
_TEMP = REP_city_mpg ;
_LP0 = _LP0 + (   -0.96946260216675 * _TEMP);

***  Effect: REP_highway_mpg ;
_TEMP = REP_highway_mpg ;
_LP0 = _LP0 + (    0.82569530280862 * _TEMP);

***  Effect: REP_num_of_cylinders ;
_TEMP = 1;
_LP0 = _LP0 + (   -1.02161983235279) * _TEMP * _12_0;

***  Effect: REP_wheel_base ;
_TEMP = REP_wheel_base ;
_LP0 = _LP0 + (   -0.65228360692637 * _TEMP);

***  Effect: REP_width ;
_TEMP = REP_width ;
_LP0 = _LP0 + (    1.17019399274576 * _TEMP);

*** Naive Posterior Probabilities;
drop _MAXP _IY _P0 _P1;
_TEMP =     22.6333848750239 + _LP0;
if (_TEMP < 0) then do;
   _TEMP = exp(_TEMP);
   _P0 = _TEMP / (1 + _TEMP);
end;
else _P0 = 1 / (1 + exp(-_TEMP));
_P1 = 1.0 - _P0;

REG3DR1:

*** Residuals;
if (_Y = .) then do;
   R_Risk1 = .;
   R_Risk0 = .;
end;
else do;
    label R_Risk1 = 'Residual: Risk=1' ;
    label R_Risk0 = 'Residual: Risk=0' ;
   R_Risk1 = - _P0;
   R_Risk0 = - _P1;
   select( _Y );
      when (0)  R_Risk1 = R_Risk1 + 1;
      when (1)  R_Risk0 = R_Risk0 + 1;
   end;
end;

*** Posterior Probabilities and Predicted Level;
label P_Risk1 = 'Predicted: Risk=1' ;
label P_Risk0 = 'Predicted: Risk=0' ;
P_Risk1 = _P0;
_MAXP = _P0;
_IY = 1;
P_Risk0 = _P1;
if (_P1 >  _MAXP + 1E-8) then do;
   _MAXP = _P1;
   _IY = 2;
end;
I_Risk = REG3DRF[_IY];
U_Risk = REG3DRU[_IY];

*************************************;
***** end scoring code for regression;
*************************************;
