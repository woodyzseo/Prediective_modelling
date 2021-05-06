***********************************;
*** Begin Scoring Code for Neural;
***********************************;
DROP _DM_BAD _EPS _NOCL_ _MAX_ _MAXP_ _SUM_ _NTRIALS;
 _DM_BAD = 0;
 _NOCL_ = .;
 _MAX_ = .;
 _MAXP_ = .;
 _SUM_ = .;
 _NTRIALS = .;
 _EPS =                1E-10;
LENGTH _WARN_ $4
;
      label S_LOG_REP_IMP_price = 'Standard: LOG_REP_IMP_price' ;

      label S_LOG_REP_compression_ratio =
'Standard: LOG_REP_compression_ratio' ;

      label S_LOG_REP_engine_size = 'Standard: LOG_REP_engine_size' ;

      label S_REP_IMP_bore = 'Standard: REP_IMP_bore' ;

      label S_REP_IMP_stroke = 'Standard: REP_IMP_stroke' ;

      label S_REP_city_mpg = 'Standard: REP_city_mpg' ;

      label S_REP_curb_weight = 'Standard: REP_curb_weight' ;

      label S_REP_height = 'Standard: REP_height' ;

      label S_REP_highway_mpg = 'Standard: REP_highway_mpg' ;

      label S_REP_horsepower = 'Standard: REP_horsepower' ;

      label S_REP_length = 'Standard: REP_length' ;

      label S_REP_peak_rpm = 'Standard: REP_peak_rpm' ;

      label S_REP_wheel_base = 'Standard: REP_wheel_base' ;

      label S_REP_width = 'Standard: REP_width' ;

      label M_bore0 = 'Dummy: M_bore=0' ;

      label M_num_of_doors0 = 'Dummy: M_num_of_doors=0' ;

      label M_price0 = 'Dummy: M_price=0' ;

      label M_stroke0 = 'Dummy: M_stroke=0' ;

      label IMP_num_of_doors2 = 'Dummy: IMP_num_of_doors=2' ;

      label REP_aspirationS = 'Dummy: REP_aspiration=S' ;

      label REP_body_styleC = 'Dummy: REP_body_style=C' ;

      label REP_body_styleH = 'Dummy: REP_body_style=H' ;

      label REP_body_styleS = 'Dummy: REP_body_style=S' ;

      label REP_drive_wheels4 = 'Dummy: REP_drive_wheels=4' ;

      label REP_drive_wheelsF = 'Dummy: REP_drive_wheels=F' ;

      label REP_engine_locationF = 'Dummy: REP_engine_location=F' ;

      label REP_fuel_systemnon_spdi = 'Dummy: REP_fuel_system=non-spdi' ;

      label REP_fuel_typeD = 'Dummy: REP_fuel_type=D' ;

      label REP_num_of_cylinders__4 = 'Dummy: REP_num_of_cylinders=<=4' ;

      label engine_typedohc = 'Dummy: engine_type=dohc' ;

      label engine_typel = 'Dummy: engine_type=l' ;

      label engine_typeohc = 'Dummy: engine_type=ohc' ;

      label engine_typeohcf = 'Dummy: engine_type=ohcf' ;

      label engine_typeohcv = 'Dummy: engine_type=ohcv' ;

      label H11 = 'Hidden: H1=1' ;

      label H12 = 'Hidden: H1=2' ;

      label H13 = 'Hidden: H1=3' ;

      label H14 = 'Hidden: H1=4' ;

      label I_Risk = 'Into: Risk' ;

      label U_Risk = 'Unnormalized Into: Risk' ;

      label P_Risk1 = 'Predicted: Risk=1' ;

      label P_Risk0 = 'Predicted: Risk=0' ;

      label  _WARN_ = "Warnings";

