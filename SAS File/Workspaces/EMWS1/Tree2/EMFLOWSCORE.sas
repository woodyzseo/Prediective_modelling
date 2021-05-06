****************************************************************;
******             DECISION TREE SCORING CODE             ******;
****************************************************************;
 
******         LENGTHS OF NEW CHARACTER VARIABLES         ******;
LENGTH F_Risk  $   12;
LENGTH I_Risk  $   12;
LENGTH _WARN_  $    4;
 
******              LABELS FOR NEW VARIABLES              ******;
LABEL _NODE_  = 'Node' ;
LABEL _LEAF_  = 'Leaf' ;
LABEL P_Risk1  = 'Predicted: Risk=1' ;
LABEL P_Risk0  = 'Predicted: Risk=0' ;
LABEL Q_Risk1  = 'Unadjusted P: Risk=1' ;
LABEL Q_Risk0  = 'Unadjusted P: Risk=0' ;
LABEL V_Risk1  = 'Validated: Risk=1' ;
LABEL V_Risk0  = 'Validated: Risk=0' ;
LABEL R_Risk1  = 'Residual: Risk=1' ;
LABEL R_Risk0  = 'Residual: Risk=0' ;
LABEL F_Risk  = 'From: Risk' ;
LABEL I_Risk  = 'Into: Risk' ;
LABEL U_Risk  = 'Unnormalized Into: Risk' ;
LABEL _WARN_  = 'Warnings' ;
 
 
******      TEMPORARY VARIABLES FOR FORMATTED VALUES      ******;
LENGTH _ARBFMT_12 $     12; DROP _ARBFMT_12;
_ARBFMT_12 = ' '; /* Initialize to avoid warning. */
LENGTH _ARBFMT_5 $      5; DROP _ARBFMT_5;
_ARBFMT_5 = ' '; /* Initialize to avoid warning. */
 
 
_ARBFMT_12 = PUT( Risk , BEST12.);
 %DMNORMCP( _ARBFMT_12, F_Risk );
 
******             ASSIGN OBSERVATION TO NODE             ******;
_ARBFMT_12 = PUT( num_of_doors , BEST12.);
 %DMNORMIP( _ARBFMT_12);
IF _ARBFMT_12 IN ('2' ) THEN DO;
  IF  NOT MISSING(wheel_base ) AND
                    96.2 <= wheel_base  THEN DO;
    _NODE_  =                    6;
    _LEAF_  =                    2;
    P_Risk1  =     0.73333333333333;
    P_Risk0  =     0.26666666666666;
    Q_Risk1  =     0.73333333333333;
    Q_Risk0  =     0.26666666666666;
    V_Risk1  =     0.86666666666666;
    V_Risk0  =     0.13333333333333;
    I_Risk  = '1' ;
    U_Risk  =                    1;
    END;
  ELSE DO;
    _NODE_  =                    5;
    _LEAF_  =                    1;
    P_Risk1  =                    1;
    P_Risk0  =                    0;
    Q_Risk1  =                    1;
    Q_Risk0  =                    0;
    V_Risk1  =                    1;
    V_Risk0  =                    0;
    I_Risk  = '1' ;
    U_Risk  =                    1;
    END;
  END;
ELSE DO;
  IF  NOT MISSING(height ) AND
    height  <                 51.8 THEN DO;
    _NODE_  =                    7;
    _LEAF_  =                    3;
    P_Risk1  =                    1;
    P_Risk0  =                    0;
    Q_Risk1  =                    1;
    Q_Risk0  =                    0;
    V_Risk1  =                  0.8;
    V_Risk0  =                  0.2;
    I_Risk  = '1' ;
    U_Risk  =                    1;
    END;
  ELSE DO;
    _ARBFMT_5 = PUT( engine_type , $5.);
     %DMNORMIP( _ARBFMT_5);
    IF _ARBFMT_5 IN ('OHC' ) THEN DO;
      _NODE_  =                    9;
      _LEAF_  =                    4;
      P_Risk1  =     0.28571428571428;
      P_Risk0  =     0.71428571428571;
      Q_Risk1  =     0.28571428571428;
      Q_Risk0  =     0.71428571428571;
      V_Risk1  =                 0.25;
      V_Risk0  =                 0.75;
      I_Risk  = '0' ;
      U_Risk  =                    0;
      END;
    ELSE DO;
      _NODE_  =                   10;
      _LEAF_  =                    5;
      P_Risk1  =                    0;
      P_Risk0  =                    1;
      Q_Risk1  =                    0;
      Q_Risk0  =                    1;
      V_Risk1  =     0.05263157894736;
      V_Risk0  =     0.94736842105263;
      I_Risk  = '0' ;
      U_Risk  =                    0;
      END;
    END;
  END;
 
*****  RESIDUALS R_ *************;
IF  F_Risk  NE '1'
AND F_Risk  NE '0'  THEN DO;
        R_Risk1  = .;
        R_Risk0  = .;
 END;
 ELSE DO;
       R_Risk1  =  -P_Risk1 ;
       R_Risk0  =  -P_Risk0 ;
       SELECT( F_Risk  );
          WHEN( '1'  ) R_Risk1  = R_Risk1  +1;
          WHEN( '0'  ) R_Risk0  = R_Risk0  +1;
       END;
 END;
 
****************************************************************;
******          END OF DECISION TREE SCORING CODE         ******;
****************************************************************;
 
drop _LEAF_;
