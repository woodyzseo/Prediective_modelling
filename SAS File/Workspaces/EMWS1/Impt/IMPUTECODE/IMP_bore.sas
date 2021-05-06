format IMP_bore BEST12.0;
label IMP_bore = 'Imputed bore';
IMP_bore = bore;
if missing(bore) then IMP_bore = 3.3026530612;
