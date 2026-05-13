-- ------------------------------------------------------------------------------
-- File       : mystat_pga.sql
-- Purpose    : Oracle administration helper: mystat pga.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @mystat_pga.sql
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
SELECT B.NAME, ROUND (A.VALUE / 1024 / 1024, 2) MB
  FROM V$SESSTAT A, V$STATNAME B, V$SESSION C
 WHERE C.AUDSID = USERENV ('sessionid')
   AND A.SID = C.SID
   AND (A.STATISTIC# = B.STATISTIC#)
   AND NAME like '%pga%';