*************************************;
*** begin scoring code for regression;
*************************************;

length _WARN_ $4;
label _WARN_ = 'Warnings' ;

length I_Risk $ 12;
label I_Risk = 'Into: Risk' ;
*** Target Values;
array REGDRF [2] $12 _temporary_ ('1' '0' );
label U_Risk = 'Unnormalized Into: Risk' ;
format U_Risk BEST12.;
*** Unnormalized target values;
ARRAY REGDRU[2]  _TEMPORARY_ (1 0);

drop _DM_BAD;
_DM_BAD=0;

*** Check LOG_REP_IMP_price for missing values ;
if missing( LOG_REP_IMP_price ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check LOG_REP_compression_ratio for missing values ;
if missing( LOG_REP_compression_ratio ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check LOG_REP_engine_size for missing values ;
if missing( LOG_REP_engine_size ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check REP_IMP_bore for missing values ;
if missing( REP_IMP_bore ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check REP_IMP_stroke for missing values ;
if missing( REP_IMP_stroke ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check REP_city_mpg for missing values ;
if missing( REP_city_mpg ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check REP_curb_weight for missing values ;
if missing( REP_curb_weight ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check REP_height for missing values ;
if missing( REP_height ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check REP_highway_mpg for missing values ;
if missing( REP_highway_mpg ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check REP_horsepower for missing values ;
if missing( REP_horsepower ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check REP_length for missing values ;
if missing( REP_length ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check REP_peak_rpm for missing values ;
if missing( REP_peak_rpm ) then do;
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

*** Generate dummy variables for M_bore ;
drop _2_0 ;
if missing( M_bore ) then do;
   _2_0 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( M_bore , BEST12. );
   %DMNORMIP( _dm12 )
   if _dm12 = '0'  then do;
      _2_0 = 1;
   end;
   else if _dm12 = '1'  then do;
      _2_0 = -1;
   end;
   else do;
      _2_0 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for M_num_of_doors ;
drop _3_0 ;
if missing( M_num_of_doors ) then do;
   _3_0 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( M_num_of_doors , BEST12. );
   %DMNORMIP( _dm12 )
   if _dm12 = '0'  then do;
      _3_0 = 1;
   end;
   else if _dm12 = '1'  then do;
      _3_0 = -1;
   end;
   else do;
      _3_0 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for M_price ;
drop _4_0 ;
if missing( M_price ) then do;
   _4_0 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( M_price , BEST12. );
   %DMNORMIP( _dm12 )
   if _dm12 = '0'  then do;
      _4_0 = 1;
   end;
   else if _dm12 = '1'  then do;
      _4_0 = -1;
   end;
   else do;
      _4_0 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for REP_aspiration ;
drop _6_0 ;
if missing( REP_aspiration ) then do;
   _6_0 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm5 $ 5; drop _dm5 ;
   _dm5 = put( REP_aspiration , $5. );
   %DMNORMIP( _dm5 )
   if _dm5 = 'S'  then do;
      _6_0 = 1;
   end;
   else if _dm5 = 'T'  then do;
      _6_0 = -1;
   end;
   else do;
      _6_0 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for REP_body_style ;
drop _7_0 _7_1 _7_2 ;
if missing( REP_body_style ) then do;
   _7_0 = .;
   _7_1 = .;
   _7_2 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm11 $ 11; drop _dm11 ;
   %DMNORMCP( REP_body_style , _dm11 )
   if _dm11 = 'S'  then do;
      _7_0 = 0;
      _7_1 = 0;
      _7_2 = 1;
   end;
   else if _dm11 = 'H'  then do;
      _7_0 = 0;
      _7_1 = 1;
      _7_2 = 0;
   end;
   else if _dm11 = 'W'  then do;
      _7_0 = -1;
      _7_1 = -1;
      _7_2 = -1;
   end;
   else if _dm11 = 'C'  then do;
      _7_0 = 1;
      _7_1 = 0;
      _7_2 = 0;
   end;
   else do;
      _7_0 = .;
      _7_1 = .;
      _7_2 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for REP_drive_wheels ;
drop _8_0 _8_1 ;
if missing( REP_drive_wheels ) then do;
   _8_0 = .;
   _8_1 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm3 $ 3; drop _dm3 ;
   %DMNORMCP( REP_drive_wheels , _dm3 )
   if _dm3 = 'F'  then do;
      _8_0 = 0;
      _8_1 = 1;
   end;
   else if _dm3 = 'R'  then do;
      _8_0 = -1;
      _8_1 = -1;
   end;
   else if _dm3 = '4'  then do;
      _8_0 = 1;
      _8_1 = 0;
   end;
   else do;
      _8_0 = .;
      _8_1 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for REP_engine_location ;
drop _9_0 ;
if missing( REP_engine_location ) then do;
   _9_0 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm5 $ 5; drop _dm5 ;
   %DMNORMCP( REP_engine_location , _dm5 )
   if _dm5 = 'F'  then do;
      _9_0 = 1;
   end;
   else if _dm5 = 'R'  then do;
      _9_0 = -1;
   end;
   else do;
      _9_0 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for REP_fuel_system ;
drop _10_0 ;
if missing( REP_fuel_system ) then do;
   _10_0 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm8 $ 8; drop _dm8 ;
   %DMNORMCP( REP_fuel_system , _dm8 )
   if _dm8 = 'NON-SPDI'  then do;
      _10_0 = 1;
   end;
   else if _dm8 = 'SPDI'  then do;
      _10_0 = -1;
   end;
   else do;
      _10_0 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for REP_fuel_type ;
drop _11_0 ;
if missing( REP_fuel_type ) then do;
   _11_0 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm6 $ 6; drop _dm6 ;
   %DMNORMCP( REP_fuel_type , _dm6 )
   if _dm6 = 'G'  then do;
      _11_0 = -1;
   end;
   else if _dm6 = 'D'  then do;
      _11_0 = 1;
   end;
   else do;
      _11_0 = .;
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

*** Generate dummy variables for engine_type ;
drop _13_0 _13_1 _13_2 _13_3 _13_4 ;
*** encoding is sparse, initialize to zero;
_13_0 = 0;
_13_1 = 0;
_13_2 = 0;
_13_3 = 0;
_13_4 = 0;
if missing( engine_type ) then do;
   _13_0 = .;
   _13_1 = .;
   _13_2 = .;
   _13_3 = .;
   _13_4 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm5 $ 5; drop _dm5 ;
   %DMNORMCP( engine_type , _dm5 )
   if _dm5 = 'OHC'  then do;
      _13_2 = 1;
   end;
   else if _dm5 = 'OHCF'  then do;
      _13_3 = 1;
   end;
   else if _dm5 = 'OHCV'  then do;
      _13_4 = 1;
   end;
   else if _dm5 = 'DOHC'  then do;
      _13_0 = 1;
   end;
   else if _dm5 = 'L'  then do;
      _13_1 = 1;
   end;
   else if _dm5 = 'ROTOR'  then do;
      _13_0 = -1;
      _13_1 = -1;
      _13_2 = -1;
      _13_3 = -1;
      _13_4 = -1;
   end;
   else do;
      _13_0 = .;
      _13_1 = .;
      _13_2 = .;
      _13_3 = .;
      _13_4 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** If missing inputs, use averages;
if _DM_BAD > 0 then do;
   _P0 = 0.54;
   _P1 = 0.46;
   goto REGDR1;
end;

*** Compute Linear Predictor;
drop _TEMP;
drop _LP0;
_LP0 = 0;

***  Effect: IMP_num_of_doors ;
_TEMP = 1;
_LP0 = _LP0 + (    5.57210910044529) * _TEMP * _1_0;

***  Effect: LOG_REP_IMP_price ;
_TEMP = LOG_REP_IMP_price ;
_LP0 = _LP0 + (    11.9518012758651 * _TEMP);

***  Effect: LOG_REP_compression_ratio ;
_TEMP = LOG_REP_compression_ratio ;
_LP0 = _LP0 + (   -9.94715013623581 * _TEMP);

***  Effect: LOG_REP_engine_size ;
_TEMP = LOG_REP_engine_size ;
_LP0 = _LP0 + (    -178.20123476361 * _TEMP);

***  Effect: M_bore ;
_TEMP = 1;
_LP0 = _LP0 + (   -5.34355712875215) * _TEMP * _2_0;

***  Effect: M_num_of_doors ;
_TEMP = 1;
_LP0 = _LP0 + (   -1.18400450701266) * _TEMP * _3_0;

***  Effect: M_price ;
_TEMP = 1;
_LP0 = _LP0 + (    11.9326557543356) * _TEMP * _4_0;

***  Effect: REP_IMP_bore ;
_TEMP = REP_IMP_bore ;
_LP0 = _LP0 + (       10.2632175353 * _TEMP);

***  Effect: REP_IMP_stroke ;
_TEMP = REP_IMP_stroke ;
_LP0 = _LP0 + (    8.44790433662516 * _TEMP);

***  Effect: REP_aspiration ;
_TEMP = 1;
_LP0 = _LP0 + (    17.2425857123684) * _TEMP * _6_0;

***  Effect: REP_body_style ;
_TEMP = 1;
_LP0 = _LP0 + (    0.55352273770039) * _TEMP * _7_0;
_LP0 = _LP0 + (   -6.35110159104338) * _TEMP * _7_1;
_LP0 = _LP0 + (    3.18293421007515) * _TEMP * _7_2;

***  Effect: REP_city_mpg ;
_TEMP = REP_city_mpg ;
_LP0 = _LP0 + (   -3.79588419740667 * _TEMP);

***  Effect: REP_curb_weight ;
_TEMP = REP_curb_weight ;
_LP0 = _LP0 + (   -0.00455699377009 * _TEMP);

***  Effect: REP_drive_wheels ;
_TEMP = 1;
_LP0 = _LP0 + (   -14.0618241207844) * _TEMP * _8_0;
_LP0 = _LP0 + (   -10.7068028686924) * _TEMP * _8_1;

***  Effect: REP_engine_location ;
_TEMP = 1;
_LP0 = _LP0 + (    28.9796677445423) * _TEMP * _9_0;

***  Effect: REP_fuel_system ;
_TEMP = 1;
_LP0 = _LP0 + (   -14.0060782743662) * _TEMP * _10_0;

***  Effect: REP_fuel_type ;
_TEMP = 1;
_LP0 = _LP0 + (    10.5128198160205) * _TEMP * _11_0;

***  Effect: REP_height ;
_TEMP = REP_height ;
_LP0 = _LP0 + (   -0.22379743248917 * _TEMP);

***  Effect: REP_highway_mpg ;
_TEMP = REP_highway_mpg ;
_LP0 = _LP0 + (    2.16759667979231 * _TEMP);

***  Effect: REP_horsepower ;
_TEMP = REP_horsepower ;
_LP0 = _LP0 + (    0.32382171887187 * _TEMP);

***  Effect: REP_length ;
_TEMP = REP_length ;
_LP0 = _LP0 + (   -0.76813968642315 * _TEMP);

***  Effect: REP_num_of_cylinders ;
_TEMP = 1;
_LP0 = _LP0 + (     -10.96587007805) * _TEMP * _12_0;

***  Effect: REP_peak_rpm ;
_TEMP = REP_peak_rpm ;
_LP0 = _LP0 + (   -0.02144834544441 * _TEMP);

***  Effect: REP_wheel_base ;
_TEMP = REP_wheel_base ;
_LP0 = _LP0 + (   -8.90797155476209 * _TEMP);

***  Effect: REP_width ;
_TEMP = REP_width ;
_LP0 = _LP0 + (    20.9493526132144 * _TEMP);

***  Effect: engine_type ;
_TEMP = 1;
_LP0 = _LP0 + (    40.2925191974815) * _TEMP * _13_0;
_LP0 = _LP0 + (    24.8358823337596) * _TEMP * _13_1;
_LP0 = _LP0 + (    31.5645382349809) * _TEMP * _13_2;
_LP0 = _LP0 + (    14.2415788924155) * _TEMP * _13_3;
_LP0 = _LP0 + (                   0) * _TEMP * _13_4;

*** Naive Posterior Probabilities;
drop _MAXP _IY _P0 _P1;
_TEMP =     424.692537224367 + _LP0;
if (_TEMP < 0) then do;
   _TEMP = exp(_TEMP);
   _P0 = _TEMP / (1 + _TEMP);
end;
else _P0 = 1 / (1 + exp(-_TEMP));
_P1 = 1.0 - _P0;

REGDR1:


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
I_Risk = REGDRF[_IY];
U_Risk = REGDRU[_IY];

*************************************;
***** end scoring code for regression;
*************************************;
