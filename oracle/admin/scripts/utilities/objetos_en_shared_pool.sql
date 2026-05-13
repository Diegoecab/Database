-- ------------------------------------------------------------------------------
-- File       : objetos_en_shared_pool.sql
-- Purpose    : Oracle administration helper: objetos en shared pool.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @objetos_en_shared_pool.sql
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
--shared_pool_obj
SELECT   doc.owner, doc.NAME, doc.TYPE, doc.loads, doc.sharable_mem,
         upper(ins.instance_name) instance_name
FROM     v$db_object_cache doc, v$instance ins
WHERE    doc.loads > 2
AND      doc.TYPE IN ('PACKAGE', 'PACKAGE BODY', 'FUNCTION', 'PROCEDURE')
ORDER BY doc.loads DESC