-- ------------------------------------------------------------------------------
-- File       : longops10g.sql
-- Purpose    : Oracle administration helper: longops10g.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @longops10g.sql
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
select sername, OPNAME, TARGET, SOFAR, TOTALWORK, UNITS, START_TIME, TIME_REMAINING, ELAPSED_SECONDS from v$session_longops

select OPNAME,SQL_ID ,TOTALWORK,UNITS,START_TIME,TIME_REMAINING,
ELAPSED_SECONDS from v$session_longops where username='GARBA_EUL' and time_remaining > 0;

SELECT SQL_TEXT FROM V$SQL WHERE SQL_ID ='55d439b5zjamb';

//////////////////
Para versiones anteriores ver Note:1067799.6 de metalink
//////////////////