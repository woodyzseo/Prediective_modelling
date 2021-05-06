*------------------------------------------------------------*;
* Reg4: Create decision matrix;
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
data EM_DMREG / view=EM_DMREG;
set EMWS1.Repl2_TRAIN(keep=
IMP_num_of_doors LOG_REP_IMP_price LOG_REP_compression_ratio
LOG_REP_engine_size M_bore M_num_of_doors M_price M_stroke REP_IMP_bore
REP_IMP_stroke REP_aspiration REP_body_style REP_city_mpg REP_curb_weight
REP_drive_wheels REP_engine_location REP_fuel_system REP_fuel_type REP_height
REP_highway_mpg REP_horsepower REP_length REP_num_of_cylinders REP_peak_rpm
REP_wheel_base REP_width Risk engine_type );
run;
*------------------------------------------------------------* ;
* Reg4: DMDBClass Macro ;
*------------------------------------------------------------* ;
%macro DMDBClass;
    IMP_num_of_doors(ASC) M_bore(ASC) M_num_of_doors(ASC) M_price(ASC)
   M_stroke(ASC) REP_aspiration(ASC) REP_body_style(ASC) REP_drive_wheels(ASC)
   REP_engine_location(ASC) REP_fuel_system(ASC) REP_fuel_type(ASC)
   REP_num_of_cylinders(ASC) Risk(DESC) engine_type(ASC)
%mend DMDBClass;
*------------------------------------------------------------* ;
* Reg4: DMDBVar Macro ;
*------------------------------------------------------------* ;
%macro DMDBVar;
    LOG_REP_IMP_price LOG_REP_compression_ratio LOG_REP_engine_size REP_IMP_bore
   REP_IMP_stroke REP_city_mpg REP_curb_weight REP_height REP_highway_mpg
   REP_horsepower REP_length REP_peak_rpm REP_wheel_base REP_width
%mend DMDBVar;
*------------------------------------------------------------*;
* Reg4: Create DMDB;
*------------------------------------------------------------*;
proc dmdb batch data=WORK.EM_DMREG
dmdbcat=WORK.Reg4_DMDB
maxlevel = 513
;
class %DMDBClass;
var %DMDBVar;
target
Risk
;
run;
quit;
*------------------------------------------------------------*;
* Reg4: Run DMREG procedure;
*------------------------------------------------------------*;
proc dmreg data=EM_DMREG dmdbcat=WORK.Reg4_DMDB
validata = EMWS1.Repl2_VALIDATE
outest = EMWS1.Reg4_EMESTIMATE
outterms = EMWS1.Reg4_OUTTERMS
outmap= EMWS1.Reg4_MAPDS namelen=200
;
class
Risk
IMP_num_of_doors
M_bore
M_num_of_doors
M_price
M_stroke
REP_aspiration
REP_body_style
REP_drive_wheels
REP_engine_location
REP_fuel_system
REP_fuel_type
REP_num_of_cylinders
engine_type
;
model Risk =
IMP_num_of_doors
LOG_REP_IMP_price
LOG_REP_compression_ratio
LOG_REP_engine_size
M_bore
M_num_of_doors
M_price
M_stroke
REP_IMP_bore
REP_IMP_stroke
REP_aspiration
REP_body_style
REP_city_mpg
REP_curb_weight
REP_drive_wheels
REP_engine_location
REP_fuel_system
REP_fuel_type
REP_height
REP_highway_mpg
REP_horsepower
REP_length
REP_num_of_cylinders
REP_peak_rpm
REP_wheel_base
REP_width
engine_type
/error=binomial link=LOGIT
coding=DEVIATION
nodesignprint
selection=STEPWISE choose=VERROR
Hierarchy=CLASS
Rule=NONE
;
;
code file="H:\746\Decision Tree test\Workspaces\EMWS1\Reg4\EMPUBLISHSCORE.sas"
group=Reg4
;
code file="H:\746\Decision Tree test\Workspaces\EMWS1\Reg4\EMFLOWSCORE.sas"
group=Reg4
residual
;
run;
quit;
