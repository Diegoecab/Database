-- ------------------------------------------------------------------------------
-- File       : dba_tab_part_sub_count.sql
-- Purpose    : Oracle administration helper: dba tab part sub count.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_tab_part_sub_count.sql
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
--dba_tab_part_sub_count

col table_owner for a20
col table_name for a30
col pct_free for 999
col buffer_pool for a10
col subpartition_position for 9999
col high_value for a100
set long 4000
set lines 400
set verify off


select
table_name,--bytes/1024/1024 mb,
count(*) cnt_partitions
from dba_tab_partitions a 
--join dba_segments b on b.owner=a.table_owner and b.segment_name=a.table_name and b.partition_name=a.subpartition_name
where table_owner like upper('%&table_owner%')
group by table_owner,table_name
order by 2
/


select
table_owner,
table_name,--bytes/1024/1024 mb,
count(*) cnt_subpartitions
from dba_tab_subpartitions a 
--join dba_segments b on b.owner=a.table_owner and b.segment_name=a.table_name and b.partition_name=a.subpartition_name
where table_owner like upper('%&table_owner%')
group by table_owner,table_name
order by 1,3
/



