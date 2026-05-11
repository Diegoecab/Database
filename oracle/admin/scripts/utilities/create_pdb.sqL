-- ------------------------------------------------------------------------------
-- File       : create_pdb.sqL
-- Purpose    : Oracle administration helper: create pdb.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @create_pdb.sqL
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
CREATE PLUGGABLE DATABASE PDB2
ADMIN USER ADMIN1 IDENTIFIED BY p1 ROLES=(CONNECT, DBA);
--FILE_NAME_CONVERT = ('CDB1/','PDB2/');
ALTER PLUGGABLE DATABASE PDB1 OPEN RESTRICTED;
