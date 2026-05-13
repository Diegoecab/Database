-- ------------------------------------------------------------------------------
-- File       : accessobj.sql
-- Purpose    : Oracle administration helper: accessobj.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @accessobj.sql
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
select a.sid, a.serial#, a.username,
b.owner, b.object, b.type
from   v$session a, v$access b
where  a.sid = b.sid
and b.object like upper('%&1%')
/