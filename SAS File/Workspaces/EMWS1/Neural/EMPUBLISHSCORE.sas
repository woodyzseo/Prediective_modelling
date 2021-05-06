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
      label S_IMP_bore = 'Standard: IMP_bore' ;

      label S_IMP_price = 'Standard: IMP_price' ;

      label S_IMP_stroke = 'Standard: IMP_stroke' ;

      label S_city_mpg = 'Standard: city_mpg' ;

      label S_compression_ratio = 'Standard: compression_ratio' ;

      label S_curb_weight = 'Standard: curb_weight' ;

      label S_engine_size = 'Standard: engine_size' ;

      label S_height = 'Standard: height' ;

      label S_highway_mpg = 'Standard: highway_mpg' ;

      label S_horsepower = 'Standard: horsepower' ;

      label S_length = 'Standard: length' ;

      label S_peak_rpm = 'Standard: peak_rpm' ;

      label S_wheel_base = 'Standard: wheel_base' ;

      label S_width = 'Standard: width' ;

      label M_bore0 = 'Dummy: M_bore=0' ;

      label M_num_of_doors0 = 'Dummy: M_num_of_doors=0' ;

      label M_price0 = 'Dummy: M_price=0' ;

      label M_stroke0 = 'Dummy: M_stroke=0' ;

      label IMP_num_of_doors2 = 'Dummy: IMP_num_of_doors=2' ;

      label aspirationstd = 'Dummy: aspiration=std' ;

      label body_styleconvertible = 'Dummy: body_style=convertible' ;

      label body_stylehardtop = 'Dummy: body_style=hardtop' ;

      label body_stylehatchback = 'Dummy: body_style=hatchback' ;

      label body_stylesedan = 'Dummy: body_style=sedan' ;

      label drive_wheels4wd = 'Dummy: drive_wheels=4wd' ;

      label drive_wheelsfwd = 'Dummy: drive_wheels=fwd' ;

      label engine_locationfront = 'Dummy: engine_location=front' ;

      label engine_typedohc = 'Dummy: engine_type=dohc' ;

      label engine_typel = 'Dummy: engine_type=l' ;

      label engine_typeohc = 'Dummy: engine_type=ohc' ;

      label engine_typeohcf = 'Dummy: engine_type=ohcf' ;

      label engine_typeohcv = 'Dummy: engine_type=ohcv' ;

      label fuel_system1bbl = 'Dummy: fuel_system=1bbl' ;

      label fuel_system2bbl = 'Dummy: fuel_system=2bbl' ;

      label fuel_system4bbl = 'Dummy: fuel_system=4bbl' ;

      label fuel_systemidi = 'Dummy: fuel_system=idi' ;

      label fuel_systemmpfi = 'Dummy: fuel_system=mpfi' ;

      label fuel_typediesel = 'Dummy: fuel_type=diesel' ;

      label num_of_cylindersfive = 'Dummy: num_of_cylinders=five' ;

      label num_of_cylindersfour = 'Dummy: num_of_cylinders=four' ;

      label num_of_cylinderssix = 'Dummy: num_of_cylinders=six' ;

      label H11 = 'Hidden: H1=1' ;

      label H12 = 'Hidden: H1=2' ;

      label H13 = 'Hidden: H1=3' ;

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

*** Generate dummy variables for aspiration ;
drop aspirationstd ;
if missing( aspiration ) then do;
   aspirationstd = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm5 $ 5; drop _dm5 ;
   _dm5 = put( aspiration , $5. );
   %DMNORMIP( _dm5 )
   if _dm5 = 'STD'  then do;
      aspirationstd = 1;
   end;
   else if _dm5 = 'TURBO'  then do;
      aspirationstd = -1;
   end;
   else do;
      aspirationstd = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for body_style ;
drop body_styleconvertible body_stylehardtop body_stylehatchback
        body_stylesedan ;
