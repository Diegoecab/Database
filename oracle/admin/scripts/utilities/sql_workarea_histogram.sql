-- ------------------------------------------------------------------------------
-- File       : sql_workarea_histogram.sql
-- Purpose    : Oracle administration helper: sql workarea histogram.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @sql_workarea_histogram.sql
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
--sql_workarea_histogram
--history of active pga workarea
set lines 300
select
	inst_id,
	low_optimal_size/1024/1024 low_optimal_size_mb
	, (high_optimal_size+1)/1024/1024 high_optimal_size_mb
	, optimal_executions
	, onepass_executions
	, multipasses_executions
	, total_executions
	, optimal_executions / total_executions * 100 pct_optimal_executions
	, onepass_executions / total_executions * 100 pct_onepass_executions
	, multipasses_executions / total_executions * 100 pct_multipasses_executions
	, ratio_to_report(optimal_executions) over ( ) * 100 pct_total_optimal_executions
from gv$sql_workarea_histogram
where total_executions != 0
order by inst_id,low_optimal_size_mb
/