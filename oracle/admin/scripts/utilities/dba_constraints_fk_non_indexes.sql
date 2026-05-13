-- ------------------------------------------------------------------------------
-- File       : dba_constraints_fk_non_indexes.sql
-- Purpose    : Oracle administration helper: dba constraints fk non indexes.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_constraints_fk_non_indexes.sql
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
--dba_constraints_fk_non_indexes.sql
col owner for a20 truncate
col table_name for a40 truncate
col column_name for a30 truncate

SELECT * FROM (
SELECT c.owner,c.table_name, cc.column_name, cc.position column_position
FROM   dba_constraints c, dba_cons_columns cc
WHERE  c.constraint_name = cc.constraint_name
AND    c.constraint_type = 'R'
MINUS
SELECT i.owner,i.table_name, ic.column_name, ic.column_position
FROM   dba_indexes i, dba_ind_columns ic
WHERE  i.index_name = ic.index_name
)
where owner like upper('%&OWNER%')
ORDER BY owner,table_name, column_position;