*** encoding is sparse, initialize to zero;
body_styleconvertible = 0;
body_stylehardtop = 0;
body_stylehatchback = 0;
body_stylesedan = 0;
if missing( body_style ) then do;
   body_styleconvertible = .;
   body_stylehardtop = .;
   body_stylehatchback = .;
   body_stylesedan = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm11 $ 11; drop _dm11 ;
   %DMNORMCP( body_style , _dm11 )
   _dm_find = 0; drop _dm_find;
   if _dm11 <= 'HATCHBACK'  then do;
      if _dm11 <= 'HARDTOP'  then do;
         if _dm11 = 'CONVERTIBLE'  then do;
            body_styleconvertible = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm11 = 'HARDTOP'  then do;
               body_stylehardtop = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm11 = 'HATCHBACK'  then do;
            body_stylehatchback = 1;
            _dm_find = 1;
         end;
      end;
   end;
   else do;
      if _dm11 = 'SEDAN'  then do;
         body_stylesedan = 1;
         _dm_find = 1;
      end;
      else do;
         if _dm11 = 'WAGON'  then do;
            body_styleconvertible = -1;
            body_stylehardtop = -1;
            body_stylehatchback = -1;
            body_stylesedan = -1;
            _dm_find = 1;
         end;
      end;
   end;
   if not _dm_find then do;
      body_styleconvertible = .;
      body_stylehardtop = .;
      body_stylehatchback = .;
      body_stylesedan = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for drive_wheels ;
drop drive_wheels4wd drive_wheelsfwd ;
if missing( drive_wheels ) then do;
   drive_wheels4wd = .;
   drive_wheelsfwd = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm3 $ 3; drop _dm3 ;
   %DMNORMCP( drive_wheels , _dm3 )
   if _dm3 = 'FWD'  then do;
      drive_wheels4wd = 0;
      drive_wheelsfwd = 1;
   end;
   else if _dm3 = 'RWD'  then do;
      drive_wheels4wd = -1;
      drive_wheelsfwd = -1;
   end;
   else if _dm3 = '4WD'  then do;
      drive_wheels4wd = 1;
      drive_wheelsfwd = 0;
   end;
   else do;
      drive_wheels4wd = .;
      drive_wheelsfwd = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for engine_location ;
drop engine_locationfront ;
if missing( engine_location ) then do;
   engine_locationfront = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm5 $ 5; drop _dm5 ;
   %DMNORMCP( engine_location , _dm5 )
   if _dm5 = 'FRONT'  then do;
      engine_locationfront = 1;
   end;
   else if _dm5 = 'REAR'  then do;
      engine_locationfront = -1;
   end;
   else do;
      engine_locationfront = .;
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

*** Generate dummy variables for fuel_system ;
drop fuel_system1bbl fuel_system2bbl fuel_system4bbl fuel_systemidi
        fuel_systemmpfi ;
*** encoding is sparse, initialize to zero;
fuel_system1bbl = 0;
fuel_system2bbl = 0;
fuel_system4bbl = 0;
fuel_systemidi = 0;
fuel_systemmpfi = 0;
if missing( fuel_system ) then do;
   fuel_system1bbl = .;
   fuel_system2bbl = .;
   fuel_system4bbl = .;
   fuel_systemidi = .;
   fuel_systemmpfi = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm4 $ 4; drop _dm4 ;
   %DMNORMCP( fuel_system , _dm4 )
   if _dm4 = 'MPFI'  then do;
      fuel_systemmpfi = 1;
   end;
   else if _dm4 = '2BBL'  then do;
      fuel_system2bbl = 1;
   end;
   else if _dm4 = 'IDI'  then do;
      fuel_systemidi = 1;
   end;
   else if _dm4 = '1BBL'  then do;
      fuel_system1bbl = 1;
   end;
   else if _dm4 = 'SPDI'  then do;
      fuel_system1bbl = -1;
      fuel_system2bbl = -1;
      fuel_system4bbl = -1;
      fuel_systemidi = -1;
      fuel_systemmpfi = -1;
   end;
   else if _dm4 = '4BBL'  then do;
      fuel_system4bbl = 1;
   end;
   else do;
      fuel_system1bbl = .;
      fuel_system2bbl = .;
      fuel_system4bbl = .;
      fuel_systemidi = .;
      fuel_systemmpfi = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for fuel_type ;
drop fuel_typediesel ;
if missing( fuel_type ) then do;
   fuel_typediesel = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm6 $ 6; drop _dm6 ;
   %DMNORMCP( fuel_type , _dm6 )
   if _dm6 = 'GAS'  then do;
      fuel_typediesel = -1;
   end;
   else if _dm6 = 'DIESEL'  then do;
      fuel_typediesel = 1;
   end;
   else do;
      fuel_typediesel = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for num_of_cylinders ;
