-- ------------------------------------------------------------------------------
-- File       : CloneRmanRestore.sql
-- Purpose    : Oracle RMAN backup, restore or recovery helper: CloneRmanRestore.
-- Category   : backup_recovery/rman
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @CloneRmanRestore.sql
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
connect "SYS"/"&&sysPassword" as SYSDBA
set echo on
spool /u01/app/oracle/admin/db01/scripts/CloneRmanRestore.log
startup nomount pfile="/u01/app/oracle/admin/db01/scripts/init.ora";
@/u01/app/oracle/admin/db01/scripts/rmanRestoreDatafiles.sql;
