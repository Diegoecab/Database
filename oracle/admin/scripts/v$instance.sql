set lines 400
col instance_number for 99
col host_name for a30
col database_status heading "Database|Status" 
select instance_number,instance_name,host_name,version,startup_time,status, database_status from v$instance;