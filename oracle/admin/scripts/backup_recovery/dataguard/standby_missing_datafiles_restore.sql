-- ------------------------------------------------------------------------------
-- File       : standby_missing_datafiles_restore.sql
-- Purpose    : Oracle Data Guard administration helper: standby missing datafiles restore.
-- Category   : backup_recovery/dataguard
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @standby_missing_datafiles_restore.sql
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
select file#, name, status, BYTES from v$datafile;


select file#, name, status, BYTES from v$datafile where bytes = 0;


select 'restore datafile '||file#||' from service CSIBSP_PRIMARY;' from v$datafile where bytes = 0;