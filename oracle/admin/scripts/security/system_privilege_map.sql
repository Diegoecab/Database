-- ------------------------------------------------------------------------------
-- File       : system_privilege_map.sql
-- Purpose    : Oracle security, audit, user, role or grants helper: system privilege map.
-- Category   : security
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @system_privilege_map.sql
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
REM	Script para obtener todos los privilegios de sistema
REM ======================================================================
REM system_privilege_map.sql		Version 1.1	10 Enero 2011
col name for a100
SELECT   NAME
    FROM SYS.system_privilege_map
   WHERE 1 = 1
ORDER BY 1;