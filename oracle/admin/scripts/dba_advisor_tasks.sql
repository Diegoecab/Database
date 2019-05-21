--dba_advisor_tasks


set linesize 400
set pagesize 50000
set verify off
col description for a80
col task_name for a30
col pct_completion_time for 999
col task_id for 9999999
ttitle 'Advisor Id'
select distinct advisor_id,advisor_name from dba_advisor_tasks
/
ttitle off
col owner new_value owner noprint
ttitle left 'Owner: ' owner skip 1
break on owner skip page
btitle off
accept ADVISORID prompt 'Ingrese advisor id: '
select owner,task_id,task_name,description,created,status,pct_completion_time,execution_start,execution_end from dba_advisor_tasks where advisor_id=&ADVISORID 
order by 4;
ttitle off
prompt 
prompt
prompt Ejecutar v$advisor_progress para ver progreso de la tarea
prompt