-- ------------------------------------------------------------------------------
-- File       : dba_pdb_saved_states.sql
-- Purpose    : Oracle administration helper: dba pdb saved states.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_pdb_saved_states.sql
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

COLUMN con_name FORMAT A20
COLUMN instance_name FORMAT A20

SELECT con_name, instance_name, state FROM dba_pdb_saved_states;