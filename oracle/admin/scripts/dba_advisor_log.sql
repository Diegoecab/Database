--dba_advisor_log.sql
col status_message for a50
col error_message for a50
set lines 400
select * from dba_advisor_log order by task_id
/