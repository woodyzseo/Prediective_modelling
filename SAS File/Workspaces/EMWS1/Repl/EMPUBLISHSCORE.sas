* ;
* Variable: IMP_bore ;
* ;
Label REP_IMP_bore='Replacement: Imputed bore';
REP_IMP_bore =IMP_bore ;
if IMP_bore  eq . then REP_IMP_bore = . ;
else
if IMP_bore <2.5610632332  then REP_IMP_bore  = 2.5610632332 ;
else
if IMP_bore >4.0442428893  then REP_IMP_bore  = 4.0442428893 ;
* ;
* Variable: IMP_price ;
* ;
Label REP_IMP_price='Replacement: Imputed price';
REP_IMP_price =IMP_price ;
if IMP_price  eq . then REP_IMP_price = . ;
else
if IMP_price <-8881.562846  then REP_IMP_price  = -8881.562846 ;
else
if IMP_price >34427.946684  then REP_IMP_price  = 34427.946684 ;
* ;
* Variable: IMP_stroke ;
* ;
Label REP_IMP_stroke='Replacement: Imputed stroke';
REP_IMP_stroke =IMP_stroke ;
if IMP_stroke  eq . then REP_IMP_stroke = . ;
else
if IMP_stroke <2.3537374593  then REP_IMP_stroke  = 2.3537374593 ;
else
if IMP_stroke >4.148915602  then REP_IMP_stroke  = 4.148915602 ;
* ;
* Variable: city_mpg ;
* ;
Label REP_city_mpg='Replacement: city-mpg';
REP_city_mpg =city_mpg ;
if city_mpg  eq . then REP_city_mpg = . ;
else
if city_mpg <7.3597447091  then REP_city_mpg  = 7.3597447091 ;
else
if city_mpg >43.860255291  then REP_city_mpg  = 43.860255291 ;
* ;
* Variable: compression_ratio ;
* ;
Label REP_compression_ratio='Replacement: compression-ratio';
REP_compression_ratio =compression_ratio ;
if compression_ratio  eq . then REP_compression_ratio = . ;
else
if compression_ratio <-2.270373854  then REP_compression_ratio  = -2.270373854 ;
else
if compression_ratio >23.020573854  then REP_compression_ratio  = 23.020573854 ;
* ;
* Variable: curb_weight ;
* ;
Label REP_curb_weight='Replacement: curb-weight';
REP_curb_weight =curb_weight ;
if curb_weight  eq . then REP_curb_weight = . ;
else
if curb_weight <1095.8998842  then REP_curb_weight  = 1095.8998842 ;
else
if curb_weight >3938.8001158  then REP_curb_weight  = 3938.8001158 ;
* ;
* Variable: engine_size ;
* ;
Label REP_engine_size='Replacement: engine-size';
REP_engine_size =engine_size ;
if engine_size  eq . then REP_engine_size = . ;
else
if engine_size <20.507238043  then REP_engine_size  = 20.507238043 ;
else
if engine_size >226.83276196  then REP_engine_size  = 226.83276196 ;
* ;
* Variable: height ;
* ;
Label REP_height='Replacement: height';
REP_height =height ;
if height  eq . then REP_height = . ;
else
if height <46.545892936  then REP_height  = 46.545892936 ;
else
if height >61.328107064  then REP_height  = 61.328107064 ;
* ;
* Variable: highway_mpg ;
* ;
Label REP_highway_mpg='Replacement: highway-mpg';
REP_highway_mpg =highway_mpg ;
if highway_mpg  eq . then REP_highway_mpg = . ;
else
if highway_mpg <12.423938514  then REP_highway_mpg  = 12.423938514 ;
else
if highway_mpg >49.896061486  then REP_highway_mpg  = 49.896061486 ;
* ;
* Variable: horsepower ;
* ;
Label REP_horsepower='Replacement: horsepower';
REP_horsepower =horsepower ;
if horsepower  eq . then REP_horsepower = . ;
else
if horsepower <-9.271451561  then REP_horsepower  = -9.271451561 ;
else
if horsepower >210.11145156  then REP_horsepower  = 210.11145156 ;
* ;
* Variable: length ;
* ;
Label REP_length='Replacement: length';
REP_length =length ;
if length  eq . then REP_length = . ;
else
if length <139.36573105  then REP_length  = 139.36573105 ;
else
if length >207.69426895  then REP_length  = 207.69426895 ;
* ;
* Variable: peak_rpm ;
* ;
Label REP_peak_rpm='Replacement: peak-rpm';
REP_peak_rpm =peak_rpm ;
if peak_rpm  eq . then REP_peak_rpm = . ;
else
if peak_rpm <3690.5039457  then REP_peak_rpm  = 3690.5039457 ;
else
if peak_rpm >6570.4960543  then REP_peak_rpm  = 6570.4960543 ;
* ;
* Variable: wheel_base ;
* ;
Label REP_wheel_base='Replacement: wheel-base';
REP_wheel_base =wheel_base ;
if wheel_base  eq . then REP_wheel_base = . ;
else
if wheel_base <81.954600847  then REP_wheel_base  = 81.954600847 ;
else
if wheel_base >115.17739915  then REP_wheel_base  = 115.17739915 ;
* ;
* Variable: width ;
* ;
Label REP_width='Replacement: width';
REP_width =width ;
if width  eq . then REP_width = . ;
else
if width <60.189403674  then REP_width  = 60.189403674 ;
else
if width >71.200596326  then REP_width  = 71.200596326 ;
