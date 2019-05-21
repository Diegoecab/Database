connect "SYS"/"&&sysPassword" as SYSDBA
set echo on
spool /u01/app/oracle/admin/db01/scripts/CloneRmanRestore.log
startup nomount pfile="/u01/app/oracle/admin/db01/scripts/init.ora";
@/u01/app/oracle/admin/db01/scripts/rmanRestoreDatafiles.sql;
