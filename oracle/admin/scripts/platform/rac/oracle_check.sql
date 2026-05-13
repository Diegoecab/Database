-- ------------------------------------------------------------------------------
-- File       : oracle_check.sql
-- Purpose    : Oracle RAC or cluster administration helper: oracle check.
-- Category   : platform/rac
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @oracle_check.sql
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
--oracle_check.sql
/*
Identify Data Dictionary Inconsistency [ID 456468.1]

1. Identifying Objects with Data Dictionary Inconsistency


In order to detect data dictionary inconsistency we need to run hcheck.full procedure, see Note 136697.1.

      a. Connect as SYS schema in sqlplus
      b. Create package hOut as described in Note 101468.1
      c. Create package hcheck in SYS schema as described in Note 136697.1 attachment.
      d. set serveroutput on
      c. execute hcheck.full

The script will report various dictionary related issues that may or may not be a problem.
Any problems reported should be reviewed by an experienced support analyst as some
reported "problems" may be normal and expected. 
*/
prompt Ejecutar con SYS!
@hout.sql
@hcheck.sql