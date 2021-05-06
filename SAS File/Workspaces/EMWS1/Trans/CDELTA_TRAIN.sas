*------------------------------------------------------------*;
* Computed Code;
*------------------------------------------------------------*;

if NAME="LOG_REP_IMP_price" then do;
   COMMENT = "log(REP_IMP_price  + 1) ";
ROLE ="INPUT";
REPORT ="N";
LEVEL  ="INTERVAL";
end;
if NAME="REP_IMP_price" then delete;

if NAME="LOG_REP_compression_ratio" then do;
   COMMENT = "log(REP_compression_ratio  + 1) ";
ROLE ="INPUT";
REPORT ="N";
LEVEL  ="INTERVAL";
end;
if NAME="REP_compression_ratio" then delete;

if NAME="LOG_REP_engine_size" then do;
   COMMENT = "log(REP_engine_size  + 1) ";
ROLE ="INPUT";
REPORT ="N";
LEVEL  ="INTERVAL";
end;
if NAME="REP_engine_size" then delete;
