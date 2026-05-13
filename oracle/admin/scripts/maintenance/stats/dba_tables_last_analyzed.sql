-- ------------------------------------------------------------------------------
-- File       : dba_tables_last_analyzed.sql
-- Purpose    : Oracle database maintenance helper: dba tables last analyzed.
-- Category   : maintenance/stats
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_tables_last_analyzed.sql
-- Parameters : Review ACCEPT variables and substitution variables before running.
-- Requires   : SQL*Plus or SQLcl and privileges required by referenced dictionary views.
-- Oracle Ver.: Review compatibility before production use.
-- Risk       : REVIEW
-- Output     : SQL*Plus/SQLcl console or spool output.
-- Notes      : Validate in a non-production session before operational use.
-- Source     : internal
-- Change Log : 
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
set linesize 150
SELECT   TO_CHAR(TRUNC (last_analyzed),'DD/MM/YYYY') fecha,
         (CASE
             WHEN TO_CHAR (TRUNC (last_analyzed), 'D') = 0
                THEN 'Domingo'
             WHEN TO_CHAR (TRUNC (last_analyzed), 'D') = 1
                THEN 'Lunes'
             WHEN TO_CHAR (TRUNC (last_analyzed), 'D') = 2
                THEN 'Martes'
             WHEN TO_CHAR (TRUNC (last_analyzed), 'D') = 3
                THEN 'Miercoles'
             WHEN TO_CHAR (TRUNC (last_analyzed), 'D') = 4
                THEN 'Jueves'
             WHEN TO_CHAR (TRUNC (last_analyzed), 'D') = 5
                THEN 'Viernes'
             WHEN TO_CHAR (TRUNC (last_analyzed), 'D') = 6
                THEN 'Sabado'
          END
         ) dia,
         MIN (last_analyzed), MAX (last_analyzed)
    FROM dba_tables
   WHERE last_analyzed IS NOT NULL
GROUP BY TRUNC (last_analyzed)
ORDER BY TRUNC (last_analyzed) DESC
/