-- ------------------------------------------------------------------------------
-- File       : flashback_query.sql
-- Purpose    : Oracle administration helper: flashback query.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @flashback_query.sql
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
/*
Eg
CREATE TABLE TNDOMINICAN.SM_INITIAL_BAL_R COMPRESS PCTFREE 0 TABLESPACE COL_DW_DATA as ( 
SELECT *
FROM TNDOMINICAN.SM_INITIAL_BAL
AS OF TIMESTAMP TO_TIMESTAMP('17-MAY-12 08.00.00.000000'))
/
*/