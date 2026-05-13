-- ------------------------------------------------------------------------------
-- File       : diff_parameters_rac.sql
-- Purpose    : Oracle RAC or cluster administration helper: diff parameters rac.
-- Category   : platform/rac
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @diff_parameters_rac.sql
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
col value_i1 for a30
col value_i2 for a30
set lines 160
SELECT p1.name, p1.value value_i1, p2.value value_i2 FROM gv$parameter p1
  JOIN gv$parameter p2 ON p1.name = p2.name
  WHERE p1.inst_id = 1
    AND p2.inst_id = 2
    AND p1.value != p2.value
    AND p1.name NOT IN ('instance_number', 'instance_name', 'local_listener');
	