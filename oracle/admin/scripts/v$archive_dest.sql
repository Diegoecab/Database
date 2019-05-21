--v$archive_dest
col dest_id for 99
col dest_name for a20
col destination for a25
col process for a4
col max_connections for 99
col db_unique_name for a15
select DEST_ID,DEST_NAME,STATUS,DESTINATION,DELAY_MINS,MAX_CONNECTIONS,PROCESS,TRANSMIT_MODE,DB_UNIQUE_NAME from v$archive_dest;