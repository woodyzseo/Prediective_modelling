label M_price = "Imputation Indicator for price";
if missing(price) then M_price = 1;
else M_price= 0;
