-- ------------------------------------------------------------------------------
-- File       : show_public_stats.sql
-- Purpose    : Oracle SQL performance and tuning helper: show public stats.
-- Category   : performance/sql_tuning
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @show_public_stats.sql
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

set echo off

-- tables
select table_name, last_analyzed analyze_time, num_rows, blocks, avg_row_len
from user_tables
where table_name = '&1';

-- indexes
select index_name, last_analyzed ANALYZE_TIME, num_rows, 
       leaf_blocks, distinct_keys
from user_indexes
where table_name = '&1'
order by index_name;

-- columns
select column_name, last_analyzed ANALYZE_TIME, num_distinct, 
       num_nulls, density
from user_tab_columns
where table_name = '&1'
order by column_name;

set echo on
