-- ------------------------------------------------------------------------------
-- File       : kill_session_batch2.sql
-- Purpose    : Oracle diagnostic query/report helper: kill session batch2.
-- Category   : diagnostics/sessions_waits
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @kill_session_batch2.sql
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
 select 'alter system kill session '''||s.sid||','||s.serial#||',@'||s.inst_id||''' immediate;' from gv$session s ,gv$process p where s.paddr = p.addr
  --and s.username is not null and status = 'ACTIVE'
  --and s.sql_id='4nqnfu8ctc7u4'
 and s.username='S_CO_PRD_WSRECAR_DB'
/