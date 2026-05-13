-- ------------------------------------------------------------------------------
-- File       : dba_lobs.sql
-- Purpose    : Oracle administration helper: dba lobs.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_lobs.sql
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
set lines 900
col owner for a20
col table_name for a30
col column_name for a30
col segment_name for a70
col tablespace_name for a30
select owner, table_name, column_name, segment_name, tablespace_name, securefile  from dba_lobs
where upper(owner) like upper('%&owner%')
and upper(table_name) like upper('%&table_name%')
and upper(column_name) like upper('%&column_name%')
and upper(segment_name) like upper('%&segment_name%')
and upper(tablespace_name) like upper('%&tablespace_name%')
order by 1,2,3;