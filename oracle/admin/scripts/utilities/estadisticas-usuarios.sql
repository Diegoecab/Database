-- ------------------------------------------------------------------------------
-- File       : estadisticas-usuarios.sql
-- Purpose    : Oracle administration helper: estadisticas usuarios.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @estadisticas-usuarios.sql
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
SELECT B.NAME,DECODE (B.CLASS,
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
              ) CLASS, A.VALUE
  FROM V$SESSTAT A, V$STATNAME B, V$SESSION C
 WHERE C.AUDSID = USERENV ('sessionid')
   AND A.SID = C.SID
   AND (A.STATISTIC# = B.STATISTIC#);