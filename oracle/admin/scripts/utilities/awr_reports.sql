-- ------------------------------------------------------------------------------
-- File       : awr_reports.sql
-- Purpose    : Oracle administration helper: awr reports.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @awr_reports.sql
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
--awr_reports.sql
set lines 300
set pages 1000

accept days prompt 'Days: '

SELECT dbid, snap_id, begin_interval_time, end_interval_time from dba_hist_snapshot
where begin_interval_time > sysdate - &days
order by begin_interval_time;


--11881

--SELECT output FROM TABLE (dbms_workload_repository.awr_report_text(1747444437, 1, 11881, 12063))