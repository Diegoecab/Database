-- ------------------------------------------------------------------------------
-- File       : buffer_busy_waits.sql
-- Purpose    : Oracle diagnostic query/report helper: buffer busy waits.
-- Category   : diagnostics/sessions_waits
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @buffer_busy_waits.sql
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
select   p1 "File #",   p2 "Block #",   p3 "Reason Code"from   v$session_waitwhere   event = 'buffer busy waits';