drop num_of_cylindersfive num_of_cylindersfour num_of_cylinderssix ;
if missing( num_of_cylinders ) then do;
   num_of_cylindersfive = .;
   num_of_cylindersfour = .;
   num_of_cylinderssix = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm6 $ 6; drop _dm6 ;
   %DMNORMCP( num_of_cylinders , _dm6 )
   if _dm6 = 'FOUR'  then do;
      num_of_cylindersfive = 0;
      num_of_cylindersfour = 1;
      num_of_cylinderssix = 0;
   end;
   else if _dm6 = 'SIX'  then do;
      num_of_cylindersfive = 0;
      num_of_cylindersfour = 0;
      num_of_cylinderssix = 1;
   end;
   else if _dm6 = 'FIVE'  then do;
      num_of_cylindersfive = 1;
      num_of_cylindersfour = 0;
      num_of_cylinderssix = 0;
   end;
   else if _dm6 = 'TWO'  then do;
      num_of_cylindersfive = -1;
      num_of_cylindersfour = -1;
      num_of_cylinderssix = -1;
   end;
   else do;
      num_of_cylindersfive = .;
      num_of_cylindersfour = .;
      num_of_cylinderssix = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** *************************;
*** Checking missing input Interval
*** *************************;

IF NMISS(
   IMP_bore ,
   IMP_price ,
   IMP_stroke ,
   city_mpg ,
   compression_ratio ,
   curb_weight ,
   engine_size ,
   height ,
   highway_mpg ,
   horsepower ,
   length ,
   peak_rpm ,
   wheel_base ,
   width   ) THEN DO;
   SUBSTR(_WARN_, 1, 1) = 'M';

   _DM_BAD = 1;
END;
*** *************************;
*** Writing the Node intvl ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   S_IMP_bore  =    -13.3604302656684 +     4.04536293034574 * IMP_bore ;
   S_IMP_price  =    -1.76956867778247 +     0.00013853770372 * IMP_price ;
   S_IMP_stroke  =    -10.8668653654577 +     3.34228668303343 * IMP_stroke ;
   S_city_mpg  =    -4.20980412468247 +     0.16438126218986 * city_mpg ;
   S_compression_ratio  =    -2.46137870028453 +     0.23723903386806 *
        compression_ratio ;
   S_curb_weight  =    -5.31291947276211 +     0.00211052077492 * curb_weight
         ;
   S_engine_size  =    -3.59635582610259 +      0.0290802605814 * engine_size
         ;
   S_height  =    -21.8926608140893 +     0.40589318675657 * height ;
   S_highway_mpg  =      -4.989308989555 +     0.16011903047352 * highway_mpg
         ;
   S_horsepower  =    -2.74643097264309 +     0.02734944206973 * horsepower ;
   S_length  =    -15.2378498365576 +     0.08781104037663 * length ;
   S_peak_rpm  =    -10.6885709541859 +     0.00208333904184 * peak_rpm ;
   S_wheel_base  =    -17.8009087180129 +     0.18059887504832 * wheel_base ;
   S_width  =      -35.79721220308 +     0.54490010203333 * width ;
