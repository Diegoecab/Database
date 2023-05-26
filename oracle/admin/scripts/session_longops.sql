--
-- Use Longops To Check The Estimation Runtime
--v$session_longops
--Una operacion aparece en esta vista si:
--la ejecución demora más de 6 segundos y tiene que leer más de 10.000 bloques de la tabla (Entre otros criterios)



set pagesize 2000
set linesize 500
set feedback off
set verify off

col operation for a100
col opname for a12
col sid for 99999
col units for a6
col target for a20
col elap_mins for 999
col tot_min heading for 999
col pct heading '%' for 999

SELECT inst_id, sid, start_time, round(elapsed_seconds/60,1) ELAP_MINS, round(time_remaining/60,1) REM_MINS, 
round((time_remaining+elapsed_seconds)/60,1) tot_min, round((sofar/totalwork)* 100,1) pct, message operation
FROM gv$session_longops
WHERE sofar<>totalwork
AND time_remaining <> '0'
and sid like '%&sid%'
order by 1,3;
