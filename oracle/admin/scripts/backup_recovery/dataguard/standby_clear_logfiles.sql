-- ------------------------------------------------------------------------------
-- File       : standby_clear_logfiles.sql
-- Purpose    : Oracle Data Guard administration helper: standby clear logfiles.
-- Category   : backup_recovery/dataguard
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @standby_clear_logfiles.sql
-- Parameters : Review ACCEPT variables and substitution variables before running.
-- Requires   : SQL*Plus or SQLcl and privileges required by referenced dictionary views.
-- Oracle Ver.: Review compatibility before production use.
-- Risk       : REVIEW
-- Output     : SQL*Plus/SQLcl console or spool output.
-- Notes      : Validate in a non-production session before operational use.
-- Source     : internal
-- Change Log : 
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
SQL> select GROUP# from v$logfile where TYPE='STANDBY' group by GROUP#;

    GROUP#
----------
ALTER DATABASE CLEAR LOGFILE GROUP    3;
ALTER DATABASE CLEAR LOGFILE GROUP   11;
ALTER DATABASE CLEAR LOGFILE GROUP   12;
ALTER DATABASE CLEAR LOGFILE GROUP   14;
ALTER DATABASE CLEAR LOGFILE GROUP   15;
ALTER DATABASE CLEAR LOGFILE GROUP   16;


ALTER DATABASE CLEAR LOGFILE GROUP 3;


set pages 100

select 'ALTER DATABASE CLEAR LOGFILE GROUP '||group#||';' from v$log;