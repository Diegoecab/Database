-- ------------------------------------------------------------------------------
-- File       : recreate_standby_logfiles.sql
-- Purpose    : Oracle Data Guard administration helper: recreate standby logfiles.
-- Category   : backup_recovery/dataguard
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @recreate_standby_logfiles.sql
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
set lines 600
set pages 100
select 'ALTER DATABASE DROP STANDBY LOGFILE GROUP '||group#||';' from v$standby_log;
select 'ALTER DATABASE ADD STANDBY LOGFILE GROUP '||group#||' (''+PDCP_FRA'') size '||ROUND (BYTES / 1024 / 1024)||'M ;'
from v$standby_log;