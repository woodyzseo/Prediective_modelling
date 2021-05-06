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
      F_Risk  $ 12
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

      label I_Risk = 'Into: Risk' ;

      label F_Risk = 'From: Risk' ;

      label U_Risk = 'Unnormalized Into: Risk' ;

      label P_Risk1 = 'Predicted: Risk=1' ;

      label R_Risk1 = 'Residual: Risk=1' ;

      label P_Risk0 = 'Predicted: Risk=0' ;

      label R_Risk0 = 'Residual: Risk=0' ;

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
   H11  =     0.14114604923302 * S_LOG_REP_IMP_price
          +     0.22107710355073 * S_LOG_REP_compression_ratio
          +     0.01063730358557 * S_LOG_REP_engine_size
          +    -0.10014119004384 * S_REP_IMP_bore  +    -0.03759863264035 * 
        S_REP_IMP_stroke  +     0.07482450466947 * S_REP_city_mpg
          +    -0.28536465017016 * S_REP_curb_weight
          +     0.11632138704241 * S_REP_height  +     0.24359872537276 * 
        S_REP_highway_mpg  +     0.11053757208758 * S_REP_horsepower
          +    -0.07045784528695 * S_REP_length  +    -0.21762346468185 * 
        S_REP_peak_rpm  +    -0.17325144725852 * S_REP_wheel_base
          +     0.37161591541424 * S_REP_width ;
   H12  =     0.05896220480011 * S_LOG_REP_IMP_price
          +     0.18017576649352 * S_LOG_REP_compression_ratio
          +     0.13666603498983 * S_LOG_REP_engine_size
          +     0.08905307497507 * S_REP_IMP_bore  +     0.08450123024202 * 
        S_REP_IMP_stroke  +      0.0953955201221 * S_REP_city_mpg
          +     0.06997312342759 * S_REP_curb_weight
          +     0.11454978606317 * S_REP_height  +    -0.19856329211228 * 
        S_REP_highway_mpg  +     0.12027932441722 * S_REP_horsepower
          +      0.2974258001212 * S_REP_length  +     0.23235745908363 * 
        S_REP_peak_rpm  +    -0.16918609268289 * S_REP_wheel_base
          +    -0.23250714188118 * S_REP_width ;
   H13  =    -0.12906110115101 * S_LOG_REP_IMP_price
          +    -0.02233821917203 * S_LOG_REP_compression_ratio
          +    -0.35091523886958 * S_LOG_REP_engine_size
          +    -0.41460804807699 * S_REP_IMP_bore  +    -0.24839281719309 * 
        S_REP_IMP_stroke  +    -0.70537276068634 * S_REP_city_mpg
          +    -0.58021382402741 * S_REP_curb_weight
          +    -0.22826753012592 * S_REP_height  +      0.0169914306349 * 
        S_REP_highway_mpg  +     0.10463377560074 * S_REP_horsepower
          +     0.35288922545253 * S_REP_length  +    -0.19481970154693 * 
        S_REP_peak_rpm  +    -0.80556145797505 * S_REP_wheel_base
          +     0.51492976697395 * S_REP_width ;
   H11  = H11  +    -0.09761603527807 * M_bore0  +     0.32345868357271 * 
        M_num_of_doors0  +     0.20084593155895 * M_price0
          +    -0.20994977796409 * M_stroke0 ;
   H12  = H12  +    -0.06788596638774 * M_bore0  +     0.34399071242393 * 
        M_num_of_doors0  +      0.0463196246907 * M_price0
          +    -0.26485643855048 * M_stroke0 ;
   H13  = H13  +    -0.35051306126484 * M_bore0  +    -0.02794915457366 * 
        M_num_of_doors0  +     0.31309425299639 * M_price0
          +    -0.47776887747706 * M_stroke0 ;
   H11  = H11  +     0.06100363905736 * IMP_num_of_doors2
          +     0.10122536313104 * REP_aspirationS  +    -0.17959848113703 * 
        REP_body_styleC  +    -0.39712858179454 * REP_body_styleH
          +     0.04767092759288 * REP_body_styleS  +     0.10233875091231 * 
        REP_drive_wheels4  +    -0.09500800631183 * REP_drive_wheelsF
          +     0.07460109227871 * REP_engine_locationF
          +     0.26300770846072 * REP_fuel_systemnon_spdi
          +     0.23650863802652 * REP_fuel_typeD  +    -0.32049705686665 * 
        REP_num_of_cylinders__4  +     0.06805374196668 * engine_typedohc
          +     0.16364588242528 * engine_typel  +    -0.05913911607092 * 
        engine_typeohc  +     0.18536496535236 * engine_typeohcf
          +    -0.09174498568145 * engine_typeohcv ;
   H12  = H12  +    -0.04288679296194 * IMP_num_of_doors2
          +    -0.09067917550664 * REP_aspirationS  +    -0.00898495387833 * 
        REP_body_styleC  +       0.159812944318 * REP_body_styleH
          +      0.0711141581938 * REP_body_styleS  +     0.10210979168732 * 
        REP_drive_wheels4  +     -0.3538576414303 * REP_drive_wheelsF
          +    -0.16393166907394 * REP_engine_locationF
          +     0.11934989985506 * REP_fuel_systemnon_spdi
          +     0.02352084105235 * REP_fuel_typeD  +    -0.11143166546072 * 
        REP_num_of_cylinders__4  +    -0.10331230763277 * engine_typedohc
          +     0.09972953235323 * engine_typel  +    -0.02037020133855 * 
        engine_typeohc  +    -0.10116492050927 * engine_typeohcf
          +    -0.29902685656789 * engine_typeohcv ;
   H13  = H13  +     0.57885984374832 * IMP_num_of_doors2
          +    -0.06313012281847 * REP_aspirationS  +     0.18273714441841 * 
        REP_body_styleC  +    -0.00453951283747 * REP_body_styleH
          +      0.0466508929301 * REP_body_styleS  +    -0.04931547332574 * 
        REP_drive_wheels4  +     0.07528309204941 * REP_drive_wheelsF
          +    -0.01679674641439 * REP_engine_locationF
          +      -0.148583011616 * REP_fuel_systemnon_spdi
          +     0.01206718731045 * REP_fuel_typeD  +     0.01468742261582 * 
        REP_num_of_cylinders__4  +     0.07027057170791 * engine_typedohc
          +     0.20558093284809 * engine_typel  +     0.55435637562404 * 
        engine_typeohc  +    -0.38590829668888 * engine_typeohcf
          +      0.0022264257698 * engine_typeohcv ;
   H11  =    -0.54817324462785 + H11 ;
   H12  =    -0.46773956921898 + H12 ;
   H13  =     0.60022135338159 + H13 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
   H13  = TANH(H13 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
   H13  = .;
END;
*** *************************;
*** Writing the Node Risk ;
*** *************************;

*** Generate dummy variables for Risk ;
drop Risk1 Risk0 ;
label F_Risk = 'From: Risk' ;
length F_Risk $ 12;
F_Risk = put( Risk , BEST12. );
%DMNORMIP( F_Risk )
if missing( Risk ) then do;
   Risk1 = .;
   Risk0 = .;
end;
else do;
   if F_Risk = '1'  then do;
      Risk1 = 1;
      Risk0 = 0;
   end;
   else if F_Risk = '0'  then do;
      Risk1 = 0;
      Risk0 = 1;
   end;
   else do;
      Risk1 = .;
      Risk0 = .;
   end;
end;
IF _DM_BAD EQ 0 THEN DO;
   P_Risk1  =     1.21348641298657 * H11  +     0.09729650872853 * H12
          +     5.64979482539338 * H13 ;
   P_Risk1  =    -0.00460119400654 + P_Risk1 ;
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
*** *****************************;
*** Writing the Residuals  of the Node Risk ;
*** ******************************;
IF MISSING( Risk1 ) THEN R_Risk1  = . ;
ELSE R_Risk1  = Risk1  - P_Risk1 ;
IF MISSING( Risk0 ) THEN R_Risk0  = . ;
ELSE R_Risk0  = Risk0  - P_Risk0 ;
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
