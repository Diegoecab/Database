-- ------------------------------------------------------------------------------
-- File       : sessions1.sql
-- Purpose    : Oracle diagnostic query/report helper: sessions1.
-- Category   : diagnostics/sessions_waits
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @sessions1.sql
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
set pagesize 500
set linesize 120
col sid for 999
column piece noprint
column username format a16
column osuser format a10
break on sid 
--,serial#
-- or username
select s.sid, s.serial#, p.spid, s.username, t.piece, t.sql_text
from v$session s, v$sqltext t, v$process p
where s.username is not null
and p.addr=s.paddr
and s.status='ACTIVE'
and s.sql_address=t.address
and s.username like upper('&&1%')
order by 1,5
/
