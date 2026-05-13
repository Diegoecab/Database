-- ------------------------------------------------------------------------------
-- File       : msession.sql
-- Purpose    : Oracle diagnostic query/report helper: msession.
-- Category   : diagnostics/sessions_waits
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @msession.sql
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
column username format a14
set pagesize 500

break on username 

  column "Current UGA memory" format a30
SELECT username, value/1024 || 'KB' "Current UGA memory"
   FROM v$session sess, v$sesstat stat, v$statname name
WHERE sess.sid = stat.sid
   AND stat.statistic# = name.statistic#
   AND name.name = 'session uga memory' and sess.username is not null order by value DESC;
   