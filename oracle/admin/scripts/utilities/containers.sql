-- ------------------------------------------------------------------------------
-- File       : containers.sql
-- Purpose    : Oracle administration helper: containers.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @containers.sql
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
col PDBName for a30
select con_id "PDBID", name "PDBName", application_root "AppRoot", application_pdb "AppPDB", 
application_seed "AppSeed" , application_root_con_id "AppRootID" from v$containers;