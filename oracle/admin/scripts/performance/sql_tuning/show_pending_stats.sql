-- ------------------------------------------------------------------------------
-- File       : show_pending_stats.sql
-- Purpose    : Oracle SQL performance and tuning helper: show pending stats.
-- Category   : performance/sql_tuning
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @show_pending_stats.sql
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
select table_name, last_analyzed "analyze time", num_rows, blocks, avg_row_len
from user_tab_pending_stats
where table_name = '&1' and partition_name is null;

-- indexes
select index_name, last_analyzed "analyze time", num_rows, 
       leaf_blocks, distinct_keys
from user_ind_pending_stats
where table_name = '&1' and partition_name is null
order by index_name;

-- columns
select column_name, last_analyzed "analyze time", num_distinct, 
       num_nulls, density
from user_col_pending_stats
where table_name = '&1' and partition_name is null
order by column_name;

set echo on
