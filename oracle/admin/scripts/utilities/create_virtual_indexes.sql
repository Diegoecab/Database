-- ------------------------------------------------------------------------------
-- File       : create_virtual_indexes.sql
-- Purpose    : Oracle administration helper: create virtual indexes.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @create_virtual_indexes.sql
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
ejemplo 
ALTER SESSION SET "_use_nosegment_indexes" = TRUE;
CREATE INDEX IX_USERTYPE ON CUSTOMER.GO_EVENTS (USERTYPE) nosegment;

set autotrace traceonly explain
