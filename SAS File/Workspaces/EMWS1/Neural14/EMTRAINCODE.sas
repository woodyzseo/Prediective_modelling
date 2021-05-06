*------------------------------------------------------------*;
* Neural14: Create decision matrix;
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
data EM_Neural14;
set EMWS1.Reg4_TRAIN(keep=
IMP_num_of_doors REP_wheel_base REP_width Risk );
run;
*------------------------------------------------------------* ;
* Neural14: DMDBClass Macro ;
*------------------------------------------------------------* ;
%macro DMDBClass;
    IMP_num_of_doors(ASC) Risk(DESC)
%mend DMDBClass;
*------------------------------------------------------------* ;
* Neural14: DMDBVar Macro ;
*------------------------------------------------------------* ;
%macro DMDBVar;
    REP_wheel_base REP_width
%mend DMDBVar;
*------------------------------------------------------------*;
* Neural14: Create DMDB;
*------------------------------------------------------------*;
proc dmdb batch data=WORK.EM_Neural14
dmdbcat=WORK.Neural14_DMDB
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
* Neural14: Interval Input Variables Macro ;
*------------------------------------------------------------* ;
%macro INTINPUTS;
    REP_wheel_base REP_width
%mend INTINPUTS;
*------------------------------------------------------------* ;
* Neural14: Binary Inputs Macro ;
*------------------------------------------------------------* ;
%macro BININPUTS;

%mend BININPUTS;
*------------------------------------------------------------* ;
* Neural14: Nominal Inputs Macro ;
*------------------------------------------------------------* ;
%macro NOMINPUTS;
    IMP_num_of_doors
%mend NOMINPUTS;
*------------------------------------------------------------* ;
* Neural14: Ordinal Inputs Macro ;
*------------------------------------------------------------* ;
%macro ORDINPUTS;

%mend ORDINPUTS;
*------------------------------------------------------------*;
* Neural Network Training;
;
*------------------------------------------------------------*;
proc neural data=EM_Neural14 dmdbcat=WORK.Neural14_DMDB
validdata = EMWS1.Reg4_VALIDATE
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
Hidden=4
;
save network=EMWS1.Neural14_NETWORK.dm_neural;
train Maxiter=50
maxtime=300
Outest=EMWS1.Neural14_outest estiter=1
Outfit=EMWS1.Neural14_OUTFIT
;
run;
quit;
proc sort data=EMWS1.Neural14_OUTFIT(where=(_iter_ ne . and _NAME_="OVERALL")) out=fit_Neural14;
by _VAVERR_;
run;
%GLOBAL ITER;
data _null_;
set fit_Neural14(obs=1);
call symput('ITER',put(_ITER_, 6.));
run;
data EMWS1.Neural14_INITIAL;
set EMWS1.Neural14_outest(where=(_ITER_ eq &ITER and _OBJ_ ne .));
run;
*------------------------------------------------------------*;
* Neural Network Model Selection;
;
*------------------------------------------------------------*;
proc neural data=EM_Neural14 dmdbcat=WORK.Neural14_DMDB
validdata = EMWS1.Reg4_VALIDATE
network = EMWS1.Neural14_NETWORK.dm_neural
random=12345
;
nloptions noprint;
performance alldetails noutilfile;
initial inest=EMWS1.Neural14_INITIAL;
train tech=NONE;
code file="H:\746\Decision Tree test\Workspaces\EMWS1\Neural14\SCORECODE.sas"
group=Neural14
;
;
code file="H:\746\Decision Tree test\Workspaces\EMWS1\Neural14\RESIDUALSCORECODE.sas"
group=Neural14
residual
;
;
score data=EMWS1.Reg4_TRAIN out=_NULL_
outfit=WORK.FIT1
role=TRAIN
outkey=EMWS1.Neural14_OUTKEY;
score data=EMWS1.Reg4_VALIDATE out=_NULL_
outfit=WORK.FIT2
role=VALID
outkey=EMWS1.Neural14_OUTKEY;
run;
quit;
data EMWS1.Neural14_OUTFIT;
merge WORK.FIT1 WORK.FIT2;
run;
data EMWS1.Neural14_EMESTIMATE;
set EMWS1.Neural14_outest;
if _type_ ^in('HESSIAN' 'GRAD');
run;
proc datasets lib=work nolist;
delete EM_Neural14;
run;
quit;
