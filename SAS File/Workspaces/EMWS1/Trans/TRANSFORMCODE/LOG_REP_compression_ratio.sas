label LOG_REP_compression_ratio = 'Transformed: Replacement: compression-ratio';
if REP_compression_ratio eq . then LOG_REP_compression_ratio = .;
else do;
if REP_compression_ratio + 1 > 0 then LOG_REP_compression_ratio = log(REP_compression_ratio + 1);
else LOG_REP_compression_ratio = .;
end;
