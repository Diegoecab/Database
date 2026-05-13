-- ------------------------------------------------------------------------------
-- File       : open_cursor_sid.sql
-- Purpose    : Oracle administration helper: open cursor sid.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @open_cursor_sid.sql
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
rem v$open_cursor_sid.sql
col sql_text for a60
col user_name for a10

accept SID prompt 'Ingrese SID:  '

SELECT o.sql_text, o.address, o.sql_id, o.hash_value, o.user_name, s.schemaname
  FROM v$open_cursor o, v$session s
 WHERE o.saddr = s.saddr AND o.SID = s.SID AND (o.SID = '&SID')
 /