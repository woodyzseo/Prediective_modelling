format IMP_stroke BEST12.0;
label IMP_stroke = 'Imputed stroke';
IMP_stroke = stroke;
if missing(stroke) then IMP_stroke = 3.2513265306;
