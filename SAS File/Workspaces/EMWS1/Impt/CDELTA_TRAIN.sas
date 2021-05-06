else 
if NAME  = "M_Risk " then do;
   ROLE  ="INPUT";
   LEVEL ="UNARY";
 end;
else 
if NAME  = "M_aspiration " then do;
   ROLE  ="INPUT";
   LEVEL ="UNARY";
 end;
else 
if NAME  = "M_body_style " then do;
   ROLE  ="INPUT";
   LEVEL ="UNARY";
 end;
if NAME = "bore" then delete;
else 
if NAME    = "IMP_bore"  then do;
   ROLE    = "INPUT" ;
   FAMILY  = "" ;
   REPORT  = "N" ;
   LEVEL   = "INTERVAL" ;
   ORDER   = "" ;
end;
else 
if NAME  = "M_bore " then do;
   ROLE  ="INPUT";
   LEVEL ="BINARY";
 end;
else 
if NAME  = "M_city_mpg " then do;
   ROLE  ="INPUT";
   LEVEL ="UNARY";
 end;
else 
if NAME  = "M_compression_ratio " then do;
   ROLE  ="INPUT";
   LEVEL ="UNARY";
 end;
else 
if NAME  = "M_curb_weight " then do;
   ROLE  ="INPUT";
   LEVEL ="UNARY";
 end;
else 
if NAME  = "M_drive_wheels " then do;
   ROLE  ="INPUT";
   LEVEL ="UNARY";
 end;
else 
if NAME  = "M_engine_location " then do;
   ROLE  ="INPUT";
   LEVEL ="UNARY";
 end;
else 
if NAME  = "M_engine_size " then do;
   ROLE  ="INPUT";
   LEVEL ="UNARY";
 end;
else 
if NAME  = "M_engine_type " then do;
   ROLE  ="INPUT";
   LEVEL ="UNARY";
 end;
else 
if NAME  = "M_fuel_system " then do;
   ROLE  ="INPUT";
   LEVEL ="UNARY";
 end;
else 
if NAME  = "M_fuel_type " then do;
   ROLE  ="INPUT";
   LEVEL ="UNARY";
 end;
else 
if NAME  = "M_height " then do;
   ROLE  ="INPUT";
   LEVEL ="UNARY";
 end;
else 
if NAME  = "M_highway_mpg " then do;
   ROLE  ="INPUT";
   LEVEL ="UNARY";
 end;
else 
if NAME  = "M_horsepower " then do;
   ROLE  ="INPUT";
   LEVEL ="UNARY";
 end;
else 
if NAME  = "M_length " then do;
   ROLE  ="INPUT";
   LEVEL ="UNARY";
 end;
else 
if NAME  = "M_num_of_cylinders " then do;
   ROLE  ="INPUT";
   LEVEL ="UNARY";
 end;
if NAME = "num_of_doors" then delete;
else 
if NAME    = "IMP_num_of_doors"  then do;
   ROLE    = "INPUT" ;
   FAMILY  = "" ;
   REPORT  = "N" ;
   LEVEL   = "NOMINAL" ;
   ORDER   = "" ;
end;
else 
if NAME  = "M_num_of_doors " then do;
   ROLE  ="INPUT";
   LEVEL ="BINARY";
 end;
else 
if NAME  = "M_peak_rpm " then do;
   ROLE  ="INPUT";
   LEVEL ="UNARY";
 end;
if NAME = "price" then delete;
else 
if NAME    = "IMP_price"  then do;
   ROLE    = "INPUT" ;
   FAMILY  = "" ;
   REPORT  = "N" ;
   LEVEL   = "INTERVAL" ;
   ORDER   = "" ;
end;
else 
if NAME  = "M_price " then do;
   ROLE  ="INPUT";
   LEVEL ="BINARY";
 end;
if NAME = "stroke" then delete;
else 
if NAME    = "IMP_stroke"  then do;
   ROLE    = "INPUT" ;
   FAMILY  = "" ;
   REPORT  = "N" ;
   LEVEL   = "INTERVAL" ;
   ORDER   = "" ;
end;
else 
if NAME  = "M_stroke " then do;
   ROLE  ="INPUT";
   LEVEL ="BINARY";
 end;
else 
if NAME  = "M_wheel_base " then do;
   ROLE  ="INPUT";
   LEVEL ="UNARY";
 end;
else 
if NAME  = "M_width " then do;
   ROLE  ="INPUT";
   LEVEL ="UNARY";
 end;
