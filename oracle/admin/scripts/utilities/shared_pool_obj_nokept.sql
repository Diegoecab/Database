-- ------------------------------------------------------------------------------
-- File       : shared_pool_obj_nokept.sql
-- Purpose    : Oracle administration helper: shared pool obj nokept.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @shared_pool_obj_nokept.sql
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
--shared_pool_obj_nokept.sql
col name for a50
col owner for a30

SELECT   doc.owner, doc.NAME, doc.TYPE, doc.loads, round(doc.sharable_mem/1024) sharable_mem_kb,
         upper(ins.instance_name) instance_name
FROM     v$db_object_cache doc, v$instance ins
WHERE    doc.loads > 2
AND      doc.TYPE IN ('PACKAGE', 'PACKAGE BODY', 'FUNCTION', 'PROCEDURE')
AND KEPT = 'NO'
ORDER BY sharable_mem_kb
/