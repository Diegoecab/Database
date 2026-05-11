-- ------------------------------------------------------------------------------
-- File       : current_sql_hash.sql
-- Purpose    : Oracle administration helper: current sql hash.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @current_sql_hash.sql
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
col sid for 999
col sql_text for a70
col osuser for a10
col username for a15
col program for a15
col machine for a20
set linesize 180
accept HASH prompt 'Ingrese HASH:  '
SELECT s.SID,s.username,s.machine,s.process, s.osuser, p.program,a.sql_text
  FROM v$session s, v$sqlarea a
WHERE s.sql_hash_value = a.hash_value
   AND s.sql_address = a.address
   AND s.paddr = p.addr
   AND s.SQL_HASH_VALUE='&HASH'
/
