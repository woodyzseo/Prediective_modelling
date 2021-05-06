if ROLE in('INPUT', 'REJECTED') then do;
if upcase(NAME) in(
'IMP_NUM_OF_DOORS'
'LOG_REP_ENGINE_SIZE'
'REP_CITY_MPG'
'REP_HIGHWAY_MPG'
'REP_NUM_OF_CYLINDERS'
'REP_WHEEL_BASE'
'REP_WIDTH'
) then ROLE='INPUT';
else do;
ROLE='REJECTED';
COMMENT = "Reg3: Rejected using backward selection";
end;
end;
