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
      label S_LOG_REP_engine_size = 'Standard: LOG_REP_engine_size' ;

      label S_REP_city_mpg = 'Standard: REP_city_mpg' ;

      label S_REP_highway_mpg = 'Standard: REP_highway_mpg' ;

      label S_REP_wheel_base = 'Standard: REP_wheel_base' ;

      label S_REP_width = 'Standard: REP_width' ;

      label IMP_num_of_doors2 = 'Dummy: IMP_num_of_doors=2' ;

      label REP_num_of_cylinders__4 = 'Dummy: REP_num_of_cylinders=<=4' ;

      label H11 = 'Hidden: H1=1' ;

      label H12 = 'Hidden: H1=2' ;

      label H13 = 'Hidden: H1=3' ;

      label H14 = 'Hidden: H1=4' ;

      label I_Risk = 'Into: Risk' ;

      label F_Risk = 'From: Risk' ;

      label U_Risk = 'Unnormalized Into: Risk' ;

      label P_Risk1 = 'Predicted: Risk=1' ;

      label R_Risk1 = 'Residual: Risk=1' ;

      label P_Risk0 = 'Predicted: Risk=0' ;

      label R_Risk0 = 'Residual: Risk=0' ;

      label  _WARN_ = "Warnings"; 

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

*** *************************;
*** Checking missing input Interval
*** *************************;

IF NMISS(
   LOG_REP_engine_size , 
   REP_city_mpg , 
   REP_highway_mpg , 
   REP_wheel_base , 
   REP_width   ) THEN DO;
   SUBSTR(_WARN_, 1, 1) = 'M';

   _DM_BAD = 1;
END;
*** *************************;
*** Writing the Node intvl ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   S_LOG_REP_engine_size  =    -19.3053254119757 +     4.02929302984948 * 
        LOG_REP_engine_size ;
   S_REP_city_mpg  =    -4.23279255832632 +     0.16535248553422 * 
        REP_city_mpg ;
   S_REP_highway_mpg  =    -4.99166764925563 +     0.16020006928199 * 
        REP_highway_mpg ;
   S_REP_wheel_base  =    -17.8009087180129 +     0.18059887504832 * 
        REP_wheel_base ;
   S_REP_width  =    -35.9167499004784 +     0.54673628301566 * REP_width ;
END;
ELSE DO;
   IF MISSING( LOG_REP_engine_size ) THEN S_LOG_REP_engine_size  = . ;
   ELSE S_LOG_REP_engine_size
          =    -19.3053254119757 +     4.02929302984948 * LOG_REP_engine_size
         ;
   IF MISSING( REP_city_mpg ) THEN S_REP_city_mpg  = . ;
   ELSE S_REP_city_mpg  =    -4.23279255832632 +     0.16535248553422 * 
        REP_city_mpg ;
   IF MISSING( REP_highway_mpg ) THEN S_REP_highway_mpg  = . ;
   ELSE S_REP_highway_mpg  =    -4.99166764925563 +     0.16020006928199 * 
        REP_highway_mpg ;
   IF MISSING( REP_wheel_base ) THEN S_REP_wheel_base  = . ;
   ELSE S_REP_wheel_base  =    -17.8009087180129 +     0.18059887504832 * 
        REP_wheel_base ;
   IF MISSING( REP_width ) THEN S_REP_width  = . ;
   ELSE S_REP_width  =    -35.9167499004784 +     0.54673628301566 * REP_width
         ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =    -0.08328000130634 * S_LOG_REP_engine_size
          +    -0.27082220070338 * S_REP_city_mpg  +      0.2941277656539 * 
        S_REP_highway_mpg  +    -0.68178399229392 * S_REP_wheel_base
          +    -0.11636373594759 * S_REP_width ;
   H12  =     0.46016954229273 * S_LOG_REP_engine_size
          +     0.58894660671161 * S_REP_city_mpg  +    -0.43707500512519 * 
        S_REP_highway_mpg  +      0.9147558643471 * S_REP_wheel_base
          +    -0.54289170000161 * S_REP_width ;
   H13  =      -0.374774625922 * S_LOG_REP_engine_size
          +     0.64219236202961 * S_REP_city_mpg  +    -0.30604011038026 * 
        S_REP_highway_mpg  +     0.95470269724804 * S_REP_wheel_base
          +    -0.31074571191766 * S_REP_width ;
   H14  =     0.62415466000555 * S_LOG_REP_engine_size
          +     0.40215309156823 * S_REP_city_mpg  +     0.19194164537104 * 
        S_REP_highway_mpg  +     0.42927771554025 * S_REP_wheel_base
          +      0.0470558538138 * S_REP_width ;
   H11  = H11  +     0.86289606388419 * IMP_num_of_doors2
          +     0.48494981900966 * REP_num_of_cylinders__4 ;
   H12  = H12  +    -0.41348646599925 * IMP_num_of_doors2
          +     0.23776642837172 * REP_num_of_cylinders__4 ;
   H13  = H13  +     0.69067623472442 * IMP_num_of_doors2
          +     0.59780083335342 * REP_num_of_cylinders__4 ;
   H14  = H14  +    -0.59899262566557 * IMP_num_of_doors2
          +    -0.37887024673783 * REP_num_of_cylinders__4 ;
   H11  =    -1.20756316808349 + H11 ;
   H12  =    -0.86401445071558 + H12 ;
   H13  =     0.30924578948537 + H13 ;
   H14  =    -0.73462981674119 + H14 ;
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
   P_Risk1  =     1.65496314420086 * H11  +    -2.65462601121748 * H12
          +    -0.84301923521356 * H13  +    -0.77284863209262 * H14 ;
   P_Risk1  =    -0.22714803089239 + P_Risk1 ;
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
