-- ------------------------------------------------------------------------------
-- File       : borrar_crear_logs_online.sql
-- Purpose    : Oracle administration helper: borrar crear logs online (2).
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @borrar_crear_logs_online (2).sql
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

ALTER DATABASE DROP LOGFILE GROUP 1
commit;

--Borrar archivo LOG del SO

ALTER DATABASE ADD LOGFILE GROUP 1
 ('/u01/app/oracle/oradata/oratest/redo01.log','/u01/app/oracle/oradata/oratest/redo01_2.log')
 SIZE 100M;


