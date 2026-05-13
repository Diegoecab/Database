-- ------------------------------------------------------------------------------
-- File       : dbms_perf.report_sql.sql
-- Purpose    : Oracle administration helper: dbms perf report sql.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dbms_perf.report_sql.sql
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
SET LONG 1000000
SET LONGCHUNKSIZE 1000000
SET LINESIZE 1000
SET PAGESIZE 0
SET TRIM ON
SET TRIMSPOOL ON
SET ECHO OFF
SET FEEDBACK OFF

spool report_sql.html

select sys.dbms_perf.report_sql(sql_id=>'1ntpr2hkbspd9',is_realtime=>0,type=>'active',selected_start_time=>to_date('20-OCT-20 04:00:00','dd-MON-YY hh24:mi:ss'),selected_end_time=>to_date('29-OCT-20 16:00:00','dd-MON-YY hh24:mi:ss')) from dual;