if upcase(NAME) = "ASPIRATION" then do;
ROLE = "REJECTED";
end;
else 
if upcase(NAME) = "BODY_STYLE" then do;
ROLE = "REJECTED";
end;
else 
if upcase(NAME) = "BORE" then do;
ROLE = "REJECTED";
end;
else 
if upcase(NAME) = "CITY_MPG" then do;
ROLE = "REJECTED";
end;
else 
if upcase(NAME) = "COMPRESSION_RATIO" then do;
ROLE = "REJECTED";
end;
else 
if upcase(NAME) = "CURB_WEIGHT" then do;
ROLE = "REJECTED";
end;
else 
if upcase(NAME) = "DRIVE_WHEELS" then do;
ROLE = "REJECTED";
end;
else 
if upcase(NAME) = "ENGINE_LOCATION" then do;
ROLE = "REJECTED";
end;
else 
if upcase(NAME) = "ENGINE_SIZE" then do;
ROLE = "REJECTED";
end;
else 
if upcase(NAME) = "FUEL_SYSTEM" then do;
ROLE = "REJECTED";
end;
else 
if upcase(NAME) = "FUEL_TYPE" then do;
ROLE = "REJECTED";
end;
else 
if upcase(NAME) = "HIGHWAY_MPG" then do;
ROLE = "REJECTED";
end;
else 
if upcase(NAME) = "HORSEPOWER" then do;
ROLE = "REJECTED";
end;
else 
if upcase(NAME) = "LENGTH" then do;
ROLE = "REJECTED";
end;
else 
if upcase(NAME) = "NUM_OF_CYLINDERS" then do;
ROLE = "REJECTED";
end;
else 
if upcase(NAME) = "PEAK_RPM" then do;
ROLE = "REJECTED";
end;
else 
if upcase(NAME) = "PRICE" then do;
ROLE = "REJECTED";
end;
else 
if upcase(NAME) = "Q_RISK0" then do;
ROLE = "ASSESS";
end;
else 
if upcase(NAME) = "Q_RISK1" then do;
ROLE = "ASSESS";
end;
else 
if upcase(NAME) = "STROKE" then do;
ROLE = "REJECTED";
end;
else 
if upcase(NAME) = "WIDTH" then do;
ROLE = "REJECTED";
end;
else 
if upcase(NAME) = "_NODE_" then do;
ROLE = "SEGMENT";
LEVEL = "NOMINAL";
end;
