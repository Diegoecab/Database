-- ------------------------------------------------------------------------------
-- File       : rman_status.sql
-- Purpose    : Oracle RMAN backup, restore or recovery helper: rman status.
-- Category   : backup_recovery/rman
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @rman_status.sql
-- Parameters : Review ACCEPT variables and substitution variables before running.
-- Requires   : RMAN, Oracle environment, and required backup/recovery privileges.
-- Oracle Ver.: Review compatibility before production use.
-- Risk       : REVIEW
-- Output     : SQL*Plus/SQLcl console or spool output.
-- Notes      : Validate in a non-production session before operational use.
-- Source     : internal
-- Change Log : 
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
--v$rman_status

select * from v$rman_status
where operation like upper('%&operation%')
and status like upper('%&status%')
order by start_time
/

prompt Para ver detalles, ver v$rman_output where session_stamp=....