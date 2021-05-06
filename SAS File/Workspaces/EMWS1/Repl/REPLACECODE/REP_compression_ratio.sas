* ;
*Variable: compression_ratio;
* ;
Label REP_compression_ratio= 'Replacement: compression-ratio';
REP_compression_ratio= compression_ratio;
if compression_ratio eq . then REP_compression_ratio = .;
else
if compression_ratio<-2.270373854 then REP_compression_ratio=-2.270373854;
else
if compression_ratio>23.020573854 then REP_compression_ratio=23.020573854;
