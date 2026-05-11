-- ------------------------------------------------------------------------------
-- File       : utl_recomp.sql
-- Purpose    : Oracle administration helper: utl recomp.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @utl_recomp.sql
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
-- Schema level.
EXEC UTL_RECOMP.recomp_serial('SCOTT');
EXEC UTL_RECOMP.recomp_parallel(4, 'SCOTT');

-- Database level.
EXEC UTL_RECOMP.recomp_serial();
EXEC UTL_RECOMP.recomp_parallel(4);

-- Using job_queue_processes value.
EXEC UTL_RECOMP.recomp_parallel();
EXEC UTL_RECOMP.recomp_parallel(NULL, 'SCOTT');


EXEC DBMS_UTILITY.compile_schema(schema => 'SCOTT', compile_all => false);