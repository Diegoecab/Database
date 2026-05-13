-- ------------------------------------------------------------------------------
-- File       : dbs_stats_delete.sql
-- Purpose    : Oracle SQL performance and tuning helper: dbs stats delete.
-- Category   : performance/sql_tuning
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dbs_stats_delete.sql
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
set feed on
set timing on
delete from dbadmin.dbs_stale_stats a 
where job_id = &job_id
and table_name in ('SM_AVERAGE','SM_ACCOUNT_MOVEMENTS')
and inserts=0 and deletes=0 and updates=0 and truncated='YES'
and not exists (select 1 from dbadmin.dbs_stats_queue_details where job_id=a.job_id and stale_id=a.stale_id)
/

commit;

set timing off