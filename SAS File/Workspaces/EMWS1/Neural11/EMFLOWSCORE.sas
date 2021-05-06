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
      label S_REP_wheel_base = 'Standard: REP_wheel_base' ;

      label S_REP_width = 'Standard: REP_width' ;

      label IMP_num_of_doors2 = 'Dummy: IMP_num_of_doors=2' ;

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

*** *************************;
*** Checking missing input Interval
*** *************************;

IF NMISS(
   REP_wheel_base ,
   REP_width   ) THEN DO;
   SUBSTR(_WARN_, 1, 1) = 'M';

   _DM_BAD = 1;
END;
*** *************************;
*** Writing the Node intvl ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   S_REP_wheel_base  =    -17.8009087180129 +     0.18059887504832 *
        REP_wheel_base ;
   S_REP_width  =    -35.9167499004784 +     0.54673628301566 * REP_width ;
END;
ELSE DO;
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
   H11  =    -2.41977886689088 * S_REP_wheel_base  +    -1.09684887135623 *
        S_REP_width ;
   H12  =     1.37973613189109 * S_REP_wheel_base  +    -0.73968554591273 *
        S_REP_width ;
   H13  =     0.89984832557406 * S_REP_wheel_base  +    -0.58516957850016 *
        S_REP_width ;
   H14  =    -0.68214313010923 * S_REP_wheel_base  +     0.61427628584864 *
        S_REP_width ;
   H11  = H11  +     0.22450770283973 * IMP_num_of_doors2 ;
   H12  = H12  +     0.33930246909293 * IMP_num_of_doors2 ;
   H13  = H13  +    -0.61779062410348 * IMP_num_of_doors2 ;
   H14  = H14  +     0.66968699908324 * IMP_num_of_doors2 ;
   H11  =    -2.58375979504889 + H11 ;
   H12  =      0.7942165393337 + H12 ;
   H13  =     0.14814942709658 + H13 ;
   H14  =     0.85518933364214 + H14 ;
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
   P_Risk1  =     2.10698502186864 * H11  +    -1.61641930445614 * H12
          +    -0.65722650486238 * H13  +     3.33888762068555 * H14 ;
   P_Risk1  =     1.27320760040051 + P_Risk1 ;
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
drop
H11
H12
H13
H14
;
drop S_:;
