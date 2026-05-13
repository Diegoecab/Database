-- ------------------------------------------------------------------------------
-- File       : borra_tabla_cascade.sql
-- Purpose    : Oracle administration helper: borra tabla cascade.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @borra_tabla_cascade.sql
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
ALTER TABLE GEM_ADM.CCP_EMPRESAS
 DROP PRIMARY KEY CASCADE;
DROP TABLE GEM_ADM.CCP_EMPRESAS CASCADE CONSTRAINTS;