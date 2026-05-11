-- ------------------------------------------------------------------------------
-- File       : postDBCreation.sql
-- Purpose    : Oracle administration helper: postDBCreation.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @postDBCreation.sql
-- Parameters : Review ACCEPT variables and substitution variables before running.
-- Requires   : SQL*Plus or SQLcl and privileges required by referenced dictionary views.
-- Oracle Ver.: Review compatibility before production use.
-- Risk       : READ ONLY
-- Output     : SQL*Plus/SQLcl console or spool output.
-- Notes      : Validate in a non-production session before operational use.
-- Source     : internal
-- Change Log : 
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
connect "SYS"/"&&sysPassword" as SYSDBA
set echo on
spool /u01/app/oracle/admin/db01/scripts/postDBCreation.log
connect "SYS"/"&&sysPassword" as SYSDBA
set echo on
create spfile='/u01/app/oracle/product/10.2.0/dbs/spfiledb01.ora' FROM pfile='/u01/app/oracle/admin/db01/scripts/init.ora';
shutdown immediate;
connect "SYS"/"&&sysPassword" as SYSDBA
startup ;
alter user SYSMAN identified by "&&sysmanPassword" account unlock;
alter user DBSNMP identified by "&&dbsnmpPassword" account unlock;
select 'utl_recomp_begin: ' || to_char(sysdate, 'HH:MI:SS') from dual;
execute utl_recomp.recomp_serial();
select 'utl_recomp_end: ' || to_char(sysdate, 'HH:MI:SS') from dual;
host /u01/app/oracle/product/10.2.0/bin/emca -config dbcontrol db -silent -DB_UNIQUE_NAME db01 -PORT 1521 -EM_HOME /u01/app/oracle/product/10.2.0 -LISTENER LISTENER -SERVICE_NAME db01 -SYS_PWD &&sysPassword -SID db01 -ORACLE_HOME /u01/app/oracle/product/10.2.0 -DBSNMP_PWD &&dbsnmpPassword -HOST vtrtest.ryaco.local.com -LISTENER_OH /u01/app/oracle/product/10.2.0 -LOG_FILE /u01/app/oracle/admin/db01/scripts/emConfig.log -SYSMAN_PWD &&sysmanPassword;
spool /u01/app/oracle/admin/db01/scripts/postDBCreation.log
exit;
