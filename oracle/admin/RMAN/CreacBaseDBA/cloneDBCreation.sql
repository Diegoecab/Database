connect "SYS"/"&&sysPassword" as SYSDBA
set echo on
spool D:\oracle\DBA\Scripts\cloneDBCreation.log
Create controlfile reuse set database "dba"
MAXINSTANCES 8
MAXLOGHISTORY 1
MAXLOGFILES 16
MAXLOGMEMBERS 3
MAXDATAFILES 100
Datafile 
'D:\oracle\DBA\DataFiles\dba\SYSTEM01.DBF',
'D:\oracle\DBA\DataFiles\dba\UNDOTBS01.DBF',
'D:\oracle\DBA\DataFiles\dba\SYSAUX01.DBF',
'D:\oracle\DBA\DataFiles\dba\USERS01.DBF'
LOGFILE GROUP 1 ('D:\oracle\DBA\DataFiles\dba\redo01.log') SIZE 51200K,
GROUP 2 ('D:\oracle\DBA\DataFiles\dba\redo02.log') SIZE 51200K,
GROUP 3 ('D:\oracle\DBA\DataFiles\dba\redo03.log') SIZE 51200K RESETLOGS;
exec dbms_backup_restore.zerodbid(0);
shutdown immediate;
startup nomount pfile="D:\oracle\DBA\Scripts\initdbaTemp.ora";
Create controlfile reuse set database "dba"
MAXINSTANCES 8
MAXLOGHISTORY 1
MAXLOGFILES 16
MAXLOGMEMBERS 3
MAXDATAFILES 100
Datafile 
'D:\oracle\DBA\DataFiles\dba\SYSTEM01.DBF',
'D:\oracle\DBA\DataFiles\dba\UNDOTBS01.DBF',
'D:\oracle\DBA\DataFiles\dba\SYSAUX01.DBF',
'D:\oracle\DBA\DataFiles\dba\USERS01.DBF'
LOGFILE GROUP 1 ('D:\oracle\DBA\DataFiles\dba\redo01.log') SIZE 51200K,
GROUP 2 ('D:\oracle\DBA\DataFiles\dba\redo02.log') SIZE 51200K,
GROUP 3 ('D:\oracle\DBA\DataFiles\dba\redo03.log') SIZE 51200K RESETLOGS;
alter system enable restricted session;
alter database "dba" open resetlogs;
alter database rename global_name to "dba";
ALTER TABLESPACE TEMP ADD TEMPFILE 'D:\oracle\DBA\DataFiles\dba\TEMP01.DBF' SIZE 20480K REUSE AUTOEXTEND ON NEXT 640K MAXSIZE UNLIMITED;
select tablespace_name from dba_tablespaces where tablespace_name='USERS';
alter system disable restricted session;
connect "SYS"/"&&sysPassword" as SYSDBA
@C:\oracle\database\10g\dba\demo\schema\mkplug.sql &&sysPassword change_on_install change_on_install change_on_install change_on_install change_on_install change_on_install C:\oracle\database\10g\dba\assistants\dbca\templates\example.dmp C:\oracle\database\10g\dba\assistants\dbca\templates\example01.dfb D:\oracle\DBA\DataFiles\dba\example01.dbf D:\oracle\DBA\Scripts\ "'SYS/&&sysPassword as SYSDBA'";
connect "SYS"/"&&sysPassword" as SYSDBA
shutdown immediate;
startup pfile="D:\oracle\DBA\Scripts\initdbaTemp.ora";
alter system enable restricted session;
select sid, program, serial#, username from v$session;
alter database character set INTERNAL_CONVERT WE8ISO8859P1;
alter database national character set INTERNAL_CONVERT AL16UTF16;
alter user sys identified by "&&sysPassword";
alter user system identified by "&&systemPassword";
alter system disable restricted session;
