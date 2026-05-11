-- ------------------------------------------------------------------------------
-- File       : restoreDatafile.sql
-- Purpose    : Oracle RMAN backup, restore or recovery helper: restoreDatafile.
-- Category   : backup_recovery/rman
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @restoreDatafile.sql
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
connect target sys/sys
run { allocate channel c1 type disk ;
allocate channel c2 type disk ;
sql 'alter database datafile nº offline';
restore datafile nº;
recover datafile nº;
sql 'alter database datafile nº online';}