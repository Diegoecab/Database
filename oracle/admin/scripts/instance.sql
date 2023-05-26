set lines 400
col instance_number for 99
col host_name for a30
col database_status heading "Database|Status" 
select * from (
select '*' connected, instance_number,logins,instance_name,host_name,version,startup_time,status, database_status from v$instance a
union 
select  ' ' connected , instance_number,logins,instance_name,host_name,version,startup_time,status, database_status from gv$instance where instance_number <> (select instance_number from v$instance))
order by 2;

SHOW CON_NAME
