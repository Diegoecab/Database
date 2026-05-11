-- ------------------------------------------------------------------------------
-- File       : dba_indexes_invalid.sql
-- Purpose    : Oracle administration helper: dba indexes invalid.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_indexes_invalid.sql
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
--dba_indexes_invalid

set verify off
set lines 400
set pages 1000
col owner for a20
col degree for a3
col index_name for a30
col index_type for a25
col table_name for a30
col uniqueness for a10
col compression for a10
col per_clust_fact_x_t_num_rows for 999999
undefine all

select a.owner,a.index_name,a.index_type,a.table_name,a.uniqueness,a.tablespace_name,a.status,a.compression,a.degree,a.clustering_factor,b.num_rows t_num_rows,b.blocks t_blocks,
round((a.clustering_factor*100)/b.num_rows,1) per_clust_fact_x_t_num_rows,a.last_analyzed
from dba_indexes a, dba_tables b
where b.owner = a.owner
and b.table_name = a.table_name
and a.owner like upper('%&index_owner%')
and a.table_name like upper('%&table_name%')
and a.index_name like upper('%&index_name%')
and a.index_type like upper('%&index_type%')
and a.status not in ('VALID','N/A')
order by 1,2,4
/

clear col