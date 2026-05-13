-- ------------------------------------------------------------------------------
-- File       : session_sid.sql
-- Purpose    : Oracle diagnostic query/report helper: session sid.
-- Category   : diagnostics/sessions_waits
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @session_sid.sql
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
--v$session_sid
col rownum for 99
col event for a40
col machine for a20
col program for a20
col username for a25
col module for a20
set linesize 180
accept SID prompt 'Ingrese SID: '
SELECT username,machine,program,module,status
  FROM v$session
 WHERE sid = '&SID'
 ORDER BY 1,2,3,4
 /