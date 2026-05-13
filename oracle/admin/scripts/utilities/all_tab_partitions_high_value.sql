-- ------------------------------------------------------------------------------
-- File       : all_tab_partitions_high_value.sql
-- Purpose    : Oracle administration helper: all tab partitions high value.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @all_tab_partitions_high_value.sql
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
--all_tab_partitions_high_value.sql
col table_name for a30 truncate
col partition for a30 truncate
col high_value for a30 truncate
set pages 100
with xml as (
  select dbms_xmlgen.getxmltype('select table_name, partition_name, high_value from all_tab_partitions') as x
  from   dual
)
  select extractValue(rws.object_value, '/ROW/TABLE_NAME') table_name,
         extractValue(rws.object_value, '/ROW/PARTITION_NAME') partition,
         extractValue(rws.object_value, '/ROW/HIGH_VALUE') high_value
  from   xml x, 
         table(xmlsequence(extract(x.x, '/ROWSET/ROW'))) rws;