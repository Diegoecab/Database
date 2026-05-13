-- ------------------------------------------------------------------------------
-- File       : sql_monitor.sql
-- Purpose    : Oracle SQL performance and tuning helper: sql monitor.
-- Category   : performance/sql_tuning
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @sql_monitor.sql
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
set lines 900
set pages 1000
SELECT
report_id,
con_id,
inst_id,
status,
username,
module,
action,
service_name,
program,
sid,
session_serial#,
elapsed_time,
-- gives up to 2000 characters of SQL statement
sql_text,
sql_id,
sql_exec_start,
sql_exec_id,
sql_plan_hash_value,
first_refresh_time,
last_refresh_time,
refresh_count
FROM gv$sql_monitor
WHERE sql_text IS NOT NULL
/