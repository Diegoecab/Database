-- ------------------------------------------------------------------------------
-- File       : clear_logfile_standby_dataguard.sql
-- Purpose    : Oracle Data Guard administration helper: clear logfile standby dataguard.
-- Category   : backup_recovery/dataguard
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @clear_logfile_standby_dataguard.sql
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
select GROUP# from v$logfile where TYPE='STANDBY' group by GROUP#;

ALTER DATABASE CLEAR LOGFILE GROUP   15;