*** Generate dummy variables for M_bore ;
drop M_bore0 ;
if missing( M_bore ) then do;
   M_bore0 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( M_bore , BEST12. );
   %DMNORMIP( _dm12 )
   if _dm12 = '0'  then do;
      M_bore0 = 1;
   end;
   else if _dm12 = '1'  then do;
      M_bore0 = -1;
   end;
   else do;
      M_bore0 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for M_num_of_doors ;
drop M_num_of_doors0 ;
if missing( M_num_of_doors ) then do;
   M_num_of_doors0 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( M_num_of_doors , BEST12. );
   %DMNORMIP( _dm12 )
   if _dm12 = '0'  then do;
      M_num_of_doors0 = 1;
   end;
   else if _dm12 = '1'  then do;
      M_num_of_doors0 = -1;
   end;
   else do;
      M_num_of_doors0 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for M_price ;
drop M_price0 ;
if missing( M_price ) then do;
   M_price0 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( M_price , BEST12. );
   %DMNORMIP( _dm12 )
   if _dm12 = '0'  then do;
      M_price0 = 1;
   end;
   else if _dm12 = '1'  then do;
      M_price0 = -1;
   end;
   else do;
      M_price0 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for M_stroke ;
drop M_stroke0 ;
if missing( M_stroke ) then do;
   M_stroke0 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( M_stroke , BEST12. );
   %DMNORMIP( _dm12 )
   if _dm12 = '0'  then do;
      M_stroke0 = 1;
   end;
   else if _dm12 = '1'  then do;
      M_stroke0 = -1;
   end;
   else do;
      M_stroke0 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for IMP_num_of_doors ;
drop IMP_num_of_doors2 ;
if missing( IMP_num_of_doors ) then do;
   IMP_num_of_doors2 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( IMP_num_of_doors , BEST12. );
   %DMNORMIP( _dm12 )
   if _dm12 = '4'  then do;
      IMP_num_of_doors2 = -1;
   end;
   else if _dm12 = '2'  then do;
      IMP_num_of_doors2 = 1;
   end;
   else do;
      IMP_num_of_doors2 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for REP_aspiration ;
drop REP_aspirationS ;
if missing( REP_aspiration ) then do;
   REP_aspirationS = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm5 $ 5; drop _dm5 ;
   _dm5 = put( REP_aspiration , $5. );
   %DMNORMIP( _dm5 )
   if _dm5 = 'S'  then do;
      REP_aspirationS = 1;
   end;
   else if _dm5 = 'T'  then do;
      REP_aspirationS = -1;
   end;
   else do;
      REP_aspirationS = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for REP_body_style ;
drop REP_body_styleC REP_body_styleH REP_body_styleS ;
if missing( REP_body_style ) then do;
   REP_body_styleC = .;
   REP_body_styleH = .;
   REP_body_styleS = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm11 $ 11; drop _dm11 ;
   %DMNORMCP( REP_body_style , _dm11 )
   if _dm11 = 'S'  then do;
      REP_body_styleC = 0;
      REP_body_styleH = 0;
      REP_body_styleS = 1;
   end;
   else if _dm11 = 'H'  then do;
      REP_body_styleC = 0;
      REP_body_styleH = 1;
      REP_body_styleS = 0;
   end;
   else if _dm11 = 'W'  then do;
      REP_body_styleC = -1;
      REP_body_styleH = -1;
      REP_body_styleS = -1;
   end;
   else if _dm11 = 'C'  then do;
      REP_body_styleC = 1;
      REP_body_styleH = 0;
      REP_body_styleS = 0;
   end;
   else do;
      REP_body_styleC = .;
      REP_body_styleH = .;
      REP_body_styleS = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for REP_drive_wheels ;
