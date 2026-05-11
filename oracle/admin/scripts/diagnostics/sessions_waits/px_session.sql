-- ------------------------------------------------------------------------------
-- File       : px_session.sql
-- Purpose    : Oracle diagnostic query/report helper: px session.
-- Category   : diagnostics/sessions_waits
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @px_session.sql
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
SELECT 
  decode (px.qcinst_id,
  null,
  username,
  ' - '||lower(substr(s.program,
  length(s.program)-4,
  4) ) ) "Username",
  decode(px.qcinst_id,
  null,
  'QC',
  '(Slave)') "QC/Slave",
  to_char(px.server_set) "Slave Set",
  to_char(s.sid) "SID",
  decode(px.qcinst_id,
  null,
  to_char(s.sid),
  px.qcsid) "QC SID",
  px.req_degree "Requested DOP",
  px.degree "Actual DOP"
FROM 
  v$px_session px,
  v$session s
WHERE 
  px.sid=s.sid(+)  and
  px.serial#=s.serial#   
  order by 5,1 desc;

