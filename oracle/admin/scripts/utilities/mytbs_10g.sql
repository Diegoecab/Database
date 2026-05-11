-- ------------------------------------------------------------------------------
-- File       : mytbs_10g.sql
-- Purpose    : Oracle administration helper: mytbs 10g.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @mytbs_10g.sql
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
CREATE SMALLFILE TABLESPACE "MYTBS" DATAFILE '/u01/app/oracle/oradata/dev1/mytbs01.dbf' SIZE 5M REUSE AUTOEXTEND ON NEXT 5M MAXSIZE UNLIMITED LOGGING EXTENT MANAGEMENT LOCAL SEGMENT SPACE MANAGEMENT AUTO
/

