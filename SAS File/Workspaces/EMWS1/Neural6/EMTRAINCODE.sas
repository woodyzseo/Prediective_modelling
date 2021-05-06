*------------------------------------------------------------*;
* Neural6: Create decision matrix;
*------------------------------------------------------------*;
data WORK.Risk;
  length   Risk                             $  32
           COUNT                                8
           DATAPRIOR                            8
           TRAINPRIOR                           8
           DECPRIOR                             8
           DECISION1                            8
           DECISION2                            8
           ;

  label    COUNT="Level Counts"
           DATAPRIOR="Data Proportions"
           TRAINPRIOR="Training Proportions"
           DECPRIOR="Decision Priors"
           DECISION1="1"
           DECISION2="0"
           ;
  format   COUNT 10.
           ;
Risk="1"; COUNT=54; DATAPRIOR=0.55445544554455; TRAINPRIOR=0.54; DECPRIOR=.; DECISION1=1; DECISION2=0;
output;
Risk="0"; COUNT=46; DATAPRIOR=0.44554455445544; TRAINPRIOR=0.46; DECPRIOR=.; DECISION1=0; DECISION2=1;
output;
;
run;
proc datasets lib=work nolist;
modify Risk(type=PROFIT label=Risk);
label DECISION1= '1';
label DECISION2= '0';
run;
quit;
data EM_Neural6;
set EMWS1.Reg2_TRAIN(keep=
IMP_num_of_doors REP_wheel_base REP_width Risk );
run;
*------------------------------------------------------------* ;
* Neural6: DMDBClass Macro ;
*------------------------------------------------------------* ;
%macro DMDBClass;
    IMP_num_of_doors(ASC) Risk(DESC)
%mend DMDBClass;
*------------------------------------------------------------* ;
* Neural6: DMDBVar Macro ;
*------------------------------------------------------------* ;
%macro DMDBVar;
    REP_wheel_base REP_width
%mend DMDBVar;
*------------------------------------------------------------*;
* Neural6: Create DMDB;
*------------------------------------------------------------*;
proc dmdb batch data=WORK.EM_Neural6
dmdbcat=WORK.Neural6_DMDB
maxlevel = 513
;
class %DMDBClass;
var %DMDBVar;
target
Risk
;
run;
quit;
*------------------------------------------------------------* ;
* Neural6: Interval Input Variables Macro ;
*------------------------------------------------------------* ;
%macro INTINPUTS;
    REP_wheel_base REP_width
%mend INTINPUTS;
*------------------------------------------------------------* ;
* Neural6: Binary Inputs Macro ;
*------------------------------------------------------------* ;
%macro BININPUTS;

%mend BININPUTS;
*------------------------------------------------------------* ;
* Neural6: Nominal Inputs Macro ;
*------------------------------------------------------------* ;
%macro NOMINPUTS;
    IMP_num_of_doors
%mend NOMINPUTS;
*------------------------------------------------------------* ;
* Neural6: Ordinal Inputs Macro ;
*------------------------------------------------------------* ;
%macro ORDINPUTS;

%mend ORDINPUTS;
*------------------------------------------------------------*;
* Neural Network Training;
;
*------------------------------------------------------------*;
proc neural data=EM_Neural6 dmdbcat=WORK.Neural6_DMDB
validdata = EMWS1.Reg2_VALIDATE
random=12345
;
nloptions
;
performance alldetails noutilfile;
netopts
decay=0;
input %INTINPUTS / level=interval id=intvl
;
input %NOMINPUTS / level=nominal id=nom
;
target Risk / level=NOMINAL id=Risk
bias
;
arch MLP
Hidden=3
;
save network=EMWS1.Neural6_NETWORK.dm_neural;
train Maxiter=50
maxtime=300
Outest=EMWS1.Neural6_outest estiter=1
Outfit=EMWS1.Neural6_OUTFIT
;
run;
quit;
proc sort data=EMWS1.Neural6_OUTFIT(where=(_iter_ ne . and _NAME_="OVERALL")) out=fit_Neural6;
by _VAVERR_;
run;
%GLOBAL ITER;
data _null_;
set fit_Neural6(obs=1);
call symput('ITER',put(_ITER_, 6.));
run;
data EMWS1.Neural6_INITIAL;
set EMWS1.Neural6_outest(where=(_ITER_ eq &ITER and _OBJ_ ne .));
run;
*------------------------------------------------------------*;
* Neural Network Model Selection;
;
*------------------------------------------------------------*;
proc neural data=EM_Neural6 dmdbcat=WORK.Neural6_DMDB
validdata = EMWS1.Reg2_VALIDATE
network = EMWS1.Neural6_NETWORK.dm_neural
random=12345
;
nloptions noprint;
performance alldetails noutilfile;
initial inest=EMWS1.Neural6_INITIAL;
train tech=NONE;
code file="H:\746\Decision Tree test\Workspaces\EMWS1\Neural6\SCORECODE.sas"
group=Neural6
;
;
code file="H:\746\Decision Tree test\Workspaces\EMWS1\Neural6\RESIDUALSCORECODE.sas"
group=Neural6
residual
;
;
score data=EMWS1.Reg2_TRAIN out=_NULL_
outfit=WORK.FIT1
role=TRAIN
outkey=EMWS1.Neural6_OUTKEY;
score data=EMWS1.Reg2_VALIDATE out=_NULL_
outfit=WORK.FIT2
role=VALID
outkey=EMWS1.Neural6_OUTKEY;
run;
quit;
data EMWS1.Neural6_OUTFIT;
merge WORK.FIT1 WORK.FIT2;
run;
data EMWS1.Neural6_EMESTIMATE;
set EMWS1.Neural6_outest;
if _type_ ^in('HESSIAN' 'GRAD');
run;
proc datasets lib=work nolist;
delete EM_Neural6;
run;
quit;
