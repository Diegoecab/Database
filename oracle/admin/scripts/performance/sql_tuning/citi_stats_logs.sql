-- ------------------------------------------------------------------------------
-- File       : citi_stats_logs.sql
-- Purpose    : Oracle SQL performance and tuning helper: citi stats logs.
-- Category   : performance/sql_tuning
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @citi_stats_logs.sql
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
--citi_stats_logs.sql

set lines 400
col step_detail for a50
set verify off

prompt Last n runs details

select a.*,round((fh_end-fh_start) *24*60) diff_mins from
dbadmin.stat_running_logs a
where id_job > ((select max (id_job) from dbadmin.stat_running_logs) - &runs)
order by id_job
/

prompt Last n runs, elapsed time group by owner

break on id_job skip 1
compute sum of diff_hours on id_job

select id_job,min(fh_start),max(fh_end),owner_name,round(sum((FH_END-FH_START) *24*60)) diff_mins,round(sum((fh_end-fh_start) *24)) diff_hours from
dbadmin.stat_running_logs a
where id_job > ((select max (id_job) from dbadmin.stat_running_logs) - &runs)
group by id_job,owner_name
order by id_job desc,diff_mins
/