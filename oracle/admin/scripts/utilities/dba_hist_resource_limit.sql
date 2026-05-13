-- ------------------------------------------------------------------------------
-- File       : dba_hist_resource_limit.sql
-- Purpose    : Oracle administration helper: dba hist resource limit.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_hist_resource_limit.sql
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
--@dba_hist_resource_limit ((rl.current_utilization*100/limit_value))>70 sysdate-30 sysdate
--
--


col resource_name for a10 truncate
set pages 30

SELECT   s.begin_interval_time, s.end_interval_time,
         rl.instance_number, rl.resource_name, rl.current_utilization,
         rl.max_utilization,
		 limit_value
    FROM dba_hist_resource_limit rl, dba_hist_snapshot s
   WHERE s.snap_id = rl.snap_id AND rl.resource_name in ('sessions','processes')
   and S.BEGIN_INTERVAL_TIME> &2
   and S.END_INTERVAL_TIME < &3
   and &1
ORDER BY s.begin_interval_time, rl.instance_number;





SELECT   to_char(begin_interval_time,'DD-MM-YY HH24'),
         rl.instance_number, rl.resource_name, round(avg(rl.current_utilization)) avg_current_utilization,
		 min(rl.current_utilization),
		 min(limit_value) limit_value,
		 max(rl.max_utilization),
		 round(max(rl.current_utilization*100/limit_value)) pct_usage
    FROM dba_hist_resource_limit rl, dba_hist_snapshot s
   WHERE s.snap_id = rl.snap_id AND rl.resource_name in ('sessions','processes')
   and S.BEGIN_INTERVAL_TIME> &2
   and S.END_INTERVAL_TIME < &3
   and &1
   GROUP BY to_char(begin_interval_time,'DD-MM-YY HH24'), rl.instance_number, rl.resource_name
ORDER BY to_date(to_char(begin_interval_time,'DD-MM-YY HH24'),'DD-MM-YY HH24'),2;

