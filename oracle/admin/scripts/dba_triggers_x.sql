--@dba_triggers_x
set verify off
set linesize 180
set pagesize 2000
col column_name for a30
col table_owner for a20
col description for a50
col triggering_event for a15
col trigger_body for a50
col when_clause for a20

select owner,trigger_name,trigger_type,triggering_event,trigger_body,status,table_owner,
table_name,when_clause,action_type from dba_triggers 
where owner like upper('%&owner%')
and trigger_name like upper('%&trigger_name%')
and table_owner like upper('%&table_name%')
and table_name like upper('%&table_name%')
order by 1,2,3
/
