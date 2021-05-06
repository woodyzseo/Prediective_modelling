*************************************;
*** begin scoring code for regression;
*************************************;

length _WARN_ $4;
label _WARN_ = 'Warnings' ;

length I_Risk $ 12;
label I_Risk = 'Into: Risk' ;
*** Target Values;
array REG4DRF [2] $12 _temporary_ ('1' '0' );
label U_Risk = 'Unnormalized Into: Risk' ;
format U_Risk BEST12.;
*** Unnormalized target values;
ARRAY REG4DRU[2]  _TEMPORARY_ (1 0);

drop _DM_BAD;
_DM_BAD=0;

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

*** If missing inputs, use averages;
if _DM_BAD > 0 then do;
   _P0 = 0.54;
   _P1 = 0.46;
   goto REG4DR1;
end;

*** Compute Linear Predictor;
drop _TEMP;
drop _LP0;
_LP0 = 0;

***  Effect: IMP_num_of_doors ;
_TEMP = 1;
_LP0 = _LP0 + (    1.30982910856518) * _TEMP * _1_0;

***  Effect: REP_wheel_base ;
_TEMP = REP_wheel_base ;
_LP0 = _LP0 + (   -0.66408760041165 * _TEMP);

***  Effect: REP_width ;
_TEMP = REP_width ;
_LP0 = _LP0 + (    1.04341066362593 * _TEMP);

*** Naive Posterior Probabilities;
drop _MAXP _IY _P0 _P1;
_TEMP =     -2.4884177664295 + _LP0;
if (_TEMP < 0) then do;
   _TEMP = exp(_TEMP);
   _P0 = _TEMP / (1 + _TEMP);
end;
else _P0 = 1 / (1 + exp(-_TEMP));
_P1 = 1.0 - _P0;

REG4DR1:


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
I_Risk = REG4DRF[_IY];
U_Risk = REG4DRU[_IY];

*************************************;
***** end scoring code for regression;
*************************************;
