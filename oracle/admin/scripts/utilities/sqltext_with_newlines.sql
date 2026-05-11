-- ------------------------------------------------------------------------------
-- File       : sqltext_with_newlines.sql
-- Purpose    : Oracle administration helper: sqltext with newlines.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @sqltext_with_newlines.sql
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
SET LINESIZE 500
SET PAGESIZE 1000
SET FEEDBACK OFF
SET VERIFY OFF
col sql_text for a64
set long 900

SELECT a.sql_text
FROM   v$sqltext_with_newlines a
WHERE  a.sql_id = '&sqlid' --a.address = UPPER('&&1')
ORDER BY a.piece;


select sql_fulltext from v$sql where sql_id='&sqlid';

PROMPT
SET PAGESIZE 14
SET FEEDBACK ON