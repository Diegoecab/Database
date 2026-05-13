-- ------------------------------------------------------------------------------
-- File       : dba_ind_columns.sql
-- Purpose    : Oracle administration helper: dba ind columns.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_ind_columns.sql
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
--dba_ind_columns

set pages 100
set lines 200
col index_owner for a30 truncate
col index_name for a40 truncate
col column_name for a30 truncate
col table_name for a30 truncate
col table_owner for a30 truncate

select table_owner,table_name,index_owner,index_name,column_name,column_position
from dba_ind_columns 
where table_owner like upper('%&table_owner%')
and table_name like upper('%&table_name%')
and index_name like upper('%&index_name%')
and column_name like upper('%&column_name%')
order by 1,2,3,4,6
/