END;
ELSE DO;
   IF MISSING( IMP_bore ) THEN S_IMP_bore  = . ;
   ELSE S_IMP_bore  =    -13.3604302656684 +     4.04536293034574 * IMP_bore ;
   IF MISSING( IMP_price ) THEN S_IMP_price  = . ;
   ELSE S_IMP_price  =    -1.76956867778247 +     0.00013853770372 * IMP_price
         ;
   IF MISSING( IMP_stroke ) THEN S_IMP_stroke  = . ;
   ELSE S_IMP_stroke  =    -10.8668653654577 +     3.34228668303343 *
        IMP_stroke ;
   IF MISSING( city_mpg ) THEN S_city_mpg  = . ;
   ELSE S_city_mpg  =    -4.20980412468247 +     0.16438126218986 * city_mpg ;
   IF MISSING( compression_ratio ) THEN S_compression_ratio  = . ;
   ELSE S_compression_ratio  =    -2.46137870028453 +     0.23723903386806 *
        compression_ratio ;
   IF MISSING( curb_weight ) THEN S_curb_weight  = . ;
   ELSE S_curb_weight  =    -5.31291947276211 +     0.00211052077492 *
        curb_weight ;
   IF MISSING( engine_size ) THEN S_engine_size  = . ;
   ELSE S_engine_size  =    -3.59635582610259 +      0.0290802605814 *
        engine_size ;
   IF MISSING( height ) THEN S_height  = . ;
   ELSE S_height  =    -21.8926608140893 +     0.40589318675657 * height ;
   IF MISSING( highway_mpg ) THEN S_highway_mpg  = . ;
   ELSE S_highway_mpg  =      -4.989308989555 +     0.16011903047352 *
        highway_mpg ;
   IF MISSING( horsepower ) THEN S_horsepower  = . ;
   ELSE S_horsepower  =    -2.74643097264309 +     0.02734944206973 *
        horsepower ;
   IF MISSING( length ) THEN S_length  = . ;
   ELSE S_length  =    -15.2378498365576 +     0.08781104037663 * length ;
   IF MISSING( peak_rpm ) THEN S_peak_rpm  = . ;
   ELSE S_peak_rpm  =    -10.6885709541859 +     0.00208333904184 * peak_rpm ;
   IF MISSING( wheel_base ) THEN S_wheel_base  = . ;
   ELSE S_wheel_base  =    -17.8009087180129 +     0.18059887504832 *
        wheel_base ;
   IF MISSING( width ) THEN S_width  = . ;
   ELSE S_width  =      -35.79721220308 +     0.54490010203333 * width ;
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
   H11  =     0.24764702083622 * S_IMP_bore  +     0.28213326401805 *
        S_IMP_price  +    -0.53879116397667 * S_IMP_stroke
          +    -0.11931132274074 * S_city_mpg  +     0.09567849674331 *
        S_compression_ratio  +      0.1935255149849 * S_curb_weight
          +     -0.0815136152389 * S_engine_size  +     0.16188737913458 *
        S_height  +     0.09695051488223 * S_highway_mpg
          +     0.20225749653559 * S_horsepower  +    -0.07669105060228 *
        S_length  +    -0.47912199175711 * S_peak_rpm
          +     -0.1232784239268 * S_wheel_base  +     0.32967247826106 *
        S_width ;
   H12  =     0.25361356900853 * S_IMP_bore  +    -0.01705220399916 *
        S_IMP_price  +    -0.07011739266761 * S_IMP_stroke
          +       0.079977664863 * S_city_mpg  +    -0.01814747756212 *
        S_compression_ratio  +      0.2849876772342 * S_curb_weight
          +    -0.00397489455247 * S_engine_size  +     0.02719534553776 *
        S_height  +    -0.18309231474003 * S_highway_mpg
          +    -0.06204381675248 * S_horsepower  +     0.30761615298988 *
        S_length  +     0.73467282164771 * S_peak_rpm
          +     0.29150941282208 * S_wheel_base  +     -0.1117321224432 *
        S_width ;
   H13  =    -0.08447128816673 * S_IMP_bore  +    -0.29293151559674 *
        S_IMP_price  +     0.08250304233007 * S_IMP_stroke
          +     -0.9236441200224 * S_city_mpg  +     0.18249944739401 *
        S_compression_ratio  +    -0.41497236958385 * S_curb_weight
          +    -0.56883798262612 * S_engine_size  +    -0.07597879988065 *
        S_height  +     0.10515142048938 * S_highway_mpg
          +     0.15323355736007 * S_horsepower  +     0.18181421956378 *
        S_length  +     0.39257648170384 * S_peak_rpm
          +    -1.37993595763031 * S_wheel_base  +     0.45601171372661 *
        S_width ;
   H11  = H11  +    -0.21919555405402 * M_bore0  +     0.15085903800231 *
        M_num_of_doors0  +    -0.00962570043438 * M_price0
          +    -0.32149134365324 * M_stroke0 ;
   H12  = H12  +    -0.14016461842775 * M_bore0  +     0.25994321831867 *
        M_num_of_doors0  +    -0.12741801834042 * M_price0
          +    -0.31953414263151 * M_stroke0 ;
   H13  = H13  +    -0.37841464171324 * M_bore0  +    -0.06345701158933 *
        M_num_of_doors0  +     0.28477929824556 * M_price0
          +    -0.49429909360858 * M_stroke0 ;
   H11  = H11  +    -0.11477055440116 * IMP_num_of_doors2
          +    -0.07783399585187 * aspirationstd  +    -0.10994675941847 *
        body_styleconvertible  +    -0.13058366982583 * body_stylehardtop
          +    -0.21923114725556 * body_stylehatchback
          +     0.32821169408793 * body_stylesedan  +    -0.14484062500884 *
        drive_wheels4wd  +    -0.30105219504248 * drive_wheelsfwd
          +     0.04181245417934 * engine_locationfront
          +      0.1341639873628 * engine_typedohc  +    -0.13681100308426 *
        engine_typel  +    -0.08003968427127 * engine_typeohc
          +     0.17069702796575 * engine_typeohcf  +    -0.12178525541041 *
        engine_typeohcv  +    -0.07406679737738 * fuel_system1bbl
          +    -0.01476508675057 * fuel_system2bbl  +    -0.02342675380675 *
        fuel_system4bbl  +    -0.07761575246892 * fuel_systemidi
          +     0.07158065221534 * fuel_systemmpfi  +     0.27912180841842 *
        fuel_typediesel  +     0.02562471178527 * num_of_cylindersfive
          +    -0.06116758357011 * num_of_cylindersfour
          +    -0.17869082980453 * num_of_cylinderssix ;
   H12  = H12  +    -0.79950652163205 * IMP_num_of_doors2
          +     0.06022503814421 * aspirationstd  +    -0.03934507532933 *
        body_styleconvertible  +    -0.19719644812026 * body_stylehardtop
          +     0.36229771168581 * body_stylehatchback
          +    -0.30618888006383 * body_stylesedan  +       0.436856065837 *
        drive_wheels4wd  +     0.43174171171681 * drive_wheelsfwd
          +     -0.3194288080945 * engine_locationfront
          +    -0.23077583867824 * engine_typedohc  +     0.01622151793299 *
        engine_typel  +    -0.00141499417135 * engine_typeohc
          +     0.25952209543266 * engine_typeohcf  +      0.0695342349125 *
        engine_typeohcv  +     0.64180901279902 * fuel_system1bbl
          +    -0.16773032066945 * fuel_system2bbl  +     0.12083740596009 *
        fuel_system4bbl  +    -0.01593356166188 * fuel_systemidi
          +    -0.39742729666636 * fuel_systemmpfi  +     0.16035360742573 *
        fuel_typediesel  +     0.12071629234633 * num_of_cylindersfive
          +     0.26750120232856 * num_of_cylindersfour
          +     0.01884923565656 * num_of_cylinderssix ;
   H13  = H13  +     0.33856869861001 * IMP_num_of_doors2
          +     0.03676626235743 * aspirationstd  +    -0.04561129850524 *
        body_styleconvertible  +    -0.04074069227269 * body_stylehardtop
          +     0.04874708222139 * body_stylehatchback
          +     0.05582731740112 * body_stylesedan  +     0.32883828198727 *
        drive_wheels4wd  +     0.22102114241081 * drive_wheelsfwd
          +    -0.19325018746552 * engine_locationfront
          +     0.39226207329319 * engine_typedohc  +    -0.29230716421671 *
        engine_typel  +     0.02671887453383 * engine_typeohc
          +    -0.76511456522233 * engine_typeohcf  +    -0.08642782539104 *
        engine_typeohcv  +    -1.37111302632063 * fuel_system1bbl
          +     0.19046186011514 * fuel_system2bbl  +     0.02802877071491 *
        fuel_system4bbl  +     0.18999405084301 * fuel_systemidi
          +     0.85076189905037 * fuel_systemmpfi  +     0.15524254676424 *
        fuel_typediesel  +      0.3037113350789 * num_of_cylindersfive
          +     0.16318456895222 * num_of_cylindersfour
          +    -0.29369169854782 * num_of_cylinderssix ;
   H11  =     -0.0510449793034 + H11 ;
   H12  =     0.56620299684424 + H12 ;
   H13  =     0.54252266558478 + H13 ;
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
IF _DM_BAD EQ 0 THEN DO;
   P_Risk1  =     0.49314885360637 * H11  +    -3.90210364732559 * H12
          +     5.29550173197034 * H13 ;
   P_Risk1  =     0.56802040802389 + P_Risk1 ;
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
;
drop S_:;
