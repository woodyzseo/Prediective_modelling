* ;
*Variable: engine_size;
* ;
Label REP_engine_size= 'Replacement: engine-size';
REP_engine_size= engine_size;
if engine_size eq . then REP_engine_size = .;
else
if engine_size<20.507238043 then REP_engine_size=20.507238043;
else
if engine_size>226.83276196 then REP_engine_size=226.83276196;
