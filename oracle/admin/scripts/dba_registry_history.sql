col comp_name for a40
col comp_id for a10
set lines 900
select  action_time, action, version, id from dba_registry_history order by action_time;