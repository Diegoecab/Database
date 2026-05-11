-- ------------------------------------------------------------------------------
-- File       : componentes.sql
-- Purpose    : Oracle administration helper: componentes.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @componentes.sql
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
SET LINESIZE 145
SET PAGESIZE 9999
SET VERIFY OFF

COLUMN parameter FORMAT a45 HEADING 'Option Name'
COLUMN value FORMAT a10 HEADING 'Installed?'

SELECT
parameter
, value
FROM
v$option
ORDER BY
parameter
/
