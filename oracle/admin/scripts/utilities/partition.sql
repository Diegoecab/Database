-- ------------------------------------------------------------------------------
-- File       : partition.sql
-- Purpose    : Oracle administration helper: partition.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @partition.sql
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
set long 2000
col pos format 999
col tablespace_name format a10
col subp# format 99999
col high_value format a200
set linesize 300
select partition_position pos, partition_name, tablespace_name, subpartition_count SubP#, high_value  
from dba_tab_partitions where table_name like upper('&1')
order by partition_position
/
set linesize 150
