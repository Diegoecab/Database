-- ------------------------------------------------------------------------------
-- File       : dba_part_key_columns.sql
-- Purpose    : Oracle administration helper: dba part key columns.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_part_key_columns.sql
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
--dba_part_key_columns
col column_name for a20
set lines 300
set pages 1000
set verify off
undefine all

select a.*,b.data_type from 
dba_part_key_columns a, dba_tab_columns b
where b.owner=a.owner and b.table_name=a.name and b.column_name=a.column_name 
and a.owner like upper('%&owner%')
and a.name like upper('%&name%')
and a.object_type like upper('%&object_type%')
and a.column_name like upper('%&column_name%')
and b.data_type like upper('%&data_type%')
order by 1,2
/