label LOG_REP_IMP_price = 'Transformed: Replacement: Imputed price';
if REP_IMP_price eq . then LOG_REP_IMP_price = .;
else do;
if REP_IMP_price + 1 > 0 then LOG_REP_IMP_price = log(REP_IMP_price + 1);
else LOG_REP_IMP_price = .;
end;
