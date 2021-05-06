*------------------------------------------------------------*;
* Neural: Create decision matrix;
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
data EM_Neural;
set EMWS1.Impt_TRAIN(keep=
IMP_bore IMP_num_of_doors IMP_price IMP_stroke M_bore M_num_of_doors M_price
M_stroke Risk aspiration body_style city_mpg compression_ratio curb_weight
drive_wheels engine_location engine_size engine_type fuel_system fuel_type
height highway_mpg horsepower length num_of_cylinders peak_rpm wheel_base width );
run;
*------------------------------------------------------------* ;
* Neural: DMDBClass Macro ;
*------------------------------------------------------------* ;
%macro DMDBClass;
    IMP_num_of_doors(ASC) M_bore(ASC) M_num_of_doors(ASC) M_price(ASC)
   M_stroke(ASC) Risk(DESC) aspiration(ASC) body_style(ASC) drive_wheels(ASC)
   engine_location(ASC) engine_type(ASC) fuel_system(ASC) fuel_type(ASC)
   num_of_cylinders(ASC)
%mend DMDBClass;
*------------------------------------------------------------* ;
* Neural: DMDBVar Macro ;
*------------------------------------------------------------* ;
%macro DMDBVar;
    IMP_bore IMP_price IMP_stroke city_mpg compression_ratio curb_weight
   engine_size height highway_mpg horsepower length peak_rpm wheel_base width
%mend DMDBVar;
*------------------------------------------------------------*;
* Neural: Create DMDB;
*------------------------------------------------------------*;
proc dmdb batch data=WORK.EM_Neural
dmdbcat=WORK.Neural_DMDB
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
* Neural: Interval Input Variables Macro ;
*------------------------------------------------------------* ;
%macro INTINPUTS;
    IMP_bore IMP_price IMP_stroke city_mpg compression_ratio curb_weight
   engine_size height highway_mpg horsepower length peak_rpm wheel_base width
%mend INTINPUTS;
*------------------------------------------------------------* ;
* Neural: Binary Inputs Macro ;
*------------------------------------------------------------* ;
%macro BININPUTS;
    M_bore M_num_of_doors M_price M_stroke
%mend BININPUTS;
*------------------------------------------------------------* ;
* Neural: Nominal Inputs Macro ;
*------------------------------------------------------------* ;
%macro NOMINPUTS;
    IMP_num_of_doors aspiration body_style drive_wheels engine_location
   engine_type fuel_system fuel_type num_of_cylinders
%mend NOMINPUTS;
*------------------------------------------------------------* ;
* Neural: Ordinal Inputs Macro ;
*------------------------------------------------------------* ;
%macro ORDINPUTS;

%mend ORDINPUTS;
*------------------------------------------------------------*;
* Neural Network Training;
;
*------------------------------------------------------------*;
proc neural data=EM_Neural dmdbcat=WORK.Neural_DMDB
validdata = EMWS1.Impt_VALIDATE
random=12345
;
nloptions
;
performance alldetails noutilfile;
netopts
decay=0;
input %INTINPUTS / level=interval id=intvl
;
input %BININPUTS / level=nominal id=bin
;
input %NOMINPUTS / level=nominal id=nom
;
target Risk / level=NOMINAL id=Risk
bias
;
arch MLP
Hidden=3
;
save network=EMWS1.Neural_NETWORK.dm_neural;
train Maxiter=50
maxtime=300
Outest=EMWS1.Neural_outest estiter=1
Outfit=EMWS1.Neural_OUTFIT
;
run;
quit;
proc sort data=EMWS1.Neural_OUTFIT(where=(_iter_ ne . and _NAME_="OVERALL")) out=fit_Neural;
by _VAVERR_;
run;
%GLOBAL ITER;
data _null_;
set fit_Neural(obs=1);
call symput('ITER',put(_ITER_, 6.));
run;
data EMWS1.Neural_INITIAL;
set EMWS1.Neural_outest(where=(_ITER_ eq &ITER and _OBJ_ ne .));
run;
*------------------------------------------------------------*;
* Neural Network Model Selection;
;
*------------------------------------------------------------*;
proc neural data=EM_Neural dmdbcat=WORK.Neural_DMDB
validdata = EMWS1.Impt_VALIDATE
network = EMWS1.Neural_NETWORK.dm_neural
random=12345
;
nloptions noprint;
performance alldetails noutilfile;
initial inest=EMWS1.Neural_INITIAL;
train tech=NONE;
code file="H:\746\Decision Tree test\Workspaces\EMWS1\Neural\SCORECODE.sas"
group=Neural
;
;
code file="H:\746\Decision Tree test\Workspaces\EMWS1\Neural\RESIDUALSCORECODE.sas"
group=Neural
residual
;
;
score data=EMWS1.Impt_TRAIN out=_NULL_
outfit=WORK.FIT1
role=TRAIN
outkey=EMWS1.Neural_OUTKEY;
score data=EMWS1.Impt_VALIDATE out=_NULL_
outfit=WORK.FIT2
role=VALID
outkey=EMWS1.Neural_OUTKEY;
run;
quit;
data EMWS1.Neural_OUTFIT;
merge WORK.FIT1 WORK.FIT2;
run;
data EMWS1.Neural_EMESTIMATE;
set EMWS1.Neural_outest;
if _type_ ^in('HESSIAN' 'GRAD');
run;
proc datasets lib=work nolist;
delete EM_Neural;
run;
quit;
