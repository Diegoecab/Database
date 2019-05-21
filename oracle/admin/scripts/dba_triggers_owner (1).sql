set verify off
set linesize 180
set pagesize 2000
col column_name for a20
col table_owner for a10
col description for a20
col triggering_event for a15
col trigger_body for a20
col when_clause for a20
accept OWNER prompt 'Ingrese OWNER: '

select trigger_name,trigger_type,triggering_event,trigger_body,status,table_owner,
table_name,when_clause,action_type from dba_triggers where owner = upper('&OWNER')

/
