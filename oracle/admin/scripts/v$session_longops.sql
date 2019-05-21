--Tiempo de ejecución de operaciones en la base de datos
-- Use Longops To Check The Estimation Runtime
--v$session_longops
--Una operacion aparece en esta vista si:
--la ejecución demora más de 6 segundos y tiene que leer más de 10.000 bloques de la tabla (Entre otros criterios)

COLUMN SID NEW_VALUE MGRVAR NOPRINT
TTITLE LEFT 'SID: ' MGRVAR SKIP 2
BREAK ON SID SKIP PAGE
BTITLE OFF


set pagesize 20
set linesize 400
set feedback off
set verify off

col operacion heading 'Operacion' for a90
col opname for a12
col sid for 999
col units for a6
col target for a20
col elap_mins heading 'Minutos|Transc' for 999
col rem_mins heading 'Minutos|Restantes'
col tot_min heading 'Total|Min' for 999
col porcen heading '%' for 99
col start_time heading 'Fecha|Inicio'

SELECT sid, start_time, round(elapsed_seconds/60,1) ELAP_MINS, round(time_remaining/60,1) REM_MINS, 
round((time_remaining+elapsed_seconds)/60,1) tot_min, round((sofar/totalwork)* 100,1) porcen, message Operacion
FROM v$session_longops
WHERE sofar<>totalwork
AND time_remaining <> '0'
and sid like '%&sid%';

CLEAR COLUMNS
CLEAR BREAKS
CLEAR COMPUTES
ttitle off
set feedback on