drop REP_drive_wheels4 REP_drive_wheelsF ;
if missing( REP_drive_wheels ) then do;
   REP_drive_wheels4 = .;
   REP_drive_wheelsF = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm3 $ 3; drop _dm3 ;
   %DMNORMCP( REP_drive_wheels , _dm3 )
   if _dm3 = 'F'  then do;
      REP_drive_wheels4 = 0;
      REP_drive_wheelsF = 1;
   end;
   else if _dm3 = 'R'  then do;
      REP_drive_wheels4 = -1;
      REP_drive_wheelsF = -1;
   end;
   else if _dm3 = '4'  then do;
      REP_drive_wheels4 = 1;
      REP_drive_wheelsF = 0;
   end;
   else do;
      REP_drive_wheels4 = .;
      REP_drive_wheelsF = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for REP_engine_location ;
drop REP_engine_locationF ;
if missing( REP_engine_location ) then do;
   REP_engine_locationF = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm5 $ 5; drop _dm5 ;
   %DMNORMCP( REP_engine_location , _dm5 )
   if _dm5 = 'F'  then do;
      REP_engine_locationF = 1;
   end;
   else if _dm5 = 'R'  then do;
      REP_engine_locationF = -1;
   end;
   else do;
      REP_engine_locationF = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for REP_fuel_system ;
drop REP_fuel_systemnon_spdi ;
if missing( REP_fuel_system ) then do;
   REP_fuel_systemnon_spdi = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm8 $ 8; drop _dm8 ;
   %DMNORMCP( REP_fuel_system , _dm8 )
   if _dm8 = 'NON-SPDI'  then do;
      REP_fuel_systemnon_spdi = 1;
   end;
   else if _dm8 = 'SPDI'  then do;
      REP_fuel_systemnon_spdi = -1;
   end;
   else do;
      REP_fuel_systemnon_spdi = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for REP_fuel_type ;
drop REP_fuel_typeD ;
if missing( REP_fuel_type ) then do;
   REP_fuel_typeD = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm6 $ 6; drop _dm6 ;
   %DMNORMCP( REP_fuel_type , _dm6 )
   if _dm6 = 'G'  then do;
      REP_fuel_typeD = -1;
   end;
   else if _dm6 = 'D'  then do;
      REP_fuel_typeD = 1;
   end;
   else do;
      REP_fuel_typeD = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for REP_num_of_cylinders ;
drop REP_num_of_cylinders__4 ;
if missing( REP_num_of_cylinders ) then do;
   REP_num_of_cylinders__4 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm6 $ 6; drop _dm6 ;
   %DMNORMCP( REP_num_of_cylinders , _dm6 )
   if _dm6 = '<=4'  then do;
      REP_num_of_cylinders__4 = 1;
   end;
   else if _dm6 = '>4'  then do;
      REP_num_of_cylinders__4 = -1;
   end;
   else do;
      REP_num_of_cylinders__4 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for engine_type ;
drop engine_typedohc engine_typel engine_typeohc engine_typeohcf
        engine_typeohcv ;
*** encoding is sparse, initialize to zero;
engine_typedohc = 0;
engine_typel = 0;
engine_typeohc = 0;
engine_typeohcf = 0;
engine_typeohcv = 0;
if missing( engine_type ) then do;
   engine_typedohc = .;
   engine_typel = .;
   engine_typeohc = .;
   engine_typeohcf = .;
   engine_typeohcv = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm5 $ 5; drop _dm5 ;
   %DMNORMCP( engine_type , _dm5 )
   if _dm5 = 'OHC'  then do;
      engine_typeohc = 1;
   end;
   else if _dm5 = 'OHCF'  then do;
      engine_typeohcf = 1;
   end;
   else if _dm5 = 'OHCV'  then do;
      engine_typeohcv = 1;
   end;
   else if _dm5 = 'DOHC'  then do;
      engine_typedohc = 1;
   end;
   else if _dm5 = 'L'  then do;
      engine_typel = 1;
   end;
   else if _dm5 = 'ROTOR'  then do;
      engine_typedohc = -1;
      engine_typel = -1;
      engine_typeohc = -1;
      engine_typeohcf = -1;
      engine_typeohcv = -1;
   end;
   else do;
      engine_typedohc = .;
      engine_typel = .;
      engine_typeohc = .;
      engine_typeohcf = .;
      engine_typeohcv = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** *************************;
