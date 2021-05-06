label LOG_REP_engine_size = 'Transformed: Replacement: engine-size';
if REP_engine_size eq . then LOG_REP_engine_size = .;
else do;
if REP_engine_size + 1 > 0 then LOG_REP_engine_size = log(REP_engine_size + 1);
else LOG_REP_engine_size = .;
end;
