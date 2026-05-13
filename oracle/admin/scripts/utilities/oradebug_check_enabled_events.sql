-- ------------------------------------------------------------------------------
-- File       : oradebug_check_enabled_events.sql
-- Purpose    : Oracle administration helper: oradebug check enabled events.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @oradebug_check_enabled_events.sql
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
#https://dba.stackexchange.com/questions/107521/generate-analyze-trace-for-error-1461

alter system set events '1461 trace name context forever, level 4';
from alert.log:

OS Pid: 4069 executed alter system set events '1461 trace name context forever, level 4'
from oradebug:

oradebug setmypid
oradebug eventdump system

1461 trace name CONTEXT level 4, forever