--dba_registry_sqlpatch_12
col comp_name for a40
col comp_id for a10
set lines 900
col logfile for a120 truncate
col action_time for a30 truncate
col status for a15 truncate
select install_id, patch_id,  action, status, action_time,logfile,bundle_id from dba_registry_sqlpatch order by action_time;

/*
select bundle_id,action_time from dba_registry_sqlpatch where INSTALL_ID=(select max(INSTALL_ID) from dba_registry_sqlpatch where status='SUCCESS');
*/