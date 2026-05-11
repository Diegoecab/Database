-- ------------------------------------------------------------------------------
-- File       : rc_rman_configuration.sql
-- Purpose    : Oracle RMAN backup, restore or recovery helper: rc rman configuration.
-- Category   : backup_recovery/rman
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @rc_rman_configuration.sql
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
--rc_rman_configuration
set pages 100
set lines 900
select a.name, b.* from
rc_database a,
rc_rman_configuration b
where a.db_key = b.db_key
and a.name like upper('%&db_name%')
order by a.name, conf#
/