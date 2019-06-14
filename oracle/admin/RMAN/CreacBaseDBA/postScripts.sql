connect "SYS"/"&&sysPassword" as SYSDBA
set echo on
spool D:\oracle\DBA\Scripts\postScripts.log
@C:\oracle\database\10g\dba\rdbms\admin\dbmssml.sql;
execute dbms_datapump_utl.replace_default_dir;
commit;
connect "SYS"/"&&sysPassword" as SYSDBA
alter session set current_schema=ORDSYS;
@C:\oracle\database\10g\dba\ord\im\admin\ordlib.sql;
alter session set current_schema=SYS;
connect "SYS"/"&&sysPassword" as SYSDBA
connect "SYS"/"&&sysPassword" as SYSDBA
alter user CTXSYS account unlock identified by change_on_install;
connect "CTXSYS"/"change_on_install"
@C:\oracle\database\10g\dba\ctx\admin\defaults\dr0defdp.sql;
@C:\oracle\database\10g\dba\ctx\admin\defaults\dr0defin.sql "SPANISH";
connect "SYS"/"&&sysPassword" as SYSDBA
execute dbms_swrf_internal.cleanup_database(cleanup_local => FALSE);
commit;
spool off
