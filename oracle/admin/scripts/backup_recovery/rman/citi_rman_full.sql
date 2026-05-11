-- ------------------------------------------------------------------------------
-- File       : citi_rman_full.sql
-- Purpose    : Oracle RMAN backup, restore or recovery helper: citi rman full.
-- Category   : backup_recovery/rman
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @citi_rman_full.sql
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
set lines 400
set pages 1000
select host, sid,
          started,
          finished,
          round((FINISHED-started)*1440/60) h_taken,
          round((output)/1024/1024/1024,2) size_g
  from dbadmin.rman_backup_status a
where --host like 'lath14'
sid='dbrepo'
--  and sid='cdwpro'
  and type='FULL'
order by 1,2,3;