/*Este select es para ver la cantidad  en porcent. de veces que se realizo lecturas a disco desde que inicio la instancia.
Lo ideal es que la cantidad sea al menos 95%*/
SELECT mem.value/(disk.value + mem.value) Indicador
FROM v$sysstat mem, v$sysstat disk
WHERE mem.name = 'sorts (memory)'
AND   disk.name = 'sorts (disk)';