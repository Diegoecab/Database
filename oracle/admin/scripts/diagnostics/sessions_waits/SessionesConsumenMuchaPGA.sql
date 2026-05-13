-- ------------------------------------------------------------------------------
-- File       : SessionesConsumenMuchaPGA.sql
-- Purpose    : Oracle diagnostic query/report helper: SessionesConsumenMuchaPGA.
-- Category   : diagnostics/sessions_waits
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @SessionesConsumenMuchaPGA.sql
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
SELECT username usuario,
name,
value
FROM v$statname sn,
v$session s,
v$sesstat st
WHERE sn.statistic# = st.statistic#
AND s.sid = st.sid
AND sn.name like '%session%pga%mem%'
AND st.value > 40000
AND s.type = 'USER';