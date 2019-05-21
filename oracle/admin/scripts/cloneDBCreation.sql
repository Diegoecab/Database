connect "SYS"/"&&sysPassword" as SYSDBA
set echo on
spool /u01/app/oracle/admin/db01/scripts/cloneDBCreation.log
Create controlfile reuse set database "db01"
MAXINSTANCES 8
MAXLOGHISTORY 1
MAXLOGFILES 16
MAXLOGMEMBERS 3
MAXDATAFILES 100
Datafile 
'/u01/app/oracle/oradata/db01/system01.dbf',
'/u01/app/oracle/oradata/db01/undotbs01.dbf',
'/u01/app/oracle/oradata/db01/sysaux01.dbf',
'/u01/app/oracle/oradata/db01/users01.dbf'
LOGFILE GROUP 1 ('/u01/app/oracle/oradata/db01/redo01.log') SIZE 51200K,
GROUP 2 ('/u01/app/oracle/oradata/db01/redo02.log') SIZE 51200K,
GROUP 3 ('/u01/app/oracle/oradata/db01/redo03.log') SIZE 51200K RESETLOGS;
exec dbms_backup_restore.zerodbid(0);
shutdown immediate;
startup nomount pfile="/u01/app/oracle/admin/db01/scripts/initdb01Temp.ora";
Create controlfile reuse set database "db01"
MAXINSTANCES 8
MAXLOGHISTORY 1
MAXLOGFILES 16
MAXLOGMEMBERS 3
MAXDATAFILES 100
Datafile 
'/u01/app/oracle/oradata/db01/system01.dbf',
'/u01/app/oracle/oradata/db01/undotbs01.dbf',
'/u01/app/oracle/oradata/db01/sysaux01.dbf',
'/u01/app/oracle/oradata/db01/users01.dbf'
LOGFILE GROUP 1 ('/u01/app/oracle/oradata/db01/redo01.log') SIZE 51200K,
GROUP 2 ('/u01/app/oracle/oradata/db01/redo02.log') SIZE 51200K,
GROUP 3 ('/u01/app/oracle/oradata/db01/redo03.log') SIZE 51200K RESETLOGS;
alter system enable restricted session;
alter database "db01" open resetlogs;
alter database rename global_name to "db01";
ALTER TABLESPACE TEMP ADD TEMPFILE '/u01/app/oracle/oradata/db01/temp01.dbf' SIZE 20480K REUSE AUTOEXTEND ON NEXT 640K MAXSIZE UNLIMITED;
select tablespace_name from dba_tablespaces where tablespace_name='USERS';
select sid, program, serial#, username from v$session;
alter database character set INTERNAL_CONVERT WE8ISO8859P1;
alter database national character set INTERNAL_CONVERT AL16UTF16;
alter user sys identified by "&&sysPassword";
alter user system identified by "&&systemPassword";
alter system disable restricted session;
