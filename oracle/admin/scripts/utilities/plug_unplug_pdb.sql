-- ------------------------------------------------------------------------------
-- File       : plug_unplug_pdb.sql
-- Purpose    : Oracle administration helper: plug unplug pdb.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @plug_unplug_pdb.sql
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
alter pluggable database pdb1 close;

alter pluggable database pdb1
unplug into '/tmp/pdb1.pdb';

create pluggable database pdb_new
using '/tmp/pdb1.pdb';

alter pluggable database pdb1
unplug into '/tmp/pdb1.xml' encrypt using "tpwd1";

create pluggable database pdb_new
using '/tmp/pdb1.xml' keystore identified by pass
decrypt using "tpwd1";



show pdbs;

drop pluggable database pdb1;


