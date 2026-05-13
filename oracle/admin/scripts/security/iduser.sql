-- ------------------------------------------------------------------------------
-- File       : iduser.sql
-- Purpose    : Oracle security, audit, user, role or grants helper: iduser.
-- Category   : security
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @iduser.sql
-- Parameters : Review ACCEPT variables and substitution variables before running.
-- Requires   : SQL*Plus or SQLcl and privileges required by referenced dictionary views.
-- Oracle Ver.: Review compatibility before production use.
-- Risk       : REVIEW
-- Output     : SQL*Plus/SQLcl console or spool output.
-- Notes      : Validate in a non-production session before operational use.
-- Source     : internal
-- Change Log : 
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
col logon_time format a20
col last_call_et format a20
select sid,s.serial#, spid,  process cpid, s.username, 
to_char(s.logon_time,'DD/MM/YYYY HH24:MI:SS') logon_time,
to_char(sysdate - last_call_et / 86400,'DD/MM/YYYY HH24:MI:SS') last_call_et,
s.status, SERVER
from v$session s,v$process
where addr(+)=paddr
and s.username like upper('%&&1%')
order by s.username,sid
/
