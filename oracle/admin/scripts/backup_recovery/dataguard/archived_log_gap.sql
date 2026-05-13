-- ------------------------------------------------------------------------------
-- File       : archived_log_gap.sql
-- Purpose    : Oracle Data Guard administration helper: archived log gap.
-- Category   : backup_recovery/dataguard
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @archived_log_gap.sql
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
--v$archived_log_gap.sql
col name for a20
select dest_id, lower(name) name, applied, count(*) from v$archived_log 
where dest_id <> 1 and applied <> 'YES'
group by dest_id, lower(name), applied
order by dest_id;