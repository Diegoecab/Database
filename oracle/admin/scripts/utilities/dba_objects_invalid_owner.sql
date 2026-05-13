-- ------------------------------------------------------------------------------
-- File       : dba_objects_invalid_owner.sql
-- Purpose    : Oracle administration helper: dba objects invalid owner.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_objects_invalid_owner.sql
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
--dba_objects_invalid_owner
set pages 1000
set lines 200
set trims on
col owner for a20
col object_name for a40
col sql for a80

SELECT   owner,
           object_type,
           object_name,
           created,
           status,
           CASE object_type
              WHEN 'PACKAGE BODY'
              THEN
                    'ALTER PACKAGE '
                 || owner
                 || '.'
                 || object_name
                 || '  COMPILE BODY;'
              ELSE
                    'ALTER '
                 || object_type
                 || ' '
                 || owner
                 || '.'
                 || object_name
                 || '  compile;'
           END
              "SQL"
    FROM   dba_objects
   WHERE   status <> 'VALID' and owner like upper('%&owner%')
ORDER BY   1, 2, 3
/