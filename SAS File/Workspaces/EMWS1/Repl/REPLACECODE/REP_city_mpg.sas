* ;
*Variable: city_mpg;
* ;
Label REP_city_mpg= 'Replacement: city-mpg';
REP_city_mpg= city_mpg;
if city_mpg eq . then REP_city_mpg = .;
else
if city_mpg<7.3597447091 then REP_city_mpg=7.3597447091;
else
if city_mpg>43.860255291 then REP_city_mpg=43.860255291;
