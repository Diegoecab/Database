-- ------------------------------------------------------------------------------
-- File       : dbms_sqltune_report_x.sql
-- Purpose    : Oracle SQL performance and tuning helper: dbms sqltune report x.
-- Category   : performance/sql_tuning
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dbms_sqltune_report_x.sql
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
--dbms_sqltune_report_x.sql
accept TTASK prompt 'Ingrese Tuning Task (Para ver un listado ejecutar dba_advisor_tasks): '
SET LONG 1000000
SET LONGCHUNKSIZE 1000
SET LINESIZE 100
SELECT DBMS_SQLTUNE.REPORT_TUNING_TASK( '&TTASK')
  FROM DUAL;