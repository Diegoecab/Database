-- ------------------------------------------------------------------------------
-- File       : open_cursor.sql
-- Purpose    : Oracle administration helper: open cursor.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @open_cursor.sql
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
--v$open_cursor
set pagesize 1000

PROMPT Cantidad de cursores abiertos por sesion
PROMPT
COMPUTE SUM LABEL 'TOTAL' OF count ON REPORT
BREAK ON REPORT
select user_name, sid, count(1) as count
from sys.v_$open_cursor
group by user_name, sid
order by count
/

PROMPT
PROMPT Se puede ver los cursores abiertos con sql sql_text por SID, con v$open_cursor_sid
PROMPT