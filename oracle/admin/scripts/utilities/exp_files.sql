-- ------------------------------------------------------------------------------
-- File       : exp_files.sql
-- Purpose    : Oracle administration helper: exp files.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @exp_files.sql
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
Select servername, db_sid, to_char(book_date,'YYYYMM') PERIOD, COUNT(1)
       FROM EXP_QUEUE Q, EXP_EOM_FILE E
    WHERE Q.JOB_ID=E.JOB_ID
GROUP BY servername, db_sid, to_char(book_date,'YYYYMM')
ORDER BY 3;