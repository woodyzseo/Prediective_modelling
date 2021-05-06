*------------------------------------------------------------*;
* Neural2: Create decision matrix;
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
data EM_Neural2;
set EMWS1.Repl2_TRAIN(keep=
IMP_num_of_doors LOG_REP_IMP_price LOG_REP_compression_ratio
LOG_REP_engine_size M_bore M_num_of_doors M_price M_stroke REP_IMP_bore
REP_IMP_stroke REP_aspiration REP_body_style REP_city_mpg REP_curb_weight
REP_drive_wheels REP_engine_location REP_fuel_system REP_fuel_type REP_height
REP_highway_mpg REP_horsepower REP_length REP_num_of_cylinders REP_peak_rpm
REP_wheel_base REP_width Risk engine_type );
run;
*------------------------------------------------------------* ;
* Neural2: DMDBClass Macro ;
*------------------------------------------------------------* ;
%macro DMDBClass;
    IMP_num_of_doors(ASC) M_bore(ASC) M_num_of_doors(ASC) M_price(ASC)
   M_stroke(ASC) REP_aspiration(ASC) REP_body_style(ASC) REP_drive_wheels(ASC)
   REP_engine_location(ASC) REP_fuel_system(ASC) REP_fuel_type(ASC)
   REP_num_of_cylinders(ASC) Risk(DESC) engine_type(ASC)
%mend DMDBClass;
*------------------------------------------------------------* ;
* Neural2: DMDBVar Macro ;
*------------------------------------------------------------* ;
%macro DMDBVar;
    LOG_REP_IMP_price LOG_REP_compression_ratio LOG_REP_engine_size REP_IMP_bore
   REP_IMP_stroke REP_city_mpg REP_curb_weight REP_height REP_highway_mpg
   REP_horsepower REP_length REP_peak_rpm REP_wheel_base REP_width
%mend DMDBVar;
*------------------------------------------------------------*;
* Neural2: Create DMDB;
*------------------------------------------------------------*;
proc dmdb batch data=WORK.EM_Neural2
dmdbcat=WORK.Neural2_DMDB
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
* Neural2: Interval Input Variables Macro ;
*------------------------------------------------------------* ;
%macro INTINPUTS;
    LOG_REP_IMP_price LOG_REP_compression_ratio LOG_REP_engine_size REP_IMP_bore
   REP_IMP_stroke REP_city_mpg REP_curb_weight REP_height REP_highway_mpg
   REP_horsepower REP_length REP_peak_rpm REP_wheel_base REP_width
%mend INTINPUTS;
*------------------------------------------------------------* ;
* Neural2: Binary Inputs Macro ;
*------------------------------------------------------------* ;
%macro BININPUTS;
    M_bore M_num_of_doors M_price M_stroke
%mend BININPUTS;
*------------------------------------------------------------* ;
* Neural2: Nominal Inputs Macro ;
*------------------------------------------------------------* ;
%macro NOMINPUTS;
    IMP_num_of_doors REP_aspiration REP_body_style REP_drive_wheels
   REP_engine_location REP_fuel_system REP_fuel_type REP_num_of_cylinders
   engine_type
%mend NOMINPUTS;
*------------------------------------------------------------* ;
* Neural2: Ordinal Inputs Macro ;
*------------------------------------------------------------* ;
%macro ORDINPUTS;

%mend ORDINPUTS;
*------------------------------------------------------------*;
* Neural Network Training;
;
*------------------------------------------------------------*;
proc neural data=EM_Neural2 dmdbcat=WORK.Neural2_DMDB
validdata = EMWS1.Repl2_VALIDATE
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
save network=EMWS1.Neural2_NETWORK.dm_neural;
train Maxiter=50
maxtime=300
Outest=EMWS1.Neural2_outest estiter=1
Outfit=EMWS1.Neural2_OUTFIT
;
run;
quit;
proc sort data=EMWS1.Neural2_OUTFIT(where=(_iter_ ne . and _NAME_="OVERALL")) out=fit_Neural2;
by _VAVERR_;
run;
%GLOBAL ITER;
data _null_;
set fit_Neural2(obs=1);
call symput('ITER',put(_ITER_, 6.));
run;
data EMWS1.Neural2_INITIAL;
set EMWS1.Neural2_outest(where=(_ITER_ eq &ITER and _OBJ_ ne .));
run;
*------------------------------------------------------------*;
* Neural Network Model Selection;
;
*------------------------------------------------------------*;
proc neural data=EM_Neural2 dmdbcat=WORK.Neural2_DMDB
validdata = EMWS1.Repl2_VALIDATE
network = EMWS1.Neural2_NETWORK.dm_neural
random=12345
;
nloptions noprint;
performance alldetails noutilfile;
initial inest=EMWS1.Neural2_INITIAL;
train tech=NONE;
code file="H:\746\Decision Tree test\Workspaces\EMWS1\Neural2\SCORECODE.sas"
group=Neural2
;
;
code file="H:\746\Decision Tree test\Workspaces\EMWS1\Neural2\RESIDUALSCORECODE.sas"
group=Neural2
residual
;
;
score data=EMWS1.Repl2_TRAIN out=_NULL_
outfit=WORK.FIT1
role=TRAIN
outkey=EMWS1.Neural2_OUTKEY;
score data=EMWS1.Repl2_VALIDATE out=_NULL_
outfit=WORK.FIT2
role=VALID
outkey=EMWS1.Neural2_OUTKEY;
run;
quit;
data EMWS1.Neural2_OUTFIT;
merge WORK.FIT1 WORK.FIT2;
run;
data EMWS1.Neural2_EMESTIMATE;
set EMWS1.Neural2_outest;
if _type_ ^in('HESSIAN' 'GRAD');
run;
proc datasets lib=work nolist;
delete EM_Neural2;
run;
quit;
