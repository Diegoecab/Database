--archive_dest
col dest_id for 99
col dest_name for a20
col destination for a25
col process for a4
col max_connections for 99
col db_unique_name for a15
set lines 900
set pages 1000
select DEST_ID,DEST_NAME,STATUS,DESTINATION,DELAY_MINS,MAX_CONNECTIONS,PROCESS,TRANSMIT_MODE,DB_UNIQUE_NAME,COMPRESSION,APPLIED_SCN,ENCRYPTION from gv$archive_dest 
where status <> 'INACTIVE';

prompt Dataguard Status
select dest_id,status,error from gv$archive_dest
where target='STANDBY';