-- ------------------------------------------------------------------------------
-- File       : open_cursor_sess.sql
-- Purpose    : Oracle diagnostic query/report helper: open cursor sess.
-- Category   : diagnostics/sessions_waits
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @open_cursor_sess.sql
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
--v$open_cursor_sess
col statement for a65
col module for a10
set pagesize 50
col username for a10
SELECT username,
SUBSTR(machine,1,10) "Machine",
sharable_mem, persistent_mem,
runtime_mem, executions, v$sql.module,
SUBSTR(v$sql.sql_text,1,60) "Statement"
FROM   v$session, v$sql, v$open_cursor
WHERE  v$open_cursor.saddr   = v$session.saddr
AND    v$open_cursor.address = v$sql.address
and rownum < 50
ORDER BY SUBSTR(USERNAME,1,10), SUBSTR(machine,1,10);