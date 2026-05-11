-- ------------------------------------------------------------------------------
-- File       : session_sid_pid_process.sql
-- Purpose    : Oracle diagnostic query/report helper: session sid pid process.
-- Category   : diagnostics/sessions_waits
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @session_sid_pid_process.sql
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
--session_sid_pid_process
Set lines 200
col sid format 99999
col username format a15
col osuser format a15
col machine for a40 truncate
col program for a60 truncate
select a.username, a.machine, a.program, a.sid, a.serial#,a.username, a.osuser, b.spid
from gv$session a, gv$process b
where a.paddr= b.addr
and a.inst_id=b.inst_id
and a.sid='&sid'
and a.serial#='&serial'
order by a.sid;