*** Checking missing input Interval
*** *************************;

IF NMISS(
   LOG_REP_IMP_price ,
   LOG_REP_compression_ratio ,
   LOG_REP_engine_size ,
   REP_IMP_bore ,
   REP_IMP_stroke ,
   REP_city_mpg ,
   REP_curb_weight ,
   REP_height ,
   REP_highway_mpg ,
   REP_horsepower ,
   REP_length ,
   REP_peak_rpm ,
   REP_wheel_base ,
   REP_width   ) THEN DO;
   SUBSTR(_WARN_, 1, 1) = 'M';

   _DM_BAD = 1;
END;
*** *************************;
*** Writing the Node intvl ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   S_LOG_REP_IMP_price  =    -20.2356185469493 +     2.16855745948401 *
        LOG_REP_IMP_price ;
   S_LOG_REP_compression_ratio
          =    -8.72649819321039 +     3.65742873950677 *
        LOG_REP_compression_ratio ;
   S_LOG_REP_engine_size  =    -19.3053254119757 +     4.02929302984948 *
        LOG_REP_engine_size ;
   S_REP_IMP_bore  =    -13.3604302656684 +     4.04536293034574 *
        REP_IMP_bore ;
   S_REP_IMP_stroke  =    -11.3205669287077 +     3.47855217496738 *
        REP_IMP_stroke ;
   S_REP_city_mpg  =    -4.23279255832632 +     0.16535248553422 *
        REP_city_mpg ;
   S_REP_curb_weight  =    -5.35597047742979 +     0.00212869810672 *
        REP_curb_weight ;
   S_REP_height  =    -21.8926608140893 +     0.40589318675657 * REP_height ;
   S_REP_highway_mpg  =    -4.99166764925563 +     0.16020006928199 *
        REP_highway_mpg ;
   S_REP_horsepower  =    -2.74643097264309 +     0.02734944206973 *
        REP_horsepower ;
   S_REP_length  =    -15.2378498365576 +     0.08781104037663 * REP_length ;
   S_REP_peak_rpm  =    -10.6885709541859 +     0.00208333904184 *
        REP_peak_rpm ;
   S_REP_wheel_base  =    -17.8009087180129 +     0.18059887504832 *
        REP_wheel_base ;
   S_REP_width  =    -35.9167499004784 +     0.54673628301566 * REP_width ;
