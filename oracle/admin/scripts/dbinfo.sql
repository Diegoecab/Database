--dbinfo.sql
set lines 400
col instance_number for 99
col host_name for a30
col database_status heading "Database|Status" 
set head off


prompt
prompt ***********************************************
prompt Database version:
prompt ***********************************************
prompt
select banner from v$version;

set head on
prompt
prompt ***********************************************
prompt Connected to database:
prompt ***********************************************
prompt
set lines 200
col current_scn for 9999999999999999
select dbid,name,current_scn, created,open_mode,force_logging,database_role,log_mode,archivelog_compression from v$database
/

prompt
prompt ***********************************************
prompt Instances:
prompt ***********************************************
prompt
select * from (
select '*' connected, instance_number,instance_name,host_name,version,startup_time,status, database_status from v$instance a
union 
select  ' ' connected , instance_number,instance_name,host_name,version,startup_time,status, database_status from gv$instance where instance_number <> (select instance_number from v$instance))
order by 2;

