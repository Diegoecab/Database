-- ------------------------------------------------------------------------------
-- File       : dba_directories.sql
-- Purpose    : Oracle administration helper: dba directories.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_directories.sql
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
ttitle off
col directory_path for a50
select * from dba_directories 
where directory_name like upper('%&directory_name%')
and directory_path like upper('%&directory_path%')
order by 2
/