-- ------------------------------------------------------------------------------
-- File       : postDBCreation.sql
-- Purpose    : Oracle RMAN backup, restore or recovery helper: postDBCreation.
-- Category   : backup_recovery/rman
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @postDBCreation.sql
-- Parameters : Review ACCEPT variables and substitution variables before running.
-- Requires   : RMAN, Oracle environment, and required backup/recovery privileges.
-- Oracle Ver.: Review compatibility before production use.
-- Risk       : REVIEW
-- Output     : SQL*Plus/SQLcl console or spool output.
-- Notes      : Validate in a non-production session before operational use.
-- Source     : internal
-- Change Log : 
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
connect "SYS"/"&&sysPassword" as SYSDBA
set echo on
spool D:\oracle\DBA\Scripts\postDBCreation.log
connect "SYS"/"&&sysPassword" as SYSDBA
set echo on
create spfile='C:\oracle\database\10g\dba/dbs/spfiledba.ora' FROM pfile='D:\oracle\DBA\Scripts\init.ora';
shutdown immediate;
connect "SYS"/"&&sysPassword" as SYSDBA
startup ;
alter user SYSMAN identified by "&&sysmanPassword" account unlock;
alter user DBSNMP identified by "&&dbsnmpPassword" account unlock;
select 'utl_recomp_begin: ' || to_char(sysdate, 'HH:MI:SS') from dual;
execute utl_recomp.recomp_serial();
select 'utl_recomp_end: ' || to_char(sysdate, 'HH:MI:SS') from dual;
host C:\oracle\database\10g\dba\bin\emca.bat -config dbcontrol db -silent -DB_UNIQUE_NAME dba -PORT 1521 -EM_HOME C:\oracle\database\10g\dba -LISTENER LISTENER -SERVICE_NAME dba -SYS_PWD &&sysPassword -SID dba -ORACLE_HOME C:\oracle\database\10g\dba -DBSNMP_PWD &&dbsnmpPassword -HOST dcnot -LISTENER_OH C:\oracle\database\10g\dba -LOG_FILE D:\oracle\DBA\Scripts\emConfig.log -SYSMAN_PWD &&sysmanPassword;
spool D:\oracle\DBA\Scripts\postDBCreation.log
