-- ------------------------------------------------------------------------------
-- File       : pga_test.sql
-- Purpose    : Oracle administration helper: pga test.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @pga_test.sql
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
DECLARE
  PROCEDURE grab_memory AS
    l_dummy VARCHAR2(4000);
  BEGIN
    grab_memory;
  END;
BEGIN
  grab_memory;
END;
/
