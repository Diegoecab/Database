-- ------------------------------------------------------------------------------
-- File       : sysmetric_summary.sql
-- Purpose    : Oracle administration helper: sysmetric summary.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @sysmetric_summary.sql
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
select begin_time,CASE METRIC_NAME
 WHEN 'SQL Service Response Time' then 'SQL Service Response Time (secs)'
 WHEN 'Response Time Per Txn' then 'Response Time Per Txn (secs)'
 ELSE METRIC_NAME
 END METRIC_NAME,
 CASE METRIC_NAME
 WHEN 'SQL Service Response Time' then ROUND((MINVAL / 100),2)
 WHEN 'Response Time Per Txn' then ROUND((MINVAL / 100),2)
 ELSE MINVAL
 END MININUM,
 CASE METRIC_NAME
 WHEN 'SQL Service Response Time' then ROUND((MAXVAL / 100),2)
 WHEN 'Response Time Per Txn' then ROUND((MAXVAL / 100),2)
 ELSE MAXVAL
 END MAXIMUM,
 CASE METRIC_NAME
 WHEN 'SQL Service Response Time' then ROUND((AVERAGE / 100),2)
 WHEN 'Response Time Per Txn' then ROUND((AVERAGE / 100),2)
 ELSE AVERAGE
 END AVERAGE
 from SYS.V_$SYSMETRIC_SUMMARY 
 where METRIC_NAME in ('CPU Usage Per Sec',
 'CPU Usage Per Txn',
 'Database CPU Time Ratio',
 'Database Wait Time Ratio',
 'Executions Per Sec',
 'Executions Per Txn',
 'Response Time Per Txn',
 'SQL Service Response Time',
 'User Transaction Per Sec')
 ORDER BY 1;