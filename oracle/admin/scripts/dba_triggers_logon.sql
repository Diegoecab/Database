--@dba_triggers_logon
set verify off
set lines 600
set pages 2000
col column_name for a30 truncate
col table_owner for a20 truncate
col description for a50 truncate
col triggering_event for a20 truncate
col trigger_body for a180 truncate
col when_clause for a20 truncate
col ACTION_TYPE   for a20 truncate
col TRIGGER_TYPE  for a20 truncate
col OWNER for a20 truncate
col TRIGGER_NAME for a30 truncate

select owner,trigger_name,trigger_type,triggering_event,trigger_body,status,table_owner,
table_name,when_clause,action_type from dba_triggers 
where owner ='SYS' AND TRIGGERING_EVENT LIKE 'LOGON%'
order by 1,2,3
/
