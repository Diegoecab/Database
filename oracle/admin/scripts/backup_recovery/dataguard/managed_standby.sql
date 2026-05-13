-- ------------------------------------------------------------------------------
-- File       : managed_standby.sql
-- Purpose    : Oracle Data Guard administration helper: managed standby.
-- Category   : backup_recovery/dataguard
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @managed_standby.sql
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
ttitle off
prompt Verify that managed recovery is running
select process,status, delay_mins, active_agents,thread#, sequence# from
v$managed_standby
/