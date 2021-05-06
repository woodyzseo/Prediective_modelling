*------------------------------------------------------------*;
* Neural13: Create decision matrix;
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
data EM_Neural13;
set EMWS1.Reg3_TRAIN(keep=
IMP_num_of_doors LOG_REP_engine_size REP_city_mpg REP_highway_mpg
REP_num_of_cylinders REP_wheel_base REP_width Risk );
run;
*------------------------------------------------------------* ;
* Neural13: DMDBClass Macro ;
*------------------------------------------------------------* ;
%macro DMDBClass;
    IMP_num_of_doors(ASC) REP_num_of_cylinders(ASC) Risk(DESC)
%mend DMDBClass;
*------------------------------------------------------------* ;
* Neural13: DMDBVar Macro ;
*------------------------------------------------------------* ;
%macro DMDBVar;
    LOG_REP_engine_size REP_city_mpg REP_highway_mpg REP_wheel_base REP_width
%mend DMDBVar;
*------------------------------------------------------------*;
* Neural13: Create DMDB;
*------------------------------------------------------------*;
proc dmdb batch data=WORK.EM_Neural13
dmdbcat=WORK.Neural13_DMDB
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
* Neural13: Interval Input Variables Macro ;
*------------------------------------------------------------* ;
%macro INTINPUTS;
    LOG_REP_engine_size REP_city_mpg REP_highway_mpg REP_wheel_base REP_width
%mend INTINPUTS;
*------------------------------------------------------------* ;
* Neural13: Binary Inputs Macro ;
*------------------------------------------------------------* ;
%macro BININPUTS;

%mend BININPUTS;
*------------------------------------------------------------* ;
* Neural13: Nominal Inputs Macro ;
*------------------------------------------------------------* ;
%macro NOMINPUTS;
    IMP_num_of_doors REP_num_of_cylinders
%mend NOMINPUTS;
*------------------------------------------------------------* ;
* Neural13: Ordinal Inputs Macro ;
*------------------------------------------------------------* ;
%macro ORDINPUTS;

%mend ORDINPUTS;
*------------------------------------------------------------*;
* Neural Network Training;
;
*------------------------------------------------------------*;
proc neural data=EM_Neural13 dmdbcat=WORK.Neural13_DMDB
validdata = EMWS1.Reg3_VALIDATE
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
save network=EMWS1.Neural13_NETWORK.dm_neural;
train Maxiter=50
maxtime=300
Outest=EMWS1.Neural13_outest estiter=1
Outfit=EMWS1.Neural13_OUTFIT
;
run;
quit;
proc sort data=EMWS1.Neural13_OUTFIT(where=(_iter_ ne . and _NAME_="OVERALL")) out=fit_Neural13;
by _VAVERR_;
run;
%GLOBAL ITER;
data _null_;
set fit_Neural13(obs=1);
call symput('ITER',put(_ITER_, 6.));
run;
data EMWS1.Neural13_INITIAL;
set EMWS1.Neural13_outest(where=(_ITER_ eq &ITER and _OBJ_ ne .));
run;
*------------------------------------------------------------*;
* Neural Network Model Selection;
;
*------------------------------------------------------------*;
proc neural data=EM_Neural13 dmdbcat=WORK.Neural13_DMDB
validdata = EMWS1.Reg3_VALIDATE
network = EMWS1.Neural13_NETWORK.dm_neural
random=12345
;
nloptions noprint;
performance alldetails noutilfile;
initial inest=EMWS1.Neural13_INITIAL;
train tech=NONE;
code file="H:\746\Decision Tree test\Workspaces\EMWS1\Neural13\SCORECODE.sas"
group=Neural13
;
;
code file="H:\746\Decision Tree test\Workspaces\EMWS1\Neural13\RESIDUALSCORECODE.sas"
group=Neural13
residual
;
;
score data=EMWS1.Reg3_TRAIN out=_NULL_
outfit=WORK.FIT1
role=TRAIN
outkey=EMWS1.Neural13_OUTKEY;
score data=EMWS1.Reg3_VALIDATE out=_NULL_
outfit=WORK.FIT2
role=VALID
outkey=EMWS1.Neural13_OUTKEY;
run;
quit;
data EMWS1.Neural13_OUTFIT;
merge WORK.FIT1 WORK.FIT2;
run;
data EMWS1.Neural13_EMESTIMATE;
set EMWS1.Neural13_outest;
if _type_ ^in('HESSIAN' 'GRAD');
run;
proc datasets lib=work nolist;
delete EM_Neural13;
run;
quit;
