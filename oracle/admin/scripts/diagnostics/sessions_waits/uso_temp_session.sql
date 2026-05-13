-- ------------------------------------------------------------------------------
-- File       : uso_temp_session.sql
-- Purpose    : oracle/admin diagnostics/sessions_waits helper: uso temp session.
-- Engine     : oracle/admin
-- Category   : diagnostics/sessions_waits
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: uso_temp_session.sql
-- Parameters : Review script body before running.
-- Risk       : READ_ONLY
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
prompt 
prompt Uso x Session
prompt
set heading on
col machine for a30
col tablespace for a10
col program for a20
col username for a20
Break on username on report 
compute sum of mb on report

SELECT s.username, s.sid, s.machine,s.program,u.tablespace, u.contents, u.extents, u.blocks, (u.blocks*8)/1024 mb
FROM v$session s, v$sort_usage u
WHERE s.saddr=u.session_addr
/

