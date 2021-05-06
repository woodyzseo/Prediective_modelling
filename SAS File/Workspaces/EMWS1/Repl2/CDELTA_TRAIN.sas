if NAME="aspiration" then ROLE="REJECTED";
else
if NAME="REP_aspiration" then do;
ROLE="INPUT";
LEVEL="NOMINAL";
end;
else
if NAME="body_style" then ROLE="REJECTED";
else
if NAME="REP_body_style" then do;
ROLE="INPUT";
LEVEL="NOMINAL";
end;
else
if NAME="drive_wheels" then ROLE="REJECTED";
else
if NAME="REP_drive_wheels" then do;
ROLE="INPUT";
LEVEL="NOMINAL";
end;
else
if NAME="engine_location" then ROLE="REJECTED";
else
if NAME="REP_engine_location" then do;
ROLE="INPUT";
LEVEL="NOMINAL";
end;
else
if NAME="fuel_system" then ROLE="REJECTED";
else
if NAME="REP_fuel_system" then do;
ROLE="INPUT";
LEVEL="NOMINAL";
end;
else
if NAME="fuel_type" then ROLE="REJECTED";
else
if NAME="REP_fuel_type" then do;
ROLE="INPUT";
LEVEL="NOMINAL";
end;
else
if NAME="num_of_cylinders" then ROLE="REJECTED";
else
if NAME="REP_num_of_cylinders" then do;
ROLE="INPUT";
LEVEL="NOMINAL";
end;
