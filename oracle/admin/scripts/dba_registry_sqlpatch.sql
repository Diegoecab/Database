--dba_registry_sqlpatch
col comp_name for a40
col comp_id for a10
set lines 900
col logfile for a120 truncate
col action_time for a30 truncate
col status for a15 truncate
select install_id, patch_id,  action, status, action_time,logfile,source_version,target_version from dba_registry_sqlpatch order by action_time;