END;
ELSE DO;
   IF MISSING( LOG_REP_IMP_price ) THEN S_LOG_REP_IMP_price  = . ;
   ELSE S_LOG_REP_IMP_price  =    -20.2356185469493 +     2.16855745948401 *
        LOG_REP_IMP_price ;
   IF MISSING( LOG_REP_compression_ratio ) THEN S_LOG_REP_compression_ratio
          = . ;
   ELSE S_LOG_REP_compression_ratio
          =    -8.72649819321039 +     3.65742873950677 *
        LOG_REP_compression_ratio ;
   IF MISSING( LOG_REP_engine_size ) THEN S_LOG_REP_engine_size  = . ;
   ELSE S_LOG_REP_engine_size
          =    -19.3053254119757 +     4.02929302984948 * LOG_REP_engine_size
         ;
   IF MISSING( REP_IMP_bore ) THEN S_REP_IMP_bore  = . ;
   ELSE S_REP_IMP_bore  =    -13.3604302656684 +     4.04536293034574 *
        REP_IMP_bore ;
   IF MISSING( REP_IMP_stroke ) THEN S_REP_IMP_stroke  = . ;
   ELSE S_REP_IMP_stroke  =    -11.3205669287077 +     3.47855217496738 *
        REP_IMP_stroke ;
   IF MISSING( REP_city_mpg ) THEN S_REP_city_mpg  = . ;
   ELSE S_REP_city_mpg  =    -4.23279255832632 +     0.16535248553422 *
        REP_city_mpg ;
   IF MISSING( REP_curb_weight ) THEN S_REP_curb_weight  = . ;
   ELSE S_REP_curb_weight  =    -5.35597047742979 +     0.00212869810672 *
        REP_curb_weight ;
   IF MISSING( REP_height ) THEN S_REP_height  = . ;
   ELSE S_REP_height  =    -21.8926608140893 +     0.40589318675657 *
        REP_height ;
   IF MISSING( REP_highway_mpg ) THEN S_REP_highway_mpg  = . ;
   ELSE S_REP_highway_mpg  =    -4.99166764925563 +     0.16020006928199 *
        REP_highway_mpg ;
   IF MISSING( REP_horsepower ) THEN S_REP_horsepower  = . ;
   ELSE S_REP_horsepower  =    -2.74643097264309 +     0.02734944206973 *
        REP_horsepower ;
   IF MISSING( REP_length ) THEN S_REP_length  = . ;
   ELSE S_REP_length  =    -15.2378498365576 +     0.08781104037663 *
        REP_length ;
   IF MISSING( REP_peak_rpm ) THEN S_REP_peak_rpm  = . ;
   ELSE S_REP_peak_rpm  =    -10.6885709541859 +     0.00208333904184 *
        REP_peak_rpm ;
   IF MISSING( REP_wheel_base ) THEN S_REP_wheel_base  = . ;
   ELSE S_REP_wheel_base  =    -17.8009087180129 +     0.18059887504832 *
        REP_wheel_base ;
   IF MISSING( REP_width ) THEN S_REP_width  = . ;
   ELSE S_REP_width  =    -35.9167499004784 +     0.54673628301566 * REP_width
         ;
