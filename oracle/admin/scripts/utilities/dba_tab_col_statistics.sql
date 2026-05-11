-- ------------------------------------------------------------------------------
-- File       : dba_tab_col_statistics.sql
-- Purpose    : Oracle administration helper: dba tab col statistics.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_tab_col_statistics.sql
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
--dba_tab_col_statistics
set lines 400

clear col
col owner for a15 truncate 
col column_name for a30 truncate
col data_type for a10 truncate
col table_name for a20 truncate
col low_value for a20 truncate
col high_value for a20 truncate
col notes for a20 truncate

select a.*, b.data_type  from
dba_tab_col_statistics a, dba_tab_columns b
where a.owner like upper ('%&owner%')
and a.table_name like upper ('%&table_name%')
and a.column_name like upper ('%&column_name%')
and b.owner = a.owner and b.table_name = a.table_name and b.column_name = a.column_name and
b.data_type like upper ('%&data_type%')
order by 1,2
/
