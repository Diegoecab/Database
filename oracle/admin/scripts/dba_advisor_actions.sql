--dba_advisor_actions.sql

col status_message for a50
col error_message for a50
col attr1 for a100
col attr2 for a100
col message for a50

set lines 800
set verify off

select * from dba_advisor_actions
where owner like upper('%&owner%')
and task_id = &task_id
and upper(task_name) like upper('%&task_name%')
 order by task_id
/