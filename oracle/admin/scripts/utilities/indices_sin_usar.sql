-- ------------------------------------------------------------------------------
-- File       : indices_sin_usar.sql
-- Purpose    : Oracle administration helper: indices sin usar.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @indices_sin_usar.sql
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
SELECT owner, index_name indice , table_owner owner_tabla, table_name tabla ,  NULL particion,
       NULL subparticion, TO_CHAR(num_rows) num_registros , last_analyzed
FROM   DBA_INDEXES
WHERE  tablespace_name IS NOT NULL
AND    status = 'UNUSABLE'
UNION ALL
SELECT i.owner, i.index_name, i.table_owner, i.table_name,  p.partition_name particion,
       NULL subparticion, TO_CHAR(p.num_rows), p.last_analyzed
FROM   DBA_IND_PARTITIONS p, DBA_INDEXES i
WHERE  p.index_owner = i.owner
AND    p.index_name = i.index_name
AND    i.partitioned = 'YES'
AND    p.subpartition_count = 0
AND    P.STATUS = 'UNUSABLE'
UNION ALL
SELECT i.owner, i.index_name, i.table_owner, i.table_name,  p.partition_name,
       p.subpartition_name, TO_CHAR(p.num_rows), p.last_analyzed
FROM   DBA_IND_SUBPARTITIONS p, DBA_INDEXES i
WHERE  p.index_owner = i.owner
AND    p.index_name = i.index_name
AND    i.partitioned = 'YES'
AND    P.STATUS = 'UNUSABLE'
ORDER BY 1,2;