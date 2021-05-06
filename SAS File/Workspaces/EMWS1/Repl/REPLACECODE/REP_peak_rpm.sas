* ;
*Variable: peak_rpm;
* ;
Label REP_peak_rpm= 'Replacement: peak-rpm';
REP_peak_rpm= peak_rpm;
if peak_rpm eq . then REP_peak_rpm = .;
else
if peak_rpm<3690.5039457 then REP_peak_rpm=3690.5039457;
else
if peak_rpm>6570.4960543 then REP_peak_rpm=6570.4960543;
