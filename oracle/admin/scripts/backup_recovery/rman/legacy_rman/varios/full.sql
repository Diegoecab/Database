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
spool log to c:\oracle\disco2\rman_logs\rman_log.log
run { allocate channel c1 type disk format ='C:\oracle\disco2\rman\%d_%u_%t.bkp';
allocate channel c2 type disk format ='C:\oracle\disco2\rman\%d_%u_%t.bkp';
allocate channel c3 type disk format ='C:\oracle\disco2\rman\%d_%u_%t.bkp';
backup incremental level=0 database include current controlfile;}
run {sql 'alter system archive log current';
allocate channel c1 type disk format ='C:\oracle\disco2\rman\%d_%u_%t.bkp';
backup archivelog all delete all input;
sql 'alter system archive log start';}
backup copies 1 database format 'c:\oracle\disco3\rman\%d_%u_%t.bkp2';
exit;