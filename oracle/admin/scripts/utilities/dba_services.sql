-- ------------------------------------------------------------------------------
-- File       : dba_services.sql
-- Purpose    : Oracle administration helper: dba services.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_services.sql
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
--dba_services
col name for a20 truncate
col network_name for a20 truncate
col pdb for a20 truncate
select name, network_name, enabled, pdb, GLOBAL_SERVICE, GOAL,EDITION from dba_services;
select name, network_name, enabled, pdb, GLOBAL_SERVICE, GOAL,EDITION from cdb_services;