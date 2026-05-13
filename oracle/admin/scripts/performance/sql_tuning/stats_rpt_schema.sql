-- ------------------------------------------------------------------------------
-- File       : stats_rpt_schema.sql
-- Purpose    : Oracle SQL performance and tuning helper: stats rpt schema.
-- Category   : performance/sql_tuning
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @stats_rpt_schema.sql
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
select trunc(c.started), round(sum(((b.started + run_duration) - b.started ) *24*60),1) sum_mins, count(*) from 
dbadmin.dbs_stale_stats a, dbadmin.dbs_stats_queue_details b, dbadmin.dbs_stats_queue c
 where
a.schema_name like  upper('%&schema_name%') and b.stale_id = a.stale_id
and c.job_id = a.job_id
group by trunc(c.started) order by 1
/
