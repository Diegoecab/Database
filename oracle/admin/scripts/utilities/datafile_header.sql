-- ------------------------------------------------------------------------------
-- File       : datafile_header.sql
-- Purpose    : Oracle administration helper: datafile header.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @datafile_header.sql
-- Parameters : Review ACCEPT variables and substitution variables before running.
-- Requires   : SQL*Plus or SQLcl and privileges required by referenced dictionary views.
-- Oracle Ver.: Review compatibility before production use.
-- Risk       : READ ONLY
-- Output     : SQL*Plus/SQLcl console or spool output.
-- Notes      : Validate in a non-production session before operational use.
-- Source     : internal
-- Change Log : 
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
col checkpoint_change# for 99999999999999999999999999999
set lines 900
select file#, status, fuzzy, error, checkpoint_change#,checkpoint_time,resetlogs_time
from v$datafile_header;

