-- ------------------------------------------------------------------------------
-- File       : citi_rman_avg_type.sql
-- Purpose    : Oracle RMAN backup, restore or recovery helper: citi rman avg type.
-- Category   : backup_recovery/rman
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @citi_rman_avg_type.sql
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
select host, sid,
       type,
       round((avg(output))/1024/1024/1024,2) size_g
  from dbadmin.rman_backup_status a
where host like 'lath14'
group by host, sid, type
order by 1,2,3;