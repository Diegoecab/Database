-- ------------------------------------------------------------------------------
-- File       : dba_indexes_duplicate.sql
-- Purpose    : Oracle administration helper: dba indexes duplicate.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_indexes_duplicate.sql
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
--dba_indexes_duplicate.sql

SELECT 
   /*+ RULE */ 
   tab_owner.name owner, t.name table_name, 
   o1.name || '(' || DECODE(bitand(i1.property, 1), 0, 'N', 1, 'U', '*') || ')' included_index_name , 
   o2.name || '(' || DECODE(bitand(i2.property, 1), 0, 'N', 1, 'U', '*') || ')' including_index_name 
FROM  sys.USER$ tab_owner, sys.OBJ$ t, sys.IND$ i1, sys.OBJ$ o1, sys.IND$ i2, sys.OBJ$ o2 
WHERE i1.bo# = i2.bo# AND i1.obj# <> i2.obj# AND i2.cols >= i1.cols AND i1.cols > 0 AND
   i1.cols = ( SELECT /*+ ORDERED */ COUNT(1) FROM sys.ICOL$ cc1, sys.icol$ cc2 
               WHERE cc2.obj# = i2.obj# AND cc1.obj# = i1.obj# AND 
                     cc2.pos# = cc1.pos# AND cc2.COL# = cc1.COL#) AND 
   i1.obj# = o1.obj# AND i2.obj# = o2.obj# AND t.obj# = i1.bo# AND 
   t.owner# = tab_owner.USER# AND tab_owner.name LIKE '%' 
and tab_owner.name not in ('SYS','SYSTEM','XDB','MDSYS')
ORDER BY 1, 2
/