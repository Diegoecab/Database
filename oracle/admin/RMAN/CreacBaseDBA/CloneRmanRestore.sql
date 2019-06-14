connect "SYS"/"&&sysPassword" as SYSDBA
set echo on
spool D:\oracle\DBA\Scripts\CloneRmanRestore.log
startup nomount pfile="D:\oracle\DBA\Scripts\init.ora";
@D:\oracle\DBA\Scripts\rmanRestoreDatafiles.sql;
