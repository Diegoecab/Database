-- ------------------------------------------------------------------------------
-- File       : chained.sql
-- Purpose    : Oracle administration helper: chained(1).
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @chained(1).sql
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
set lines 300
col owner for a20 truncate
col table_name for a40 truncate
select owner, table_name, num_rows, AVG_SPACE,  CHAIN_CNT, AVG_ROW_LEN , round((CHAIN_CNT * 100) / num_rows,2) pct_chain,
chain_cnt * avg_row_len tot_chain, BLOCKS, EMPTY_BLOCKS, BLOCKS - EMPTY_BLOCKS, NUM_ROWS / BLOCKS                
from dba_tables where chain_cnt > 0;