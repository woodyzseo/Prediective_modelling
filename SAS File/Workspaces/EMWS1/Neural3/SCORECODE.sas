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
   H11  =    -0.05945014320178 * S_LOG_REP_IMP_price
          +     0.23028408042981 * S_LOG_REP_compression_ratio
          +    -0.55947033299445 * S_LOG_REP_engine_size
          +    -0.14523273532281 * S_REP_IMP_bore  +     0.33601025614724 * 
        S_REP_IMP_stroke  +    -0.88654773082892 * S_REP_city_mpg
          +    -0.51801568326425 * S_REP_curb_weight
          +    -0.05802738940523 * S_REP_height  +    -0.03810113319956 * 
        S_REP_highway_mpg  +     0.03924459552049 * S_REP_horsepower
          +     0.21002997468069 * S_REP_length  +     0.61749212318384 * 
        S_REP_peak_rpm  +    -1.16690362615029 * S_REP_wheel_base
          +     0.56523113334313 * S_REP_width ;
   H12  =    -0.04519390964671 * S_LOG_REP_IMP_price
          +     0.20636780304144 * S_LOG_REP_compression_ratio
          +     0.38610029587113 * S_LOG_REP_engine_size
          +     0.02122891644848 * S_REP_IMP_bore  +     0.72819142903819 * 
        S_REP_IMP_stroke  +     0.45607954634849 * S_REP_city_mpg
          +     0.39788671190423 * S_REP_curb_weight
          +     0.58866221273788 * S_REP_height  +     -0.2991223373507 * 
        S_REP_highway_mpg  +    -0.14997208033764 * S_REP_horsepower
          +     0.19770445044787 * S_REP_length  +     1.03487555197917 * 
        S_REP_peak_rpm  +     0.37505053462771 * S_REP_wheel_base
          +    -0.36159431110716 * S_REP_width ;
   H11  = H11  +    -0.40247462393464 * M_bore0  +    -0.25246866470873 * 
        M_num_of_doors0  +     0.29358262174114 * M_price0
          +    -0.35755285679311 * M_stroke0 ;
   H12  = H12  +     0.08024821292732 * M_bore0  +    -0.06359251950002 * 
        M_num_of_doors0  +    -0.40464698886501 * M_price0
          +    -0.13913068986552 * M_stroke0 ;
   H11  = H11  +     1.06135788272891 * IMP_num_of_doors2
          +    -0.14271127694006 * REP_aspirationS  +     0.36486615758056 * 
        REP_body_styleC  +     0.16638919064823 * REP_body_styleH
          +    -0.20034443648902 * REP_body_styleS  +     0.24076662872441 * 
        REP_drive_wheels4  +     0.26823357856593 * REP_drive_wheelsF
          +     0.01216030599789 * REP_engine_locationF
          +    -0.20794679840242 * REP_fuel_systemnon_spdi
          +    -0.14424463363172 * REP_fuel_typeD  +     0.27719722840907 * 
        REP_num_of_cylinders__4  +      0.4631346933705 * engine_typedohc
          +    -0.00348674456935 * engine_typel  +    -0.09101365786253 * 
        engine_typeohc  +    -0.60243729714628 * engine_typeohcf
          +     0.00552330628134 * engine_typeohcv ;
   H12  = H12  +    -0.26520980153166 * IMP_num_of_doors2
          +    -0.23036271899934 * REP_aspirationS  +    -0.11289541849347 * 
        REP_body_styleC  +     0.29085726156181 * REP_body_styleH
          +    -0.40563301302664 * REP_body_styleS  +    -0.15690978888542 * 
        REP_drive_wheels4  +    -0.04649324093232 * REP_drive_wheelsF
          +     0.19888563265162 * REP_engine_locationF
          +     0.14250615398431 * REP_fuel_systemnon_spdi
          +     0.20472143332967 * REP_fuel_typeD  +     0.22871373636412 * 
        REP_num_of_cylinders__4  +     0.09726112642423 * engine_typedohc
          +    -0.06367563895304 * engine_typel  +    -0.10610223785692 * 
        engine_typeohc  +     0.31078965445942 * engine_typeohcf
          +     -0.0252088697624 * engine_typeohcv ;
   H11  =     1.38027470319246 + H11 ;
   H12  =    -0.62757281657758 + H12 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
END;
*** *************************;
*** Writing the Node Risk ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   P_Risk1  =     2.97301617245243 * H11  +    -2.28437588370032 * H12 ;
   P_Risk1  =     -1.3124328498497 + P_Risk1 ;
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
