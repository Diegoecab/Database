set linesize 180
set verify off
accept SQL_TEXT prompt 'Ingrese %SQL%:  '
select sql_id,sql_text,executions,round(sharable_mem/1024)    "MemKB", elapsed_time,
loads, invalidations from v$sql where UPPER(sql_text) like upper('%&SQL_TEXT%');