END;
*** *************************;
*** Writing the Node bin ;
*** *************************;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =    -0.30239282542129 * S_LOG_REP_IMP_price
          +     0.07375266777945 * S_LOG_REP_compression_ratio
          +    -0.32314301225116 * S_LOG_REP_engine_size
          +    -0.05791191369564 * S_REP_IMP_bore  +    -0.31295728139086 *
        S_REP_IMP_stroke  +    -0.50271357032608 * S_REP_city_mpg
          +    -0.49945653510897 * S_REP_curb_weight
          +    -0.35982904642168 * S_REP_height  +     0.17605089142765 *
        S_REP_highway_mpg  +     0.28723977440497 * S_REP_horsepower
          +     0.00026487266845 * S_REP_length  +     0.02115131299283 *
        S_REP_peak_rpm  +    -0.71479623156263 * S_REP_wheel_base
          +     0.57582729455077 * S_REP_width ;
   H12  =     0.06053587643791 * S_LOG_REP_IMP_price
          +      0.0008309684403 * S_LOG_REP_compression_ratio
          +     0.10954404329148 * S_LOG_REP_engine_size
          +    -0.15328263161893 * S_REP_IMP_bore  +      0.3532849519374 *
        S_REP_IMP_stroke  +    -0.15402746977116 * S_REP_city_mpg
          +     0.08110850880681 * S_REP_curb_weight
          +      0.1651911585853 * S_REP_height  +    -0.32984368998018 *
        S_REP_highway_mpg  +     0.18550754810975 * S_REP_horsepower
          +     0.41047827319029 * S_REP_length  +     0.63048066732644 *
        S_REP_peak_rpm  +    -0.29989205901953 * S_REP_wheel_base
          +     -0.1141373130746 * S_REP_width ;
   H13  =    -0.12651763973835 * S_LOG_REP_IMP_price
          +     0.02916610158425 * S_LOG_REP_compression_ratio
          +    -0.35464297055318 * S_LOG_REP_engine_size
          +    -0.46861794622827 * S_REP_IMP_bore  +    -0.02615304729098 *
        S_REP_IMP_stroke  +    -0.62348817252786 * S_REP_city_mpg
          +    -0.40578479144999 * S_REP_curb_weight
          +    -0.07842498208478 * S_REP_height  +     0.04009867443631 *
        S_REP_highway_mpg  +    -0.15410203402429 * S_REP_horsepower
          +     0.56826194006802 * S_REP_length  +    -0.18451746998248 *
        S_REP_peak_rpm  +    -0.85455873337219 * S_REP_wheel_base
          +     0.42143506757855 * S_REP_width ;
   H14  =    -0.14040869686762 * S_LOG_REP_IMP_price
          +     0.26990612353105 * S_LOG_REP_compression_ratio
          +     0.08219740713507 * S_LOG_REP_engine_size
          +    -0.28143237638041 * S_REP_IMP_bore  +     0.00240833621272 *
        S_REP_IMP_stroke  +     0.36691424782401 * S_REP_city_mpg
          +     0.05296966762507 * S_REP_curb_weight
          +    -0.25195594241151 * S_REP_height  +     -0.2869086713551 *
        S_REP_highway_mpg  +     0.10149659867121 * S_REP_horsepower
          +     -0.1051173203177 * S_REP_length  +     -0.3623925092356 *
        S_REP_peak_rpm  +      0.0608651450636 * S_REP_wheel_base
          +     0.01925376907658 * S_REP_width ;
   H11  = H11  +    -0.14261512916098 * M_bore0  +    -0.15389501961531 *
        M_num_of_doors0  +     0.35584066469033 * M_price0
          +     0.27766950948074 * M_stroke0 ;
   H12  = H12  +    -0.05100694260106 * M_bore0  +     0.06706620637318 *
        M_num_of_doors0  +      0.3061805720719 * M_price0
          +     0.12447551805965 * M_stroke0 ;
   H13  = H13  +    -0.24380670225771 * M_bore0  +     0.00690440155477 *
        M_num_of_doors0  +     0.44779145359173 * M_price0
          +    -0.23546408240278 * M_stroke0 ;
   H14  = H14  +     0.27468171274192 * M_bore0  +    -0.08256208447896 *
        M_num_of_doors0  +    -0.00282400944614 * M_price0
          +    -0.06998464230678 * M_stroke0 ;
   H11  = H11  +     1.04565178534847 * IMP_num_of_doors2
          +    -0.19697323559306 * REP_aspirationS  +     0.22441677117341 *
        REP_body_styleC  +    -0.02928079039896 * REP_body_styleH
          +    -0.32302273741455 * REP_body_styleS  +    -0.34785776016975 *
        REP_drive_wheels4  +     0.10897139165566 * REP_drive_wheelsF
          +    -0.04922700305318 * REP_engine_locationF
          +    -0.26217753108901 * REP_fuel_systemnon_spdi
          +    -0.09655321276347 * REP_fuel_typeD  +     0.23776476290772 *
        REP_num_of_cylinders__4  +     0.09807786136518 * engine_typedohc
          +    -0.13265317517425 * engine_typel  +    -0.20346070618898 *
        engine_typeohc  +    -0.38758952222173 * engine_typeohcf
          +    -0.02182861600599 * engine_typeohcv ;
   H12  = H12  +     0.26990643452778 * IMP_num_of_doors2
          +       0.167681754676 * REP_aspirationS  +     0.12265207155474 *
        REP_body_styleC  +     0.01179187263391 * REP_body_styleH
          +    -0.19097006494623 * REP_body_styleS  +     0.02816873649616 *
        REP_drive_wheels4  +     0.00159784165226 * REP_drive_wheelsF
          +    -0.02772792707071 * REP_engine_locationF
          +     0.12038561732288 * REP_fuel_systemnon_spdi
          +    -0.14129190020361 * REP_fuel_typeD  +     0.19062991356263 *
        REP_num_of_cylinders__4  +     0.24458965384513 * engine_typedohc
          +     0.06535466491026 * engine_typel  +     0.03320508558174 *
        engine_typeohc  +    -0.18114960783147 * engine_typeohcf
          +    -0.07940214830665 * engine_typeohcv ;
   H13  = H13  +     1.05539312393709 * IMP_num_of_doors2
          +     0.12429838443133 * REP_aspirationS  +     0.40169612542437 *
        REP_body_styleC  +    -0.09868938303023 * REP_body_styleH
          +      0.2376441839816 * REP_body_styleS  +     0.13697634714208 *
        REP_drive_wheels4  +     0.10951824489242 * REP_drive_wheelsF
          +    -0.39061918168859 * REP_engine_locationF
          +    -0.35137171605866 * REP_fuel_systemnon_spdi
          +    -0.02185171430754 * REP_fuel_typeD  +    -0.09138285511683 *
        REP_num_of_cylinders__4  +     0.03269731016982 * engine_typedohc
          +     0.05515310047148 * engine_typel  +     0.73759347527352 *
        engine_typeohc  +    -0.25108559978843 * engine_typeohcf
          +    -0.04350517211887 * engine_typeohcv ;
   H14  = H14  +    -0.02666661002825 * IMP_num_of_doors2
          +     0.23388455289343 * REP_aspirationS  +     0.14743723464082 *
        REP_body_styleC  +      0.0123336113796 * REP_body_styleH
          +     0.09096512684108 * REP_body_styleS  +     0.10317954156915 *
        REP_drive_wheels4  +    -0.02461397967256 * REP_drive_wheelsF
          +     0.23880808113951 * REP_engine_locationF
          +     0.07730157092911 * REP_fuel_systemnon_spdi
          +    -0.18576165929056 * REP_fuel_typeD  +    -0.07768584919964 *
        REP_num_of_cylinders__4  +    -0.12278489872095 * engine_typedohc
          +    -0.11219020348018 * engine_typel  +    -0.25056732048025 *
        engine_typeohc  +     0.04020447734225 * engine_typeohcf
          +    -0.01124754988024 * engine_typeohcv ;
   H11  =     0.16799741694776 + H11 ;
   H12  =     0.36085487833004 + H12 ;
   H13  =     0.92763058157618 + H13 ;
   H14  =     1.24301062195055 + H14 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
   H13  = TANH(H13 );
   H14  = TANH(H14 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
   H13  = .;
   H14  = .;
END;
*** *************************;
*** Writing the Node Risk ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   P_Risk1  =     2.33058130691871 * H11  +      0.6315559780393 * H12
          +     2.68752606098709 * H13  +     -0.1774721562472 * H14 ;
   P_Risk1  =    -0.37783197107417 + P_Risk1 ;
   P_Risk0  = 0;
   _MAX_ = MAX (P_Risk1 , P_Risk0 );
   _SUM_ = 0.;
   P_Risk1  = EXP(P_Risk1  - _MAX_);
   _SUM_ = _SUM_ + P_Risk1 ;
   P_Risk0  = EXP(P_Risk0  - _MAX_);
   _SUM_ = _SUM_ + P_Risk0 ;
   P_Risk1  = P_Risk1  / _SUM_;
   P_Risk0  = P_Risk0  / _SUM_;
END;
ELSE DO;
   P_Risk1  = .;
   P_Risk0  = .;
END;
IF _DM_BAD EQ 1 THEN DO;
   P_Risk1  =                 0.54;
   P_Risk0  =                 0.46;
END;
*** *************************;
*** Writing the I_Risk  AND U_Risk ;
*** *************************;
_MAXP_ = P_Risk1 ;
I_Risk  = "1           " ;
U_Risk  =                    1;
IF( _MAXP_ LT P_Risk0  ) THEN DO;
   _MAXP_ = P_Risk0 ;
   I_Risk  = "0           " ;
   U_Risk  =                    0;
END;
********************************;
*** End Scoring Code for Neural;
********************************;
drop
H11
H12
H13
H14
;
drop S_:;
