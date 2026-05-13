-- ------------------------------------------------------------------------------
-- File       : full.sql
-- Purpose    : Oracle RMAN backup, restore or recovery helper: full.
-- Category   : backup_recovery/rman
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @full.sql
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
spool log to /gemini/DbBackup/GEMPROD/rman/logs/rman_log.log
run { allocate channel c1 type disk format ='/gemini/DbBackup/GEMPROD/rman/%d_%u_%t.bkp';
backup incremental level=0 database include current controlfile;}
run {sql 'alter system archive log current';
allocate channel c1 type disk format ='/gemini/DbBackup/GEMPROD/rman/%d_%u_%t.bkp';
backup archivelog all;
sql 'alter system archive log start';}
exit;
