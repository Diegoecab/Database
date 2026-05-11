-- ------------------------------------------------------------------------------
-- File       : user_sql_trace.sql
-- Purpose    : Oracle security, audit, user, role or grants helper: user sql trace.
-- Category   : security
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @user_sql_trace.sql
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
ALTER SESSION SET tracefile_identifier = dcabrera;

ALTER SESSION SET sql_trace = true;


SELECT count(*)FROM DTV_PROD_DATA.F_CHURN_PREPAGO;

ALTER SESSION SET sql_trace=FALSE;


TKPROF <trace-file> <output-file> 