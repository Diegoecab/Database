-- ------------------------------------------------------------------------------
-- File       : report_sql_monitor_sqlid.sql
-- Purpose    : Oracle SQL performance and tuning helper: report sql monitor sqlid.
-- Category   : performance/sql_tuning
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @report_sql_monitor_sqlid.sql
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
--report_sql_monitor_sqlid sqlid phv type
--@report_sql_monitor_sqlid 4g47brj07vttz 455302343 text
SET LONG 1000000
SET LONGCHUNKSIZE 1000000
SET LINESIZE 1000
SET PAGESIZE 0
SET TRIM ON
SET TRIMSPOOL ON
SET ECHO OFF
SET FEEDBACK OFF
SET VERIFY OFF
set head off

select DBMS_SQL_MONITOR.REPORT_SQL_MONITOR
        (sql_id       =>'&1',
		sql_plan_hash_value =>'&2',
         report_level =>'all', 
         type         =>'&3') report
from dual;