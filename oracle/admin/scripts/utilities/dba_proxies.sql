-- ------------------------------------------------------------------------------
-- File       : dba_proxies.sql
-- Purpose    : Oracle administration helper: dba proxies.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_proxies.sql
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
--dba_proxies.sql
/*
Eg
alter user ZENBR_ODS grant connect through ZENITH;
alter user ZENCR_ODS grant connect through ZENITH;
alter user ZENES_ODS grant connect through ZENITH;
*/
select * from dba_proxies;