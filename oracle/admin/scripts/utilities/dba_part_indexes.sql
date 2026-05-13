-- ------------------------------------------------------------------------------
-- File       : dba_part_indexes.sql
-- Purpose    : Oracle administration helper: dba part indexes.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_part_indexes.sql
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
col owner for a30
col table_name for a30
col index_name for a30
col column_name for a30

SELECT i.owner, C.TABLE_NAME,I.INDEX_NAME,I.PARTITIONING_TYPE, I.SUBPARTITIONING_TYPE, I.LOCALITY,I.ALIGNMENT,C.COLUMN_NAME,C.COLUMN_POSITION
FROM DBA_PART_INDEXES I JOIN DBA_IND_COLUMNS C
ON (I.INDEX_NAME = C.INDEX_NAME)
WHERE i.owner like upper('%&owner%') AND C.TABLE_NAME like upper('%&table_name%') AND UPPER(I.INDEX_NAME) like upper('%&index_name%')
ORDER BY 1,2,7;