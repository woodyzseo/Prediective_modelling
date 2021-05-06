format IMP_price BEST12.0;
label IMP_price = 'Imputed price';
IMP_price = price;
if missing(price) then IMP_price = 12773.191919;
