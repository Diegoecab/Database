-- ------------------------------------------------------------------------------
-- File       : java_recompile.sql
-- Purpose    : Oracle administration helper: java recompile.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @java_recompile.sql
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
alter system set java_jit_enabled = FALSE;
alter system set "_system_trig_enabled"=FALSE;
alter system set JOB_QUEUE_PROCESSES=0;
create or replace java system
/
alter system set java_jit_enabled = true;
alter system set "_system_trig_enabled"=TRUE;
alter system set JOB_QUEUE_PROCESSES=1000;
@?/rdbms/admin/utlrp.sql
