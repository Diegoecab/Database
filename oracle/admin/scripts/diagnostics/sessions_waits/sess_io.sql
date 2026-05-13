-- ------------------------------------------------------------------------------
-- File       : sess_io.sql
-- Purpose    : Oracle diagnostic query/report helper: sess io.
-- Category   : diagnostics/sessions_waits
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @sess_io.sql
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
--v$sess_io
col os_user for a15
set pagesize 50

select	nvl(ses.USERNAME,'ORACLE PROC') username,
	OSUSER os_user,
	PROCESS pid,
	ses.SID sid,
	SERIAL#,
	PHYSICAL_READS,
	BLOCK_GETS,
	CONSISTENT_GETS,
	BLOCK_CHANGES--,
--	CONSISTENT_CHANGES
from	v$session ses, 
	v$sess_io sio
where 	ses.SID = sio.SID
order 	by PHYSICAL_READS, ses.USERNAME;