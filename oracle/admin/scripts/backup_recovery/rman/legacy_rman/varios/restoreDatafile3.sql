-- ------------------------------------------------------------------------------
-- File       : restoreDatafile3.sql
-- Purpose    : Oracle RMAN backup, restore or recovery helper: restoreDatafile3.
-- Category   : backup_recovery/rman
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @restoreDatafile3.sql
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
restore datafile 6;
recover datafile 6;
sql 'alter database open';}