-- ------------------------------------------------------------------------------
-- File       : RestoreTime.sql
-- Purpose    : Oracle RMAN backup, restore or recovery helper: RestoreTime.
-- Category   : backup_recovery/rman
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @RestoreTime.sql
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
set until time= '2007-07-02:10:30:00';
restore database;
recover database
ALTER DATABASE OPEN RESETLOGS;}