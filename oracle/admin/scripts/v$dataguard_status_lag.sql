--v$dataguard_status_lag

SELECT name, value,substr(value,2,2) DIA, substr(value,5,2) HORA,
substr(value,8,2) MIN,substr(value,11,2) SEG, unit, time_computed 
FROM V$DATAGUARD_STATS 
WHERE name like '%lag'
/