-- ------------------------------------------------------------------------------
-- File       : nls.sql
-- Purpose    : Oracle administration helper: nls.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @nls.sql
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
select * from v$nls_parameters;
select * from nls_session_parameters;
select * from nls_database_parameters;
select * from nls_instance_parameters;
SELECT USERENV ('language') FROM DUAL;--entorno