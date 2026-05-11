-- ------------------------------------------------------------------------------
-- File       : session_wait_sess.sql
-- Purpose    : Oracle diagnostic query/report helper: session wait sess.
-- Category   : diagnostics/sessions_waits
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @session_wait_sess.sql
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
col event for a30
col sid for 9999

SELECT w.Event,
	s.sid,
	s.STATUS,
	s.program,
	w.p1,
	w.p2
FROM v$session s,v$transaction t,v$session_wait w
WHERE s.taddr=t.addr AND s.sid=w.sid;