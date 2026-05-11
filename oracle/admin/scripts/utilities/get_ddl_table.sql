-- ------------------------------------------------------------------------------
-- File       : get_ddl_table.sql
-- Purpose    : Oracle administration helper: get ddl table.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @get_ddl_table.sql
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
set head off
set echo off
set pages 999
set feed off
set long 90000


select dbms_metadata.get_ddl('TABLE',table_name,owner)
from dba_tables
where owner like upper('%&owner%') 
and table_name like upper('%&table_name%')
/

set feed on