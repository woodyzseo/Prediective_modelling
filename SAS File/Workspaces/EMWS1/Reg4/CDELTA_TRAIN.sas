if ROLE in('INPUT', 'REJECTED') then do;
if upcase(NAME) in(
'IMP_NUM_OF_DOORS'
'REP_WHEEL_BASE'
'REP_WIDTH'
) then ROLE='INPUT';
else do;
ROLE='REJECTED';
COMMENT = "Reg4: Rejected using stepwise selection";
end;
end;
