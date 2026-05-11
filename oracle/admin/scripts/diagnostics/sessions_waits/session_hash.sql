-- ------------------------------------------------------------------------------
-- File       : session_hash.sql
-- Purpose    : Oracle diagnostic query/report helper: session hash.
-- Category   : diagnostics/sessions_waits
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @session_hash.sql
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
col rownum for 99
col event for a40
set linesize 180
accept HASH prompt 'Ingrese HASH: '
SELECT username,machine,program,status
  FROM v$session
 WHERE sql_hash_value = '&HASH'
 ORDER BY 1,2,3,4
 /