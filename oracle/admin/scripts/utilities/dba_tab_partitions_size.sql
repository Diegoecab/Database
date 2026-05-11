-- ------------------------------------------------------------------------------
-- File       : dba_tab_partitions_size.sql
-- Purpose    : Oracle administration helper: dba tab partitions size.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_tab_partitions_size.sql
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
--dba_Tab_partitions_size
col subpartition_count heading 'Subp|Cnt' for 99
col table_owner heading 'Table|Owner' for a10
col pct_Free heading 'Pct|Free' for 99
col composite heading 'Com|Po|Si|Te'
col buffer_pool heading 'Buffer|Pool' for a8
col partition_position heading 'Part|Posit' for 999
col high_value for a50
set linesize 350

break on partition_name on report
compute sum of mb on report

set pages 999 lines 100
col tablespace_name format a20
col num_rows format 999,999,999
select	p.partition_name
,	p.tablespace_name
,	p.num_rows
,	ceil(s.bytes / 1024 / 1204) mb
from	dba_tab_partitions p
,	dba_segments s
where	p.table_owner = s.owner
and	p.partition_name = s.partition_name
and 	p.table_name = s.segment_name
and	p.table_owner = '&owner'
and	p.table_name = '&table_name'
order by partition_position
/