-- ------------------------------------------------------------------------------
-- File       : current_sql.sql
-- Purpose    : Oracle administration helper: current sql (1).
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @current_sql (1).sql
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
col sql_text for a40
col osuser for a15
col username for a15
col program for a20
set pagesize 1000
SELECT s.SID,s.username,s.process, s.osuser, a.sql_text, p.program
  FROM v$session s, v$sqlarea a, v$process p
WHERE s.sql_hash_value = a.hash_value
   AND s.sql_address = a.address
   AND s.paddr = p.addr
   AND s.status = 'ACTIVE'
/

col sql_text for a80
select sql_hash_value, sql_text, count(*) from v$session a, v$sql b
where b.hash_value=a.sql_hash_value and status = 'ACTIVE' group by sql_hash_value,sql_text order by 3;