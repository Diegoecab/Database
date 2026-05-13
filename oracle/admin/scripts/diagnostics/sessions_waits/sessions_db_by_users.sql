-- ------------------------------------------------------------------------------
-- File       : sessions_db_by_users.sql
-- Purpose    : Oracle diagnostic query/report helper: sessions db by users.
-- Category   : diagnostics/sessions_waits
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @sessions_db_by_users.sql
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
--sessions_db_by_users.sql
set lines 300
set pages 100
col username for a30 truncate
col MACHINE for a30 truncate
col osuser for a20 truncate
col service_name for a20 truncate
SELECT NVL(s.username, '[bkgrnd]') AS username, s.inst_id, status, osuser,machine,
        service_name, min(logon_time), count(*)
FROM   gv$session s,
       gv$process p
WHERE  s.paddr      = p.addr
AND    s.inst_id = p.inst_id
GROUP BY NVL(s.username, '[bkgrnd]'), s.inst_id, status, osuser,machine, service_name
ORDER BY 1
/