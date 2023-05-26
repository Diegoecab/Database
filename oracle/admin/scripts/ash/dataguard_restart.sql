Restart the archivers & redo transport on the primary:

sqlplus / as sysdba
sql> alter system set log_archive_dest_state_3=defer sid='*';
sql> show parameter log_archive_max_processes;
sql> alter system set log_archive_max_processes=1 sid='*';
sql> alter system set log_archive_max_processes=<orginal value> sid='*'; >> default is 4
sql> alter system set log_archive_dest_state_3=enable sid='*';
sql> alter system set log_archive_dest_state_2=enable sid='*';
sql> alter system archive log current;
sql> select inst_id,status,error from gv$archive_dest where dest_id in(2,3)