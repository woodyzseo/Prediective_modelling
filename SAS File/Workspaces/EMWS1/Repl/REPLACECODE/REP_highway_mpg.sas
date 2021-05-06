* ;
*Variable: highway_mpg;
* ;
Label REP_highway_mpg= 'Replacement: highway-mpg';
REP_highway_mpg= highway_mpg;
if highway_mpg eq . then REP_highway_mpg = .;
else
if highway_mpg<12.423938514 then REP_highway_mpg=12.423938514;
else
if highway_mpg>49.896061486 then REP_highway_mpg=49.896061486;
