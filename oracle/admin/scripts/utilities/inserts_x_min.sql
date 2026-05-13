-- ------------------------------------------------------------------------------
-- File       : inserts_x_min.sql
-- Purpose    : Oracle administration helper: inserts x min.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @inserts_x_min.sql
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
--inserts_x_min.sql
SELECT SUBSTR (sql_text, INSTR (sql_text, 'INTO '), 30) table_name,
       rows_processed,
       ROUND (  (SYSDATE - TO_DATE (first_load_time, 'YYYY-MM-DD HH24:MI:SS')
                )
              * 24
              * 60,
              1
             ) minutes,
       TRUNC (  rows_processed
              / (  (  SYSDATE
                    - TO_DATE (first_load_time, 'YYYY-MM-DD HH24:MI:SS')
                   )
                 * 24
                 * 60
                )
             ) rows_per_minute
  FROM SYS.v_$sqlarea
 WHERE sql_text LIKE 'INSERT%INTO%' AND open_versions > 0
/