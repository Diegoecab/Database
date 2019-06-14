set serveroutput on
spool c:\cm\scripts\logs\log_recover.log
recover standby database;
AUTO
alter database open read only;
spool off
quit