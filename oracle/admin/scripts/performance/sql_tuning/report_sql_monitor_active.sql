-- ------------------------------------------------------------------------------
-- File       : report_sql_monitor_active.sql
-- Purpose    : Oracle SQL performance and tuning helper: report sql monitor active.
-- Category   : performance/sql_tuning
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @report_sql_monitor_active.sql
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
set trimspool on
set trim on
set pagesize 0
set linesize 32767
set long 1000000
set longchunksize 1000000
spool &spool
SELECT dbms_sql_monitor.report_sql_monitor(type=>'ACTIVE')
FROM dual;
spool off