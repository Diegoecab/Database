-- ------------------------------------------------------------------------------
-- File       : stat_parse.sql
-- Purpose    : Oracle administration helper: stat parse.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @stat_parse.sql
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
--stat_parse
set define off
set feedback off
set pagesize 400

clear col
SELECT --a.SID,
       DECODE (b.CLASS,
               1, 'User',
               2, 'Redo',
               4, 'Enqueue',
               8, 'Cache',
               16, 'OS',
               32, 'ParallelServer',
               64, 'SQL',
               128, 'Debug',
               72, 'SQL & Cache',
               40, 'ParallelServer & Cache'
              ) CLASS,
       b.NAME, a.VALUE
  FROM v$sesstat a, v$statname b , v$session c
 WHERE (a.statistic# = b.statistic#) AND
 c.audsid=sys_context('userenv','SESSIONID')
 AND a.SID = c.SID
 AND value <> 0 and b.name like '%parse%'
 ORDER BY value
/

 set define on
 set feedback on