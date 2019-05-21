Select d.value as disco,
m.value as memoria,
(d.value/m.value) * 100 as razon
from v$sysstat d, v$sysstat m
where d.name = 'sorts (disk)'
and m.name = 'sorts (memory)';

Si el resultado de la razón sobrepasa el 5% puede pensarse aumentar el valor para los parámetros SORT_AREA_SIZE o PGA_AGREGATE_TARGET.