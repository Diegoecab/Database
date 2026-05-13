-- ------------------------------------------------------------------------------
-- File       : Loks10g.sql
-- Purpose    : Oracle administration helper: Loks10g.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @Loks10g.sql
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
/* para determinar los bloqueos en 10g ver nuevas columnas en v$session */
/* ver nota en yahoo */

select BLOCKING_SESSION_STATUS, BLOCKING_SESSION
from v$session 
where sid = 269
/

/* mas información de bloqueo: ( time in centiseconds ) */
select * from v$session_wait_class where sid = 269
/

select event, wait_time, wait_count
from v$session_wait_history
where sid = 265
/