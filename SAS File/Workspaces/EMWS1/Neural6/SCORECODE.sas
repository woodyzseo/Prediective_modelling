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
      label S_REP_wheel_base = 'Standard: REP_wheel_base' ;

      label S_REP_width = 'Standard: REP_width' ;

      label IMP_num_of_doors2 = 'Dummy: IMP_num_of_doors=2' ;

      label H11 = 'Hidden: H1=1' ;

      label H12 = 'Hidden: H1=2' ;

      label H13 = 'Hidden: H1=3' ;

      label I_Risk = 'Into: Risk' ;

      label U_Risk = 'Unnormalized Into: Risk' ;

      label P_Risk1 = 'Predicted: Risk=1' ;

      label P_Risk0 = 'Predicted: Risk=0' ;

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
   H11  =     1.17971602991529 * S_REP_wheel_base  +    -0.85559527755077 * 
        S_REP_width ;
   H12  =    -0.09772291964712 * S_REP_wheel_base  +    -0.07614209635768 * 
        S_REP_width ;
   H13  =     2.82903009287067 * S_REP_wheel_base  +     0.46121997965333 * 
        S_REP_width ;
   H11  = H11  +      -0.657978104242 * IMP_num_of_doors2 ;
   H12  = H12  +     0.43899673417964 * IMP_num_of_doors2 ;
   H13  = H13  +    -0.15379809694931 * IMP_num_of_doors2 ;
   H11  =    -0.75862147096058 + H11 ;
   H12  =    -1.45817796345304 + H12 ;
   H13  =     2.76129267174358 + H13 ;
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
   P_Risk1  =    -3.44898702114775 * H11  +    -0.12865972708795 * H12
          +    -2.79874286198315 * H13 ;
   P_Risk1  =     1.11128852213644 + P_Risk1 ;
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
