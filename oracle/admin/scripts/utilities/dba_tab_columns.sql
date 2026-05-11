-- ------------------------------------------------------------------------------
-- File       : dba_tab_columns.sql
-- Purpose    : Oracle administration helper: dba tab columns.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_tab_columns.sql
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
--dba_tab_columns
set pages 1000
set verify off
set lines 300
set feedback off
set trims on
col owner for a20
col column_name for a30
col data_type for a20
col table_name for a30
col selectivity_percent for 999
set trimout on
set tab off
undefine all

select owner,table_name,column_name,data_type,data_length,nullable,column_id,
(select num_rows from dba_tables where owner=a.owner and table_name=a.table_name) num_rows_table,
num_distinct, round((num_distinct/(select num_rows from dba_tables where owner=a.owner and table_name=a.table_name))*100) selectivity_percent, density, num_nulls, num_buckets, last_analyzed, sample_size, histogram
from dba_tab_columns a
where 
owner like UPPER('%&owner%') 
and table_name like upper('%&table_name%') 
and column_name like upper('%&column_name%') 
and data_type like upper('%&data_type%') 
order by column_id
/