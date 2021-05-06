****************************************************************;
******             DECISION TREE SCORING CODE             ******;
****************************************************************;
 
******         LENGTHS OF NEW CHARACTER VARIABLES         ******;
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
LABEL I_Risk  = 'Into: Risk' ;
LABEL U_Risk  = 'Unnormalized Into: Risk' ;
LABEL _WARN_  = 'Warnings' ;
 
 
******      TEMPORARY VARIABLES FOR FORMATTED VALUES      ******;
LENGTH _ARBFMT_12 $     12; DROP _ARBFMT_12;
_ARBFMT_12 = ' '; /* Initialize to avoid warning. */
 
 
******             ASSIGN OBSERVATION TO NODE             ******;
_ARBFMT_12 = PUT( num_of_doors , BEST12.);
 %DMNORMIP( _ARBFMT_12);
IF _ARBFMT_12 IN ('2' ) THEN DO;
  _NODE_  =                    2;
  _LEAF_  =                    1;
  P_Risk1  =                  0.9;
  P_Risk0  =                  0.1;
  Q_Risk1  =                  0.9;
  Q_Risk0  =                  0.1;
  V_Risk1  =     0.95454545454545;
  V_Risk0  =     0.04545454545454;
  I_Risk  = '1' ;
  U_Risk  =                    1;
  END;
ELSE DO;
  IF  NOT MISSING(height ) AND
    height  <                 51.8 THEN DO;
    _NODE_  =                    6;
    _LEAF_  =                    2;
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
    _NODE_  =                    7;
    _LEAF_  =                    3;
    P_Risk1  =     0.22222222222222;
    P_Risk0  =     0.77777777777777;
    Q_Risk1  =     0.22222222222222;
    Q_Risk0  =     0.77777777777777;
    V_Risk1  =     0.17647058823529;
    V_Risk0  =      0.8235294117647;
    I_Risk  = '0' ;
    U_Risk  =                    0;
    END;
  END;
 
****************************************************************;
******          END OF DECISION TREE SCORING CODE         ******;
****************************************************************;
 
drop _LEAF_;
