-- ------------------------------------------------------------------------------
-- File       : dba_dependencies.sql
-- Purpose    : Oracle administration helper: dba dependencies.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_dependencies.sql
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
--dba_dependencies.sql

desc dba_dependencies

set lines 400
set verify off

select * from dba_dependencies
where owner like upper('%&owner%') 
and name like upper('%&name%')
and type like upper('%&type%')
and referenced_owner like upper('%&referenced_owner%')
and referenced_name like upper('%&referenced_name%')
and referenced_type like upper('%&referenced_type%')
order by 1,2,3
/