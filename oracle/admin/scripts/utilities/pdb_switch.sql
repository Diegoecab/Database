-- ------------------------------------------------------------------------------
-- File       : pdb_switch.sql
-- Purpose    : Oracle administration helper: pdb switch.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @pdb_switch.sql
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
prompt All PDBS within CDB
set lines 600
select pdb_id, PDB_NAME from cdb_pdbs;
show con_name;
alter session set container = CRGBITDP_RGBITDP;

alter session set container = CRGBILKP_SHLAKP;


