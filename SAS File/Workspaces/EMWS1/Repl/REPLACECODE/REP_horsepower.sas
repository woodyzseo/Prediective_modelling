* ;
*Variable: horsepower;
* ;
Label REP_horsepower= 'Replacement: horsepower';
REP_horsepower= horsepower;
if horsepower eq . then REP_horsepower = .;
else
if horsepower<-9.271451561 then REP_horsepower=-9.271451561;
else
if horsepower>210.11145156 then REP_horsepower=210.11145156;
